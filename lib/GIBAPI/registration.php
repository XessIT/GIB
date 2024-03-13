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
   $table = isset($_GET['table']) ? $_GET['table'] : "";
    if ($table == "district") {
            $offerlist = "SELECT DISTINCT district FROM district";
            $offerResult = mysqli_query($conn, $offerlist);
            if ($offerResult && mysqli_num_rows($offerResult) > 0) {
                $offers = array();
                while ($row = mysqli_fetch_assoc($offerResult)) {
                    $offers[] = $row;
                }
                echo json_encode($offers);
            } else {
                echo json_encode(array("message" => "No offers found"));
            }
    }elseif($table == "chapter"){
        $district = isset($_GET['district']) ? mysqli_real_escape_string($conn, $_GET['district']) : "";

            $offerlist = "SELECT chapter FROM chapter WHERE district = '$district' ORDER BY chapter";
                 $offerResult = mysqli_query($conn, $offerlist);
                 if ($offerResult && mysqli_num_rows($offerResult) > 0) {
                     $offers = array();
                     while ($row = mysqli_fetch_assoc($offerResult)) {
                         $offers[] = $row;
                     }
                     echo json_encode($offers);
                 } else {
                     echo json_encode(array("message" => "No offers found"));
                 }

    }
    else if ($table == "registration") {

    $id = isset($_GET['id']) ? mysqli_real_escape_string($conn, $_GET['id']) : "";
    $mobile = isset($_GET['mobile']) ? mysqli_real_escape_string($conn, $_GET['mobile']) : "";
    $member_id = isset($_GET['member_id']) ? mysqli_real_escape_string($conn, $_GET['member_id']) : "";
    $referrer_id = isset($_GET['referrer_id']) ? mysqli_real_escape_string($conn, $_GET['referrer_id']) : "";

                 // Fetch data from the registration table
                         if(isset($_GET['referrer_id'])){

                        $registrationlist = "SELECT * FROM registration where referrer_id='$referrer_id'";

                        }else if(isset($_GET["mobile"])){

                          $registrationlist = " SELECT * FROM registration where mobile = '$mobile' ";

                        }else if(isset($_GET["member_id"])){

                          $registrationlist = " SELECT mobile FROM registration where member_id = '$member_id' ";

                        }else if(isset($_GET["id"])){

                          $registrationlist = " SELECT * FROM registration where id = '$id' ";

                        }
                         if(isset($_GET['id'])){

                                                $registrationlist = "SELECT * FROM registration where id='$id'";

                                                }
                        else{
                        echo "Invalid parameter";
                        }
                        $registrationResult = mysqli_query($conn, $registrationlist);
                        if ($registrationResult && mysqli_num_rows($registrationResult) > 0) {
                            $registrations = array();
                            while ($row = mysqli_fetch_assoc($registrationResult)) {
                                $registrations[] = $row;
                            }
                            echo json_encode($registrations);
                        } else {
                            echo json_encode(array("message" => "No registrations found"));
                        }
             } else {
                       echo json_encode(array("message" => "Invalid table name"));
                       exit;
           }

}

