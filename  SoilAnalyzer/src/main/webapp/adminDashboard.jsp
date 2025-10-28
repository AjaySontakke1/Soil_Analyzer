<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.Bean.Soil"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !"admin".equals(role)) {
	response.sendRedirect("login.jsp");
	return;
}

List<Soil> soilList = (List<Soil>) request.getAttribute("soilList");
Map<String, Double> avgMap = (Map<String, Double>) request.getAttribute("avgMap");
Map<String, Integer> cropCount = (Map<String, Integer>) request.getAttribute("cropCount");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - Soil Analysis</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
:root {
	--soil-dark: #8B4513;
	--soil-medium: #A0522D;
	--soil-light: #D2B48C;
	--earth-green: #556B2F;
	--leaf-green: #6B8E23;
	--growth-green: #9ACD32;
	--water-blue: #4682B4;
	--sky-blue: #87CEEB;
	--text-dark: #2F4F4F;
	--text-light: #F5F5DC;
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	--transition: all 0.3s ease;
	/* Vibrant chart colors */
	--chart-soil: #8B4513;
	--chart-moisture: #4682B4;
	--chart-organic: #556B2F;
	--chart-wheat: #F5DEB3;
	--chart-rice: #87CEEB;
	--chart-corn: #FFD700;
	--chart-cotton: #F8F8FF;
	--chart-sugarcane: #228B22;
	--chart-pulses: #CD853F;
	--chart-vegetables: #32CD32;
	--chart-fruits: #FF6347;
	--chart-other: #6A5ACD;
}

body {
	background: linear-gradient(135deg, #f5f7fa 0%, #e4e8d2 100%);
	min-height: 100vh;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: var(--text-dark);
	position: relative;
	overflow-x: hidden;
}

/* Soil-themed background elements */
.soil-layer {
	position: absolute;
	width: 100%;
	height: 20%;
	bottom: 0;
	background: linear-gradient(to top, var(--soil-dark), var(--soil-medium));
	z-index: -1;
	border-top-left-radius: 50% 20%;
	border-top-right-radius: 50% 20%;
}

.soil-layer::before {
	content: '';
	position: absolute;
	top: -10px;
	left: 0;
	width: 100%;
	height: 20px;
	background: var(--soil-light);
	border-radius: 50%;
}

.container-custom {
	max-width: 95%;
	margin: 0 auto;
	padding: 2rem 1rem;
}

/* Header Card */
.header-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
	margin-bottom: 2rem;
}

.header-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 5px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green), var(--growth-green));
}

.btn-logout {
	background: linear-gradient(to right, #dc3545, #c82333);
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-logout:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
	color: white;
}

.btn-users {
	background: linear-gradient(to right, var(--earth-green),
		var(--leaf-green));
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-users:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
	color: white;
}

/* Search and Filter Section */
.search-filter-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
	margin-bottom: 2rem;
}

.search-filter-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green));
}

.btn-search {
	background: linear-gradient(to right, var(--water-blue), var(--sky-blue));
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-search:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
	color: white;
}

.btn-filter {
	background: linear-gradient(to right, var(--earth-green),
		var(--leaf-green));
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-filter:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
	color: white;
}

/* Table Card */
.table-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
	margin-bottom: 2rem;
}

.table-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green));
}

.table thead {
	background: linear-gradient(to right, var(--soil-dark),
		var(--soil-medium));
	color: white;
}

.table tbody tr:hover {
	background-color: rgba(210, 180, 140, 0.1);
}

.btn-delete {
	background: linear-gradient(to right, #dc3545, #c82333);
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-delete:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
	color: white;
}

/* Charts Section */
.charts-section {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
}

.charts-section::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green));
}

.section-title {
	color: var(--earth-green);
	font-weight: 700;
	margin-bottom: 1.5rem;
	text-align: center;
	position: relative;
	display: inline-block;
	left: 50%;
	transform: translateX(-50%);
}

.section-title::after {
	content: '';
	position: absolute;
	bottom: -8px;
	left: 25%;
	width: 50%;
	height: 3px;
	background: linear-gradient(to right, var(--soil-light),
		var(--growth-green));
	border-radius: 2px;
}

