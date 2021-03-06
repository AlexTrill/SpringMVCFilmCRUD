<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Films</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">
<link rel="stylesheet" href="styles/styles.css">
<link rel="stylesheet" href="styles/tableStyles.css">
<link rel="stylesheet" href="styles/navbar.css">
</head>
<body>

	<nav class="navbar navbar-expand-md style="background-color:#e3f2fd;">
		<a class="navbar-brand" href="#">FilmMVC</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarText" aria-controls="navbarText"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarText">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link"
					href="searchFilm.do?filmid=">Search Films</a></li>
				<li><a class="nav-link" href="goAddFilm.do">Add Film</a></li>
			</ul>
		</div>
	</nav>


	<h1>Film Search</h1>

	<form action="searchFilm.do" id="searchForm">
		<div class="searchByKeywordFrom">
			<label id="keywordLabel">Keyword</label> <input type="text"
				name="filmid" placeholder="${searchTerm}">
			<button type="submit" class="btn btn-success">Search</button>
		</div>
	</form>

	<form action="showFilm.do" id="searchForm">
		<div class="searchByKeywordFrom">
			<label id="keywordLabel">Film ID</label> <input type="number"
				min="1" name="filmid">
			<button type="submit" class="btn btn-success">Search</button>
		</div>
	</form>


	<c:choose>

		<c:when test="${empty films}">
			<h4>${films.size()} films found</h4>
		</c:when>
		<c:otherwise>
			<h4>${films.size()} films found</h4>
			<table class="table table-hover">
				<thead class="thead-dark">
					<tr>
						<th>Update</th>
						<th>Delete</th>
						<th>ID</th>
						<th>Title</th>
						<th>Year</th>
						<th>Description</th>
						<th>Language</th>
						<th>Rent Length</th>
						<th>Rental Rate</th>
						<th>length</th>
						<th>Cost</th>
						<th>Rating</th>
						<th>SpecialFeatures</th>
					</tr>
				</thead>
				<c:forEach items="${films}" var="film">
					<c:choose>
						<c:when test="${film.id <= 1000}">
							<td><button class="btn btn-secondary">N/A</button></td>
							<td><button class="btn btn-danger">N/A</button></td>
						</c:when>
						<c:otherwise>
							<td><a href="displayFilm.do?filmid=${film.id}"><button
										class="btn btn-secondary">Update</button></a></td>
							<td><a
								href="removeFilmFromTable.do?filmid=${film.id}&searchTerm=${searchTerm}"><button
										class="btn btn-danger"
										onclick="return confirm('Are you sure you want to delete ${film.title}?')">Remove</button></a></td>
						</c:otherwise>
					</c:choose>
					<td>${film.id}</td>
					<td><a href="showFilm.do?filmid=${film.id}">${film.title}</a></td>
					<td>${film.releaseYear}</td>
					<td>${film.description}</td>
					<td>${film.languageId}</td>
					<td>${film.rentalDuration}</td>
					<td>${film.rental_rate}</td>
					<td>${film.length}</td>
					<td>${film.replacementCost}</td>
					<td>${film.rating}</td>
					<td>${film.specialFeatures}</td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>