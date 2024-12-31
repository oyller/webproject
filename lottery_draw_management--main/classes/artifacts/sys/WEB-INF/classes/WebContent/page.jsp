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

        /* 自定义图片容器样式 */
        .lottery-image-container {
            text-align: center;
            margin-top: 20px;
        }

        .lottery-image {
            width: 100%;
            max-width: 600px;
            height: auto;
            border: 2px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 自定义图片下方的文字样式 */
        .lottery-image-caption {
            margin-top: 10px;
            font-size: 1.5rem;
            color: #555;
        }

    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<!-- 抽奖图片容器 -->
<div class="lottery-image-container">
    <img src="333539-20160118140100216-1678345602.png" alt="Lottery Image" class="lottery-image">
    <div class="lottery-image-caption">抽奖活动</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
