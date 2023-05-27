<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CarRoute" %>
<%@ page import="com.chengxusheji.po.Car" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<CarRoute> carRouteList = (List<CarRoute>)request.getAttribute("carRouteList");
    //获取所有的carObj信息
    List<Car> carList = (List<Car>)request.getAttribute("carList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Car carObj = (Car)request.getAttribute("carObj");
    String startPlace = (String)request.getAttribute("startPlace"); //出发地查询关键字
    String endPlace = (String)request.getAttribute("endPlace"); //终到地查询关键字
    String startTime = (String)request.getAttribute("startTime"); //出发时间查询关键字
    String endTime = (String)request.getAttribute("endTime"); //抵达时间查询关键字
    String routeState = (String)request.getAttribute("routeState"); //调度状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>车辆调度查询</title>
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
			    	<li role="presentation" class="active"><a href="#carRouteListPanel" aria-controls="carRouteListPanel" role="tab" data-toggle="tab">车辆调度列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>CarRoute/carRoute_frontAdd.jsp" style="display:none;">添加车辆调度</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="carRouteListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td> <td>调度车辆</td><td>出发地</td><td>终到地</td><td>当前位置</td><td>出发时间</td><td>抵达时间</td><td>调度状态</td><td>运输成本</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<carRouteList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		CarRoute carRoute = carRouteList.get(i); //获取到车辆调度对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 										 
 											<td><%=carRoute.getCarObj().getCarNo() %></td>
 											<td><%=carRoute.getStartPlace() %></td>
 											<td><%=carRoute.getEndPlace() %></td>
 											<td><%=carRoute.getCurrenPlace() %></td>
 											<td><%=carRoute.getStartTime() %></td>
 											<td><%=carRoute.getEndTime() %></td>
 											<td><%=carRoute.getRouteState() %></td>
 											<td><%=carRoute.getCostMoney() %></td>
 											<td>
 												<a href="<%=basePath  %>CarRoute/<%=carRoute.getRouteId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="carRouteEdit('<%=carRoute.getRouteId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="carRouteDelete('<%=carRoute.getRouteId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
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
    		<h1>车辆调度查询</h1>
		</div>
		<form name="carRouteQueryForm" id="carRouteQueryForm" action="<%=basePath %>CarRoute/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="carObj_carNo">调度车辆：</label>
                <select id="carObj_carNo" name="carObj.carNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Car carTemp:carList) {
	 					String selected = "";
 					if(carObj!=null && carObj.getCarNo()!=null && carObj.getCarNo().equals(carTemp.getCarNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=carTemp.getCarNo() %>" <%=selected %>><%=carTemp.getCarNo() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="startPlace">出发地:</label>
				<input type="text" id="startPlace" name="startPlace" value="<%=startPlace %>" class="form-control" placeholder="请输入出发地">
			</div>






			<div class="form-group">
				<label for="endPlace">终到地:</label>
				<input type="text" id="endPlace" name="endPlace" value="<%=endPlace %>" class="form-control" placeholder="请输入终到地">
			</div>






			<div class="form-group">
				<label for="startTime">出发时间:</label>
				<input type="text" id="startTime" name="startTime" class="form-control"  placeholder="请选择出发时间" value="<%=startTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="endTime">抵达时间:</label>
				<input type="text" id="endTime" name="endTime" class="form-control"  placeholder="请选择抵达时间" value="<%=endTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="routeState">调度状态:</label>
				<input type="text" id="routeState" name="routeState" value="<%=routeState %>" class="form-control" placeholder="请输入调度状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="carRouteEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;车辆调度信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="carRouteEditForm" id="carRouteEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="carRoute_routeId_edit" class="col-md-3 text-right">调度id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="carRoute_routeId_edit" name="carRoute.routeId" class="form-control" placeholder="请输入调度id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="carRoute_carObj_carNo_edit" class="col-md-3 text-right">调度车辆:</label>
		  	 <div class="col-md-9">
			    <select id="carRoute_carObj_carNo_edit" name="carRoute.carObj.carNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_startPlace_edit" class="col-md-3 text-right">出发地:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_startPlace_edit" name="carRoute.startPlace" class="form-control" placeholder="请输入出发地">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_startLongitude_edit" class="col-md-3 text-right">起点经度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_startLongitude_edit" name="carRoute.startLongitude" class="form-control" placeholder="请输入起点经度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_startLatitude_edit" class="col-md-3 text-right">起点纬度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_startLatitude_edit" name="carRoute.startLatitude" class="form-control" placeholder="请输入起点纬度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_endPlace_edit" class="col-md-3 text-right">终到地:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_endPlace_edit" name="carRoute.endPlace" class="form-control" placeholder="请输入终到地">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_endLongitude_edit" class="col-md-3 text-right">终点经度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_endLongitude_edit" name="carRoute.endLongitude" class="form-control" placeholder="请输入终点经度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_endLatitude_edit" class="col-md-3 text-right">终点纬度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_endLatitude_edit" name="carRoute.endLatitude" class="form-control" placeholder="请输入终点纬度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_currenPlace_edit" class="col-md-3 text-right">当前位置:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_currenPlace_edit" name="carRoute.currenPlace" class="form-control" placeholder="请输入当前位置">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_startTime_edit" class="col-md-3 text-right">出发时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date carRoute_startTime_edit col-md-12" data-link-field="carRoute_startTime_edit">
                    <input class="form-control" id="carRoute_startTime_edit" name="carRoute.startTime" size="16" type="text" value="" placeholder="请选择出发时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_endTime_edit" class="col-md-3 text-right">抵达时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date carRoute_endTime_edit col-md-12" data-link-field="carRoute_endTime_edit">
                    <input class="form-control" id="carRoute_endTime_edit" name="carRoute.endTime" size="16" type="text" value="" placeholder="请选择抵达时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_routeState_edit" class="col-md-3 text-right">调度状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_routeState_edit" name="carRoute.routeState" class="form-control" placeholder="请输入调度状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="carRoute_costMoney_edit" class="col-md-3 text-right">运输成本:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="carRoute_costMoney_edit" name="carRoute.costMoney" class="form-control" placeholder="请输入运输成本">
			 </div>
		  </div>
		</form> 
	    <style>#carRouteEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCarRouteModify();">提交</button>
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
    document.carRouteQueryForm.currentPage.value = currentPage;
    document.carRouteQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.carRouteQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.carRouteQueryForm.currentPage.value = pageValue;
    documentcarRouteQueryForm.submit();
}

/*弹出修改车辆调度界面并初始化数据*/
function carRouteEdit(routeId) {
	$.ajax({
		url :  basePath + "CarRoute/" + routeId + "/update",
		type : "get",
		dataType: "json",
		success : function (carRoute, response, status) {
			if (carRoute) {
				$("#carRoute_routeId_edit").val(carRoute.routeId);
				$.ajax({
					url: basePath + "Car/listAll",
					type: "get",
					success: function(cars,response,status) { 
						$("#carRoute_carObj_carNo_edit").empty();
						var html="";
		        		$(cars).each(function(i,car){
		        			html += "<option value='" + car.carNo + "'>" + car.carNo + "</option>";
		        		});
		        		$("#carRoute_carObj_carNo_edit").html(html);
		        		$("#carRoute_carObj_carNo_edit").val(carRoute.carObjPri);
					}
				});
				$("#carRoute_startPlace_edit").val(carRoute.startPlace);
				$("#carRoute_startLongitude_edit").val(carRoute.startLongitude);
				$("#carRoute_startLatitude_edit").val(carRoute.startLatitude);
				$("#carRoute_endPlace_edit").val(carRoute.endPlace);
				$("#carRoute_endLongitude_edit").val(carRoute.endLongitude);
				$("#carRoute_endLatitude_edit").val(carRoute.endLatitude);
				$("#carRoute_currenPlace_edit").val(carRoute.currenPlace);
				$("#carRoute_startTime_edit").val(carRoute.startTime);
				$("#carRoute_endTime_edit").val(carRoute.endTime);
				$("#carRoute_routeState_edit").val(carRoute.routeState);
				$("#carRoute_costMoney_edit").val(carRoute.costMoney);
				$('#carRouteEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除车辆调度信息*/
function carRouteDelete(routeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "CarRoute/deletes",
			data : {
				routeIds : routeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#carRouteQueryForm").submit();
					//location.href= basePath + "CarRoute/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交车辆调度信息表单给服务器端修改*/
function ajaxCarRouteModify() {
	$.ajax({
		url :  basePath + "CarRoute/" + $("#carRoute_routeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#carRouteEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#carRouteQueryForm").submit();
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

    /*出发时间组件*/
    $('.carRoute_startTime_edit').datetimepicker({
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
    /*抵达时间组件*/
    $('.carRoute_endTime_edit').datetimepicker({
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

