package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.CarRoute;

public interface CarRouteMapper {
	/*添加车辆调度信息*/
	public void addCarRoute(CarRoute carRoute) throws Exception;

	/*按照查询条件分页查询车辆调度记录*/
	public ArrayList<CarRoute> queryCarRoute(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有车辆调度记录*/
	public ArrayList<CarRoute> queryCarRouteList(@Param("where") String where) throws Exception;

	/*按照查询条件的车辆调度记录数*/
	public int queryCarRouteCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条车辆调度记录*/
	public CarRoute getCarRoute(int routeId) throws Exception;

	/*更新车辆调度记录*/
	public void updateCarRoute(CarRoute carRoute) throws Exception;

	/*删除车辆调度记录*/
	public void deleteCarRoute(int routeId) throws Exception;

}
