<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>MySQL Connection Test</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
body {background-color: #dfdfdf}
#wrapper {
    width: 600px;
    margin: 20px auto 0;
    font: 1.2em Verdana, Arial, sans-serif;
}

#results {
    padding: 50px;
    background-color: #223;
    color: #999;
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


    <h1>PHP-MySQL Connection Test</h1>

<?php if (!empty($_POST)) {
    echo '<div id="results">';

// The variables have not been adequately sanitized to protect against SQL Injection attacks: http://us3.php.net/mysql_real_escape_string

    $host = trim($_POST['hostname']);
    $ip = trim($_POST['hostip']);
    $user = trim($_POST['username']);
    $pass = trim($_POST['password']);
    $db = trim($_POST['database']);

    if (!empty($host)) {
      echo "<h4>$host</h4>";
      $mysqli = new mysqli($host, $user, $pass);
      //$mysqli = new mysqli($host, $user, $pass, $db, 3306, "/var/run/mysqld/mysqld.sock");
      if ($mysqli->connect_errno) {
          echo "<span class=\"red\">Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "</span>";
      } else {
          echo "<span class=\"green\"><b>Connected: </b>" . $mysqli->host_info . "</span><br>";
          echo "<span class=\"green\"><b>Info: </b>" . mysqli_get_server_info( $mysqli ) . "</span><br>";
      }
      if (!empty($db)) {
          $mysqli = new mysqli($host, $user, $pass, $db);
          if ($mysqli->connect_errno) {
              echo "<span class=\"red\">Failed to connect to " .$db.": (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "</span><br>";
          } else {
              echo "<span class=\"green\">Connected to database: ".$db . "</span><br>";
          }
      }
    }

    if (!empty($host)) {
      echo "<h4>$ip</h4>";
      $mysqli = new mysqli($ip, $user, $pass);

      if ($mysqli->connect_errno) {
          echo "<span class=\"red\">Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "</span>";
      } else {
          echo "<span class=\"green\"><b>Connected: </b>" . $mysqli->host_info . "</span><br>";
          echo "<span class=\"green\"><b>Info: </b>" . mysqli_get_server_info( $mysqli ) . "</span><br>";
      }
      if (!empty($db)) {
          $mysqli = new mysqli($host, $user, $pass, $db);
          if ($mysqli->connect_errno) {
              echo "<span class=\"red\">Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "</span><br>";
          } else {
              echo "<span class=\"green\">Connected to database: ".$db . "</span><br>";
          }
      }
    }

    echo "</div><br>";
}?>



<form action="<?php echo $_SERVER['PHP_SELF']; ?>" id="dbtest" method="post">

    <table cellpadding="2">
        <tr>
            <td>Hostname</td>
            <td><input type="text" name="hostname" id="hostname" value="localhost" size="30" tabindex="1" /></td>
            <td></td>
        </tr>
        <tr>
            <td>Host IP</td>
            <td><input type="text" name="hostip" id="hostip" value="" size="30" tabindex="1" /></td>
            <td></td>
        </tr>

        <tr>
            <td>Username</td>
            <td><input type="text" name="username" id="username" value="" size="30" tabindex="2" /></td>
            <td></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password" id="password" value="" size="30" tabindex="3" /></td>
            <td></td>
        </tr>
        <tr>
            <td>Database</td>
            <td><input type="text" name="database" id="database" value="" size="30" tabindex="4" /></td>
            <td>(optional)</td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" id="submit" value="Test Connection" tabindex="5" /></td>
            <td></td>
        </tr>
    </table>

</form>
<p>&nbsp;</p>


</div><!-- end #wrapper -->
</body>
</html>
