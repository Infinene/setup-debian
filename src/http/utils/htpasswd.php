<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>MySQL Connection Test</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
body {background-color: #dfdfdf}
#wrapper {
	width: 90%;
	margin: 20px auto 0;
	font: 1.2em Verdana, Arial, sans-serif;
}

#results {
	padding: 10px;
	background-color: #223;
	color: #aa9;
	margin: auto;
}
#results h4 {
	text-decoration: underline;
	color: white;
}
input {
	font-size: 1em;
	border: 1px solid #ccc;
	border-radius: 6px;
	padding: 8px;
}
.green { color: #0c0 }
.red { color: red }
#submit {
	padding: 4px 8px;
	border: 3px ridge #ccc;
}
</style>
</head>

<body>

<div id="wrapper">


<h1>Generate nginx htpasswd</h1>

<?php
	$user = '';
	$passwd = '';
	if (!empty($_POST)) {
	echo '<div id="results">';

	// The variables have not been adequately sanitized to protect against SQL Injection attacks: http://us3.php.net/mysql_real_escape_string

	$user = trim($_POST['username']);
	$passwd = trim($_POST['password']);

	function crypt_apr1_md5($plainpasswd)
	{
	   $tmp = '';
	   $salt = substr(str_shuffle("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"), 0, 8);
	   $len = strlen($plainpasswd);
	   $text = $plainpasswd.'$apr1$'.$salt;
	   $bin = pack("H32", md5($plainpasswd.$salt.$plainpasswd));
	   for($i = $len; $i > 0; $i -= 16) { $text .= substr($bin, 0, min(16, $i)); }
	   for($i = $len; $i > 0; $i >>= 1) { $text .= ($i & 1) ? chr(0) : $plainpasswd[0]; }
	   $bin = pack("H32", md5($text));
	   for($i = 0; $i < 1000; $i++)
	   {
		  $new = ($i & 1) ? $plainpasswd : $bin;
		  if ($i % 3) $new .= $salt;
		  if ($i % 7) $new .= $plainpasswd;
		  $new .= ($i & 1) ? $bin : $plainpasswd;
		  $bin = pack("H32", md5($new));
	   }
	   for ($i = 0; $i < 5; $i++)
	   {
		  $k = $i + 6;
		  $j = $i + 12;
		  if ($j == 16) $j = 5;
		  $tmp = $bin[$i].$bin[$k].$bin[$j].$tmp;
	   }
	   $tmp = chr(0).chr(0).$bin[11].$tmp;
	   $tmp = strtr(strrev(substr(base64_encode($tmp), 2)),
	   "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
	   "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");

	   return "$"."apr1"."$".$salt."$".$tmp;
	}

	$crypt = crypt($passwd, base64_encode($passwd));
	$apr1 = crypt_apr1_md5($passwd);
	$hash = password_hash($passwd, PASSWORD_DEFAULT);


	echo '<pre>'."\n";
	echo '<h4>crypt</h4>';
	echo $user . ':' . $crypt . ':' . $passwd . "\n";
	echo '<h4>apr1</h4>';
	echo $user . ':' . $apr1 . ':' . $passwd .  "\n";
	echo '<h4>password_hash</h4>';
	echo $user . ':' . $hash . ':' . $passwd .  "\n";
	echo '</pre>'."\n";


	echo "</div><br>";
}
?>



<form action="<?php echo $_SERVER['PHP_SELF']; ?>" id="pwdt" method="post">

	<table cellpadding="2">
		<tr>
			<td>Username</td>
			<td><input type="text" name="username" id="username" value="<?= $user ?>" size="30" tabindex="1" /></td>
			<td></td>
		</tr>
		<tr>
			<td>Password</td>
			<td><input type="text" name="password" id="password" value="<?= $passwd ?>" size="30" tabindex="2" /></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" id="submit" value="Get Password" tabindex="3" /></td>
			<td></td>
		</tr>
	</table>

</form>
<p>&nbsp;</p>


</div><!-- end #wrapper -->
</body>
</html>
