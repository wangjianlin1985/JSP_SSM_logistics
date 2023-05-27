package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Car;
import com.chengxusheji.po.CarRoute;

import com.chengxusheji.mapper.CarRouteMapper;
@Service
public class CarRouteService {

	@Resource CarRouteMapper carRouteMapper;
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

    /*添加车辆调度记录*/
    public void addCarRoute(CarRoute carRoute) throws Exception {
    	carRouteMapper.addCarRoute(carRoute);
    }

    /*按照查询条件分页查询车辆调度记录*/
    public ArrayList<CarRoute> queryCarRoute(Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != carObj &&  carObj.getCarNo() != null  && !carObj.getCarNo().equals(""))  where += " and t_carRoute.carObj='" + carObj.getCarNo() + "'";
    	if(!startPlace.equals("")) where = where + " and t_carRoute.startPlace like '%" + startPlace + "%'";
    	if(!endPlace.equals("")) where = where + " and t_carRoute.endPlace like '%" + endPlace + "%'";
    	if(!startTime.equals("")) where = where + " and t_carRoute.startTime like '%" + startTime + "%'";
    	if(!endTime.equals("")) where = where + " and t_carRoute.endTime like '%" + endTime + "%'";
    	if(!routeState.equals("")) where = where + " and t_carRoute.routeState like '%" + routeState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return carRouteMapper.queryCarRoute(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<CarRoute> queryCarRoute(Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != carObj &&  carObj.getCarNo() != null && !carObj.getCarNo().equals(""))  where += " and t_carRoute.carObj='" + carObj.getCarNo() + "'";
    	if(!startPlace.equals("")) where = where + " and t_carRoute.startPlace like '%" + startPlace + "%'";
    	if(!endPlace.equals("")) where = where + " and t_carRoute.endPlace like '%" + endPlace + "%'";
    	if(!startTime.equals("")) where = where + " and t_carRoute.startTime like '%" + startTime + "%'";
    	if(!endTime.equals("")) where = where + " and t_carRoute.endTime like '%" + endTime + "%'";
    	if(!routeState.equals("")) where = where + " and t_carRoute.routeState like '%" + routeState + "%'";
    	return carRouteMapper.queryCarRouteList(where);
    }

    /*查询所有车辆调度记录*/
    public ArrayList<CarRoute> queryAllCarRoute()  throws Exception {
        return carRouteMapper.queryCarRouteList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState) throws Exception {
     	String where = "where 1=1";
    	if(null != carObj &&  carObj.getCarNo() != null && !carObj.getCarNo().equals(""))  where += " and t_carRoute.carObj='" + carObj.getCarNo() + "'";
    	if(!startPlace.equals("")) where = where + " and t_carRoute.startPlace like '%" + startPlace + "%'";
    	if(!endPlace.equals("")) where = where + " and t_carRoute.endPlace like '%" + endPlace + "%'";
    	if(!startTime.equals("")) where = where + " and t_carRoute.startTime like '%" + startTime + "%'";
    	if(!endTime.equals("")) where = where + " and t_carRoute.endTime like '%" + endTime + "%'";
    	if(!routeState.equals("")) where = where + " and t_carRoute.routeState like '%" + routeState + "%'";
        recordNumber = carRouteMapper.queryCarRouteCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取车辆调度记录*/
    public CarRoute getCarRoute(int routeId) throws Exception  {
        CarRoute carRoute = carRouteMapper.getCarRoute(routeId);
        return carRoute;
    }

    /*更新车辆调度记录*/
    public void updateCarRoute(CarRoute carRoute) throws Exception {
        carRouteMapper.updateCarRoute(carRoute);
    }

    /*删除一条车辆调度记录*/
    public void deleteCarRoute (int routeId) throws Exception {
        carRouteMapper.deleteCarRoute(routeId);
    }

    /*删除多条车辆调度信息*/
    public int deleteCarRoutes (String routeIds) throws Exception {
    	String _routeIds[] = routeIds.split(",");
    	for(String _routeId: _routeIds) {
    		carRouteMapper.deleteCarRoute(Integer.parseInt(_routeId));
    	}
    	return _routeIds.length;
    }
}
