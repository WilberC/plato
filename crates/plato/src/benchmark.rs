use std::fs::{File, OpenOptions};
use std::io::{BufWriter, Write};
use std::path::Path;
use std::time::Instant;

use plato_core::device::CURRENT_DEVICE;
use plato_core::serde_json::json;
use plato_core::view::RenderQueueTiming;

pub struct Benchmark {
    output: Option<BufWriter<File>>,
    sequence: u64,
    sample: Option<Sample>,
}

struct Sample {
    id: u64,
    started: Instant,
    direction: &'static str,
    page_before: String,
    cache_entries_before: usize,
    page_handler_complete: Option<Instant>,
}

impl Benchmark {
    pub fn enabled(&self) -> bool {
        self.output.is_some()
    }

    pub fn new() -> Benchmark {
        let marker_enabled = Path::new("/mnt/onboard/.adds/plato/benchmark.enabled").exists();
        let enabled = std::env::var("PLATO_BENCHMARK")
            .map(|v| v == "1" || v == "true")
            .unwrap_or(false)
            || marker_enabled;
        let output = if enabled {
            let path = std::env::var("PLATO_BENCHMARK_OUTPUT")
                .unwrap_or_else(|_| {
                    if marker_enabled {
                        "/mnt/onboard/.adds/plato/benchmark.jsonl".to_string()
                    } else {
                        "benchmark.jsonl".to_string()
                    }
                });
            match OpenOptions::new().create(true).append(true).open(&path) {
                Ok(file) => Some(BufWriter::new(file)),
                Err(err) => {
                    eprintln!("Can't open benchmark output {}: {}.", path, err);
                    None
                },
            }
        } else {
            None
        };

        Benchmark { output, sequence: 0, sample: None }
    }

    pub fn start_page(&mut self, direction: &'static str, page: String, cache_entries: usize) {
        if self.output.is_none() {
            return;
        }
        self.sequence += 1;
        self.sample = Some(Sample {
            id: self.sequence,
            started: Instant::now(),
            direction,
            page_before: page,
            cache_entries_before: cache_entries,
            page_handler_complete: None,
        });
    }

    pub fn mark_page_handler_complete(&mut self) {
        if let Some(sample) = self.sample.as_mut() {
            sample.page_handler_complete = Some(Instant::now());
        }
    }

    pub fn finish_page(&mut self, page: Option<(String, usize)>, update_modes: Vec<String>, timing: RenderQueueTiming) {
        let Some(sample) = self.sample.take() else { return };
        let Some(output) = self.output.as_mut() else { return };
        let elapsed = |time: Option<Instant>| {
            time.map(|value| value.duration_since(sample.started).as_nanos())
        };
        let record = json!({
            "schema_version": 1,
            "sequence": sample.id,
            "device_model": format!("{}", CURRENT_DEVICE.model),
            "direction": sample.direction,
            "page_before": sample.page_before,
            "page_after": page.as_ref().map(|value| value.0.clone()),
            "cache_entries_before": sample.cache_entries_before,
            "cache_entries_after": page.as_ref().map(|value| value.1),
            "update_modes": update_modes,
            "stages_ns": {
                "input_received": 0,
                "page_preparation_complete": elapsed(sample.page_handler_complete),
                "rasterization_complete": Some(timing.rasterization_complete.duration_since(sample.started).as_nanos()),
                "framebuffer_submission_complete": Some(timing.framebuffer_submission_complete.duration_since(sample.started).as_nanos()),
                "framebuffer_completion": null,
                "visible_page_ready": null
            }
        });

        if let Err(err) = writeln!(output, "{}", record) {
            eprintln!("Can't write benchmark record: {}.", err);
        }
        output.flush().ok();
    }
}
