<?php
include 'db.php';

$sql = "SELECT * FROM prompts";
$result = $conn->query($sql);

$promptsMap = array();

while ($row = $result->fetch_assoc()) {

    $promptsMap[$row['prompt_id']] = array(
        'prompt_name' => $row['prompt_name'],
        'sql_condition' => $row['sql_condition'],
        'image_name' => $row['image_name']
    );

}

// convert the prompts map to JSON format and echo it
echo json_encode($promptsMap);

?>