<?php
// Is this even safe to push?
$servername = "baseball-db.cr1bywcw4nzo.us-east-1.rds.amazonaws.com";
$username = "admin";
$password = "password";
$dbname = "baseball"; 

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>