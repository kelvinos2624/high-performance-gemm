#!/usr/bin/env python3
"""Tests use synthetic counters, not benchmark expectations."""
import copy
from datetime import datetime, timezone
import importlib.util
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location('analyzer', Path(__file__).resolve().parents[1] / 'scripts/analyze_counters.py')
analyzer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(analyzer)


class SelectionTests(unittest.TestCase):
    def setUp(self):
        self.sample = dict(is_delta=True, elapsed_ns=1_000_000_000,
            timestamp=datetime.fromtimestamp(105, timezone.utc).replace(tzinfo=None),
            tasks=[dict(pid=7, name='gemm_benchmark', cpu_instructions=400,
                cpu_cycles=100, pcpu_instructions=300, pcpu_cycles=75,
                cputime_ns=900_000_000, ptime_ns=700_000_000, interval_ns=1_000_000_000)])

    def test_interior(self):
        row, reason = analyzer.select_sample(self.sample, 7, 100, 110)
        self.assertEqual(reason, 'selected')
        self.assertEqual(row['start_bound_epoch'], 103)
        self.assertEqual(row['end_bound_epoch'], 106)

    def test_boundary_uncertainty(self):
        self.assertIsNone(analyzer.select_sample(self.sample, 7, 103, 110)[0])
        self.assertIsNone(analyzer.select_sample(self.sample, 7, 100, 106)[0])

    def test_pid_not_name(self):
        self.assertEqual(analyzer.select_sample(self.sample, 8, 100, 110)[1], 'target-absent')

    def test_invalid_and_cumulative(self):
        for changes in (dict(invalid=True), dict(is_delta=False)):
            with self.assertRaises(ValueError):
                analyzer.select_sample(dict(self.sample, **changes), 7, 100, 110)

    def test_bad_counter(self):
        for value in (float('nan'), -1, 0):
            sample = copy.deepcopy(self.sample)
            sample['tasks'][0]['cpu_cycles'] = value
            with self.assertRaises(ValueError):
                analyzer.select_sample(sample, 7, 100, 110)

    def test_missing_counter(self):
        del self.sample['tasks'][0]['cpu_instructions']
        with self.assertRaises(KeyError):
            analyzer.select_sample(self.sample, 7, 100, 110)

    def test_task_interval_bounds(self):
        self.sample['tasks'][0]['interval_ns'] = 6_000_000_000
        self.assertIsNone(analyzer.select_sample(self.sample, 7, 100, 110)[0])


if __name__ == '__main__':
    unittest.main()
