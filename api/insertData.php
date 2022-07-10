<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		
		$user = $_GET['user'];
		$password = $_GET['password'];
		$name_prefix = $_GET['name_prefix'];
		$name = $_GET['name'];
		$surname = $_GET['surname'];
		$sex = $_GET['sex'];
		$email = $_GET['email'];
		$pic_members = $_GET['pic_members'];
		$role_id  = $_GET['role_id'];
		

		
							
		$sql = "INSERT INTO `members`(`members_id`, `user`, `password`, `name_prefix`, `name`, `surname`, `sex`, `email`, `pic_members`, `role_id`) VALUES (Null,'$user','$password','$name_prefix','$name','$surname','$sex','$email','$pic_members','$role_id')";


		$result = mysqli_query($link, $sql);
        echo $sql;

		if ($result) {
			echo "true";
		} else {
			echo "false";
			
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>