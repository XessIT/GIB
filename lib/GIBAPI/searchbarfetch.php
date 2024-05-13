<?php
error_log($_SERVER['REQUEST_METHOD']);
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gib";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Perform GET query
$sql = "SELECT * FROM `registration` WHERE member_type='Executive';
";
$result = mysqli_query($conn, $sql);

// Check if any rows returned
if (mysqli_num_rows($result) > 0) {
    // Fetch data and return as JSON
    $rows = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $rows[] = $row;
    }
    echo json_encode($rows);
} else {
    echo "No records found";
}

// Close connection
mysqli_close($conn);
?>
