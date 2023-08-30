<?php

function getResult() {

    $result = file_get_contents("JSON_alternative.txt");
    return $result;

}

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    $output = getResult();
    echo $output;
}

?>