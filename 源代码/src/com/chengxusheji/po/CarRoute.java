package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class CarRoute {
    /*调度id*/
    private Integer routeId;
    public Integer getRouteId(){
        return routeId;
    }
    public void setRouteId(Integer routeId){
        this.routeId = routeId;
    }

    /*调度车辆*/
    private Car carObj;
    public Car getCarObj() {
        return carObj;
    }
    public void setCarObj(Car carObj) {
        this.carObj = carObj;
    }

    /*出发地*/
    @NotEmpty(message="出发地不能为空")
    private String startPlace;
    public String getStartPlace() {
        return startPlace;
    }
    public void setStartPlace(String startPlace) {
        this.startPlace = startPlace;
    }

    /*起点经度*/
    @NotNull(message="必须输入起点经度")
    private Float startLongitude;
    public Float getStartLongitude() {
        return startLongitude;
    }
    public void setStartLongitude(Float startLongitude) {
        this.startLongitude = startLongitude;
    }

    /*起点纬度*/
    @NotNull(message="必须输入起点纬度")
    private Float startLatitude;
    public Float getStartLatitude() {
        return startLatitude;
    }
    public void setStartLatitude(Float startLatitude) {
        this.startLatitude = startLatitude;
    }

    /*终到地*/
    @NotEmpty(message="终到地不能为空")
    private String endPlace;
    public String getEndPlace() {
        return endPlace;
    }
    public void setEndPlace(String endPlace) {
        this.endPlace = endPlace;
    }

    /*终点经度*/
    @NotNull(message="必须输入终点经度")
    private Float endLongitude;
    public Float getEndLongitude() {
        return endLongitude;
    }
    public void setEndLongitude(Float endLongitude) {
        this.endLongitude = endLongitude;
    }

    /*终点纬度*/
    @NotNull(message="必须输入终点纬度")
    private Float endLatitude;
    public Float getEndLatitude() {
        return endLatitude;
    }
    public void setEndLatitude(Float endLatitude) {
        this.endLatitude = endLatitude;
    }

    /*当前位置*/
    @NotEmpty(message="当前位置不能为空")
    private String currenPlace;
    public String getCurrenPlace() {
        return currenPlace;
    }
    public void setCurrenPlace(String currenPlace) {
        this.currenPlace = currenPlace;
    }

    /*出发时间*/
    @NotEmpty(message="出发时间不能为空")
    private String startTime;
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /*抵达时间*/
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /*调度状态*/
    @NotEmpty(message="调度状态不能为空")
    private String routeState;
    public String getRouteState() {
        return routeState;
    }
    public void setRouteState(String routeState) {
        this.routeState = routeState;
    }

    /*运输成本*/
    @NotNull(message="必须输入运输成本")
    private Float costMoney;
    public Float getCostMoney() {
        return costMoney;
    }
    public void setCostMoney(Float costMoney) {
        this.costMoney = costMoney;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCarRoute=new JSONObject(); 
		jsonCarRoute.accumulate("routeId", this.getRouteId());
		jsonCarRoute.accumulate("carObj", this.getCarObj().getCarNo());
		jsonCarRoute.accumulate("carObjPri", this.getCarObj().getCarNo());
		jsonCarRoute.accumulate("startPlace", this.getStartPlace());
		jsonCarRoute.accumulate("startLongitude", this.getStartLongitude());
		jsonCarRoute.accumulate("startLatitude", this.getStartLatitude());
		jsonCarRoute.accumulate("endPlace", this.getEndPlace());
		jsonCarRoute.accumulate("endLongitude", this.getEndLongitude());
		jsonCarRoute.accumulate("endLatitude", this.getEndLatitude());
		jsonCarRoute.accumulate("currenPlace", this.getCurrenPlace());
		jsonCarRoute.accumulate("startTime", this.getStartTime().length()>19?this.getStartTime().substring(0,19):this.getStartTime());
		jsonCarRoute.accumulate("endTime", this.getEndTime().length()>19?this.getEndTime().substring(0,19):this.getEndTime());
		jsonCarRoute.accumulate("routeState", this.getRouteState());
		jsonCarRoute.accumulate("costMoney", this.getCostMoney());
		return jsonCarRoute;
    }}