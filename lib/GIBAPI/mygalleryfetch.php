<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Set headers for CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, PUT, OPTIONS, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Database connection parameters
 $servername = "207.174.212.202";
  $username = "kanin7w7_gibErode";
  $password = "Kanxtl@6868#";
  $dbname = "kanin7w7_gibErode";


// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}

// Fetch all image data from the database
$sql = "SELECT image_path, id FROM mygallery ";
$result = $conn->query($sql);

$imageData = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $imageData[] = array(
            'image_path' => $row['image_path'],
            'id' => $row['id']
        );
    }
    echo json_encode($imageData);
} else {
    echo json_encode(array('error' => 'Image not found.'));
}

// Close database connection
$conn->close();
?>
