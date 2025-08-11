<?php
//simple counter to test sessions. should increment on each page reload.
echo '<PRE>';
$path = session_save_path();
echo 'session_save_path:'.$path.PHP_EOL;
session_start();
$count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;
echo '$_SESSION[\'count\']: '. $count;
$_SESSION['count'] = ++$count;
