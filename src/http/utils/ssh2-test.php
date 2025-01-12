<?php

/*
In sshd_config the following line should be enabled
HostKey /etc/ssh/ssh_host_rsa_key
 */

$server = '127.0.0.1';
$user = 'aom';
$pwd = 'itnoa';
$pub_key = '/srv/www/.ssh/id_rsa.pub';
$private_key = '/srv/www/.ssh/id_rsa';

if ($key = file_get_contents($pub_key)) {
	echo "Reading public key '{$pub_key}' successful: <br>\n";
	echo "<pre>";
	var_export($key);
	echo "</pre>";
} else {
	echo "Cannot read public key: {$pub_key}! <br>\n";
}

if ($key = file_get_contents($private_key)) {
	echo "Reading private key '{$private_key}' successful: <br>\n";
	echo "<pre>";
	var_export($key);
	echo "</pre>";
} else {
	echo "Cannot read private  key: {$private_key}! <br>\n";
}

if (!$ssh2_conn = ssh2_connect($server, 22, array('hostkey' => 'ssh-rsa'))) {
	echo "Error: cannot connect to server: " . $server . " <br>\n";
}

if ($ssh2_conn) {
	if ($key && ssh2_auth_pubkey_file($ssh2_conn, $user, $pub_key, $private_key)) {
		echo "Public key authentication using $pub_key  successful <br>\n";
		// } elseif (ssh2_auth_password($ssh2_conn, $user, $pwd)) {
		//     echo "<br> Password authentication for $user  successful <br>\n";
	} else {
		die("<br> Authentication failed! <br>\n");
	}
}
