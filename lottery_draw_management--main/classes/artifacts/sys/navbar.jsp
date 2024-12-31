<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>抽奖管理系统</title>
    <!-- 引入统一版本的Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <!-- 引入自定义样式 -->
    <style>
        /* 自定义样式 */
        .navbar-custom {
            background-color: rgb(34, 34, 34);
        }

        .navbar-custom .navbar-brand,
        .navbar-custom .navbar-nav .nav-link {
            color: #fff; /* 自定义链接颜色 */
        }

        .navbar-custom .navbar-nav .nav-link:hover,
        .navbar-custom .navbar-nav .nav-link.active {
            color: #f1c40f; /* 自定义链接悬停和激活时的颜色 */
        }

        /* 右侧导航链接样式 */
        .navbar-custom .ml-auto .nav-link {
            margin-left: 1rem; /* 右侧链接之间的间距 */
        }

        /* 响应式样式（可选） */
        @media (max-width: 991.98px) {
            .navbar-custom .ml-auto .nav-link {
                margin-left: 0.5rem; /* 在小屏幕上减小间距 */
                padding: .75rem .5rem; /* 减小链接的padding以适应小屏幕 */
            }
        }

        /* 自定义导航栏字体间距和高亮效果 */
        .navbar-nav .nav-link {
            padding-left: 15px;
            padding-right: 15px;
        }

        .navbar-nav .nav-item.active .nav-link {
            background-color: #f1c40f;
            color: #333;
            border-radius: 5px;
        }

        .navbar-nav .nav-link:hover {
            background-color: #f1c40f;
            color: #333;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<!-- 使用Bootstrap的导航栏组件 -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <a class="navbar-brand" href="#">抽奖管理系统</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="page.jsp">首页</a>
            </li>
            <!-- 可以在这里添加更多左侧导航链接 -->
        </ul>
        <ul class="navbar-nav ml-auto">
            <%-- 登录页面导航链接 --%>
            <li class="nav-item">
                <a class="nav-link" href="confirm.jsp">用户登录</a>
            </li>
            <%-- 注册页面导航链接 --%>
            <li class="nav-item">
                <a class="nav-link" href="register.jsp">用户注册</a>
            </li>
            <%-- 管理员登录页面导航链接 --%>
            <li class="nav-item">
                <a class="nav-link" href="confirm.jsp">管理员登录</a>
            </li>
        </ul>
    </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
