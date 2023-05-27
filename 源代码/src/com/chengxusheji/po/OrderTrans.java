package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderTrans {
    /*运输id*/
    private Integer transId;
    public Integer getTransId(){
        return transId;
    }
    public void setTransId(Integer transId){
        this.transId = transId;
    }

    /*运输订单*/
    private OrderInfo orderObj;
    public OrderInfo getOrderObj() {
        return orderObj;
    }
    public void setOrderObj(OrderInfo orderObj) {
        this.orderObj = orderObj;
    }

    /*加入调度*/
    private CarRoute carRouteObj;
    public CarRoute getCarRouteObj() {
        return carRouteObj;
    }
    public void setCarRouteObj(CarRoute carRouteObj) {
        this.carRouteObj = carRouteObj;
    }

    /*加入时间*/
    @NotEmpty(message="加入时间不能为空")
    private String joinTime;
    public String getJoinTime() {
        return joinTime;
    }
    public void setJoinTime(String joinTime) {
        this.joinTime = joinTime;
    }

    /*备注*/
    private String memo;
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderTrans=new JSONObject(); 
		jsonOrderTrans.accumulate("transId", this.getTransId());
		jsonOrderTrans.accumulate("orderObj", this.getOrderObj().getOrderId());
		jsonOrderTrans.accumulate("orderObjPri", this.getOrderObj().getOrderId());
		jsonOrderTrans.accumulate("orderObjDesc", this.getOrderObj().getProductName() + "【" + this.getOrderObj().getSendAddress() + "=》" + this.getOrderObj().getGetAddress() + "】");
		jsonOrderTrans.accumulate("carRouteObj", this.getCarRouteObj().getRouteId());
		jsonOrderTrans.accumulate("carRouteObjPri", this.getCarRouteObj().getRouteId());
		jsonOrderTrans.accumulate("carRouteObjDesc", this.getCarRouteObj().getCarObj().getCarNo() + "【" + this.getCarRouteObj().getStartPlace() + " => " + this.getCarRouteObj().getEndPlace() + "】");
		jsonOrderTrans.accumulate("joinTime", this.getJoinTime().length()>19?this.getJoinTime().substring(0,19):this.getJoinTime());
		jsonOrderTrans.accumulate("memo", this.getMemo());
		return jsonOrderTrans;
    }}