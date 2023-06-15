<?php
printf '%s\n' "<style>body {margin: 5%;}</style>";
printf '%s\n' "Waking computers ...\n";
$output = shell_exec('/usr/bin/wakeonlan -f /home/aom/dev/mac.list');
printf '%s\n' "<pre>$output</pre>";
printf '%s\n' "Done!";
