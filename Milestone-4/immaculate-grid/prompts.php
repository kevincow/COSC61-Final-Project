<?php
include 'db.php';

// Obtain the data stored in the prompts table in the baseball databsae
$sql = "SELECT * FROM prompts";
$result = $conn->query($sql);

// Store this data in an array/dictionary
$promptsMap = array();

while ($row = $result->fetch_assoc()) {

    $promptsMap[$row['prompt_id']] = array(
        'prompt_name' => $row['prompt_name'],
        'sql_condition' => $row['sql_condition'],
        'image_name' => $row['image_name']
    );

}

// Convert the prompts map to JSON format and echo it
echo json_encode($promptsMap);

?>
