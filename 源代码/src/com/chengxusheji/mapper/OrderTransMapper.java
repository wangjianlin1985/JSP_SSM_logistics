package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.OrderTrans;

public interface OrderTransMapper {
	/*添加订单运输信息*/
	public void addOrderTrans(OrderTrans orderTrans) throws Exception;

	/*按照查询条件分页查询订单运输记录*/
	public ArrayList<OrderTrans> queryOrderTrans(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有订单运输记录*/
	public ArrayList<OrderTrans> queryOrderTransList(@Param("where") String where) throws Exception;

	/*按照查询条件的订单运输记录数*/
	public int queryOrderTransCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条订单运输记录*/
	public OrderTrans getOrderTrans(int transId) throws Exception;

	/*更新订单运输记录*/
	public void updateOrderTrans(OrderTrans orderTrans) throws Exception;

	/*删除订单运输记录*/
	public void deleteOrderTrans(int transId) throws Exception;

}
