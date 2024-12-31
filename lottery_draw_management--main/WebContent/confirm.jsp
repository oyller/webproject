<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录</title>
    <!-- 引入统一版本的Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <!-- 自定义样式 -->
    <style>
        /* 自定义样式 */
        .tpl-login {
            width: 100%;
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #ffffff; /* 白色背景 */
        }

        .tpl-login-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .am-form-group {
            margin-bottom: 15px;
        }

        .tpl-form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .am-btn-primary {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            background-color: #007BFF;
            border-color: #007BFF;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .am-btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .login-link {
            text-align: center;
            margin-top: 10px;
        }

        .login-link a {
            color: #007BFF;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .container{
            margin-top: 100px;
        }

    </style>
</head>
<body data-type="login">
<!-- 引入page.jsp -->
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="tpl-login">
        <div class="tpl-login-content">
            <div class="tpl-login-title">用户登录</div>
            <form class="am-form tpl-form-line-form" method="post" action="LoginServlet">
                <div class="am-form-group">
                    <label for="phone">手机号:</label>
                    <input type="text" class="tpl-form-input" id="phone" name="phone" required placeholder="请输入手机号">
                </div>
                <div class="am-form-group">
                    <label for="password">密码:</label>
                    <input type="password" class="tpl-form-input" id="password" name="password" required placeholder="请输入密码">
                </div>
                <div class="am-form-group">
                    <button type="button" class="am-btn am-btn-primary am-btn-block tpl-btn-bg-color-success tpl-login-btn">登录</button>
                </div>
            </form>
            <div class="login-link">
                <p>没有账号？<a href="register.jsp">点击注册</a></p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.6.0/jquery.min.js"></script>
<script src="static/assets/js/app.js"></script>

<script text="javascript">
    // 提交按钮点击事件
    $('.tpl-login-btn').click(function(event) {
        // 获取手机号和密码输入框的值
        var phone = $('input[name="phone"]').val();
        var password = $('input[name="password"]').val();

        if (phone === "" || password === "") {
            alert('手机号和密码不能为空');
            return;
        }

        $.ajax({
            type: 'post',
            url: 'GetPasswordServlet',
            data: {
                phone: phone,
                password: password
            },
            dataType: 'json',
            success: function(response) {
                // 处理返回的数据
                console.log(response.status);
                if (response.status === "not register") {
                    alert("请先注册");
                    window.location.href = "register.jsp"; // 重定向到注册页面
                } else if (response.status === "update account") {
                    $.ajax({
                        type: 'post',
                        url: 'LoginServlet',
                        data: {
                            phone: phone,
                            password: password
                        },
                        dataType: 'json',
                        success: function(response) {
                            // 处理返回的数据
                            if (response.status === "success login") {
                                alert("登录成功");
                                window.location.href = "index.jsp"; // 重定向到主页
                            } else {
                                alert("登录失败，账号或密码错误");
                                window.location.href = "confirm.jsp"; // 重定向到登录页面
                            }
                        },
                        error: function(xhr, status, error) {
                            alert("请求出错");
                        }
                    });
                } else if (response.status === "first login" && response.password === password) {
                    alert("首次登录，请先修改密码");
                    window.location.href = "login.jsp"; // 重定向到修改密码页面
                } else {
                    alert("登录失败，账号或密码错误");
                    window.location.href = "confirm.jsp"; // 重定向到登录页面
                }
            },
            error: function(xhr, status, error) {
                console.error("请求出错:");
                console.error("状态码: " + xhr.status); // HTTP 状态码，如 404, 500 等
                console.error("状态文本: " + xhr.statusText); // 与状态码对应的文本描述
                console.error("响应文本: " + xhr.responseText); // 服务器返回的响应文本（如果有的话）
                console.error("错误描述: " + error); // jQuery 提供的错误描述
                alert("请求出错");
            }
        });
    });
</script>
</body>
</html>
