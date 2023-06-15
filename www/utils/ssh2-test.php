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
    printf '%s\n' "Reading public key '{$pub_key}' successful: <br>\n";
    printf '%s\n' "<pre>";
    var_export($key);
    printf '%s\n' "</pre>";
} else {
    printf '%s\n' "Cannot read public key: {$pub_key}! <br>\n";
}

if ($key = file_get_contents($private_key)) {
    printf '%s\n' "Reading private key '{$private_key}' successful: <br>\n";
    printf '%s\n' "<pre>";
    var_export($key);
    printf '%s\n' "</pre>";
} else {
    printf '%s\n' "Cannot read private  key: {$private_key}! <br>\n";
}

if (!$ssh2_conn = ssh2_connect($server, 22, array('hostkey' => 'ssh-rsa'))) {
    printf '%s\n' "Error: cannot connect to server: " . $server . " <br>\n";
}

if ($ssh2_conn) {
    if ($key && ssh2_auth_pubkey_file($ssh2_conn, $user, $pub_key, $private_key)) {
        printf '%s\n' "Public key authentication using $pub_key  successful <br>\n";
        // } elseif (ssh2_auth_password($ssh2_conn, $user, $pwd)) {
        //     printf '%s\n' "<br> Password authentication for $user  successful <br>\n";
    } else {
        die("<br> Authentication failed! <br>\n");
    }
}
