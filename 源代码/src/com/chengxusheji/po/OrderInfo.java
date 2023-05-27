package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderInfo {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*寄件人姓名*/
    @NotEmpty(message="寄件人姓名不能为空")
    private String sendName;
    public String getSendName() {
        return sendName;
    }
    public void setSendName(String sendName) {
        this.sendName = sendName;
    }

    /*寄件人电话*/
    @NotEmpty(message="寄件人电话不能为空")
    private String sendTelephone;
    public String getSendTelephone() {
        return sendTelephone;
    }
    public void setSendTelephone(String sendTelephone) {
        this.sendTelephone = sendTelephone;
    }

    /*寄件人地址*/
    @NotEmpty(message="寄件人地址不能为空")
    private String sendAddress;
    public String getSendAddress() {
        return sendAddress;
    }
    public void setSendAddress(String sendAddress) {
        this.sendAddress = sendAddress;
    }

    /*收件方电话*/
    @NotEmpty(message="收件方电话不能为空")
    private String getName;
    public String getGetName() {
        return getName;
    }
    public void setGetName(String getName) {
        this.getName = getName;
    }

    /*收件方电话*/
    @NotEmpty(message="收件方电话不能为空")
    private String getTelephone;
    public String getGetTelephone() {
        return getTelephone;
    }
    public void setGetTelephone(String getTelephone) {
        this.getTelephone = getTelephone;
    }

    /*收件方地址*/
    @NotEmpty(message="收件方地址不能为空")
    private String getAddress;
    public String getGetAddress() {
        return getAddress;
    }
    public void setGetAddress(String getAddress) {
        this.getAddress = getAddress;
    }

    /*货物名称*/
    @NotEmpty(message="货物名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    /*货物照片*/
    private String productPhoto;
    public String getProductPhoto() {
        return productPhoto;
    }
    public void setProductPhoto(String productPhoto) {
        this.productPhoto = productPhoto;
    }

    /*货物价格*/
    @NotNull(message="必须输入货物价格")
    private Float productPrice;
    public Float getProductPrice() {
        return productPrice;
    }
    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    /*货物重量*/
    @NotEmpty(message="货物重量不能为空")
    private String weight;
    public String getWeight() {
        return weight;
    }
    public void setWeight(String weight) {
        this.weight = weight;
    }

    /*发布用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*订单状态*/
    private OrderState orderStateObj;
    public OrderState getOrderStateObj() {
        return orderStateObj;
    }
    public void setOrderStateObj(OrderState orderStateObj) {
        this.orderStateObj = orderStateObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderInfo=new JSONObject(); 
		jsonOrderInfo.accumulate("orderId", this.getOrderId());
		jsonOrderInfo.accumulate("sendName", this.getSendName());
		jsonOrderInfo.accumulate("sendTelephone", this.getSendTelephone());
		jsonOrderInfo.accumulate("sendAddress", this.getSendAddress());
		jsonOrderInfo.accumulate("getName", this.getGetName());
		jsonOrderInfo.accumulate("getTelephone", this.getGetTelephone());
		jsonOrderInfo.accumulate("getAddress", this.getGetAddress());
		jsonOrderInfo.accumulate("productName", this.getProductName());
		jsonOrderInfo.accumulate("productPhoto", this.getProductPhoto());
		jsonOrderInfo.accumulate("productPrice", this.getProductPrice());
		jsonOrderInfo.accumulate("weight", this.getWeight());
		jsonOrderInfo.accumulate("userObj", this.getUserObj().getName());
		jsonOrderInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOrderInfo.accumulate("orderStateObj", this.getOrderStateObj().getOrderStateName());
		jsonOrderInfo.accumulate("orderStateObjPri", this.getOrderStateObj().getOrderStateId());
		jsonOrderInfo.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonOrderInfo;
    }}