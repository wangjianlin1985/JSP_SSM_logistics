package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.OrderInfo;
import com.chengxusheji.po.CarRoute;
import com.chengxusheji.po.OrderTrans;

import com.chengxusheji.mapper.OrderTransMapper;
@Service
public class OrderTransService {

	@Resource OrderTransMapper orderTransMapper;
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

    /*添加订单运输记录*/
    public void addOrderTrans(OrderTrans orderTrans) throws Exception {
    	orderTransMapper.addOrderTrans(orderTrans);
    }

    /*按照查询条件分页查询订单运输记录*/
    public ArrayList<OrderTrans> queryOrderTrans(OrderInfo orderObj,CarRoute carRouteObj,String joinTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != orderObj && orderObj.getOrderId()!= null && orderObj.getOrderId()!= 0)  where += " and t_orderTrans.orderObj=" + orderObj.getOrderId();
    	if(null != carRouteObj && carRouteObj.getRouteId()!= null && carRouteObj.getRouteId()!= 0)  where += " and t_orderTrans.carRouteObj=" + carRouteObj.getRouteId();
    	if(!joinTime.equals("")) where = where + " and t_orderTrans.joinTime like '%" + joinTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return orderTransMapper.queryOrderTrans(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<OrderTrans> queryOrderTrans(OrderInfo orderObj,CarRoute carRouteObj,String joinTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != orderObj && orderObj.getOrderId()!= null && orderObj.getOrderId()!= 0)  where += " and t_orderTrans.orderObj=" + orderObj.getOrderId();
    	if(null != carRouteObj && carRouteObj.getRouteId()!= null && carRouteObj.getRouteId()!= 0)  where += " and t_orderTrans.carRouteObj=" + carRouteObj.getRouteId();
    	if(!joinTime.equals("")) where = where + " and t_orderTrans.joinTime like '%" + joinTime + "%'";
    	return orderTransMapper.queryOrderTransList(where);
    }

    /*查询所有订单运输记录*/
    public ArrayList<OrderTrans> queryAllOrderTrans()  throws Exception {
        return orderTransMapper.queryOrderTransList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(OrderInfo orderObj,CarRoute carRouteObj,String joinTime) throws Exception {
     	String where = "where 1=1";
    	if(null != orderObj && orderObj.getOrderId()!= null && orderObj.getOrderId()!= 0)  where += " and t_orderTrans.orderObj=" + orderObj.getOrderId();
    	if(null != carRouteObj && carRouteObj.getRouteId()!= null && carRouteObj.getRouteId()!= 0)  where += " and t_orderTrans.carRouteObj=" + carRouteObj.getRouteId();
    	if(!joinTime.equals("")) where = where + " and t_orderTrans.joinTime like '%" + joinTime + "%'";
        recordNumber = orderTransMapper.queryOrderTransCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取订单运输记录*/
    public OrderTrans getOrderTrans(int transId) throws Exception  {
        OrderTrans orderTrans = orderTransMapper.getOrderTrans(transId);
        return orderTrans;
    }

    /*更新订单运输记录*/
    public void updateOrderTrans(OrderTrans orderTrans) throws Exception {
        orderTransMapper.updateOrderTrans(orderTrans);
    }

    /*删除一条订单运输记录*/
    public void deleteOrderTrans (int transId) throws Exception {
        orderTransMapper.deleteOrderTrans(transId);
    }

    /*删除多条订单运输信息*/
    public int deleteOrderTranss (String transIds) throws Exception {
    	String _transIds[] = transIds.split(",");
    	for(String _transId: _transIds) {
    		orderTransMapper.deleteOrderTrans(Integer.parseInt(_transId));
    	}
    	return _transIds.length;
    }
}
