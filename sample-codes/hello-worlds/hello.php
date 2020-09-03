<?php

$data = explode(PHP_EOL, trim(stream_get_contents(STDIN)));

echo str_repeat("Hello World!" . PHP_EOL, intval($data[0]));
