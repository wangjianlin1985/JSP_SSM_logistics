package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Car;

public interface CarMapper {
	/*添加运输车辆信息*/
	public void addCar(Car car) throws Exception;

	/*按照查询条件分页查询运输车辆记录*/
	public ArrayList<Car> queryCar(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有运输车辆记录*/
	public ArrayList<Car> queryCarList(@Param("where") String where) throws Exception;

	/*按照查询条件的运输车辆记录数*/
	public int queryCarCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条运输车辆记录*/
	public Car getCar(String carNo) throws Exception;

	/*更新运输车辆记录*/
	public void updateCar(Car car) throws Exception;

	/*删除运输车辆记录*/
	public void deleteCar(String carNo) throws Exception;

}
