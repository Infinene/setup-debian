<?php
echo "<style>body {margin: 5%;}</style>";
echo "Waking computers ...\n";
$output = shell_exec('/usr/bin/wakeonlan -f /home/aom/dev/mac.list');
echo "<pre>$output</pre>";
echo "Done!";
