<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>编辑抽奖规则</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .form-section {
            margin-bottom: 2em;
        }
        .form-section h5 {
            border-bottom: 2px solid #ddd;
            padding-bottom: .5em;
            margin-bottom: 1em;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="my-4">编辑抽奖规则</h1>
    <form id="editRuleForm" action="lotteryRule?action=saveRule" method="post">
        <input type="hidden" name="ruleId" value="${rule.id}">

        <div class="form-section">
            <h5>基本信息</h5>
            <div class="form-group">
                <label for="ruleName">规则名称</label>
                <input type="text" class="form-control" id="ruleName" name="ruleName" value="${rule.name}" required>
            </div>
            <div class="form-group">
                <label for="creator">创建人</label>
                <input type="text" class="form-control" id="creator" name="creator" value="${rule.creator}" required>
            </div>
            <div class="form-group">
                <label for="department">所属部门</label>
                <input type="text" class="form-control" id="department" name="department" value="${rule.department}" required>
            </div>
            <div class="form-group">
                <label for="description">简介</label>
                <textarea class="form-control" id="description" name="description" rows="3">${rule.description}</textarea>
            </div>
        </div>

        <div class="form-section">
            <h5>抽奖设置</h5>
            <div class="form-group">
                <label for="lotterMode">模式选择</label>
                <select class="form-control" id="lotterMode" name="lotterMode">
                    <option value="1" <c:if test="${prizes[0].lotter_mode == 1}">selected</c:if>>确定奖项后，随机抽取获奖人</option>
                    <option value="2" <c:if test="${prizes[0].lotter_mode == 2}">selected</c:if>>确定抽奖后，随机抽取获奖人员，但排除已获奖人员</option>
                    <option value="3" <c:if test="${prizes[0].lotter_mode == 3}">selected</c:if>>随机抽取获奖人员后，随机抽取奖品</option>
                    <option value="4" <c:if test="${prizes[0].lotter_mode == 4}">selected</c:if>>随机抽取获奖人员，随机抽取奖品，但排除已抽取完毕奖品</option>
                </select>
            </div>
            <div class="form-group">
                <label>抽奖人员设定</label>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="attendMode" id="signupOption" value="1" <c:if test="${prizes[0].attend_mode == 1}">checked</c:if>>
                    <label class="form-check-label" for="signupOption">报名</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="attendMode" id="importOption" value="2" <c:if test="${prizes[0].attend_mode == 2}">checked</c:if>>
                    <label class="form-check-label" for="importOption">从导入的人员中选择</label>
                </div>
            </div>
        </div>

        <div class="form-section">
            <h5>抽奖奖品设置</h5>
            <div id="prizes">
                <c:forEach var="prize" items="${prizes}">
                    <div class="form-row mb-2 prize-item">
                        <div class="col">
                            <input type="text" class="form-control" name="prizeLevel" value="${prize.prizeLevel}" placeholder="奖项">
                        </div>
                        <div class="col">
                            <input type="number" class="form-control" name="prizeQuantity" value="${prize.prizeQuantity}" placeholder="数量">
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="prizeName" value="${prize.prizeName}" placeholder="奖品">
                        </div>
                        <div class="col">
                            <button type="button" class="btn btn-danger" onclick="removePrize(this)">删除</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <button type="button" class="btn btn-secondary" onclick="addPrize()">添加奖品</button>
        </div>

        <div class="form-section">
            <button type="submit" class="btn btn-primary" onclick="savePrizes()">保存</button>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    let prizesData = [];

    function addPrize() {
        const prizeRow = `
        <div class="form-row mb-2 prize-item">
            <div class="col">
                <input type="text" class="form-control" name="prizeLevel" placeholder="奖项">
            </div>
            <div class="col">
                <input type="number" class="form-control" name="prizeQuantity" placeholder="数量">
            </div>
            <div class="col">
                <input type="text" class="form-control" name="prizeName" placeholder="奖品">
            </div>
            <div class="col">
                <button type="button" class="btn btn-danger" onclick="removePrize(this)">删除</button>
            </div>
        </div>`;
        document.getElementById('prizes').insertAdjacentHTML('beforeend', prizeRow);
    }

    function removePrize(button) {
        button.closest('.prize-item').remove();
    }

    function savePrizes() {
        const prizeItems = document.querySelectorAll('.prize-item');
        prizesData = [];
        prizeItems.forEach(item => {
            const level = item.querySelector('[name="prizeLevel"]').value;
            const quantity = item.querySelector('[name="prizeQuantity"]').value;
            const name = item.querySelector('[name="prizeName"]').value;
            prizesData.push({ level, quantity, name });
        });

        const jsonData = JSON.stringify(prizesData);

        const prizesInput = document.createElement('input');
        prizesInput.type = 'hidden';
        prizesInput.name = 'prizesData';
        prizesInput.value = jsonData;

        const form = document.getElementById('editRuleForm');
        form.appendChild(prizesInput);
    }

</script>
</body>
</html>
