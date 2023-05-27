<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.OrderInfo" %>
<%@ page import="com.chengxusheji.po.OrderState" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<OrderInfo> orderInfoList = (List<OrderInfo>)request.getAttribute("orderInfoList");
    //获取所有的orderStateObj信息
    List<OrderState> orderStateList = (List<OrderState>)request.getAttribute("orderStateList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String sendName = (String)request.getAttribute("sendName"); //寄件人姓名查询关键字
    String sendTelephone = (String)request.getAttribute("sendTelephone"); //寄件人电话查询关键字
    String getName = (String)request.getAttribute("getName"); //收件方电话查询关键字
    String getTelephone = (String)request.getAttribute("getTelephone"); //收件方电话查询关键字
    String productName = (String)request.getAttribute("productName"); //货物名称查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    OrderState orderStateObj = (OrderState)request.getAttribute("orderStateObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>用户订单查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>OrderInfo/frontlist">用户订单信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>OrderInfo/orderInfo_frontAdd.jsp" style="display:none;">添加用户订单</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<orderInfoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		OrderInfo orderInfo = orderInfoList.get(i); //获取到用户订单对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>OrderInfo/<%=orderInfo.getOrderId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=orderInfo.getProductPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		订单id:<%=orderInfo.getOrderId() %>
			     	</div>
			     	<div class="field">
	            		寄件人姓名:<%=orderInfo.getSendName() %>
			     	</div>
			     	<div class="field">
	            		寄件人电话:<%=orderInfo.getSendTelephone() %>
			     	</div>
			     	<div class="field">
	            		收件方姓名:<%=orderInfo.getGetName() %>
			     	</div>
			     	<div class="field">
	            		收件方电话:<%=orderInfo.getGetTelephone() %>
			     	</div>
			     	<div class="field">
	            		货物名称:<%=orderInfo.getProductName() %>
			     	</div>
			     	<div class="field">
	            		货物重量:<%=orderInfo.getWeight() %>
			     	</div>
			     	<div class="field">
	            		发布用户:<%=orderInfo.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		订单状态:<%=orderInfo.getOrderStateObj().getOrderStateName() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=orderInfo.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>OrderInfo/<%=orderInfo.getOrderId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="orderInfoEdit('<%=orderInfo.getOrderId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="orderInfoDelete('<%=orderInfo.getOrderId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>用户订单查询</h1>
		</div>
		<form name="orderInfoQueryForm" id="orderInfoQueryForm" action="<%=basePath %>OrderInfo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="sendName">寄件人姓名:</label>
				<input type="text" id="sendName" name="sendName" value="<%=sendName %>" class="form-control" placeholder="请输入寄件人姓名">
			</div>
			<div class="form-group">
				<label for="sendTelephone">寄件人电话:</label>
				<input type="text" id="sendTelephone" name="sendTelephone" value="<%=sendTelephone %>" class="form-control" placeholder="请输入寄件人电话">
			</div>
			<div class="form-group">
				<label for="getName">收件方姓名:</label>
				<input type="text" id="getName" name="getName" value="<%=getName %>" class="form-control" placeholder="请输入收件方电话">
			</div>
			<div class="form-group">
				<label for="getTelephone">收件方电话:</label>
				<input type="text" id="getTelephone" name="getTelephone" value="<%=getTelephone %>" class="form-control" placeholder="请输入收件方电话">
			</div>
			<div class="form-group">
				<label for="productName">货物名称:</label>
				<input type="text" id="productName" name="productName" value="<%=productName %>" class="form-control" placeholder="请输入货物名称">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="orderStateObj_orderStateId">订单状态：</label>
                <select id="orderStateObj_orderStateId" name="orderStateObj.orderStateId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(OrderState orderStateTemp:orderStateList) {
	 					String selected = "";
 					if(orderStateObj!=null && orderStateObj.getOrderStateId()!=null && orderStateObj.getOrderStateId().intValue()==orderStateTemp.getOrderStateId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=orderStateTemp.getOrderStateId() %>" <%=selected %>><%=orderStateTemp.getOrderStateName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="orderInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;用户订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="orderInfoEditForm" id="orderInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderInfo_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderInfo_sendName_edit" class="col-md-3 text-right">寄件人姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_sendName_edit" name="orderInfo.sendName" class="form-control" placeholder="请输入寄件人姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_sendTelephone_edit" class="col-md-3 text-right">寄件人电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_sendTelephone_edit" name="orderInfo.sendTelephone" class="form-control" placeholder="请输入寄件人电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_sendAddress_edit" class="col-md-3 text-right">寄件人地址:</label>
		  	 <div class="col-md-9">
			    <textarea id="orderInfo_sendAddress_edit" name="orderInfo.sendAddress" rows="8" class="form-control" placeholder="请输入寄件人地址"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_getName_edit" class="col-md-3 text-right">收件方电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_getName_edit" name="orderInfo.getName" class="form-control" placeholder="请输入收件方电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_getTelephone_edit" class="col-md-3 text-right">收件方电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_getTelephone_edit" name="orderInfo.getTelephone" class="form-control" placeholder="请输入收件方电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_getAddress_edit" class="col-md-3 text-right">收件方地址:</label>
		  	 <div class="col-md-9">
			    <textarea id="orderInfo_getAddress_edit" name="orderInfo.getAddress" rows="8" class="form-control" placeholder="请输入收件方地址"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_productName_edit" class="col-md-3 text-right">货物名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_productName_edit" name="orderInfo.productName" class="form-control" placeholder="请输入货物名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_productPhoto_edit" class="col-md-3 text-right">货物照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="orderInfo_productPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="orderInfo_productPhoto" name="orderInfo.productPhoto"/>
			    <input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_productPrice_edit" class="col-md-3 text-right">货物价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_productPrice_edit" name="orderInfo.productPrice" class="form-control" placeholder="请输入货物价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_weight_edit" class="col-md-3 text-right">货物重量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_weight_edit" name="orderInfo.weight" class="form-control" placeholder="请输入货物重量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_userObj_user_name_edit" class="col-md-3 text-right">发布用户:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderStateObj_orderStateId_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_orderStateObj_orderStateId_edit" name="orderInfo.orderStateObj.orderStateId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date orderInfo_addTime_edit col-md-12" data-link-field="orderInfo_addTime_edit">
                    <input class="form-control" id="orderInfo_addTime_edit" name="orderInfo.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#orderInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOrderInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.orderInfoQueryForm.currentPage.value = currentPage;
    document.orderInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.orderInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.orderInfoQueryForm.currentPage.value = pageValue;
    documentorderInfoQueryForm.submit();
}

/*弹出修改用户订单界面并初始化数据*/
function orderInfoEdit(orderId) {
	$.ajax({
		url :  basePath + "OrderInfo/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (orderInfo, response, status) {
			if (orderInfo) {
				$("#orderInfo_orderId_edit").val(orderInfo.orderId);
				$("#orderInfo_sendName_edit").val(orderInfo.sendName);
				$("#orderInfo_sendTelephone_edit").val(orderInfo.sendTelephone);
				$("#orderInfo_sendAddress_edit").val(orderInfo.sendAddress);
				$("#orderInfo_getName_edit").val(orderInfo.getName);
				$("#orderInfo_getTelephone_edit").val(orderInfo.getTelephone);
				$("#orderInfo_getAddress_edit").val(orderInfo.getAddress);
				$("#orderInfo_productName_edit").val(orderInfo.productName);
				$("#orderInfo_productPhoto").val(orderInfo.productPhoto);
				$("#orderInfo_productPhotoImg").attr("src", basePath +　orderInfo.productPhoto);
				$("#orderInfo_productPrice_edit").val(orderInfo.productPrice);
				$("#orderInfo_weight_edit").val(orderInfo.weight);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#orderInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#orderInfo_userObj_user_name_edit").html(html);
		        		$("#orderInfo_userObj_user_name_edit").val(orderInfo.userObjPri);
					}
				});
				$.ajax({
					url: basePath + "OrderState/listAll",
					type: "get",
					success: function(orderStates,response,status) { 
						$("#orderInfo_orderStateObj_orderStateId_edit").empty();
						var html="";
		        		$(orderStates).each(function(i,orderState){
		        			html += "<option value='" + orderState.orderStateId + "'>" + orderState.orderStateName + "</option>";
		        		});
		        		$("#orderInfo_orderStateObj_orderStateId_edit").html(html);
		        		$("#orderInfo_orderStateObj_orderStateId_edit").val(orderInfo.orderStateObjPri);
					}
				});
				$("#orderInfo_addTime_edit").val(orderInfo.addTime);
				$('#orderInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除用户订单信息*/
function orderInfoDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "OrderInfo/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#orderInfoQueryForm").submit();
					//location.href= basePath + "OrderInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交用户订单信息表单给服务器端修改*/
function ajaxOrderInfoModify() {
	$.ajax({
		url :  basePath + "OrderInfo/" + $("#orderInfo_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#orderInfoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.orderInfo_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

