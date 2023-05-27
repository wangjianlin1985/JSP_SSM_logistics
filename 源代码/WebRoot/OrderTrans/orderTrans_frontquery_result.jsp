<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.OrderTrans" %>
<%@ page import="com.chengxusheji.po.CarRoute" %>
<%@ page import="com.chengxusheji.po.OrderInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<OrderTrans> orderTransList = (List<OrderTrans>)request.getAttribute("orderTransList");
    //获取所有的carRouteObj信息
    List<CarRoute> carRouteList = (List<CarRoute>)request.getAttribute("carRouteList");
    //获取所有的orderObj信息
    List<OrderInfo> orderInfoList = (List<OrderInfo>)request.getAttribute("orderInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    OrderInfo orderObj = (OrderInfo)request.getAttribute("orderObj");
    CarRoute carRouteObj = (CarRoute)request.getAttribute("carRouteObj");
    String joinTime = (String)request.getAttribute("joinTime"); //加入时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订单运输查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#orderTransListPanel" aria-controls="orderTransListPanel" role="tab" data-toggle="tab">订单运输列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>OrderTrans/orderTrans_frontAdd.jsp" style="display:none;">添加订单运输</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="orderTransListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>运输订单</td><td>加入调度</td><td>加入时间</td> </tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<orderTransList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		OrderTrans orderTrans = orderTransList.get(i); //获取到订单运输对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=orderTrans.getOrderObj().getProductName() + "【 " + orderTrans.getOrderObj().getSendAddress() + "=》" + orderTrans.getOrderObj().getGetAddress() + "】" %></td>
 											<td><a href="<%=basePath %>CarRoute/<%=orderTrans.getCarRouteObj().getRouteId() %>/frontshow" target="_blank"><%=orderTrans.getCarRouteObj().getCarObj().getCarNo() + "【 " + orderTrans.getCarRouteObj().getStartPlace() + " => " + orderTrans.getCarRouteObj().getEndPlace()+ "】" %></a></td>
 											<td><%=orderTrans.getJoinTime() %></td>
 											 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>订单运输查询</h1>
		</div>
		<form name="orderTransQueryForm" id="orderTransQueryForm" action="<%=basePath %>OrderTrans/frontlist" class="mar_t15" method="post">
            <div class="form-group" style="display:none;">
            	<label for="orderObj_orderId">运输订单：</label>
                <select id="orderObj_orderId" name="orderObj.orderId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(OrderInfo orderInfoTemp:orderInfoList) {
	 					String selected = "";
 					if(orderObj!=null && orderObj.getOrderId()!=null && orderObj.getOrderId().intValue()==orderInfoTemp.getOrderId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=orderInfoTemp.getOrderId() %>" <%=selected %>><%=orderInfoTemp.getOrderId() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group" style="display:none;">
            	<label for="carRouteObj_routeId">加入调度：</label>
                <select id="carRouteObj_routeId" name="carRouteObj.routeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(CarRoute carRouteTemp:carRouteList) {
	 					String selected = "";
 					if(carRouteObj!=null && carRouteObj.getRouteId()!=null && carRouteObj.getRouteId().intValue()==carRouteTemp.getRouteId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=carRouteTemp.getRouteId() %>" <%=selected %>><%=carRouteTemp.getRouteId() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="joinTime">加入时间:</label>
				<input type="text" id="joinTime" name="joinTime" class="form-control"  placeholder="请选择加入时间" value="<%=joinTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="orderTransEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;订单运输信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="orderTransEditForm" id="orderTransEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderTrans_transId_edit" class="col-md-3 text-right">运输id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderTrans_transId_edit" name="orderTrans.transId" class="form-control" placeholder="请输入运输id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderTrans_orderObj_orderId_edit" class="col-md-3 text-right">运输订单:</label>
		  	 <div class="col-md-9">
			    <select id="orderTrans_orderObj_orderId_edit" name="orderTrans.orderObj.orderId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderTrans_carRouteObj_routeId_edit" class="col-md-3 text-right">加入调度:</label>
		  	 <div class="col-md-9">
			    <select id="orderTrans_carRouteObj_routeId_edit" name="orderTrans.carRouteObj.routeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderTrans_joinTime_edit" class="col-md-3 text-right">加入时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date orderTrans_joinTime_edit col-md-12" data-link-field="orderTrans_joinTime_edit">
                    <input class="form-control" id="orderTrans_joinTime_edit" name="orderTrans.joinTime" size="16" type="text" value="" placeholder="请选择加入时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderTrans_memo_edit" class="col-md-3 text-right">备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="orderTrans_memo_edit" name="orderTrans.memo" rows="8" class="form-control" placeholder="请输入备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#orderTransEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOrderTransModify();">提交</button>
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
    document.orderTransQueryForm.currentPage.value = currentPage;
    document.orderTransQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.orderTransQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.orderTransQueryForm.currentPage.value = pageValue;
    documentorderTransQueryForm.submit();
}

/*弹出修改订单运输界面并初始化数据*/
function orderTransEdit(transId) {
	$.ajax({
		url :  basePath + "OrderTrans/" + transId + "/update",
		type : "get",
		dataType: "json",
		success : function (orderTrans, response, status) {
			if (orderTrans) {
				$("#orderTrans_transId_edit").val(orderTrans.transId);
				$.ajax({
					url: basePath + "OrderInfo/listAll",
					type: "get",
					success: function(orderInfos,response,status) { 
						$("#orderTrans_orderObj_orderId_edit").empty();
						var html="";
		        		$(orderInfos).each(function(i,orderInfo){
		        			html += "<option value='" + orderInfo.orderId + "'>" + orderInfo.orderId + "</option>";
		        		});
		        		$("#orderTrans_orderObj_orderId_edit").html(html);
		        		$("#orderTrans_orderObj_orderId_edit").val(orderTrans.orderObjPri);
					}
				});
				$.ajax({
					url: basePath + "CarRoute/listAll",
					type: "get",
					success: function(carRoutes,response,status) { 
						$("#orderTrans_carRouteObj_routeId_edit").empty();
						var html="";
		        		$(carRoutes).each(function(i,carRoute){
		        			html += "<option value='" + carRoute.routeId + "'>" + carRoute.routeId + "</option>";
		        		});
		        		$("#orderTrans_carRouteObj_routeId_edit").html(html);
		        		$("#orderTrans_carRouteObj_routeId_edit").val(orderTrans.carRouteObjPri);
					}
				});
				$("#orderTrans_joinTime_edit").val(orderTrans.joinTime);
				$("#orderTrans_memo_edit").val(orderTrans.memo);
				$('#orderTransEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除订单运输信息*/
function orderTransDelete(transId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "OrderTrans/deletes",
			data : {
				transIds : transId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#orderTransQueryForm").submit();
					//location.href= basePath + "OrderTrans/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交订单运输信息表单给服务器端修改*/
function ajaxOrderTransModify() {
	$.ajax({
		url :  basePath + "OrderTrans/" + $("#orderTrans_transId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderTransEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#orderTransQueryForm").submit();
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

    /*加入时间组件*/
    $('.orderTrans_joinTime_edit').datetimepicker({
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

