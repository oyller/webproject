<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>抽奖规则设置首页</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>
		/* 添加按钮间距 */
		.table .btn {
			margin-right: 5px;
		}
	</style>
</head>
<body>
<div class="container">

	<h1 class="my-4">抽奖规则设置首页</h1>
	<table class="table table-bordered table-striped" id="ruleTable">
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
		<tbody>
		<!-- 数据将通过 AJAX 填充到这里 -->
		</tbody>
	</table>
	<button class="btn btn-success mt-3" onclick="addRule()">添加规则</button>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function () {
		// 页面加载完成后，加载规则数据
		loadRules();
	});

	// 发起 AJAX 请求加载规则数据
	function loadRules() {
		$.ajax({
			url: 'lotteryRule?action=getRules', // 确保 URL 与 Servlet 的映射匹配
			type: 'GET',
			dataType: 'json',
			success: function (response) {
				// 清空表格内容
				$('#ruleTable tbody').empty();

				// 使用返回的数据填充表格
				$.each(response, function (index, rule) {
					$('#ruleTable tbody').append(
							'<tr id="ruleRow-' + rule.id + '">' +
							'<td>' + rule.id + '</td>' +
							'<td>' + rule.name + '</td>' +
							'<td>' + rule.creationTime + '</td>' +
							'<td>' + rule.creator + '</td>' +
							'<td>' + rule.department + '</td>' +
							'<td>' + rule.description + '</td>' +
							'<td>' +
							'<a href="lotteryRule?action=editRule&id=' + rule.id + '" class="btn btn-primary btn-sm">编辑</a>' +
							'<button class="btn btn-danger btn-sm" onclick="deleteRule(' + rule.id + ')">删除</button>' +
							'</td>' +
							'</tr>'
					);
				});
			},
			error: function (xhr, error) {
				console.error("请求出错:");
				console.error("状态码: " + xhr.status); // HTTP 状态码，如 404, 500 等
				console.error("状态文本: " + xhr.statusText); // 与状态码对应的文本描述
				console.error("响应文本: " + xhr.responseText); // 服务器返回的响应文本（如果有的话）
				console.error("错误描述: " + error); // jQuery 提供的错误描述
				alert('加载规则数据失败');
			}
		});
	}

	// 删除规则按钮点击事件
	function deleteRule(ruleId) {
		if (confirm('确定要删除这条规则吗？')) {
			$.ajax({
				url: 'lotteryRule?action=deleteRule_Prize&id=' + ruleId, // 确保 URL 与 Servlet 的映射匹配
				type: 'GET',
				success: function (response) {
					if (response === 'success') {
						// 从表格中移除该行
						alert("删除成功");
						$('#ruleRow-' + ruleId).remove();
					} else {
						alert('删除失败');
					}
				},
				error: function (xhr, error) {
					console.error("请求出错:");
					console.error("状态码: " + xhr.status); // HTTP 状态码，如 404, 500 等
					console.error("状态文本: " + xhr.statusText); // 与状态码对应的文本描述
					console.error("响应文本: " + xhr.responseText); // 服务器返回的响应文本（如果有的话）
					console.error("错误描述: " + error); // jQuery 提供的错误描述
					alert('删除规则失败');
				}
			});
		}
	}

	// 添加规则按钮点击事件
	function addRule() {
		window.location.href = 'addRule.jsp'; // 跳转到添加规则页面
	}
</script>
</body>
</html>