else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Handle the insert/update/delete actions
   $data = json_decode(file_get_contents("php://input"));
   $imagename = mysqli_real_escape_string($conn, $data->imagename);
   // echo "Imagename: $imagename";
   $imagedata = mysqli_real_escape_string($conn, $data->imagedata);
   $mobile = mysqli_real_escape_string($conn, $data->mobile);
   $password = mysqli_real_escape_string($conn, $data->password);
   $email = mysqli_real_escape_string($conn, $data->email);
   $member_type = mysqli_real_escape_string($conn, $data->member_type);
   $first_name = mysqli_real_escape_string($conn, $data->first_name);
   $last_name = mysqli_real_escape_string($conn, $data->last_name);
   $company_name = mysqli_real_escape_string($conn, $data->company_name);
   $blood_group = mysqli_real_escape_string($conn, $data->blood_group);
   $place = mysqli_real_escape_string($conn, $data->place);
   $pin = mysqli_real_escape_string($conn, $data->pin);
   $referrer_mobile = mysqli_real_escape_string($conn, $data->referrer_mobile);
   $OTP = mysqli_real_escape_string($conn, $data->OTP);
   $block_status = mysqli_real_escape_string($conn, $data->block_status);
   $admin_rights = mysqli_real_escape_string($conn, $data->admin_rights);
   $type = mysqli_real_escape_string($conn, $data->type);
   $district = mysqli_real_escape_string($conn, $data->district);
   $chapter = mysqli_real_escape_string($conn, $data->chapter);
   $koottam = mysqli_real_escape_string($conn, $data->koottam);
   $marital_status = mysqli_real_escape_string($conn, $data->marital_status);
   $business_type = mysqli_real_escape_string($conn, $data->business_type);
   $company_address = mysqli_real_escape_string($conn, $data->company_address);
   $business_keywords = mysqli_real_escape_string($conn, $data->business_keywords);
   $education = mysqli_real_escape_string($conn, $data->education);
   $dob = mysqli_real_escape_string($conn, $data->dob);
   $native = mysqli_real_escape_string($conn, $data->native);
   $kovil = mysqli_real_escape_string($conn, $data->kovil);
   $s_name = mysqli_real_escape_string($conn, $data->s_name);
   $WAD = mysqli_real_escape_string($conn, $data->WAD);
   $s_blood = mysqli_real_escape_string($conn, $data->s_blood);
   $s_father_koottam = mysqli_real_escape_string($conn, $data->s_father_koottam);
   $s_father_kovil = mysqli_real_escape_string($conn, $data->s_father_kovil);
   $past_experience = mysqli_real_escape_string($conn, $data->past_experience);
   $website = mysqli_real_escape_string($conn, $data->website);
   $b_year = mysqli_real_escape_string($conn, $data->b_year);
   $referrer_id = mysqli_real_escape_string($conn, $data->referrer_id);
    $path = "upload/$imagename";
       $query = "INSERT INTO `registration`(
       `mobile`,
       `password`,
       `email`,
       `member_type`,
       `profile_image`,
       `first_name`,
       `last_name`,
       `company_name`,
       `blood_group`,
       `place`,
       `pin`,
       `referrer_mobile`,
       `OTP`,
       `block_status`,
       `admin_rights`,
       `type`,
       `district`,
       `chapter`,
       `koottam`,
       `marital_status`,
       `business_type`,
       `company_address`,
       `business_keywords`,
       `education`,
       `dob`,
       `native`,
       `kovil`,
       `s_name`,
       `WAD`,
       `s_blood`,
       `s_father_koottam`,
       `s_father_kovil`,
       `past_experience`,
       `website`,
       `b_year`,
       `referrer_id`
       )
       VALUES (
       '$mobile',
       '$password',
       '$email',
       '$member_type',
       '$path',
       '$first_name',
       '$last_name',
       '$company_name',
       '$blood_group',
       '$place',
       '$pin',
       '$referrer_mobile',
       '$OTP',
       '$block_status',
       '$admin_rights',
       '$type',
       '$district',
       '$chapter',
       '$koottam',
       '$marital_status',
       '$business_type',
       '$company_address',
       '$business_keywords',
       '$education',
       '$dob',
       '$native',
       '$kovil',
       '$s_name',
       '$WAD',
       '$s_blood',
       '$s_father_koottam',
       '$s_father_kovil',
       '$past_experience',
       '$website',
       '$b_year',
       '$referrer_id'
       )";
       file_put_contents($path, base64_decode($imagedata));
       $arr = [];
       $exe = mysqli_query($conn, $query);

       if ($exe) {
           $arr["success"] = true;
       } else {
           $arr["success"] = false;
       }

       echo json_encode($arr);

}