.chart-container {
	background: white;
	border-radius: 12px;
	padding: 1.5rem;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	margin-bottom: 2rem;
	border: 1px solid rgba(139, 69, 19, 0.1);
	position: relative;
}

.chart-title {
	color: var(--earth-green);
	font-weight: 600;
	text-align: center;
	margin-bottom: 1rem;
}

/* Soil Icon */
.soil-icon {
	display: inline-block;
	width: 24px;
	height: 24px;
	background: var(--soil-medium);
	border-radius: 50%;
	margin-right: 10px;
	position: relative;
}

.soil-icon::after {
	content: '';
	position: absolute;
	top: 5px;
	left: 5px;
	width: 14px;
	height: 14px;
	background: var(--soil-light);
	border-radius: 50%;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1rem;
	}
	.container-custom {
		padding: 1rem 0.5rem;
	}
	.soil-layer {
		height: 10%;
	}
	.d-flex.justify-content-between {
		flex-direction: column;
		gap: 1rem;
	}
	.d-flex.justify-content-between>div {
		width: 100%;
	}
	.table-responsive {
		font-size: 0.875rem;
	}
}

/* Decorative elements */
.decoration-circle {
	position: absolute;
	border-radius: 50%;
	opacity: 0.1;
	z-index: -1;
}

.circle-1 {
	width: 150px;
	height: 150px;
	background: var(--soil-dark);
	top: -50px;
	right: -50px;
}

.circle-2 {
	width: 100px;
	height: 100px;
	background: var(--earth-green);
	bottom: -30px;
	left: -30px;
}

/* Chart enhancements */
.chart-legend {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 1rem;
	margin-top: 1rem;
}

.legend-item {
	display: flex;
	align-items: center;
	gap: 0.5rem;
	font-size: 0.875rem;
}

.legend-color {
	width: 12px;
	height: 12px;
	border-radius: 2px;
}
/* Media Queries for Responsive Design */

/* Large devices (desktops, 1200px and up) */
@media ( min-width : 1200px) {
	.container-custom {
		max-width: 90%;
		padding: 3rem 1rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 2rem;
	}
	.chart-container {
		padding: 2rem;
	}
	.section-title {
		font-size: 1.5rem;
		margin-bottom: 2rem;
	}
	.chart-title {
		font-size: 1.2rem;
		margin-bottom: 1.5rem;
	}
}

/* Medium devices (tablets, 768px to 1199px) */
@media ( min-width : 768px) and (max-width: 1199px) {
	.container-custom {
		max-width: 98%;
		padding: 2rem 1rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1.75rem;
	}
	.soil-layer {
		height: 15%;
	}
	.search-filter-card .d-flex {
		flex-direction: column;
	}
	.search-filter-card .d-flex>form {
		width: 100%;
		margin-bottom: 1rem;
	}
	.search-filter-card .d-flex>form:last-child {
		margin-bottom: 0;
	}
	.table-responsive {
		font-size: 0.9rem;
	}
	.chart-container {
		padding: 1.25rem;
	}
	#avgChart, #cropChart {
		height: 220px !important;
	}
	.chart-legend {
		gap: 0.75rem;
	}
	.legend-item {
		font-size: 0.8rem;
	}
}

/* Small devices (landscape phones, 576px to 767px) */
@media ( min-width : 576px) and (max-width: 767px) {
	.container-custom {
		max-width: 100%;
		padding: 1.5rem 0.75rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1.5rem;
		border-radius: 12px;
	}
	.soil-layer {
		height: 12%;
		border-top-left-radius: 40% 15%;
		border-top-right-radius: 40% 15%;
	}
	.header-card h3 {
		font-size: 1.3rem;
		text-align: center;
		width: 100%;
		margin-bottom: 1rem;
	}
	.d-flex.justify-content-between.align-items-center {
		flex-direction: column;
		text-align: center;
	}
	.section-title {
		font-size: 1.2rem;
		margin-bottom: 1.25rem;
	}
	.search-filter-card .d-flex {
		flex-direction: column;
		gap: 1rem !important;
	}
	.search-filter-card .input-group {
		width: 100%;
	}
	.table-responsive {
		font-size: 0.8rem;
	}
	.btn-delete {
		font-size: 0.75rem;
		padding: 0.25rem 0.5rem;
	}
	.chart-container {
		padding: 1rem;
		margin-bottom: 1.5rem;
	}
	#avgChart, #cropChart {
		height: 200px !important;
	}
	.chart-legend {
		gap: 0.5rem;
		margin-top: 0.75rem;
	}
	.legend-item {
		font-size: 0.75rem;
	}
	.legend-color {
		width: 10px;
		height: 10px;
	}
}

