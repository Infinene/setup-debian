<?php
//simple counter to test sessions. should increment on each page reload.
printf '%s\n' '<PRE>';
$path = session_save_path();
printf '%s\n' 'session_save_path:'.$path.PHP_EOL;
session_start();
$count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;
printf '%s\n' '$_SESSION[\'count\']: '. $count;
$_SESSION['count'] = ++$count;
