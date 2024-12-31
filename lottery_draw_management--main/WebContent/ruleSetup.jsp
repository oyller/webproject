<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>抽奖规则设置首页</title>
    <!-- 引入Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">抽奖规则设置首页</h1>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>编号</th>
            <th>规则名称</th>
            <th>创建时间</th>
            <th>创建人</th>
            <th>所属部门</th>
            <th>简介</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="rulesTable">
        <!-- This part will be dynamically generated using JSP -->
        <c:forEach var="rule" items="${rules}">
            <tr>
                <td>${rule.id}</td>
                <td>${rule.name}</td>
                <td>${rule.creationTime}</td>
                <td>${rule.creator}</td>
                <td>${rule.department}</td>
                <td>${rule.description}</td>
                <td>
                    <a href="editRule?id=${rule.id}" class="btn btn-primary btn-sm">编辑</a>
                    <a href="deleteRule?id=${rule.id}" class="btn btn-danger btn-sm">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <button class="btn btn-success mt-3" onclick="location.href='addRule.jsp'">添加规则</button>
</div>

<!-- 引入Bootstrap JS和依赖 -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 引入JQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function addTemporaryRule(rule) {
        const ruleRow = `
            <tr>
                <td>${rule.id}</td>
                <td>${rule.name}</td>
                <td>${rule.creationTime}</td>
                <td>${rule.creator}</td>
                <td>${rule.department}</td>
                <td>${rule.description}</td>
                <td>
                    <a href="editRule?id=${rule.id}" class="btn btn-primary btn-sm">编辑</a>
                    <a href="deleteRule?id=${rule.id}" class="btn btn-danger btn-sm">删除</a>
                </td>
            </tr>`;
        $('#rulesTable').append(ruleRow);
    }
</script>
</body>
</html>
