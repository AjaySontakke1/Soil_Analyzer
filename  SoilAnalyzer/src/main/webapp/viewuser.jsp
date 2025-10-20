<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.Bean.User, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Management</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }
    
    .header {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #f0f0f0;
    }
    
    h1 {
        color: #2c3e50;
        font-size: 2.5rem;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
    }
    
    h1 i {
        color: #667eea;
        background: #f8f9ff;
        padding: 15px;
        border-radius: 50%;
    }
    
    .subtitle {
        color: #7f8c8d;
        font-size: 1.1rem;
    }
    
    .message {
        padding: 15px;
        margin: 20px 0;
        border-radius: 8px;
        text-align: center;
        font-weight: 500;
        border: none;
    }
    
    .success {
        background: #d4edda;
        color: #155724;
        border-left: 4px solid #28a745;
    }
    
    .error {
        background: #f8d7da;
        color: #721c24;
        border-left: 4px solid #dc3545;
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        margin: 25px 0;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    thead {
        background: linear-gradient(135deg, #667eea, #764ba2);
    }
    
    th {
        padding: 16px 20px;
        text-align: left;
        color: white;
        font-weight: 600;
        font-size: 0.95rem;
    }
    
    tbody tr {
        transition: all 0.3s ease;
        border-bottom: 1px solid #f0f0f0;
    }
    
    tbody tr:last-child {
        border-bottom: none;
    }
    
    tbody tr:hover {
        background: #f8f9ff;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    td {
        padding: 16px 20px;
        color: #2c3e50;
        font-weight: 500;
    }
    
    .user-avatar {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        margin-right: 10px;
    }
    
    .user-info {
        display: flex;
        align-items: center;
    }
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    
    .btn-delete {
        background: #e74c3c;
        color: white;
    }
    
    .btn-delete:hover {
        background: #c0392b;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
    }
    
    .footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 2px solid #f0f0f0;
    }
    
    .back-link {
        background: #95a5a6;
        color: white;
        padding: 12px 25px;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    
    .back-link:hover {
        background: #7f8c8d;
        transform: translateY(-2px);
        text-decoration: none;
        color: white;
    }
    
    .user-count {
        color: #7f8c8d;
        font-weight: 600;
        background: #ecf0f1;
        padding: 8px 15px;
        border-radius: 20px;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }
        
        h1 {
            font-size: 2rem;
        }
        
        th, td {
            padding: 12px 15px;
            font-size: 0.9rem;
        }
        
        .footer {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>
                <i class="fas fa-users-cog"></i>
                User Management
            </h1>
            <p class="subtitle">Manage all system users efficiently</p>
        </div>
        
        <!-- Display success/error messages -->
        <% if (session.getAttribute("successMessage") != null) { %>
            <div class="message success">
                <i class="fas fa-check-circle"></i>
                <%= session.getAttribute("successMessage") %>
            </div>
            <% session.removeAttribute("successMessage"); %>
        <% } %>
        
        <% if (session.getAttribute("errorMessage") != null) { %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i>
                <%= session.getAttribute("errorMessage") %>
            </div>
            <% session.removeAttribute("errorMessage"); %>
        <% } %>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Contact</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<User> userList = (List<User>) request.getAttribute("UserList");
                    if (userList != null && !userList.isEmpty()) {
                        for (User user : userList) { 
                    %>
                        <tr>
                            <td><strong>#<%= user.getId() %></strong></td>
                            <td>
                                <div class="user-info">
                                    <div class="user-avatar">
                                        <%= user.getName().charAt(0) %>
                                    </div>
                                    <%= user.getName() %>
                                </div>
                            </td>
                            <td>••••••••</td>
                            <td>
                                <i class="fas fa-phone" style="color: #95a5a6; margin-right: 8px;"></i>
                                <%= user.getContact() %>
                            </td>
                            <td>
                                <i class="fas fa-envelope" style="color: #95a5a6; margin-right: 8px;"></i>
                                <%= user.getEmail() %>
                            </td>
                            <td>
                                <button class="btn btn-delete" 
                                        onclick="deleteUser(<%= user.getId() %>, '<%= user.getName() %>')">
                                    <i class="fas fa-trash"></i>
                                    Delete
                                </button>
                            </td>
                        </tr>
                    <% 
                        }
                    } else { 
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 40px; color: #95a5a6;">
                                <i class="fas fa-users-slash" style="font-size: 3rem; margin-bottom: 15px; display: block;"></i>
                                No users found in the system
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        
        <div class="footer">
            <a href="adminDashboard.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
            <div class="user-count">
                <i class="fas fa-users"></i>
                Total Users: <%= userList != null ? userList.size() : 0 %>
            </div>
        </div>
    </div>

    <script>
        function deleteUser(userId, userName) {
            if (confirm('Are you sure you want to delete user: ' + userName + '?')) {
                window.location.href = 'DeleteUserServlet?id=' + userId;
            }
        }
    </script>
</body>
</html>