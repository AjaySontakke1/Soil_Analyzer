<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Soil Analysis - User Registration</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
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
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
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
            height: 30%;
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
        
        .plant-decoration {
            position: absolute;
            bottom: 30%;
            width: 100%;
            height: 200px;
            z-index: -1;
            overflow: hidden;
        }
        
        .plant {
            position: absolute;
            bottom: 0;
            width: 8px;
            background: linear-gradient(to top, var(--earth-green), var(--leaf-green));
            border-radius: 4px 4px 0 0;
        }
        
        .leaf {
            position: absolute;
            width: 20px;
            height: 12px;
            background: var(--leaf-green);
            border-radius: 50% 0 50% 50%;
            transform-origin: bottom right;
        }
        
        .registration-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }
        
        .registration-card {
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
        
        .registration-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(to right, var(--soil-dark), var(--earth-green), var(--growth-green));
        }
        
        .registration-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .registration-header h2 {
            color: var(--earth-green);
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            display: inline-block;
        }
        
        .registration-header h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 25%;
            width: 50%;
            height: 3px;
            background: linear-gradient(to right, var(--soil-light), var(--growth-green));
            border-radius: 2px;
        }
        
        .registration-header p {
            color: var(--text-dark);
            font-size: 1rem;
            margin-top: 1rem;
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
        
        .btn-register {
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
        
        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: var(--transition);
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
        }
        
        .btn-register:hover::before {
            left: 100%;
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--text-dark);
        }
        
        .login-link a {
            color: var(--earth-green);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            position: relative;
        }
        
        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--growth-green);
            transition: var(--transition);
        }
        
        .login-link a:hover {
            color: var(--leaf-green);
        }
        
        .login-link a:hover::after {
            width: 100%;
        }
        
        .alert-message {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 500;
            background: rgba(255, 235, 235, 0.8);
            border-left: 4px solid #dc3545;
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
        
        /* Responsive adjustments */
        @media (max-width: 576px) {
            .registration-card {
                padding: 1.5rem;
            }
            
            .registration-container {
                padding: 1rem 0.5rem;
            }
            
            .soil-layer {
                height: 20%;
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
        
        .water-drop {
            position: absolute;
            width: 8px;
            height: 8px;
            background: var(--water-blue);
            border-radius: 50% 50% 50% 0;
            opacity: 0.7;
            z-index: -1;
        }
    </style>
</head>
<body>
    <!-- Background elements -->
    <div class="soil-layer"></div>
    <div class="plant-decoration" id="plantContainer"></div>
    <div class="decoration-circle circle-1"></div>
    <div class="decoration-circle circle-2"></div>
    
    <div class="registration-container">
        <div class="registration-card">
            <div class="registration-header">
                <h2><span class="soil-icon"></span>Create Your Account</h2>
                <p>Join our soil analysis community and grow with us</p>
            </div>
            
            <div class="alert-message text-danger">
                ${msg}
            </div>
            
            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user"></i> Full Name
                    </label>
                    <input type="text" name="name" class="form-control" placeholder="Enter your full name" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-envelope"></i> Email Address
                        <span class="optional-badge">Optional</span>
                    </label>
                    <input type="email" name="email" class="form-control" placeholder="Optional - soil analysis reports will be emailed">
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <input type="password" name="password" class="form-control" placeholder="Create a secure password" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-phone"></i> Contact Number
                    </label>
                    <input type="text" name="contact" class="form-control" placeholder="Your phone number">
                </div>
                
                <button type="submit" class="btn btn-register">
                    <i class="fas fa-seedling"></i> Create Account
                </button>
            </form>
            
            <div class="login-link">
                Already have an account? <a href="login.jsp">Sign in to your soil dashboard</a>
            </div>
        </div>
    </div>

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Simple CSS-only animations for plants -->
    <style>
        /* Plant animation */
        @keyframes growPlant {
            0% { height: 0; }
            100% { height: var(--plant-height); }
        }
        
        .plant {
            animation: growPlant 1.5s ease-out forwards;
            height: 0;
        }
        
        /* Water drop animation */
        @keyframes dropWater {
            0% { transform: translateY(-100px) scale(0.8); opacity: 0; }
            50% { opacity: 0.7; }
            100% { transform: translateY(0) scale(1); opacity: 0; }
        }
        
        .water-drop {
            animation: dropWater 3s infinite;
        }
    </style>
    
    <!-- Generate decorative plants and water drops -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Create plants
            const plantContainer = document.getElementById('plantContainer');
            const plantCount = 12;
            
            for (let i = 0; i < plantCount; i++) {
                const plant = document.createElement('div');
                const position = (i / plantCount) * 100;
                const height = 80 + Math.random() * 120;
                
                plant.className = 'plant';
                plant.style.left = `${position}%`;
                plant.style.setProperty('--plant-height', `${height}px`);
                
                // Add leaves
                const leafCount = 2 + Math.floor(Math.random() * 3);
                for (let j = 0; j < leafCount; j++) {
                    const leaf = document.createElement('div');
                    leaf.className = 'leaf';
                    leaf.style.bottom = `${20 + j * 30}px`;
                    leaf.style.transform = `rotate(${Math.random() > 0.5 ? '-' : ''}${20 + Math.random() * 30}deg)`;
                    plant.appendChild(leaf);
                }
                
                plantContainer.appendChild(plant);
            }
            
            // Create water drops
            const body = document.querySelector('body');
            const dropCount = 8;
            
            for (let i = 0; i < dropCount; i++) {
                const drop = document.createElement('div');
                drop.className = 'water-drop';
                drop.style.left = `${10 + Math.random() * 80}%`;
                drop.style.top = `${10 + Math.random() * 30}%`;
                drop.style.animationDelay = `${Math.random() * 5}s`;
                body.appendChild(drop);
            }
        });
    </script>
</body>
</html>