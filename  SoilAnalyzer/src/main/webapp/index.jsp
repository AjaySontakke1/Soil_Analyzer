<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String username = (String) session.getAttribute("username");
  if (username == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Soil Analyzer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
      height: 25%;
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
    
    /* Decorative plants */
    .plant-decoration {
      position: absolute;
      bottom: 25%;
      width: 100%;
      height: 150px;
      z-index: -1;
      overflow: hidden;
    }
    
    .plant {
      position: absolute;
      bottom: 0;
      width: 6px;
      background: linear-gradient(to top, var(--earth-green), var(--leaf-green));
      border-radius: 4px 4px 0 0;
      height: 80px;
    }
    
    .plant:nth-child(1) { left: 10%; height: 120px; }
    .plant:nth-child(2) { left: 20%; height: 90px; }
    .plant:nth-child(3) { left: 30%; height: 110px; }
    .plant:nth-child(4) { left: 40%; height: 85px; }
    .plant:nth-child(5) { left: 50%; height: 100px; }
    .plant:nth-child(6) { left: 60%; height: 95px; }
    .plant:nth-child(7) { left: 70%; height: 115px; }
    .plant:nth-child(8) { left: 80%; height: 105px; }
    .plant:nth-child(9) { left: 90%; height: 125px; }
    
    .leaf {
      position: absolute;
      width: 16px;
      height: 10px;
      background: var(--leaf-green);
      border-radius: 50% 0 50% 50%;
      transform-origin: bottom right;
    }
    
    .plant:nth-child(1) .leaf:nth-child(1) { bottom: 30px; transform: rotate(-25deg); }
    .plant:nth-child(1) .leaf:nth-child(2) { bottom: 60px; transform: rotate(20deg); }
    .plant:nth-child(1) .leaf:nth-child(3) { bottom: 90px; transform: rotate(-30deg); }
    
    .plant:nth-child(2) .leaf:nth-child(1) { bottom: 25px; transform: rotate(15deg); }
    .plant:nth-child(2) .leaf:nth-child(2) { bottom: 50px; transform: rotate(-20deg); }
    
    .plant:nth-child(3) .leaf:nth-child(1) { bottom: 35px; transform: rotate(-15deg); }
    .plant:nth-child(3) .leaf:nth-child(2) { bottom: 65px; transform: rotate(25deg); }
    .plant:nth-child(3) .leaf:nth-child(3) { bottom: 95px; transform: rotate(-20deg); }
    
    .plant:nth-child(4) .leaf:nth-child(1) { bottom: 30px; transform: rotate(20deg); }
    .plant:nth-child(4) .leaf:nth-child(2) { bottom: 55px; transform: rotate(-15deg); }
    
    .plant:nth-child(5) .leaf:nth-child(1) { bottom: 40px; transform: rotate(-20deg); }
    .plant:nth-child(5) .leaf:nth-child(2) { bottom: 70px; transform: rotate(15deg); }
    
    .plant:nth-child(6) .leaf:nth-child(1) { bottom: 35px; transform: rotate(25deg); }
    .plant:nth-child(6) .leaf:nth-child(2) { bottom: 65px; transform: rotate(-15deg); }
    
    .plant:nth-child(7) .leaf:nth-child(1) { bottom: 45px; transform: rotate(-25deg); }
    .plant:nth-child(7) .leaf:nth-child(2) { bottom: 75px; transform: rotate(20deg); }
    .plant:nth-child(7) .leaf:nth-child(3) { bottom: 105px; transform: rotate(-15deg); }
    
    .plant:nth-child(8) .leaf:nth-child(1) { bottom: 40px; transform: rotate(15deg); }
    .plant:nth-child(8) .leaf:nth-child(2) { bottom: 70px; transform: rotate(-25deg); }
    
    .plant:nth-child(9) .leaf:nth-child(1) { bottom: 50px; transform: rotate(-20deg); }
    .plant:nth-child(9) .leaf:nth-child(2) { bottom: 80px; transform: rotate(15deg); }
    .plant:nth-child(9) .leaf:nth-child(3) { bottom: 110px; transform: rotate(-25deg); }
    
    .container-custom {
      max-width: 800px;
      margin: 0 auto;
      padding: 2rem 1rem;
    }
    
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
      background: linear-gradient(to right, var(--soil-dark), var(--earth-green), var(--growth-green));
    }
    
    .user-welcome {
      color: var(--earth-green);
      font-weight: 600;
    }
    
    .username {
      color: var(--soil-dark);
      font-weight: 700;
    }
    
    .btn-report {
      background: linear-gradient(to right, var(--water-blue), var(--sky-blue));
      border: none;
      color: white;
      font-weight: 600;
      transition: var(--transition);
    }
    
    .btn-report:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
      color: white;
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
    
    .analysis-card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 16px;
      box-shadow: var(--shadow);
      padding: 2.5rem;
      border: none;
      position: relative;
      overflow: hidden;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(139, 69, 19, 0.1);
    }
    
    .analysis-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 6px;
      background: linear-gradient(to right, var(--soil-dark), var(--earth-green), var(--growth-green));
    }
    
    .card-title {
      color: var(--earth-green);
      font-weight: 700;
      margin-bottom: 1.5rem;
      text-align: center;
      position: relative;
      display: inline-block;
      left: 50%;
      transform: translateX(-50%);
    }
    
    .card-title::after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 25%;
      width: 50%;
      height: 3px;
      background: linear-gradient(to right, var(--soil-light), var(--growth-green));
      border-radius: 2px;
    }
    
    .form-group {
      margin-bottom: 1.5rem;
      position: relative;
    }
    
    .form-label {
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: var(--earth-green);
      display: flex;
      align-items: center;
    }
    
    .form-label i {
      margin-right: 8px;
      color: var(--soil-medium);
      width: 20px;
      text-align: center;
    }
    
    .form-control {
      border: 2px solid #e9ecef;
      border-radius: 8px;
      padding: 0.75rem 1rem;
      font-size: 1rem;
      transition: var(--transition);
      background: #f9f9f9;
    }
    
    .form-control:focus {
      border-color: var(--earth-green);
      box-shadow: 0 0 0 0.2rem rgba(85, 107, 47, 0.25);
      background: white;
    }
    
    .btn-analyze {
      background: linear-gradient(to right, var(--earth-green), var(--leaf-green));
      border: none;
      color: white;
      padding: 0.75rem 2rem;
      font-weight: 600;
      border-radius: 8px;
      width: 100%;
      transition: var(--transition);
      margin-top: 0.5rem;
      position: relative;
      overflow: hidden;
    }
    
    .btn-analyze::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
      transition: var(--transition);
    }
    
    .btn-analyze:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
    }
    
    .btn-analyze:hover::before {
      left: 100%;
    }
    
    .optional-badge {
      background-color: var(--soil-light);
      color: var(--text-dark);
      font-size: 0.75rem;
      padding: 0.25rem 0.5rem;
      border-radius: 4px;
      margin-left: 0.5rem;
    }
    
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
    
    /* Water drops */
    .water-drop {
      position: absolute;
      width: 8px;
      height: 8px;
      background: var(--water-blue);
      border-radius: 50% 50% 50% 0;
      opacity: 0.7;
      z-index: -1;
      animation: dropWater 3s infinite;
    }
    
    .water-drop:nth-child(1) { top: 15%; left: 15%; animation-delay: 0s; }
    .water-drop:nth-child(2) { top: 25%; left: 85%; animation-delay: 1s; }
    .water-drop:nth-child(3) { top: 40%; left: 10%; animation-delay: 2s; }
    .water-drop:nth-child(4) { top: 60%; left: 90%; animation-delay: 1.5s; }
    .water-drop:nth-child(5) { top: 75%; left: 5%; animation-delay: 0.5s; }
    
    @keyframes dropWater {
      0% { transform: translateY(-100px) scale(0.8); opacity: 0; }
      50% { opacity: 0.7; }
      100% { transform: translateY(0) scale(1); opacity: 0; }
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      .header-card {
        padding: 1rem;
      }
      
      .analysis-card {
        padding: 1.5rem;
      }
      
      .container-custom {
        padding: 1rem 0.5rem;
      }
      
      .soil-layer {
        height: 15%;
      }
      
      .d-flex.justify-content-between {
        flex-direction: column;
        gap: 1rem;
      }
      
      .d-flex.justify-content-between > div {
        width: 100%;
        text-align: center;
      }
      
      .plant-decoration {
        display: none;
      }
    }
  </style>