/* Extra small devices (portrait phones, less than 576px) */
@media ( max-width : 575px) {
	.container-custom {
		max-width: 100%;
		padding: 1rem 0.5rem;
		margin: 0 auto;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1.25rem;
		border-radius: 10px;
		margin-bottom: 1.5rem;
	}
	.header-card h3 {
		font-size: 1.1rem;
		text-align: center;
		width: 100%;
		margin-bottom: 1rem;
	}
	.btn-logout, .btn-users {
		width: 100%;
		max-width: 200px;
		font-size: 0.9rem;
	}
	.soil-layer {
		height: 8%;
		border-top-left-radius: 30% 10%;
		border-top-right-radius: 30% 10%;
	}
	.section-title {
		font-size: 1.1rem;
		margin-bottom: 1rem;
	}

	/* Search and Filter Section */
	.search-filter-card .d-flex {
		flex-direction: column;
		gap: 1rem !important;
	}
	.search-filter-card .input-group {
		flex-direction: column;
		width: 100%;
	}
	.search-filter-card .input-group-text {
		border-radius: 8px 8px 0 0 !important;
		justify-content: center;
	}
	.search-filter-card .form-control {
		border-radius: 0 !important;
		border-top: none;
	}
	.search-filter-card .btn {
		border-radius: 0 0 8px 8px !important;
		width: 100%;
	}

	/* Table Section */
	.table-responsive {
		font-size: 0.75rem;
	}
	.table thead th {
		padding: 0.5rem 0.25rem;
		font-size: 0.7rem;
	}
	.table tbody td {
		padding: 0.5rem 0.25rem;
	}
	.btn-delete {
		font-size: 0.7rem;
		padding: 0.2rem 0.4rem;
	}

	/* Charts Section */
	.charts-section .row {
		margin: 0;
	}
	.charts-section .col-md-6 {
		padding: 0;
		margin-bottom: 1rem;
	}
	.chart-container {
		padding: 1rem;
		margin-bottom: 1rem;
	}
	.chart-title {
		font-size: 0.9rem;
		margin-bottom: 0.75rem;
	}
	#avgChart, #cropChart {
		height: 180px !important;
	}

	/* Adjust chart legends for mobile */
	.chart-legend {
		gap: 0.5rem;
		margin-top: 0.5rem;
	}
	.legend-item {
		font-size: 0.7rem;
	}
	.legend-color {
		width: 8px;
		height: 8px;
	}

	/* Hide decorative elements on very small screens */
	.decoration-circle {
		display: none;
	}

	/* Soil icon adjustments */
	.soil-icon {
		width: 18px;
		height: 18px;
		margin-right: 6px;
	}
	.soil-icon::after {
		width: 10px;
		height: 10px;
		top: 4px;
		left: 4px;
	}
}

/* Very small devices (phones less than 400px) */
@media ( max-width : 400px) {
	.container-custom {
		padding: 0.75rem 0.25rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1rem;
	}
	.header-card h3 {
		font-size: 1rem;
	}
	.section-title {
		font-size: 1rem;
	}
	.table-responsive {
		font-size: 0.7rem;
	}
	.table thead th {
		padding: 0.4rem 0.2rem;
		font-size: 0.65rem;
	}
	.table tbody td {
		padding: 0.4rem 0.2rem;
	}
	.btn-delete {
		font-size: 0.65rem;
		padding: 0.15rem 0.3rem;
	}
	.chart-container {
		padding: 0.875rem;
	}
	#avgChart, #cropChart {
		height: 160px !important;
	}
	.chart-title {
		font-size: 0.85rem;
	}
	.soil-icon {
		width: 16px;
		height: 16px;
		margin-right: 4px;
	}
	.soil-icon::after {
		width: 8px;
		height: 8px;
		top: 4px;
		left: 4px;
	}
}

