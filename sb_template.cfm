<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title><cfOutput>#sb.title#</cfOutput></title>
	<link href="files/css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="wrapper" align="center">
		<div id="header">
			<h1><a href="<cfOutput>#sb.func.url("index")#</cfOutput>"><cfOutput>#sb.title#</cfOutput></a></h1>
			<h2>Powerfully simple (non-OO) MVC framework</h2>
		</div>
		<div id="body">
			<cfOutput>#sb.content#</cfOutput>	
		</div>
		<div id="footer">
			<p>
				<cfOutput>
					&copy; #year(now())# <a href="#sb.func.url("index")#">#sb.title#</a>
				</cfOutput>
			</p>
		</div>
	</div>
</body>
</html>