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
$meeting_type = isset($_GET['meeting_type']) ? mysqli_real_escape_string($conn, $_GET['meeting_type']) : "";
   $meetingname = "SELECT * FROM meeting where meeting_type='$meeting_type'";
               $meetingResult = mysqli_query($conn, $meetingname);
               if ($meetingResult && mysqli_num_rows($meetingResult) > 0) {
                   $meeting = array();
                   while ($row = mysqli_fetch_assoc($meetingResult)) {
                       $meeting[] = $row;
                   }
                   echo json_encode($meeting);
               } else {
                   echo json_encode(array("message" => "No meeting found"));
               }
}

mysqli_close($conn);
 ?>