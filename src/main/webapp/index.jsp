<html>
<head>
<title> Hello Guys!</title>
</head>
<body>
	<h1>Suuceesfully installed tomcat !</h1>
	<p>
		It is now build and deployed
		<%= new java.util.Date() %></p>
	<p>
		You are coming from 
		<%= request.getRemoteAddr()  %></p>
</body>
