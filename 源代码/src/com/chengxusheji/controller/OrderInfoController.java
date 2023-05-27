package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.OrderInfoService;
import com.chengxusheji.po.OrderInfo;
import com.chengxusheji.service.OrderStateService;
import com.chengxusheji.po.OrderState;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//OrderInfo管理控制层
@Controller
@RequestMapping("/OrderInfo")
public class OrderInfoController extends BaseController {

    /*业务层对象*/
    @Resource OrderInfoService orderInfoService;

    @Resource OrderStateService orderStateService;
    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("orderStateObj")
	public void initBinderorderStateObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderStateObj.");
	}
	@InitBinder("orderInfo")
	public void initBinderOrderInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderInfo.");
	}
	/*跳转到添加OrderInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new OrderInfo());
		/*查询所有的OrderState信息*/
		List<OrderState> orderStateList = orderStateService.queryAllOrderState();
		request.setAttribute("orderStateList", orderStateList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "OrderInfo_add";
	}

	/*客户端ajax方式提交添加用户订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated OrderInfo orderInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		try {
			orderInfo.setProductPhoto(this.handlePhotoUpload(request, "productPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        orderInfoService.addOrderInfo(orderInfo);
        message = "用户订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加用户订单信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(OrderInfo orderInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		 
		
		UserInfo userInfo = new UserInfo();
		userInfo.setUser_name(session.getAttribute("user_name").toString());
		orderInfo.setUserObj(userInfo);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		orderInfo.setAddTime(sdf.format(new java.util.Date()));
		
		try {
			orderInfo.setProductPhoto(this.handlePhotoUpload(request, "productPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        orderInfoService.addOrderInfo(orderInfo);
        message = "用户订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax方式按照查询条件分页查询用户订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String sendName,String sendTelephone,String getName,String getTelephone,String productName,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("orderStateObj") OrderState orderStateObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (sendName == null) sendName = "";
		if (sendTelephone == null) sendTelephone = "";
		if (getName == null) getName = "";
		if (getTelephone == null) getTelephone = "";
		if (productName == null) productName = "";
		if (addTime == null) addTime = "";
		if(rows != 0)orderInfoService.setRows(rows);
		List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    orderInfoService.queryTotalPageAndRecordNumber(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(OrderInfo orderInfo:orderInfoList) {
			JSONObject jsonOrderInfo = orderInfo.getJsonObject();
			jsonArray.put(jsonOrderInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询用户订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(OrderInfo orderInfo:orderInfoList) {
			JSONObject jsonOrderInfo = new JSONObject();
			jsonOrderInfo.accumulate("orderId", orderInfo.getOrderId());
			jsonOrderInfo.accumulate("orderDesc", orderInfo.getProductName() + "【" + orderInfo.getSendAddress() + "=》" + orderInfo.getGetAddress() + "】");
			jsonArray.put(jsonOrderInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询用户订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String sendName,String sendTelephone,String getName,String getTelephone,String productName,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("orderStateObj") OrderState orderStateObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sendName == null) sendName = "";
		if (sendTelephone == null) sendTelephone = "";
		if (getName == null) getName = "";
		if (getTelephone == null) getTelephone = "";
		if (productName == null) productName = "";
		if (addTime == null) addTime = "";
		List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    orderInfoService.queryTotalPageAndRecordNumber(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderInfoService.getRecordNumber();
	    request.setAttribute("orderInfoList",  orderInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("sendName", sendName);
	    request.setAttribute("sendTelephone", sendTelephone);
	    request.setAttribute("getName", getName);
	    request.setAttribute("getTelephone", getTelephone);
	    request.setAttribute("productName", productName);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("orderStateObj", orderStateObj);
	    request.setAttribute("addTime", addTime);
	    List<OrderState> orderStateList = orderStateService.queryAllOrderState();
	    request.setAttribute("orderStateList", orderStateList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "OrderInfo/orderInfo_frontquery_result"; 
	}

	
	/*前台按照查询条件分页查询用户订单信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(String sendName,String sendTelephone,String getName,String getTelephone,String productName,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("orderStateObj") OrderState orderStateObj,String addTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sendName == null) sendName = "";
		if (sendTelephone == null) sendTelephone = "";
		if (getName == null) getName = "";
		if (getTelephone == null) getTelephone = "";
		if (productName == null) productName = "";
		if (addTime == null) addTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    orderInfoService.queryTotalPageAndRecordNumber(sendName, sendTelephone, getName, getTelephone, productName, userObj, orderStateObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderInfoService.getRecordNumber();
	    request.setAttribute("orderInfoList",  orderInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("sendName", sendName);
	    request.setAttribute("sendTelephone", sendTelephone);
	    request.setAttribute("getName", getName);
	    request.setAttribute("getTelephone", getTelephone);
	    request.setAttribute("productName", productName);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("orderStateObj", orderStateObj);
	    request.setAttribute("addTime", addTime);
	    List<OrderState> orderStateList = orderStateService.queryAllOrderState();
	    request.setAttribute("orderStateList", orderStateList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "OrderInfo/orderInfo_userFrontquery_result"; 
	}
	
	
     /*前台查询OrderInfo信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取OrderInfo对象*/
        OrderInfo orderInfo = orderInfoService.getOrderInfo(orderId);

        List<OrderState> orderStateList = orderStateService.queryAllOrderState();
        request.setAttribute("orderStateList", orderStateList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("orderInfo",  orderInfo);
        return "OrderInfo/orderInfo_frontshow";
	}

	/*ajax方式显示用户订单修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取OrderInfo对象*/
        OrderInfo orderInfo = orderInfoService.getOrderInfo(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOrderInfo = orderInfo.getJsonObject();
		out.println(jsonOrderInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新用户订单信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated OrderInfo orderInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String productPhotoFileName = this.handlePhotoUpload(request, "productPhotoFile");
		if(!productPhotoFileName.equals("upload/NoImage.jpg"))orderInfo.setProductPhoto(productPhotoFileName); 


		try {
			orderInfoService.updateOrderInfo(orderInfo);
			message = "用户订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "用户订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除用户订单信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  orderInfoService.deleteOrderInfo(orderId);
	            request.setAttribute("message", "用户订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "用户订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条用户订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = orderInfoService.deleteOrderInfos(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出用户订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String sendName,String sendTelephone,String getName,String getTelephone,String productName,@ModelAttribute("userObj") UserInfo userObj,@ModelAttribute("orderStateObj") OrderState orderStateObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(sendName == null) sendName = "";
        if(sendTelephone == null) sendTelephone = "";
        if(getName == null) getName = "";
        if(getTelephone == null) getTelephone = "";
        if(productName == null) productName = "";
        if(addTime == null) addTime = "";
        List<OrderInfo> orderInfoList = orderInfoService.queryOrderInfo(sendName,sendTelephone,getName,getTelephone,productName,userObj,orderStateObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "OrderInfo信息记录"; 
        String[] headers = { "订单id","寄件人姓名","寄件人电话","收件方电话","收件方电话","货物名称","货物照片","货物重量","发布用户","订单状态","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<orderInfoList.size();i++) {
        	OrderInfo orderInfo = orderInfoList.get(i); 
        	dataset.add(new String[]{orderInfo.getOrderId() + "",orderInfo.getSendName(),orderInfo.getSendTelephone(),orderInfo.getGetName(),orderInfo.getGetTelephone(),orderInfo.getProductName(),orderInfo.getProductPhoto(),orderInfo.getWeight(),orderInfo.getUserObj().getName(),orderInfo.getOrderStateObj().getOrderStateName(),orderInfo.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"OrderInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
