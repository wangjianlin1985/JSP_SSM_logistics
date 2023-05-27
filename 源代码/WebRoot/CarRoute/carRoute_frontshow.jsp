<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CarRoute" %>
<%@ page import="com.chengxusheji.po.Car" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的carObj信息
    List<Car> carList = (List<Car>)request.getAttribute("carList");
    CarRoute carRoute = (CarRoute)request.getAttribute("carRoute");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看车辆调度详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>CarRoute/frontlist">车辆调度信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">调度id:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getRouteId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">调度车辆:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getCarObj().getCarNo() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出发地:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getStartPlace()%></div>
	</div>
	 
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">终到地:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getEndPlace()%></div>
	</div>
	 
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">当前位置:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getCurrenPlace()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出发时间:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getStartTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">抵达时间:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getEndTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">调度状态:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getRouteState()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">运输成本:</div>
		<div class="col-md-10 col-xs-6"><%=carRoute.getCostMoney()%></div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4 text-right bold">地图显示:</div>
		<div class="col-md-10 col-xs-12">
			<div id="routeMap"></div> 
			<div id="routeResult"></div>
		</div>
	</div> 
	<style>
		#routeMap{width:100%;height:500px;overflow: scroll;margin:0;}
	</style>
	
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
 <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=uOqdzZgQFY83xmQ4bqIQlixR"></script>
 <script type="text/javascript">
BMap.Point.prototype.toString = function() { 
	return "当前点的经度=" + this.lng + ",纬度=" + this.lat;
} 
BMap.Pixel.prototype.toString = function() { 
	return "当前点坐标x=" + this.x + ",y=" + this.y;
} 
 
var map;   //地图对象  

function carRoute() {
	map = new BMap.Map("routeMap"); 
	var point = new BMap.Point(120.655094,31.308261);   //苏州大学的经纬度点
	//var point = new BMap.Point(116.3,39.9);    //北京的经度纬度点
	map.centerAndZoom(point, 15); //15代表地图的放大级别，数字越大，地图放大倍数就越大
	map.enableScrollWheelZoom();  //开启鼠标滚动对地图进行缩放
	
	var drivingRouteOptions = {
		renderOptions: {
			map: map,
			panel: document.getElementById("routeResult"),
			selectFirstResult: true,
			autoViewport: true,
			highlightMode: BMAP_HIGHLIGHT_STEP
		},
		policy: BMAP_DRIVING_POLICY_LEAST_TIME,
		onSearchComplete: function(results) {	  //Function	检索完成后的回调函数。参数：results: DrivingRouteResult
			//alert('onSearchComplete');  //1
			
			if(drivingRoute.getStatus() != BMAP_STATUS_SUCCESS) {
					alert(drivingRoute.getStatus());
					alert("查询失败！");
				} else {
					//alert('查询成功'); 
					 
					//drivingRoute.clearResults();
					//alert('清除成功');
					console.log("方案个数:" + results.getNumPlans());
					for(var planIndex=0;planIndex<results.getNumPlans();planIndex++) {
						var routePlan = results.getPlan(planIndex);
						var numRoutes = routePlan.getNumRoutes();
						console.log("线路个数:" + numRoutes);
						console.log("该方案总距离:" + routePlan.getDistance());
						console.log("该方案总时间:" + routePlan.getDuration());
						for(var routeIndex=0;routeIndex<numRoutes;routeIndex++){
							var route = routePlan.getRoute(routeIndex);
							var numSteps = route.getNumSteps();
							console.log("第" + (routeIndex+1) + "线路关键点个数:" + numSteps);
							 
							
							var points = route.getPath();
								console.log("坐标点数组个数:" + points.length);
								/* 
								for(pointIndex=30;pointIndex<70;pointIndex++) {
									var marker = new BMap.Marker(points[pointIndex],{title:"第" + (pointIndex+1) +"个点坐点数组"});				
									//console.log(points[pointIndex]);
									
									map.addOverlay(marker);
								}*/
							 
							for(var stepIndex=0;stepIndex<numSteps;stepIndex++) {
								var step = route.getStep(stepIndex);
								var stepPoint = step.getPosition();
								console.log("第" + (stepIndex+1) + "关键点地理坐标:" + stepPoint);
								console.log("关键点在线路中的位置索引:" + step.getIndex());
								console.log("关键点描述:" + step.getDescription());
								//var marker = new BMap.Marker(stepPoint,{title:"第" + (stepIndex+1) +"个关键点"});
								//map.addOverlay(marker);
								 
								
							}
						 
						}
						
					}
				}
		},
		onMarkersSet: function() {
			//alert('onMarkersSet');  //2
		},
		onInfoHtmlSet: function(poi,htmlDom) {
			//alert('onInfoHtmlSet'); //点击起点和终点的marker标注时调用
			console.log(poi);
			console.log(htmlDom.innerHTML);
			var marker = poi.marker;
			marker.setRotation(30);
			marker.setTitle("起点和终点的marker");
			
		}, 
		onPolylinesSet: function(routes) {
			//alert('onPolylinesSet'); //3
			//alert("驾车线路数组length=" + routes.length);
			for(var index=0;index<routes.length;index++) {
					var route = routes[index];
					var polyline = route.getPolyline();
					if(index==0)
						polyline.setStrokeColor("green");
					if(index==1)
						polyline.setStrokeColor("blue");
					if(index==2)
						polyline.setStrokeColor("black");
					
			}
		},
		onResultsHtmlSet: function(container) {
			//alert('onResultsHtmlSet'); //4
			//console.log(container);
			container.style.border = "1px dashed green";
		}
		
	};
	var drivingRoute = new BMap.DrivingRoute(map,drivingRouteOptions);
	
	var startPoint = new BMap.Point(<%=carRoute.getStartLongitude() %>,<%=carRoute.getStartLatitude() %>);
	var endPoint = new BMap.Point(<%=carRoute.getEndLongitude() %>,<%=carRoute.getEndLatitude() %>);
	
	
	//drivingRoute.search("成都理工大学","洛带古镇");
	//drivingRoute.search("成都","北京",{waypoints:["杭州","合肥"]});
	
	drivingRoute.search(startPoint,endPoint);
	 
	map.addEventListener("click",function(event) {
		//console.log(event.point); 
	});
	
	
}

carRoute();

</script>
</body>
</html>

