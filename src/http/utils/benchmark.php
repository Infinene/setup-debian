<?php

$calibration = benchmark(function() { });
$benchmark = benchmark(function() {
	sleep(1);
});

echo "Calibration run: ".number_format($calibration)."/sec\n<br>";
echo "Benchmark run: ".number_format($benchmark)."/sec\n<br>";
echo 'Approximate code execution time (seconds): '.number_format((1/$benchmark) - (1/$calibration), 10);

function benchmark($x)
{
	$start = $t = microtime(true);
	$total = $c = $loop = 0;

	while (true) {
		$x();
		$c++;

		$now = microtime(true);
		if ($now - $t > 1) {
			$loop++;
			$total += $c;
			list($t, $c) = array(microtime(true), 0);
		}

		if ($now - $start > 2) {
			return round($total / $loop);
		}
	}
}
