package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Car;

import com.chengxusheji.mapper.CarMapper;
@Service
public class CarService {

	@Resource CarMapper carMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加运输车辆记录*/
    public void addCar(Car car) throws Exception {
    	carMapper.addCar(car);
    }

    /*按照查询条件分页查询运输车辆记录*/
    public ArrayList<Car> queryCar(String carNo,String buyDate,String driverName,String cardNumber,String telephone,String carState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!carNo.equals("")) where = where + " and t_car.carNo like '%" + carNo + "%'";
    	if(!buyDate.equals("")) where = where + " and t_car.buyDate like '%" + buyDate + "%'";
    	if(!driverName.equals("")) where = where + " and t_car.driverName like '%" + driverName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_car.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_car.telephone like '%" + telephone + "%'";
    	if(!carState.equals("")) where = where + " and t_car.carState like '%" + carState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return carMapper.queryCar(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Car> queryCar(String carNo,String buyDate,String driverName,String cardNumber,String telephone,String carState) throws Exception  { 
     	String where = "where 1=1";
    	if(!carNo.equals("")) where = where + " and t_car.carNo like '%" + carNo + "%'";
    	if(!buyDate.equals("")) where = where + " and t_car.buyDate like '%" + buyDate + "%'";
    	if(!driverName.equals("")) where = where + " and t_car.driverName like '%" + driverName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_car.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_car.telephone like '%" + telephone + "%'";
    	if(!carState.equals("")) where = where + " and t_car.carState like '%" + carState + "%'";
    	return carMapper.queryCarList(where);
    }

    /*查询所有运输车辆记录*/
    public ArrayList<Car> queryAllCar()  throws Exception {
        return carMapper.queryCarList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String carNo,String buyDate,String driverName,String cardNumber,String telephone,String carState) throws Exception {
     	String where = "where 1=1";
    	if(!carNo.equals("")) where = where + " and t_car.carNo like '%" + carNo + "%'";
    	if(!buyDate.equals("")) where = where + " and t_car.buyDate like '%" + buyDate + "%'";
    	if(!driverName.equals("")) where = where + " and t_car.driverName like '%" + driverName + "%'";
    	if(!cardNumber.equals("")) where = where + " and t_car.cardNumber like '%" + cardNumber + "%'";
    	if(!telephone.equals("")) where = where + " and t_car.telephone like '%" + telephone + "%'";
    	if(!carState.equals("")) where = where + " and t_car.carState like '%" + carState + "%'";
        recordNumber = carMapper.queryCarCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取运输车辆记录*/
    public Car getCar(String carNo) throws Exception  {
        Car car = carMapper.getCar(carNo);
        return car;
    }

    /*更新运输车辆记录*/
    public void updateCar(Car car) throws Exception {
        carMapper.updateCar(car);
    }

    /*删除一条运输车辆记录*/
    public void deleteCar (String carNo) throws Exception {
        carMapper.deleteCar(carNo);
    }

    /*删除多条运输车辆信息*/
    public int deleteCars (String carNos) throws Exception {
    	String _carNos[] = carNos.split(",");
    	for(String _carNo: _carNos) {
    		carMapper.deleteCar(_carNo);
    	}
    	return _carNos.length;
    }
}
