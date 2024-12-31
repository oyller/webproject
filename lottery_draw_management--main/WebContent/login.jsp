<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>注册</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <script src="https://cdn.bootcss.com/jquery/3.6.0/jquery.min.js"></script>
</head>

<style type="text/css">
    /* 样式表 */
    .tpl-login {
        width: 100%;
        max-width: 400px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .tpl-login {
        margin-top: 30px; /* 您可以根据需要调整这个值 */
    }

    .tpl-login-title {
        text-align: center;
        font-size: 18px;
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

    .am-btn-primary,
    .am-btn-secondary {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
    }

    .am-btn-primary {
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

    .am-btn-secondary {
        background-color: #007BFF;
        border-color: #007BFF;
        color: #fff;
        border-radius: 4px;
        cursor: pointer;
    }

    .am-btn-secondary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }
</style>

<body data-type="login">
<!-- 引入page.jsp -->
<%@ include file="navbar.jsp" %>
<div class="page-container">
</div>
<div class="am-g tpl-g">
    <div class="tpl-login">
        <div class="tpl-login-content">
            <div class="tpl-login-title">首次登录，请先修改密码</div>

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
                    <label for="confirm-password">确认密码:</label>
                    <input type="password" class="tpl-form-input" id="confirm-password" name="confirmPassword" required placeholder="确认新密码">
                </div>
                <div class="am-form-group">
                    <label for="email">邮箱:</label>
                    <input type="text" class="tpl-form-input" id="email" name="email" required placeholder="请输入邮箱">
                </div>

                <div class="am-form-group">
                    <button type="button" class="am-btn am-btn-primary am-btn-block tpl-btn-bg-color-success tpl-login-btn">提交</button>
                </div>
                <div class="am-form-group">
                    <button type="button" onclick="location.href='login.jsp';" class="am-btn am-btn-secondary am-btn-block">返回注册</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.bootcss.com/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="static/assets/js/app.js"></script>

</body>

</html>

<script text="javascript">
    function evaluatePassword(password) {
        let score = 0;

        // Length criteria
        if (password.length <= 4) {
            score += 5;
        } else if (password.length >= 5 && password.length <= 7) {
            score += 10;
        } else if (password.length >= 8) {
            score += 25;
        }

        // Alphabet criteria
        let hasUpper = /[A-Z]/.test(password);
        let hasLower = /[a-z]/.test(password);
        if (hasUpper && hasLower) {
            score += 20;
        } else if (hasUpper || hasLower) {
            score += 10;
        }

        // Digit criteria
        let hasDigit = /\d/.test(password);
        if (hasDigit) {
            score += 10;
        }

        return score;
    }

    // 提交按钮点击事件
    $('.tpl-login-btn').click(function(event) {
        console.log("******");
        // 获取密码和确认密码输入框的值
        var password = $('input[name="password"]').val();
        var confirmPassword = $('input[name="confirmPassword"]').val();
        var email = $('input[name="email"]').val();
        var phone = $('input[name="phone"]').val();

        if (phone === "") {
            alert('手机号不能为空');
            return;
        }

        // 正则表达式判断密码是否是数字和字母组合，长度大于六位
        var passwordPattern = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$/;
        if (!passwordPattern.test(password)) {
            alert('密码必须是数字和字母的组合，且长度大于六位');
            return;
        }

        // 判断确认密码是否与密码一致
        if (password !== confirmPassword) {
            alert('确认密码与密码不一致');
            return;
        }

        // 判断电子邮箱的合法性
        var emailPattern = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!emailPattern.test(email)) {
            alert('请输入有效的电子邮箱');
            return;
        }

        // 计算密码评分
        var passwordScore = evaluatePassword(password);
        if (passwordScore < 20) { // you can adjust this threshold as needed
            alert('密码评分不足，请使用更复杂的密码');
            return;
        }

        // 发起ajax请求提交数据给servlet
        $.ajax({
            type: 'post',
            url: 'LoginServlet',
            data: {
                password: password,
                email: email,
                phone: phone,
            },
            dataType: 'json',
            success: function(response) {
                // 处理返回的数据
                if (response.status === "success update") {
                    alert("success update");
                    window.location.href = "index.jsp";
                } else {
                    alert("更新失败，请重试");
                }
            },
            error: function(xhr, status, error) {
                window.location.href = "index.jsp";
            }
        });
    });
</script>
