<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
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
	$(document).ready(function() {
		$.ajax({
			url : "http://localhost:8081/shop/cateogries"
		}).then(function(data) {

			var tmpData = $.parseJSON(data);
			var mySelect = $('#cat_options');
			$.each(tmpData, function(val, text) {
				mySelect.append($('<option></option>').val(text).html(text));
			});
		});

		$("#submit").click(function() {
			var shopObject = new Object();
			shopObject.shopName = $('#shop_name').val();
			shopObject.shopCategory = $("#cat_options option:selected").text();
			shopObject.shopAddress = $('#pac-input').val();
			shopObject.shopLatitude = $('#lat').val();
			shopObject.shopLongitude = $('#lng').val();
			shopObject.ownerName = $('#owner_name').val();

			console.log(shopObject)

			$.ajax({
				url : 'http://localhost:8081/shop/add',
				dataType : 'json',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify(shopObject),
				processData : false,
				success : function(data, textStatus, jQxhr) {
					window.location.href = '/';
				},
				error : function(jqXhr, textStatus, errorThrown) {
					console.log(errorThrown);
				}
			});

		});

	});
</script>
<title>Add New Shop</title>
</head>
<body>

	<div id="main_div" align="center">
		<h1>Add New Shop</h1>
		<br /> <br />
		<table border="0">
			<tr>
				<td>Shop Name:</td>
				<td><input type="text" id="shop_name"></td>
			</tr>
			<tr>
				<td>Category:</td>
				<td><select id="cat_options">
				</select></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><input type="text" id="pac-input"></td>
			</tr>
			<tr>
				<td>Owner Name:</td>
				<td><input type="text" id="owner_name"></td>
			</tr>
		</table>
		<br /> <br />
		<div>
			<button id="submit">Submit</button>
			&nbsp;&nbsp;
			<button id="back" onclick="window.location.href='/'">Back</button>
		</div>
		<div>
			<input type="hidden" id="lat"></input><input type="hidden" id="lng"></input>
		</div>
		<div id="map"></div>

		<script>
			function initAutocomplete() {
				var map = new google.maps.Map(document.getElementById('map'), {
					center : {
						lat : -33.8688,
						lng : 151.2195
					},
					zoom : 13,
					mapTypeId : 'roadmap'
				});

				// Create the search box and link it to the UI element.
				var input = document.getElementById('pac-input');
				var searchBox = new google.maps.places.SearchBox(input);
				map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

				// Bias the SearchBox results towards current map's viewport.
				map.addListener('bounds_changed', function() {
					searchBox.setBounds(map.getBounds());
				});

				var markers = [];
				// Listen for the event fired when the user selects a prediction and retrieve
				// more details for that place.
				searchBox.addListener('places_changed', function() {
					var places = searchBox.getPlaces();

					if (places.length == 0) {
						return;
					}

					// Clear out the old markers.
					markers.forEach(function(marker) {
						marker.setMap(null);
					});
					markers = [];

					// For each place, get the icon, name and location.
					var bounds = new google.maps.LatLngBounds();
					places.forEach(function(place) {
						if (!place.geometry) {
							console.log("Returned place contains no geometry");
							return;
						}
						var icon = {
							url : place.icon,
							size : new google.maps.Size(71, 71),
							origin : new google.maps.Point(0, 0),
							anchor : new google.maps.Point(17, 34),
							scaledSize : new google.maps.Size(25, 25)
						};

						// Create a marker for each place.
						markers.push(new google.maps.Marker({
							map : map,
							icon : icon,
							title : place.name,
							position : place.geometry.location
						}));

						if (place.geometry.viewport) {
							// Only geocodes have viewport.
							bounds.union(place.geometry.viewport);
						} else {
							bounds.extend(place.geometry.location);
						}

						$("lat").val(place.geometry.location.lat());
						$("lng").val(place.geometry.location.lng())
					});

					map.fitBounds(bounds);
				});
			}
		</script>
		<script
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8Gu1tDfTKdbU7KpM84g-pxJYZo0ePL5U&libraries=places&callback=initAutocomplete"
			async defer></script>
	</div>
</body>
</html>