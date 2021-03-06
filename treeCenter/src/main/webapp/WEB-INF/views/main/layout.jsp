<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<!DOCTYPE html>
<html>
	<head>
		<title>Editorial by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
		<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
		<!--bootstrap  -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		<link rel="stylesheet" href="/resources/assets/css/main.css?var=10" />
		<script src="/resources/js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>


	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">
							<!-- header -->
							<tiles:insertAttribute name="header"/>
							<!-- content -->
							<tiles:insertAttribute name="content"/>
						</div>
					</div>
				<!-- side -->
				<tiles:insertAttribute name="side"/>
			</div>	
	
<!-- Scripts -->
			
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>
			
	
	</body>
</html>