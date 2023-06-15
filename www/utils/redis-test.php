<?php 
   //Connecting to Redis server on localhost 
   $redis = new Redis(); 
   $redis->connect('127.0.0.1', 6379); 
   printf '%s\n' "Connection to server sucessfully"; 
   //check whether server is running or not 
   printf '%s\n' "Server is running: ".$redis->ping(); 
?>
