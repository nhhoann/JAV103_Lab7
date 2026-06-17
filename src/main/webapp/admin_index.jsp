<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - FPoly Lab 07</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 20px;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header h1 {
            font-size: 28px;
        }

        .user-info {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .user-info a {
            color: white;
            padding: 8px 12px;
            background-color: rgba(0, 0, 0, 0.2);
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .user-info a:hover {
            background-color: rgba(0, 0, 0, 0.3);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card h2 {
            color: #dc3545;
            margin-bottom: 15px;
            border-bottom: 2px solid #dc3545;
            padding-bottom: 10px;
        }

        .warning-box {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            color: #856404;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .table th {
            background-color: #dc3545;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .table td {
            border-bottom: 1px solid #ddd;
            padding: 12px;
        }

        .table tr:hover {
            background-color: #f9f9f9;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .stat-box {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .stat-box .number {
            font-size: 32px;
            font-weight: bold;
            margin: 10px 0;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            margin-top: 40px;
        }

        .success-text {
            color: #28a745;
            font-weight: bold;
        }

        .danger-text {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-top">
            <h1>🔧 Admin Panel</h1>
            <div class="user-info">
                <span>👤 ${sessionScope.user.fullname}</span>
                <a href="${pageContext.request.contextPath}/account/sign-out">Đăng xuất</a>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="container">
        <!-- Welcome Card -->
        <div class="card">
            <h2>📊 Chào mừng, Admin!</h2>
            <div class="warning-box">
                <strong>⚠️ Lưu ý:</strong> Trang này được bảo vệ bởi 
                <span class="success-text">AuthFilter</span>. 
                Chỉ admin mới có thể truy cập.
            </div>
            <p>
                Bạn đang truy cập trang quản trị hệ thống. 
                Tất cả hoạt động của bạn được ghi nhận trong file nhật ký.
            </p>
        </div>

        <!-- Auth Status -->
        <div class="card">
            <h2>🔐 Thông tin Bảo mật</h2>
            <table class="table">
                <tr>
                    <th>Thông tin</th>
                    <th>Giá trị</th>
                </tr>
                <tr>
                    <td>Username</td>
                    <td><strong>${sessionScope.user.id}</strong></td>
                </tr>
                <tr>
                    <td>Tên đầy đủ</td>
                    <td>${sessionScope.user.fullname}</td>
                </tr>
                <tr>
                    <td>Quyền hạn</td>
                    <td>
                        <c:if test="${sessionScope.user.admin}">
                            <span class="success-text">✓ Admin</span>
                        </c:if>
                        <c:if test="${!sessionScope.user.admin}">
                            <span class="danger-text">✗ User</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td>Session ID</td>
                    <td><code>${pageContext.session.id}</code></td>
                </tr>
            </table>
        </div>

        <!-- Statistics -->
        <div class="card">
            <h2>📈 Thống kê Hệ thống</h2>
            <div class="stats-grid">
                <div class="stat-box">
                    <p>Tổng khách</p>
                    <div class="number">${applicationScope.visitors}</div>
                </div>

                <div class="stat-box">
                    <p>Người dùng</p>
                    <div class="number">5</div>
                </div>

                <div class="stat-box">
                    <p>Admin</p>
                    <div class="number">2</div>
                </div>

                <div class="stat-box">
                    <p>Truy cập hôm nay</p>
                    <div class="number">12</div>
                </div>
            </div>
        </div>

        <!-- Filter Information -->
        <div class="card">
            <h2>🔗 Thông tin Filter</h2>
            <p><strong>AuthFilter:</strong> 🟢 Hoạt động</p>
            <p><strong>LoggerFilter:</strong> 🟢 Hoạt động</p>
            <p><strong>AppFilter:</strong> 🟢 Hoạt động</p>
            
            <div class="warning-box" style="margin-top: 15px;">
                <strong>📝 Nhật ký truy cập:</strong><br>
                Tất cả các request tới trang admin đều được ghi lại trong:
                <ul style="margin-top: 10px; margin-left: 20px;">
                    <li>File: <code>admin_access_log.txt</code></li>
                    <li>Database: Table <code>AdminAccessLog</code></li>
                </ul>
            </div>
        </div>

        <!-- Menu -->
        <div class="card">
            <h2>📋 Menu Quản trị</h2>
            <ul style="margin-left: 20px;">
                <li><a href="#">Quản lý người dùng</a></li>
                <li><a href="#">Xem nhật ký truy cập</a></li>
                <li><a href="#">Thống kê hệ thống</a></li>
                <li><a href="#">Cấu hình ứng dụng</a></li>
                <li><a href="#">Backup dữ liệu</a></li>
            </ul>
        </div>
    </div>

    <div class="footer">
        <p>© 2024 FPoly Lab 07 - Admin Panel</p>
        <p>Bạn được truy cập trang này vì bạn là Admin</p>
    </div>
</body>
</html>
