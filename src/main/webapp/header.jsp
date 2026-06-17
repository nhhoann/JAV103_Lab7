<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="header">
    <div class="header-top">
        <h1>FPoly Education</h1>
        
        <div class="user-info">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <!-- Chưa đăng nhập -->
                    <span>Welcome you</span>
                    <a href="${pageContext.request.contextPath}/account/login">Đăng nhập</a>
                </c:when>
                <c:otherwise>
                    <!-- Đã đăng nhập -->
                    <span>Welcome ${sessionScope.user.fullname}</span>
                    <a href="${pageContext.request.contextPath}/account/sign-out">Đăng xuất</a>
                    
                    <!-- Hiển thị link Quản trị nếu là admin -->
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
        <p>👥 Số khách thăm: <strong>${applicationScope.visitors}</strong></p>
    </div>
</div>

<style>
    .header {
        background-color: #f8f9fa;
        padding: 15px;
        border-bottom: 2px solid #007bff;
    }
    
    .header-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }
    
    .user-info {
        display: flex;
        gap: 15px;
        align-items: center;
    }
    
    .user-info a {
        padding: 8px 12px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .user-info a.admin-link {
        background-color: #dc3545;
    }
    
    .user-info a:hover {
        opacity: 0.9;
    }
    
    .visitor-count {
        text-align: center;
        font-size: 12px;
        color: #666;
    }
</style>
