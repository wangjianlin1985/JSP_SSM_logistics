<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderState.css" />
<div id="orderState_editDiv">
	<form id="orderStateEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单状态id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderState_orderStateId_edit" name="orderState.orderStateId" value="<%=request.getParameter("orderStateId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">订单状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderState_orderStateName_edit" name="orderState.orderStateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="orderStateModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderState/js/orderState_modify.js"></script> 
