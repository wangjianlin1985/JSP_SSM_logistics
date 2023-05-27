<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Car" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Car> carList = (List<Car>)request.getAttribute("carList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String carNo = (String)request.getAttribute("carNo"); //车牌号查询关键字
    String buyDate = (String)request.getAttribute("buyDate"); //购买日期查询关键字
    String driverName = (String)request.getAttribute("driverName"); //驾驶员姓名查询关键字
    String cardNumber = (String)request.getAttribute("cardNumber"); //驾驶员身份证查询关键字
    String telephone = (String)request.getAttribute("telephone"); //驾驶员电话查询关键字
    String carState = (String)request.getAttribute("carState"); //车辆状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>运输车辆查询</title>
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
  			<li><a href="<%=basePath %>Car/frontlist">运输车辆信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Car/car_frontAdd.jsp" style="display:none;">添加运输车辆</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<carList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Car car = carList.get(i); //获取到运输车辆对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Car/<%=car.getCarNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=car.getCarPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		车牌号:<%=car.getCarNo() %>
			     	</div>
			     	<div class="field">
	            		车辆颜色:<%=car.getCarColor() %>
			     	</div>
			     	<div class="field">
	            		车架号:<%=car.getChejiahao() %>
			     	</div>
			     	<div class="field">
	            		吨位:<%=car.getDunwei() %>
			     	</div>
			     	<div class="field">
	            		购买日期:<%=car.getBuyDate() %>
			     	</div>
			     	<div class="field">
	            		驾驶员姓名:<%=car.getDriverName() %>
			     	</div>
			     	<div class="field">
	            		驾驶员身份证:<%=car.getCardNumber() %>
			     	</div>
			     	<div class="field">
	            		驾驶员电话:<%=car.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		车辆状态:<%=car.getCarState() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Car/<%=car.getCarNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="carEdit('<%=car.getCarNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="carDelete('<%=car.getCarNo() %>');" style="display:none;">删除</a>
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
    		<h1>运输车辆查询</h1>
		</div>
		<form name="carQueryForm" id="carQueryForm" action="<%=basePath %>Car/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="carNo">车牌号:</label>
				<input type="text" id="carNo" name="carNo" value="<%=carNo %>" class="form-control" placeholder="请输入车牌号">
			</div>
			<div class="form-group">
				<label for="buyDate">购买日期:</label>
				<input type="text" id="buyDate" name="buyDate" class="form-control"  placeholder="请选择购买日期" value="<%=buyDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="driverName">驾驶员姓名:</label>
				<input type="text" id="driverName" name="driverName" value="<%=driverName %>" class="form-control" placeholder="请输入驾驶员姓名">
			</div>
			<div class="form-group">
				<label for="cardNumber">驾驶员身份证:</label>
				<input type="text" id="cardNumber" name="cardNumber" value="<%=cardNumber %>" class="form-control" placeholder="请输入驾驶员身份证">
			</div>
			<div class="form-group">
				<label for="telephone">驾驶员电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入驾驶员电话">
			</div>
			<div class="form-group">
				<label for="carState">车辆状态:</label>
				<input type="text" id="carState" name="carState" value="<%=carState %>" class="form-control" placeholder="请输入车辆状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="carEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;运输车辆信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="carEditForm" id="carEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="car_carNo_edit" class="col-md-3 text-right">车牌号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="car_carNo_edit" name="car.carNo" class="form-control" placeholder="请输入车牌号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="car_carPhoto_edit" class="col-md-3 text-right">车辆照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="car_carPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="car_carPhoto" name="car.carPhoto"/>
			    <input id="carPhotoFile" name="carPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_carColor_edit" class="col-md-3 text-right">车辆颜色:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_carColor_edit" name="car.carColor" class="form-control" placeholder="请输入车辆颜色">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_chejiahao_edit" class="col-md-3 text-right">车架号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_chejiahao_edit" name="car.chejiahao" class="form-control" placeholder="请输入车架号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_dunwei_edit" class="col-md-3 text-right">吨位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_dunwei_edit" name="car.dunwei" class="form-control" placeholder="请输入吨位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_buyDate_edit" class="col-md-3 text-right">购买日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date car_buyDate_edit col-md-12" data-link-field="car_buyDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="car_buyDate_edit" name="car.buyDate" size="16" type="text" value="" placeholder="请选择购买日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_driverName_edit" class="col-md-3 text-right">驾驶员姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_driverName_edit" name="car.driverName" class="form-control" placeholder="请输入驾驶员姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_cardNumber_edit" class="col-md-3 text-right">驾驶员身份证:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_cardNumber_edit" name="car.cardNumber" class="form-control" placeholder="请输入驾驶员身份证">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_telephone_edit" class="col-md-3 text-right">驾驶员电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_telephone_edit" name="car.telephone" class="form-control" placeholder="请输入驾驶员电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_carState_edit" class="col-md-3 text-right">车辆状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="car_carState_edit" name="car.carState" class="form-control" placeholder="请输入车辆状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="car_memo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="car_memo_edit" name="car.memo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#carEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCarModify();">提交</button>
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
    document.carQueryForm.currentPage.value = currentPage;
    document.carQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.carQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.carQueryForm.currentPage.value = pageValue;
    documentcarQueryForm.submit();
}

/*弹出修改运输车辆界面并初始化数据*/
function carEdit(carNo) {
	$.ajax({
		url :  basePath + "Car/" + carNo + "/update",
		type : "get",
		dataType: "json",
		success : function (car, response, status) {
			if (car) {
				$("#car_carNo_edit").val(car.carNo);
				$("#car_carPhoto").val(car.carPhoto);
				$("#car_carPhotoImg").attr("src", basePath +　car.carPhoto);
				$("#car_carColor_edit").val(car.carColor);
				$("#car_chejiahao_edit").val(car.chejiahao);
				$("#car_dunwei_edit").val(car.dunwei);
				$("#car_buyDate_edit").val(car.buyDate);
				$("#car_driverName_edit").val(car.driverName);
				$("#car_cardNumber_edit").val(car.cardNumber);
				$("#car_telephone_edit").val(car.telephone);
				$("#car_carState_edit").val(car.carState);
				$("#car_memo_edit").val(car.memo);
				$('#carEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除运输车辆信息*/
function carDelete(carNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Car/deletes",
			data : {
				carNos : carNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#carQueryForm").submit();
					//location.href= basePath + "Car/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交运输车辆信息表单给服务器端修改*/
function ajaxCarModify() {
	$.ajax({
		url :  basePath + "Car/" + $("#car_carNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#carEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#carQueryForm").submit();
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

    /*购买日期组件*/
    $('.car_buyDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
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