else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
   // $data = json_decode(file_get_contents("php://input"), true);
   parse_str(file_get_contents("php://input"), $data);

       // Debugging: Print the received data and raw data
       error_log("Received PUT data: " . print_r($data, true));
    if ($data) {
    $mobile = isset($data->mobile) ? mysqli_real_escape_string($conn, $data->mobile) : '';
    $password = isset($data->password) ? mysqli_real_escape_string($conn, $data->password) : '';
    $email = isset($data->email) ? mysqli_real_escape_string($conn, $data->email) : '';
    $member_type = isset($data->member_type) ? mysqli_real_escape_string($conn, $data->member_type) : '';
    $first_name = isset($data->first_name) ? mysqli_real_escape_string($conn, $data->first_name) : '';
    $last_name = isset($data->last_name) ? mysqli_real_escape_string($conn, $data->last_name) : '';
    $company_name = isset($data->company_name) ? mysqli_real_escape_string($conn, $data->company_name) : '';
    $blood_group = isset($data->blood_group) ? mysqli_real_escape_string($conn, $data->blood_group) : '';
    $place = isset($data->place) ? mysqli_real_escape_string($conn, $data->place) : '';
    $pin = isset($data->pin) ? mysqli_real_escape_string($conn, $data->pin) : '';
    $referrer_mobile = isset($data->referrer_mobile) ? mysqli_real_escape_string($conn, $data->referrer_mobile) : '';
    $type = isset($data->type) ? mysqli_real_escape_string($conn, $data->type) : '';
    $district = isset($data->district) ? mysqli_real_escape_string($conn, $data->district) : '';
    $chapter = isset($data->chapter) ? mysqli_real_escape_string($conn, $data->chapter) : '';
    $koottam = isset($data->koottam) ? mysqli_real_escape_string($conn, $data->koottam) : '';
    $marital_status = isset($data->marital_status) ? mysqli_real_escape_string($conn, $data->marital_status) : '';
    $business_type = isset($data->business_type) ? mysqli_real_escape_string($conn, $data->business_type) : '';
    $company_address = isset($data->company_address) ? mysqli_real_escape_string($conn, $data->company_address) : '';
    $business_keywords = isset($data->business_keywords) ? mysqli_real_escape_string($conn, $data->business_keywords) : '';
    $education = isset($data->education) ? mysqli_real_escape_string($conn, $data->education) : '';
    $dob = isset($data->dob) ? mysqli_real_escape_string($conn, $data->dob) : '';
    $native = isset($data->native) ? mysqli_real_escape_string($conn, $data->native) : '';
    $kovil = isset($data->kovil) ? mysqli_real_escape_string($conn, $data->kovil) : '';
    $s_name = isset($data->s_name) ? mysqli_real_escape_string($conn, $data->s_name) : '';
    $WAD = isset($data->WAD) ? mysqli_real_escape_string($conn, $data->WAD) : '';
    $s_blood = isset($data->s_blood) ? mysqli_real_escape_string($conn, $data->s_blood) : '';
    $s_father_koottam = isset($data->s_father_koottam) ? mysqli_real_escape_string($conn, $data->s_father_koottam) : '';
    $s_father_kovil = isset($data->s_father_kovil) ? mysqli_real_escape_string($conn, $data->s_father_kovil) : '';
    $past_experience = isset($data->past_experience) ? mysqli_real_escape_string($conn, $data->past_experience) : '';
    $website = isset($data->website) ? mysqli_real_escape_string($conn, $data->website) : '';
    $b_year = isset($data->b_year) ? mysqli_real_escape_string($conn, $data->b_year) : '';
    $referrer_id = isset($data->referrer_id) ? mysqli_real_escape_string($conn, $data->referrer_id) : '';
    $id = isset($data->id) ? mysqli_real_escape_string($conn, $data->id) : '';

           /* $mobile = mysqli_real_escape_string($conn, $data->mobile);
           $password = mysqli_real_escape_string($conn, $data->password);
           $email = mysqli_real_escape_string($conn, $data->email);
           $member_type = mysqli_real_escape_string($conn, $data->member_type);
           $first_name = mysqli_real_escape_string($conn, $data->first_name);
           $last_name = mysqli_real_escape_string($conn, $data->last_name);
           $company_name = mysqli_real_escape_string($conn, $data->company_name);
           $blood_group = mysqli_real_escape_string($conn, $data->blood_group);
           $place = mysqli_real_escape_string($conn, $data->place);
           $pin = mysqli_real_escape_string($conn, $data->pin);
           $referrer_mobile = mysqli_real_escape_string($conn, $data->referrer_mobile);
           $type = mysqli_real_escape_string($conn, $data->type);
           $district = mysqli_real_escape_string($conn, $data->district);
           $chapter = mysqli_real_escape_string($conn, $data->chapter);
           $koottam = mysqli_real_escape_string($conn, $data->koottam);
           $marital_status = mysqli_real_escape_string($conn, $data->marital_status);
           $business_type = mysqli_real_escape_string($conn, $data->business_type);
           $company_address = mysqli_real_escape_string($conn, $data->company_address);
           $business_keywords = mysqli_real_escape_string($conn, $data->business_keywords);
           $education = mysqli_real_escape_string($conn, $data->education);
           $dob = mysqli_real_escape_string($conn, $data->dob);
           $native = mysqli_real_escape_string($conn, $data->native);
           $kovil = mysqli_real_escape_string($conn, $data->kovil);
           $s_name = mysqli_real_escape_string($conn, $data->s_name);
           $WAD = mysqli_real_escape_string($conn, $data->WAD);
           $s_blood = mysqli_real_escape_string($conn, $data->s_blood);
           $s_father_koottam = mysqli_real_escape_string($conn, $data->s_father_koottam);
           $s_father_kovil = mysqli_real_escape_string($conn, $data->s_father_kovil);
           $past_experience = mysqli_real_escape_string($conn, $data->past_experience);
           $website = mysqli_real_escape_string($conn, $data->website);
           $b_year = mysqli_real_escape_string($conn, $data->b_year);
           $referrer_id = mysqli_real_escape_string($conn, $data->referrer_id); */
          // $id = mysqli_real_escape_string($conn, $data->id);
         //   $path = "upload/$imagename";

        $updateOfferQuery = "UPDATE `registration` SET
                    first_name = '$first_name',
                    last_name = '$last_name',
                    mobile = '$mobile',
                    district ='$district',
                    chapter = '$chapter',
                    place = '$place',
                    dob = '$dob',
                    WAD = '$WAD',
                    koottam = '$koottam',
                    kovil = '$kovil',
                    blood_group = '$blood_group',
                    email = '$email',
                    s_name = '$s_name',
                    native = '$native',
                    s_father_koottam = '$s_father_koottam',
                    s_father_kovil = '$s_father_kovil',
                    education = '$education',
                    past_experience = '$past_experience',
                    company_name = '$company_name',
                    company_address = '$company_address',
                    business_keywords = '$business_keywords',
                    business_type = '$business_type',
                    marital_status = '$marital_status',
                    website = '$website',
                    b_year = '$b_year'
                    WHERE id = '$id'";
                error_log("SQL Query: " . $updateOfferQuery, 0);
                $updateOfferResult = mysqli_query($conn, $updateOfferQuery);

                if ($updateOfferResult) {
                error_log("Changes made successfully", 0);
                    echo "edit updated successfully";
                } else {
                    error_log("Database query error: " . mysqli_error($conn), 0);
                    echo "Error: " . mysqli_error($conn);
                }
            } else {
                echo json_encode(array("error" => "Invalid data received"));
            }
        }

else if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $ID = isset($_GET['ID']) ? $_GET['ID'] : null;

    if (!$ID) {
        echo json_encode(array("error" => "ID is missing in the request"));
        exit;
    }

    $ID = mysqli_real_escape_string($conn, $ID);

    $sql = "DELETE FROM registration WHERE ID = '$ID'";
    $result = $conn->query($sql);

    if ($result === false) {
        echo json_encode(array("error" => "Query failed: " . $conn->error));
    } else {
        echo json_encode(array("message" => "Offer deleted successfully"));
    }
}


mysqli_close($conn);
?>