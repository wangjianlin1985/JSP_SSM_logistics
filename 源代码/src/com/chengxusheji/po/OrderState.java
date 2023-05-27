package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderState {
    /*订单状态id*/
    private Integer orderStateId;
    public Integer getOrderStateId(){
        return orderStateId;
    }
    public void setOrderStateId(Integer orderStateId){
        this.orderStateId = orderStateId;
    }

    /*订单状态名称*/
    @NotEmpty(message="订单状态名称不能为空")
    private String orderStateName;
    public String getOrderStateName() {
        return orderStateName;
    }
    public void setOrderStateName(String orderStateName) {
        this.orderStateName = orderStateName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderState=new JSONObject(); 
		jsonOrderState.accumulate("orderStateId", this.getOrderStateId());
		jsonOrderState.accumulate("orderStateName", this.getOrderStateName());
		return jsonOrderState;
    }}