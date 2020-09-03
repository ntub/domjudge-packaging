<?php

$data = explode(PHP_EOL, trim(stream_get_contents(STDIN)));

foreach ($data as $item) {
  [$a, $b] = explode(' ', $item);
  echo (intval($a) + intval($b)) . PHP_EOL;
}
