
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Loader Jsp Page</title>
</head>
<!-- 🌱 Soil Analyzer - Smart Universal Loader -->
<style>
/* ========== Base Loader Styles ========== */
#page-loader {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
	z-index: 9999;
	overflow: hidden;
	transition: opacity 0.5s ease, visibility 0.5s ease;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* -------- Logo Section -------- */
.loader-logo {
	display: flex;
	align-items: center;
	justify-content: center;
	color: #2e7d32;
	font-size: 2rem;
	font-weight: 700;
	letter-spacing: 1px;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.loader-logo i {
	font-size: 2.6rem;
	margin-right: 10px;
	color: #43a047;
	animation: pulse 1.8s infinite;
}

/* Pulse animation for the leaf icon */
@
keyframes pulse { 0%, 100% {
	transform: scale(1);
	opacity: 1;
}

50
%
{
transform
:
scale(
1.2
);
opacity
:
0.8;
}
}

/* -------- Progress Bar -------- */
.progress-bar {
	width: 200px;
	height: 7px;
	background: #a5d6a7;
	border-radius: 5px;
	overflow: hidden;
	margin-top: 25px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

.progress-fill {
	width: 0%;
	height: 100%;
	background: linear-gradient(to right, #43a047, #2e7d32);
	border-radius: 5px;
	animation: loadProgress 2.5s ease-out forwards;
}

@
keyframes loadProgress { 0% {
	width: 0%;
}

100
%
{
width
:
100%;
}
}

/* -------- Text -------- */
.loader-text {
	margin-top: 20px;
	color: #1b5e20;
	font-weight: 600;
	font-size: 1rem;
	letter-spacing: 0.5px;
}

/* -------- Responsive -------- */
@media ( max-width : 600px) {
	.loader-logo {
		font-size: 1.5rem;
	}
	.loader-logo i {
		font-size: 2rem;
	}
	.progress-bar {
		width: 150px;
	}
}

/* -------- Dark Mode -------- */
@media ( prefers-color-scheme : dark) {
	#page-loader {
		background: linear-gradient(135deg, #1b5e20 0%, #2e7d32 100%);
	}
	.loader-logo {
		color: #e8f5e9;
	}
	.loader-logo i {
		color: #81c784;
	}
	.progress-bar {
		background: #4caf50;
	}
	.progress-fill {
		background: linear-gradient(to right, #a5d6a7, #81c784);
	}
	.loader-text {
		color: #e8f5e9;
	}
}
</style>


<body>
	<!-- ===== Loader HTML ===== -->
	<div id="page-loader">
		<div class="loader-logo">
			<i class="fas fa-seedling"></i> Soil Analyzer
		</div>
		<div class="progress-bar">
			<div class="progress-fill"></div>
		</div>
		<div class="loader-text">Analyzing soil data...</div>
	</div>

	<!-- ===== Loader Script ===== -->
	<script>
document.addEventListener("DOMContentLoaded", () => {
  const loader = document.getElementById('page-loader');
  setTimeout(() => {
    loader.style.opacity = '0';
    loader.style.visibility = 'hidden';
  }, 1500);
});

window.addEventListener("beforeunload", () => {
  const loader = document.getElementById('page-loader');
  loader.style.display = 'flex';
  loader.style.opacity = '1';
  loader.style.visibility = 'visible';
});
</script>

	<!-- FontAwesome for leaf icon -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</body>
</html>