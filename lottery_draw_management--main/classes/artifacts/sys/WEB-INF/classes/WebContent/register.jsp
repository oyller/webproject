<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="navbar.jsp" %>
<html lang="zh-CN" class="bootstrap-admin-vertical-centered">
<head>
    <meta charset="UTF-8">
    <title>图书馆管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 引入统一版本的Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <!-- 引入自定义样式 -->
    <link rel="stylesheet" href="static/css/bootstrap-admin-theme.css">
    <style type="text/css">
        .container {
            margin-top: 0px;
        }
        .alert {
            margin: 0 auto 20px;
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
            width: 30%;
        }
        .form-group-flex .input-with-button {
            display: flex;
            align-items: center;
        }
        .form-group-flex .input-with-button .form-control {
            flex: 1;
            margin-right: 10px;
        }
        .form-group-flex .input-with-button .btn {
            /* Button styles */
        }
        .bootstrap-admin-without-padding {
            margin-top: 0px;
        }
    </style>
</head>
<body class="bootstrap-admin-without-padding">
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="alert alert-info">
                <a class="close" data-dismiss="alert" href="#"></a>
                手机注册
            </div>
            <form class="bootstrap-admin-login-form" method="post" action="RegisterServlet">
                <%
                    String state = (String)session.getAttribute("state");
                    session.removeAttribute("state");
                    if(state!=null){
                %>
                <label class="control-label" for="username">验证码错误</label>
                <%
                    }
                %>
                <div class="form-group">
                    <label class="control-label" for="username">手机号码</label>
                    <input type="text" class="form-control" id="username" name="username" required="required" placeholder="手机号码"/>
                </div>
                <div class="form-group2 form-group-flex">
                    <label class="control-label" for="captcha">验证码</label>
                    <div class="input-with-button">
                        <input type="password" required="true" class="form-control" id="captcha" name="captcha"  placeholder="验证码"/>
                        <button type="button" class="btn captcha btn-info btn-sm">发送短信</button>
                    </div>
                </div>
                <label style="margin-top:10px">
                    <input type="checkbox" id="agreeCheckbox">
                    我已阅读并同意用户协议
                </label>
                <br>
                <div>
                    <button style="width:100%" type="button" class="btn send btn-info btn-sm">注册</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="static/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
    let countdown = 60;
    let timerId = null;

    function sendCaptchaAndStartCountdown() {
        let usernameInput = document.getElementById('username');
        let usernameValue = usernameInput.value;

        let captchaInput = document.getElementById('captcha');
        let captchaValue = captchaInput.value;

        let xhr = new XMLHttpRequest();
        xhr.open('POST', 'RegisterServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                console.log(xhr.responseText);
                startCountdown();
            }
        };

        let data = 'username=' + usernameValue + '&captcha=' + captchaValue;
        xhr.send(data);
    }

    function startCountdown() {
        if (timerId) {
            clearTimeout(timerId);
        }

        let captchaBtn = document.querySelector('.captcha');
        captchaBtn.disabled = true;
        captchaBtn.textContent = '重新发送 (' + countdown + 's)';

        timerId = setInterval(function() {
            countdown -= 1;
            captchaBtn.textContent = '重新发送 (' + countdown + 's)';

            if (countdown <= 0) {
                countdown = 60;
                captchaBtn.disabled = false;
                captchaBtn.textContent = '发送短信';
                clearInterval(timerId);
                timerId = null;
            }
        }, 1000);
    }

    document.querySelector('.captcha').addEventListener('click', sendCaptchaAndStartCountdown);

    document.querySelector('.send').addEventListener('click', function() {
        let usernameInput = document.getElementById('username');
        let usernameValue = usernameInput.value;
        let captchaInput = document.getElementById("captcha");
        let captchaValue = captchaInput.value;
        var agreeCheckbox = document.getElementById("agreeCheckbox");

        if (!agreeCheckbox.checked) {
            alert("请同意用户协议");
            return;
        }

        if(captchaInput.value.trim() === ""){
            alert("未填写验证码");
        }

        let data = 'username=' + usernameValue + '&captcha=' + captchaValue;
        $.ajax({
            url: 'RegisterServlet',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function(response) {
                if (response.status === "success") {
                    window.location.href = "page.jsp";
                    alert("注册成功, 初始密码为你的手机号码，请你尽快修改密码");
                } else {
                    window.location.href = "register.jsp";
                    alert("验证失败,验证码错误或者先点击发送短信");
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 请求失败: " + status + ", " + error);
            }
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        var checkbox = document.getElementById('agreeCheckbox');
        var isChecked = false;

        checkbox.addEventListener('change', function() {
            isChecked = this.checked;
            console.log('勾选框状态：', isChecked);
        });
    });

</script>
</body>
</html>
