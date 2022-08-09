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
				
		
		$name_product = $_GET['name_product'];
		$detail_product = $_GET['detail_product'];
		$price_product = $_GET['price_product'];
		$pic_product = $_GET['pic_product'];
		
		
		
							
		$sql = "INSERT INTO `product`(`product_id`, `name_product`, `detail_product`, `price_product`, `pic_product`) VALUES (Null,'$name_product','$detail_product','$price_product','$pic_product')";

		$result = mysqli_query($link, $sql);
		// echo $sql;

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>