<?php
include 'db.php';

if ($conn) {
    echo "Connected successfully to RDS.";
} else {
    echo "Connection failed.";
}
?>