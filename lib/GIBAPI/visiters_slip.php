 <?php
 error_log($_SERVER['REQUEST_METHOD']);
 header("Access-Control-Allow-Origin: *");
 header("Access-Control-Allow-Methods: POST, GET, OPTIONS, PUT, DELETE");
 header("Access-Control-Allow-Headers: Content-Type, Authorization");

 $servername = "207.174.212.202";
  $username = "kanin7w7_gibErode";
  $password = "Kanxtl@6868#";
  $dbname = "kanin7w7_gibErode";

 // Create connection
 $conn = mysqli_connect($servername, $username, $password, $dbname);




 if ($_SERVER['REQUEST_METHOD'] === 'GET') {
      $user_id = isset($_GET['user_id']) ? mysqli_real_escape_string($conn, $_GET['user_id']) : "";

      $register_meetinglist = "SELECT * FROM visitors_slip WHERE user_id ='$user_id'";
      $register_meetingResult = mysqli_query($conn, $register_meetinglist);

      $register_meeting = array(); // Initialize the array

      if ($register_meetingResult) {
          while ($row = mysqli_fetch_assoc($register_meetingResult)) {
              $register_meeting[] = $row;
          }
      }

      echo json_encode($register_meeting); // Always encode the array
  }

 else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
   $data = json_decode(file_get_contents("php://input"));

   $guest_name = mysqli_real_escape_string($conn, $data->guest_name);
   $company_name = mysqli_real_escape_string($conn, $data->company_name);
   $location = mysqli_real_escape_string($conn, $data->location);
   $koottam = mysqli_real_escape_string($conn, $data->koottam);
   $kovil = mysqli_real_escape_string($conn, $data->kovil);
   $gender = mysqli_real_escape_string($conn, $data->gender);
   $mobile = mysqli_real_escape_string($conn, $data->mobile);
   $meeting_id = mysqli_real_escape_string($conn, $data->meeting_id);
   $date = mysqli_real_escape_string($conn, $data->date);
   $time = mysqli_real_escape_string($conn, $data->time);
   $user_id = mysqli_real_escape_string($conn, $data->user_id);
   $meeting_date = mysqli_real_escape_string($conn,$data->meeting_date);
   $zoom_meet = mysqli_real_escape_string($conn,$data->zoom_meet);


                  $insertUserQuery = "INSERT INTO `visitors_slip`(`guest_name`, `company_name`, `location`, `koottam`, `kovil`, `gender`, `mobile`, `meeting_id`, `date`, `time`, `user_id`,`meeting_date`,`zoom_meet`)
                  VALUES ('$guest_name','$company_name','$location','$koottam','$kovil','$gender','$mobile','$meeting_id','$date','$time','$user_id','$meeting_date','$zoom_meet')";
                  $insertUserResult = mysqli_query($conn, $insertUserQuery);


      if ($insertUserResult) {
          echo json_encode(["success" => true, "message" => "RegisterMeeting stored successfully"]);
      } else {
          echo json_encode(["success" => false, "message" => "Error: " . mysqli_error($conn)]);
      }

}


mysqli_close($conn);
?>