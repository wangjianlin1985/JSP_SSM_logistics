package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Car {
    /*车牌号*/
    @NotEmpty(message="车牌号不能为空")
    private String carNo;
    public String getCarNo(){
        return carNo;
    }
    public void setCarNo(String carNo){
        this.carNo = carNo;
    }

    /*车辆照片*/
    private String carPhoto;
    public String getCarPhoto() {
        return carPhoto;
    }
    public void setCarPhoto(String carPhoto) {
        this.carPhoto = carPhoto;
    }

    /*车辆颜色*/
    @NotEmpty(message="车辆颜色不能为空")
    private String carColor;
    public String getCarColor() {
        return carColor;
    }
    public void setCarColor(String carColor) {
        this.carColor = carColor;
    }

    /*车架号*/
    @NotEmpty(message="车架号不能为空")
    private String chejiahao;
    public String getChejiahao() {
        return chejiahao;
    }
    public void setChejiahao(String chejiahao) {
        this.chejiahao = chejiahao;
    }

    /*吨位*/
    @NotEmpty(message="吨位不能为空")
    private String dunwei;
    public String getDunwei() {
        return dunwei;
    }
    public void setDunwei(String dunwei) {
        this.dunwei = dunwei;
    }

    /*购买日期*/
    @NotEmpty(message="购买日期不能为空")
    private String buyDate;
    public String getBuyDate() {
        return buyDate;
    }
    public void setBuyDate(String buyDate) {
        this.buyDate = buyDate;
    }

    /*驾驶员姓名*/
    @NotEmpty(message="驾驶员姓名不能为空")
    private String driverName;
    public String getDriverName() {
        return driverName;
    }
    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    /*驾驶员身份证*/
    @NotEmpty(message="驾驶员身份证不能为空")
    private String cardNumber;
    public String getCardNumber() {
        return cardNumber;
    }
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    /*驾驶员电话*/
    @NotEmpty(message="驾驶员电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*车辆状态*/
    @NotEmpty(message="车辆状态不能为空")
    private String carState;
    public String getCarState() {
        return carState;
    }
    public void setCarState(String carState) {
        this.carState = carState;
    }

    /*备注信息*/
    private String memo;
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCar=new JSONObject(); 
		jsonCar.accumulate("carNo", this.getCarNo());
		jsonCar.accumulate("carPhoto", this.getCarPhoto());
		jsonCar.accumulate("carColor", this.getCarColor());
		jsonCar.accumulate("chejiahao", this.getChejiahao());
		jsonCar.accumulate("dunwei", this.getDunwei());
		jsonCar.accumulate("buyDate", this.getBuyDate().length()>19?this.getBuyDate().substring(0,19):this.getBuyDate());
		jsonCar.accumulate("driverName", this.getDriverName());
		jsonCar.accumulate("cardNumber", this.getCardNumber());
		jsonCar.accumulate("telephone", this.getTelephone());
		jsonCar.accumulate("carState", this.getCarState());
		jsonCar.accumulate("memo", this.getMemo());
		return jsonCar;
    }}