/* Landscape orientation for mobile devices */
@media ( max-height : 600px) and (orientation: landscape) {
	.container-custom {
		padding: 0.5rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 1rem;
		margin-bottom: 1rem;
	}
	.soil-layer {
		height: 25%;
	}
	.table-responsive {
		max-height: 200px;
		overflow-y: auto;
	}
	.charts-section .row {
		flex-direction: column;
	}
	.chart-container {
		margin-bottom: 1rem;
	}
	#avgChart, #cropChart {
		height: 150px !important;
	}
}

/* High resolution displays (2x and above) */
@media ( -webkit-min-device-pixel-ratio : 2) , ( min-resolution :
	192dpi) {
	.header-card, .search-filter-card, .table-card, .charts-section {
		border: 1px solid rgba(139, 69, 19, 0.15);
	}
	.chart-container {
		border: 1px solid rgba(139, 69, 19, 0.1);
	}
}

/* Print styles */
@media print {
	.soil-layer, .decoration-circle {
		display: none;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		box-shadow: none;
		border: 2px solid #000;
		background: white;
	}
	.btn-logout, .btn-search, .btn-filter, .btn-delete, .btn-users {
		display: none;
	}
	.table thead {
		background: #000 !important;
		color: white !important;
		-webkit-print-color-adjust: exact;
	}
	.chart-container {
		page-break-inside: avoid;
		border: 1px solid #000;
	}
}

/* Reduced motion for accessibility */
@media ( prefers-reduced-motion : reduce) {
	.btn-logout:hover, .btn-search:hover, .btn-filter:hover, .btn-delete:hover,
		.btn-users:hover {
		transform: none;
	}
	:root {
		--transition: all 0.1s ease;
	}

	/* Disable chart animations */
	#avgChart, #cropChart {
		animation: none !important;
	}
}

/* Dark mode support */
@media ( prefers-color-scheme : dark) {
	@media ( max-width : 768px) {
		.header-card, .search-filter-card, .table-card, .charts-section {
			background: rgba(30, 30, 30, 0.95);
			color: #e0e0e0;
		}
		.chart-container {
			background: #2d2d2d;
			color: #e0e0e0;
		}
		.table {
			color: #e0e0e0;
		}
		.table thead {
			background: #1a1a1a !important;
		}
	}
}

/* Touch device optimizations */
@media ( hover : none) and (pointer: coarse) {
	.btn-logout:hover, .btn-search:hover, .btn-filter:hover, .btn-delete:hover,
		.btn-users:hover {
		transform: none;
		box-shadow: none;
	}
	.btn-logout:active, .btn-search:active, .btn-filter:active, .btn-delete:active,
		.btn-users:active {
		transform: scale(0.98);
	}
	.table tbody tr {
		min-height: 44px; /* Minimum touch target size */
	}
}

/* Foldable devices support */
@media ( max-width : 350px) {
	.container-custom {
		padding: 0.5rem 0.1rem;
	}
	.header-card, .search-filter-card, .table-card, .charts-section {
		padding: 0.75rem;
	}
	.header-card h3 {
		font-size: 0.9rem;
	}
	.section-title {
		font-size: 0.9rem;
	}
	.table-responsive {
		font-size: 0.65rem;
	}
	.chart-title {
		font-size: 0.8rem;
	}
	#avgChart, #cropChart {
		height: 140px !important;
	}
}
</style>
</head>

