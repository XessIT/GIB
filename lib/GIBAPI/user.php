<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
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

 if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  if (!isset($_GET['mobile']) || !isset($_GET['password'])) {
    die(json_encode(["error" => "Mobile and password parameters are required"]));
  }

  // Get data from Flutter app
  $mobile = mysqli_real_escape_string($conn, $_GET['mobile']);
  $password = mysqli_real_escape_string($conn, $_GET['password']);

  // Check if the user exists in the database with the provided mobile and password
  $signInQuery = "SELECT * FROM registration WHERE mobile = '$mobile' AND password = '$password'";
  $signInResult = mysqli_query($conn, $signInQuery);
  if ($signInResult) {
    if (mysqli_num_rows($signInResult) > 0) {
      $userData = mysqli_fetch_assoc($signInResult);
      $userId = $userData['id'];
      if (file_exists($userData['profile_image'])) {
          $image = base64_encode(file_get_contents($userData['profile_image']));
      } else {
          $image = ''; // or any other default value
      }
      $firstName = $userData['first_name'];
      $lastName = $userData['last_name'];
      $district = $userData['district'];
      $chapter = $userData['chapter'];
      $native = $userData['native'];
      $dob = $userData['dob'];
      $koottam = $userData['koottam'];
      $kovil = $userData['kovil'];
      $bloodGroup = $userData['blood_group'];
      $sname = $userData['s_name'];
      $place = $userData['place'];
      $wad = $userData['WAD'];
      $sblood = $userData['s_blood'];
      $skoottam = $userData['s_father_koottam'];
      $skovil = $userData['s_father_kovil'];
      $pastexperience = $userData['past_experience'];
      $website = $userData['website'];
      $byear = $userData['b_year'];
      $rid = $userData['referrer_id'];
      $education = $userData['education'];
      $mobile = $userData['mobile'];
      $email = $userData['email'];
      $company_name = $userData['company_name'];
      $business_type = $userData['business_type'];
      $business_keywords = $userData['business_keywords'];
      $company_address = $userData['company_address'];

      if ($userData['admin_rights'] == 'Accepted' && $userData['block_status'] == 'UnBlock') {
          echo json_encode(["status" => "Authentication successful",
           "member_type" => $userData['member_type'],
           "first_name" => $firstName,
           "last_name" => $lastName,
           "district" => $district,
           "chapter" => $chapter,
           "native" => $native,
           "dob" => $dob,
           "koottam" => $koottam,
           "kovil" => $kovil,
           "blood_group" => $bloodGroup,
           "s_name" => $sname,
           "s_blood" => $sblood,
           "WAD" => $wad,
           "place" => $place,
           "s_father_koottam" => $skoottam,
           "s_father_kovil" => $skovil,
           "past_experience" => $pastexperience,
           "website" => $website,
           "b_year" => $byear,
           "email" => $email,
           "referrer_id" => $rid,
           "education" => $education,
           "mobile" => $mobile,
           'profile_image'=>$image,
           'id'=>$userId,
           'company_name'=>$company_name,
           'company_address'=>$company_address,
           'business_type'=>$business_type,
           'business_keywords'=>$business_keywords,
           ]);
      } elseif ($userData['admin_rights'] == 'Rejected') {
          echo json_encode(["error" => "You are not accepted"]);
      } elseif ($userData['block_status'] == 'Blocked') {
          echo json_encode(["error" => "You are blocked"]);
      } else {
          echo json_encode(["error" => "Invalid conditions for login"]);
      }
    } else {
      echo json_encode(["error" => "Invalid username or password"]);
    }
  } else {
    echo json_encode(["error" => "Error: " . mysqli_error($conn)]);
  }
}
elseif ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Check if the required parameters are provided
    $putParams = json_decode(file_get_contents("php://input"), true);
    if (!isset($putParams['mobile']) || !isset($putParams['password'])) {
        die(json_encode(["error" => "Mobile and password parameters are required"]));
    }

    // Get data from Flutter app
    $mobile = mysqli_real_escape_string($conn, $putParams['mobile']);
    $newPassword = mysqli_real_escape_string($conn, $putParams['password']);

    // Use prepared statement to prevent SQL injection
    $updateQuery = "UPDATE registration SET password = ? WHERE mobile = ?";
    $stmt = mysqli_prepare($conn, $updateQuery);
    mysqli_stmt_bind_param($stmt, "ss", $newPassword, $mobile);
    $updateResult = mysqli_stmt_execute($stmt);

    if ($updateResult) {
        echo json_encode(["status" => "Password updated successfully"]);
    } else {
        echo json_encode(["error" => "Error updating password: " . mysqli_error($conn)]);
    }
}






mysqli_close($conn);
?>