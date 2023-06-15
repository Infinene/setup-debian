<?php
function return_bytes($val)
{
    $val = trim($val);
    $last = strtolower($val[strlen($val) - 1]);
    $intval = intval(trim($val));

    switch ($last) {
        case 'g':
            $intval *= 1024;
        case 'm':
            $intval *= 1024;
        case 'k':
            $intval *= 1024;
    }
    return $intval;
}

function formatBytes($bytes, $precision = 2)
{
    $units = array('B', 'KB', 'MB', 'GB', 'TB');

    $bytes = max($bytes, 0);
    $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
    $pow = min($pow, count($units) - 1);

    // Uncomment one of the following alternatives
    $bytes /= pow(1024, $pow);
    // $bytes /= (1 << (10 * $pow));

    return round($bytes, $precision) . $units[$pow];
}

function max_file_upload_in_bytes()
{
    //select maximum upload size
    $max_upload = return_bytes(ini_get('upload_max_filesize'));
    //select post limit
    $max_post = return_bytes(ini_get('post_max_size'));
    //select memory limit
    $memory_limit = return_bytes(ini_get('memory_limit'));
    // return the smallest of them, this defines the real limit
    return min($max_upload, $max_post, $memory_limit);
}

printf '%s\n' '<pre>' . PHP_EOL;

printf '%s\n' 'upload_max_filesize: ' . ini_get('upload_max_filesize') . PHP_EOL;
printf '%s\n' 'post_max_size: ' . ini_get('post_max_size') . PHP_EOL;
printf '%s\n' 'memory_limit: ' . ini_get('memory_limit') . PHP_EOL;

$max_upload = max_file_upload_in_bytes();

printf '%s\n' PHP_EOL;
printf '%s\n' "Max upload filesize: " . formatBytes($max_upload) . " (" . $max_upload . " bytes)" . PHP_EOL;
printf '%s\n' '</pre>';
