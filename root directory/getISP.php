<?PHP
error_reporting(E_ERROR);
$url = 'http://www.whoismyisp.org/';
$content = file_get_contents($url);
$first_step = explode( '<div class="jumbotron">' , $content );
$second_step = explode("</div>" , $first_step[1] );
$third_step = explode( '<div class="container">' ,$second_step[0]);
$third_step = explode("<h1>" , $second_step[0]);
$fourth_step = explode("</h1>" , $third_step[1]);
if($fourth_step[0]!=null){
	print_r($fourth_step[0]);
}else if($fourth_step[0]!= ""){
	print_r($fourth_step[0]);
}
else{
 echo "ISP NOT AVAILABLE";
}
//echo $third_step[0];
//echo "Here"
?>
