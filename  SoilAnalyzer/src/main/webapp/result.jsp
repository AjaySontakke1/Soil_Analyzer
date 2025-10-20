<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Soil Analysis Report</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
      max-width: 800px;
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
      background: linear-gradient(to right, var(--soil-dark), var(--earth-green), var(--growth-green));
    }
    
    .btn-back {
      background: linear-gradient(to right, var(--water-blue), var(--sky-blue));
      border: none;
      color: white;
      font-weight: 600;
      transition: var(--transition);
    }
    
    .btn-back:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(70, 130, 180, 0.4);
      color: white;
    }
    
    /* Report Card */
    .report-card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 16px;
      box-shadow: var(--shadow);
      padding: 2rem;
      border: none;
      position: relative;
      overflow: hidden;
      backdrop-filter: blur(10px);
      border: 1px solid rgba(139, 69, 19, 0.1);
    }
    
    .report-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 6px;
      background: linear-gradient(to right, var(--soil-dark), var(--earth-green), var(--growth-green));
    }
    
    .section-title {
      color: var(--earth-green);
      font-weight: 700;
      margin-bottom: 1.5rem;
      padding-bottom: 0.5rem;
      border-bottom: 2px solid var(--soil-light);
      position: relative;
    }
    
    .section-title::before {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 50px;
      height: 2px;
      background: var(--growth-green);
    }
    
    .analysis-result {
      background: rgba(139, 69, 19, 0.05);
      border-left: 4px solid var(--earth-green);
      padding: 1.5rem;
      border-radius: 8px;
      margin-bottom: 2rem;
      font-size: 1.1rem;
      line-height: 1.6;
    }
    
    .crop-list {
      background: white;
      border-radius: 12px;
      padding: 0;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      border: 1px solid rgba(139, 69, 19, 0.1);
      margin-bottom: 2rem;
    }
    
    .crop-item {
      padding: 1.25rem 1.5rem;
      border-bottom: 1px solid rgba(139, 69, 19, 0.1);
      transition: var(--transition);
    }
    
    .crop-item:last-child {
      border-bottom: none;
    }
    
    .crop-item:hover {
      background-color: rgba(210, 180, 140, 0.1);
    }
    
    .crop-name {
      color: var(--earth-green);
      font-weight: 700;
      margin-bottom: 0.5rem;
    }
    
    .crop-description {
      color: var(--text-dark);
      line-height: 1.5;
      margin: 0;
    }
    
    .chart-container {
      background: white;
      border-radius: 12px;
      padding: 1.5rem;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      border: 1px solid rgba(139, 69, 19, 0.1);
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
    
    /* Status indicators */
    .param-badge {
      display: inline-flex;
      align-items: center;
      background: rgba(139, 69, 19, 0.1);
      padding: 0.5rem 1rem;
      border-radius: 20px;
      margin: 0.25rem;
      font-size: 0.9rem;
    }
    
    .param-badge i {
      margin-right: 0.5rem;
      color: var(--soil-medium);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      .header-card, .report-card {
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
      
      .d-flex.justify-content-between > div {
        width: 100%;
        text-align: center;
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
    
    /* Success animation */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    .report-card > * {
      animation: fadeInUp 0.6s ease-out;
    }
    
    .report-card > *:nth-child(1) { animation-delay: 0.1s; }
    .report-card > *:nth-child(2) { animation-delay: 0.2s; }
    .report-card > *:nth-child(3) { animation-delay: 0.3s; }
    .report-card > *:nth-child(4) { animation-delay: 0.4s; }
  </style>
</head>
<body>
  <!-- Background elements -->
  <div class="soil-layer"></div>
  <div class="decoration-circle circle-1"></div>
  <div class="decoration-circle circle-2"></div>
  
  <div class="container-custom">
    <!-- Header Card -->
    <div class="header-card">
      <div class="d-flex justify-content-between align-items-center flex-wrap">
        <h3 class="mb-0"><span class="soil-icon"></span>Soil Analysis Report</h3>
        <a href="index.jsp" class="btn btn-back">
          <i class="fas fa-arrow-left me-1"></i>Back to Analysis
        </a>
      </div>
    </div>

    <!-- Report Card -->
    <div class="report-card">
      <!-- Analysis Section -->
      <h5 class="section-title">
        <i class="fas fa-chart-line me-2"></i>Soil Analysis Summary
      </h5>
      <div class="analysis-result">
        <p class="mb-0"><%= request.getAttribute("analysisResult") %></p>
      </div>

      <!-- Current Parameters -->
      <div class="d-flex flex-wrap mb-4">
        <div class="param-badge">
          <i class="fas fa-flask"></i>
          pH: <%= request.getAttribute("ph") %>
        </div>
        <div class="param-badge">
          <i class="fas fa-tint"></i>
          Moisture: <%= request.getAttribute("moisture") %>%
        </div>
        <div class="param-badge">
          <i class="fas fa-leaf"></i>
          Organic: <%= request.getAttribute("organic") %>%
        </div>
      </div>

      <!-- Recommended Crops Section -->
      <h5 class="section-title">
        <i class="fas fa-seedling me-2"></i>Recommended Crops & Information
      </h5>
      <div class="crop-list">
        <%
           Map<String,String> selectedCrops = (Map<String,String>) request.getAttribute("selectedCrops");
           if (selectedCrops != null) {
               for (Map.Entry<String,String> e : selectedCrops.entrySet()) {
        %>
          <div class="crop-item">
            <div class="crop-name"><%= e.getKey() %></div>
            <div class="crop-description"><%= e.getValue() %></div>
          </div>
        <%   } 
           }
        %>
      </div>

      <!-- Soil Parameters Chart -->
      <h5 class="section-title">
        <i class="fas fa-chart-bar me-2"></i>Soil Parameters Visualization
      </h5>
      <div class="chart-container">
        <canvas id="soilChart" height="300"></canvas>
      </div>
    </div>
  </div>

  <!-- Chart Script -->
  <script>
    const ctx = document.getElementById('soilChart').getContext('2d');
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['pH Level', 'Moisture (%)', 'Organic Matter (%)'],
        datasets: [{
          label: 'Soil Parameter Values',
          data: [ 
            <%= request.getAttribute("ph") %>, 
            <%= request.getAttribute("moisture") %>, 
            <%= request.getAttribute("organic") %> 
          ],
          backgroundColor: [
            'rgba(139, 69, 19, 0.7)',
            'rgba(70, 130, 180, 0.7)',
            'rgba(85, 107, 47, 0.7)'
          ],
          borderColor: [
            'rgb(139, 69, 19)',
            'rgb(70, 130, 180)',
            'rgb(85, 107, 47)'
          ],
          borderWidth: 2
        }]
      },
      options: { 
        scales: { 
          y: { 
            beginAtZero: true,
            title: {
              display: true,
              text: 'Parameter Value'
            }
          }
        },
        plugins: {
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Soil Analysis Parameters',
            font: {
              size: 16
            }
          }
        }
      }
    });
  </script>
</body>
</html>