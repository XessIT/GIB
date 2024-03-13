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
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['member_type'])) {
        $member_type = mysqli_real_escape_string($conn, $_GET['member_type']);
        $userlist = "SELECT * FROM registration where member_type!='Non-Executive'";
        $userResult = mysqli_query($conn, $userlist);
        if ($userResult && mysqli_num_rows($userResult) > 0) {
            $user = array();
            while ($row = mysqli_fetch_assoc($userResult)) {
                $user[] = $row;
            }
            echo json_encode($user);
        } else {
            echo json_encode(array("message" => "No offers found"));
        }
    } else {
        $userlist = "SELECT * FROM registration";
        $userResult = mysqli_query($conn, $userlist);
        if ($userResult && mysqli_num_rows($userResult) > 0) {
            $user = array();
            while ($row = mysqli_fetch_assoc($userResult)) {
                $user[] = $row;
            }
            echo json_encode($user);
        } else {
            echo json_encode(array("message" => "No offers found"));
        }
    }
}
mysqli_close($conn);
?>
