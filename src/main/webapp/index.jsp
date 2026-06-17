<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - FPoly Lab 07</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        .user-info a, .user-info span {
            color: white;
        }

        .user-info a {
            padding: 8px 12px;
            background-color: rgba(255, 255, 255, 0.2);
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .user-info a:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .user-info a.admin-link {
            background-color: #ff6b6b;
        }

        .visitor-count {
            text-align: center;
            padding: 10px;
            font-size: 14px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        /* Content */
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
            color: #333;
            margin-bottom: 15px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }

        .card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .stat-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .stat-box h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .stat-box .number {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            margin-top: 40px;
        }

        .info-box {
            background-color: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }

        .success-box {
            background-color: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            color: #155724;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-top">
            <h1>🎓 FPoly Lab 07</h1>
            <div class="user-info">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <span>👤 Welcome you</span>
                        <a href="${pageContext.request.contextPath}/account/login">Đăng nhập</a>
                    </c:when>
                    <c:otherwise>
                        <span>👤 Welcome ${sessionScope.user.fullname}</span>
                        <a href="${pageContext.request.contextPath}/account/sign-out">Đăng xuất</a>
                        <c:if test="${sessionScope.user.admin}">
                            <a href="${pageContext.request.contextPath}/admin/home/index" class="admin-link">
                                🔧 Quản trị
                            </a>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="visitor-count">
            👥 Tổng số khách thăm: <strong>${applicationScope.visitors}</strong> người
        </div>
    </div>

    <!-- Content -->
    <div class="container">
        <div class="card">
            <h2>📋 Lab 07 - Scope, Listener, Filter</h2>

            <div class="info-box">
                <strong>📌 Mục tiêu bài lab:</strong>
                <ul style="margin-top: 10px; margin-left: 20px;">
                    <li>Áp dụng các scope phù hợp để chia sẻ dữ liệu</li>
                    <li>Xử lý các sự kiện xảy ra trong ứng dụng web</li>
                    <li>Giải thích được cơ chế hoạt động của bộ lọc</li>
                    <li>Áp dụng bộ lọc để ghi nhận lịch sử truy xuất và bảo vệ tài nguyên</li>
                </ul>
            </div>

            <h3 style="margin-top: 20px; color: #667eea;">📝 Các bài tập trong Lab:</h3>

            <div class="stats">
                <div class="stat-box">
                    <h3>Bài 1️⃣</h3>
                    <p>Bộ đếm khách web</p>
                    <div class="number">${applicationScope.visitors}</div>
                </div>

                <div class="stat-box">
                    <h3>Bài 2️⃣</h3>
                    <p>Lưu vết người dùng</p>
                    <div class="number">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                ✓
                            </c:when>
                            <c:otherwise>
                                ✗
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="stat-box">
                    <h3>Bài 3️⃣</h3>
                    <p>AppFilter & LoggerFilter</p>
                    <div class="number">✓</div>
                </div>

                <div class="stat-box">
                    <h3>Bài 4️⃣</h3>
                    <p>Bảo mật ứng dụng</p>
                    <div class="number">✓</div>
                </div>
            </div>
        </div>

        <!-- Bài 1 -->
        <div class="card">
            <h2>🔢 Bài 1: Bộ đếm số khách thăm Web</h2>
            <p>
                Bộ đếm này được quản lý bởi <strong>AppListener</strong> - một listener
                implement HttpSessionListener và ServletContextListener.
            </p>
            <div class="success-box">
                <strong>Cách hoạt động:</strong>
                <ul style="margin-top: 10px; margin-left: 20px;">
                    <li><strong>contextInitialized():</strong> Khi ứng dụng khởi động, đọc số đếm từ file visitors.txt</li>
                    <li><strong>sessionCreated():</strong> Mỗi khi có session mới, tăng số đếm lên 1</li>
                    <li><strong>contextDestroyed():</strong> Khi ứng dụng tắt, ghi số đếm xuống file</li>
                </ul>
            </div>
        </div>

        <!-- Bài 2 -->
        <div class="card">
            <h2>👤 Bài 2: Lưu vết người sử dụng</h2>
            <p>
                Hệ thống hiển thị thông tin đăng nhập khác nhau tùy theo trạng thái của người dùng.
            </p>
            <div class="success-box">
                <strong>Tính năng:</strong>
                <ul style="margin-top: 10px; margin-left: 20px;">
                    <li>Hiển thị "Welcome you" nếu chưa đăng nhập</li>
                    <li>Hiển thị "Welcome [Tên]" và nút Đăng xuất nếu đã đăng nhập</li>
                    <li>Hiển thị link "Quản trị" nếu người dùng là admin</li>
                </ul>
            </div>

            <c:if test="${empty sessionScope.user}">
                <p style="margin-top: 15px;">
                    <a href="${pageContext.request.contextPath}/account/login" 
                       style="padding: 10px 20px; background-color: #667eea; color: white; 
                       text-decoration: none; border-radius: 5px; display: inline-block;">
                        🔐 Đăng nhập ngay
                    </a>
                </p>
            </c:if>
        </div>

        <!-- Bài 3 -->
        <div class="card">
            <h2>🔗 Bài 3: AppFilter & LoggerFilter</h2>
            <p>
                <strong>AppFilter:</strong> Thiết lập UTF-8 encoding cho toàn bộ ứng dụng (/*).
                Đảm bảo các ký tự đặc biệt được xử lý đúng.
            </p>
            <p style="margin-top: 10px;">
                <strong>LoggerFilter:</strong> Ghi nhật ký truy cập cho các URL bắt đầu bằng /admin/*.
                Lưu thông tin người dùng, URI, và thời gian.
            </p>
        </div>

        <!-- Bài 4 -->
        <div class="card">
            <h2>🛡️ Bài 4: Bảo mật ứng dụng</h2>
            <p>
                <strong>AuthFilter:</strong> Kiểm tra authentication (đã đăng nhập?) và authorization
                (có quyền truy cập?).
            </p>
            <div class="info-box">
                <strong>Quy trình bảo mật:</strong>
                <ol style="margin-top: 10px; margin-left: 20px;">
                    <li>Kiểm tra người dùng đã đăng nhập chưa</li>
                    <li>Nếu chưa → Redirect tới trang login</li>
                    <li>Kiểm tra người dùng có quyền admin không</li>
                    <li>Nếu không → Redirect tới trang lỗi</li>
                    <li>Ghi nhật ký truy cập nếu vượt qua kiểm tra</li>
                </ol>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>© 2024 FPoly Education - Lab 07 - Scope, Listener, Filter</p>
    </div>
</body>
</html>