<body>
	<%@ include file="loader.jsp"%>
	<!-- rest of your page -->

	<!-- Background elements -->
	<div class="soil-layer"></div>
	<div class="decoration-circle circle-1"></div>
	<div class="decoration-circle circle-2"></div>

	<div class="container-custom">
		<!-- Header Card -->
		<div class="header-card">
			<div
				class="d-flex justify-content-between align-items-center flex-wrap">
				<h3 class="mb-0">
					<span class="soil-icon"></span>Admin Dashboard - Soil Analysis
				</h3>
				<div class="d-flex gap-2">
					<a href="ViewUserServlet" class="btn btn-users"> <i
						class="fas fa-users me-1"></i>View All Users
					</a> <a href="LogoutServlet" class="btn btn-logout"> <i
						class="fas fa-sign-out-alt me-1"></i>Logout
					</a>
				</div>
			</div>
		</div>

		<!-- Search and Filter Card -->
		<div class="search-filter-card">
			<div class="d-flex justify-content-between flex-wrap gap-3">
				<form class="d-flex flex-grow-1" method="get"
					action="AdminDashboardServlet">
					<div class="input-group">
						<span class="input-group-text bg-light"><i
							class="fas fa-search"></i></span> <input type="text" name="searchUser"
							class="form-control" placeholder="Search by username">
						<button class="btn btn-search">Search</button>
					</div>
				</form>

				<form class="d-flex flex-grow-1" method="get"
					action="AdminDashboardServlet">
					<div class="input-group">
						<span class="input-group-text bg-light"><i
							class="fas fa-filter"></i></span> <input type="text"
							name="filterLocation" class="form-control"
							placeholder="Filter by location">
						<button class="btn btn-filter">Filter</button>
					</div>
				</form>
			</div>
		</div>

		<!-- Table Card -->
		<div class="table-card">
			<h5 class="section-title">Soil Analysis Records</h5>
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>User</th>
							<th>Location</th>
							<th>pH</th>
							<th>Moisture</th>
							<th>Organic</th>
							<th>Crops</th>
							<th>Email</th>
							<th>Date</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (soilList != null && !soilList.isEmpty()) {
							for (Soil s : soilList) {
						%>
						<tr>
							<td><%=s.getId()%></td>
							<td><%=s.getUsername()%></td>
							<td><%=s.getLocation()%></td>
							<td><%=s.getPh()%></td>
							<td><%=s.getMoisture()%></td>
							<td><%=s.getOrganic()%></td>
							<td><%=s.getCropRecommendation()%></td>
							<td><%=s.getEmail() != null ? s.getEmail() : "-"%></td>
							<td><%=s.getTestDate()%></td>
							<td><a href="DeleteSoilServlet?id=<%=s.getId()%>"
								class="btn btn-delete btn-sm"><i class="fas fa-trash me-1"></i>Delete</a></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="10" class="text-center py-4">No records found</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Charts Section -->
		<div class="charts-section">
			<h5 class="section-title">Analytics Overview</h5>

			<div class="row">
				<div class="col-md-6">
					<div class="chart-container">
						<h6 class="chart-title">Average Soil Parameters</h6>
						<canvas id="avgChart" height="250"></canvas>
						<div class="chart-legend">
							<div class="legend-item">
								<div class="legend-color"
									style="background-color: var(--chart-soil);"></div>
								<span>pH Level</span>
							</div>
							<div class="legend-item">
								<div class="legend-color"
									style="background-color: var(--chart-moisture);"></div>
								<span>Moisture %</span>
							</div>
							<div class="legend-item">
								<div class="legend-color"
									style="background-color: var(--chart-organic);"></div>
								<span>Organic %</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="chart-container">
						<h6 class="chart-title">Crop Distribution</h6>
						<canvas id="cropChart" height="250"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Chart Scripts -->
	<script>
    const avgPh = <%=(avgMap != null && avgMap.get("ph") != null) ? avgMap.get("ph") : 0%>;
    const avgMoist = <%=(avgMap != null && avgMap.get("moisture") != null) ? avgMap.get("moisture") : 0%>;
    const avgOrg = <%=(avgMap != null && avgMap.get("organic") != null) ? avgMap.get("organic") : 0%>;

    // Vibrant color palette for charts
    const vibrantColors = {
      soil: '#8B4513',
      moisture: '#4682B4', 
      organic: '#556B2F',
      wheat: '#F5DEB3',
      rice: '#87CEEB',
      corn: '#FFD700',
      cotton: '#F8F8FF',
      sugarcane: '#228B22',
      pulses: '#CD853F',
      vegetables: '#32CD32',
      fruits: '#FF6347',
      other: '#6A5ACD'
    };

    // Average Chart with attractive colors
    new Chart(document.getElementById('avgChart'), {
      type: 'bar',
      data: {
        labels: ['pH Level', 'Moisture %', 'Organic %'],
        datasets: [{
          label: 'Average Value',
          data: [avgPh, avgMoist, avgOrg],
          backgroundColor: [
            vibrantColors.soil,
            vibrantColors.moisture,
            vibrantColors.organic
          ],
          borderColor: [
            '#654321',
            '#36648B',
            '#455A2A'
          ],
          borderWidth: 2,
          borderRadius: 8,
          borderSkipped: false,
        }]
      },
      options: { 
        scales: { 
          y: { 
            beginAtZero: true,
            title: {
              display: true,
              text: 'Value',
              color: '#2F4F4F',
              font: {
                weight: 'bold'
              }
            },
            grid: {
              color: 'rgba(139, 69, 19, 0.1)'
            }
          },
          x: {
            grid: {
              color: 'rgba(139, 69, 19, 0.1)'
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          tooltip: {
            backgroundColor: 'rgba(47, 79, 79, 0.9)',
            titleColor: '#fff',
            bodyColor: '#fff',
            borderColor: vibrantColors.soil,
            borderWidth: 2
          }
        },
        animation: {
          duration: 2000,
          easing: 'easeOutQuart'
        }
      }
    });

    // Crop Distribution Chart with attractive colors
    const cropLabels = [];
    const cropValues = [];
    <%if (cropCount != null && !cropCount.isEmpty()) {
	for (Map.Entry<String, Integer> entry : cropCount.entrySet()) {%>
        cropLabels.push('<%=entry.getKey()%>');
        cropValues.push(<%=entry.getValue()%>);
    <%}
}%>

    // Color mapping for common crops
    const cropColorMap = {
      'wheat': vibrantColors.wheat,
      'rice': vibrantColors.rice,
      'corn': vibrantColors.corn,
      'cotton': vibrantColors.cotton,
      'sugarcane': vibrantColors.sugarcane,
      'pulses': vibrantColors.pulses,
      'vegetables': vibrantColors.vegetables,
      'fruits': vibrantColors.fruits
    };

    // Generate colors based on crop names
    const cropColors = cropLabels.map(label => {
      const lowerLabel = label.toLowerCase();
      for (const [crop, color] of Object.entries(cropColorMap)) {
        if (lowerLabel.includes(crop)) {
          return color;
        }
      }
      // Default colors for other crops
      return vibrantColors.other;
    });

    new Chart(document.getElementById('cropChart'), {
      type: 'doughnut',
      data: {
        labels: cropLabels,
        datasets: [{
          data: cropValues,
          backgroundColor: cropColors,
          borderColor: cropColors.map(color => {
            // Darken the color for borders
            return color.replace(/^#/, '').replace(/../g, color => ('0'+Math.min(255, Math.max(0, parseInt(color, 16) - 40)).toString(16)).substr(-2));
          }),
          borderWidth: 2,
          hoverOffset: 15
        }]
      },
      options: { 
        responsive: true,
        plugins: {
          legend: {
            position: 'right',
            labels: {
              color: '#2F4F4F',
              font: {
                size: 11,
                weight: '500'
              },
              padding: 15
            }
          },
          tooltip: {
            backgroundColor: 'rgba(47, 79, 79, 0.9)',
            titleColor: '#fff',
            bodyColor: '#fff',
            callbacks: {
              label: function(context) {
                const label = context.label || '';
                const value = context.raw || 0;
                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                const percentage = Math.round((value / total) * 100);
                return `${label}: ${value} (${percentage}%)`;
              }
            }
          }
        },
        cutout: '50%',
        animation: {
          animateScale: true,
          animateRotate: true,
          duration: 2000,
          easing: 'easeOutQuart'
        }
      }
    });
  </script>
</body>
</html>