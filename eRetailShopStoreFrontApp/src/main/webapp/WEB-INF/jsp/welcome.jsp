<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.19/js/dataTables.jqueryui.min.js"></script>

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/jquery-ui-themeroller@0.0.4/lib/themeroller.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<style>
body, h1, h2, h3, h4, h5 {
	font-family: "Raleway", sans-serif;
	background-color: #e0efde;
}
</style>

<script type="text/javascript">
	$(document).ready(
			function() {

				$.ajax({
					url : "http://localhost:8081/shop/get"
				}).then(
						function(data) {

							var shopData = $.parseJSON(data);
							var dataSet = new Array();
							$.each(shopData, function(val, text) {
								dataSet[val] = [ text.shopName,
										text.shopCategory, text.shopAddress,
										text.ownerName ];
							});

							$('#table_id').DataTable({
								data : dataSet,
								columns : [ {
									title : "Shop Name",
									"searchable" : true
								}, {
									title : "Catrgory",
									"searchable" : false
								}, {
									title : "Address",
									"searchable" : true
								}, {
									title : "Owner Name",
									"searchable" : false
								}, ]
							});
						});
			});
</script>
</head>
<body>
	<h1 align="center">Shops Dashboard</h1>
	<br />
	<br />
	<table id="table_id" class="display" width="100%"></table>
	<br />
	<br />
	<div align="center">
		<button value="Add New Shop" id="add_shop"
			onclick="window.location.href='/addshop'">Add New Shop</button>
	</div>
</body>
</html>