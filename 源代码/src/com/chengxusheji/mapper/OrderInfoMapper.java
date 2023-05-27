package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.OrderInfo;

public interface OrderInfoMapper {
	/*添加用户订单信息*/
	public void addOrderInfo(OrderInfo orderInfo) throws Exception;

	/*按照查询条件分页查询用户订单记录*/
	public ArrayList<OrderInfo> queryOrderInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有用户订单记录*/
	public ArrayList<OrderInfo> queryOrderInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的用户订单记录数*/
	public int queryOrderInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条用户订单记录*/
	public OrderInfo getOrderInfo(int orderId) throws Exception;

	/*更新用户订单记录*/
	public void updateOrderInfo(OrderInfo orderInfo) throws Exception;

	/*删除用户订单记录*/
	public void deleteOrderInfo(int orderId) throws Exception;

}
