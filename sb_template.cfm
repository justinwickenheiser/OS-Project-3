<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title><cfOutput>#sb.title#</cfOutput></title>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css">
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
	<!-- Individual CSS -->
	<link href="files/css/styles.css" rel="stylesheet" type="text/css" />
	<!-- Font Awesome -->
	<link href="http://fontawesome.io/assets/font-awesome/css/font-awesome.css" rel="stylesheet" media="screen">
</head>
<body>
	<div id="wrapper" align="center">
		<div id="header">
			<h1><cfOutput>#sb.title#</cfOutput></h1>
		</div>
		<div id="body">
			<cfOutput>#sb.content#</cfOutput>	
		</div>
		<div id="footer">
			<p style="margin: 10px 0px;">
				<cfOutput>
					&copy; #year(now())# Justin Wickenheiser. All Rights Reserved.
				</cfOutput>
			</p>
		</div>
	</div>
</body>
</html>