</head>
<body>
  <!-- Background elements -->
  <div class="soil-layer"></div>
  <div class="plant-decoration">
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
    <div class="plant">
      <div class="leaf"></div>
      <div class="leaf"></div>
      <div class="leaf"></div>
    </div>
  </div>
  
  <div class="decoration-circle circle-1"></div>
  <div class="decoration-circle circle-2"></div>
  
  <!-- Water drops -->
  <div class="water-drop"></div>
  <div class="water-drop"></div>
  <div class="water-drop"></div>
  <div class="water-drop"></div>
  <div class="water-drop"></div>
  
  <div class="container-custom">
    <!-- Header Card -->
    <div class="header-card">
      <div class="d-flex justify-content-between align-items-center flex-wrap">
        <h3 class="mb-0"><span class="soil-icon"></span>Soil Analyzer</h3>
        <div class="d-flex align-items-center flex-wrap gap-2">
          <span class="user-welcome">Hello, <span class="username"><%= username %></span></span>
          <a href="ReportServlet" class="btn btn-report btn-sm">
            <i class="fas fa-chart-bar me-1"></i>My Reports
          </a>
          <a href="LogoutServlet" class="btn btn-logout btn-sm">
            <i class="fas fa-sign-out-alt me-1"></i>Logout
          </a>
        </div>
      </div>
    </div>
    
    <!-- Analysis Form Card -->
    <div class="analysis-card">
      <h4 class="card-title">Soil Analysis Form</h4>
      
      <form action="SoilServlet" method="post">
        <div class="form-group">
          <label class="form-label">
            <i class="fas fa-map-marker-alt"></i> Location
          </label>
          <input type="text" name="location" class="form-control" placeholder="Enter soil sample location" required>
        </div>
        
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">
                <i class="fas fa-flask"></i> Soil pH
              </label>
              <input type="number" step="0.1" name="ph" class="form-control" min="0" max="14" placeholder="0.0 - 14.0" required>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">
                <i class="fas fa-tint"></i> Moisture (%)
              </label>
              <input type="number" name="moisture" class="form-control" min="0" max="100" placeholder="0 - 100" required>
            </div>
          </div>
        </div>
        
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">
                <i class="fas fa-leaf"></i> Organic Matter (%)
              </label>
              <input type="number" name="organic" class="form-control" min="0" max="100" placeholder="0 - 100" required>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <label class="form-label">
                <i class="fas fa-envelope"></i> Email
                <span class="optional-badge">Optional</span>
              </label>
              <input type="email" name="email" class="form-control" placeholder="Optional - report will be emailed">
            </div>
          </div>
        </div>
        
        <button type="submit" class="btn btn-analyze">
          <i class="fas fa-seedling me-2"></i>Analyze Soil
        </button>
      </form>
    </div>
  </div>
</body>
</html>