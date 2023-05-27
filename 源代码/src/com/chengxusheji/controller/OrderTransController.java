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
import com.chengxusheji.service.OrderTransService;
import com.chengxusheji.po.OrderTrans;
import com.chengxusheji.service.CarRouteService;
import com.chengxusheji.po.CarRoute;
import com.chengxusheji.service.OrderInfoService;
import com.chengxusheji.po.OrderInfo;

//OrderTrans管理控制层
@Controller
@RequestMapping("/OrderTrans")
public class OrderTransController extends BaseController {

    /*业务层对象*/
    @Resource OrderTransService orderTransService;

    @Resource CarRouteService carRouteService;
    @Resource OrderInfoService orderInfoService;
	@InitBinder("orderObj")
	public void initBinderorderObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderObj.");
	}
	@InitBinder("carRouteObj")
	public void initBindercarRouteObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("carRouteObj.");
	}
	@InitBinder("orderTrans")
	public void initBinderOrderTrans(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("orderTrans.");
	}
	/*跳转到添加OrderTrans视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new OrderTrans());
		/*查询所有的CarRoute信息*/
		List<CarRoute> carRouteList = carRouteService.queryAllCarRoute();
		request.setAttribute("carRouteList", carRouteList);
		/*查询所有的OrderInfo信息*/
		List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
		request.setAttribute("orderInfoList", orderInfoList);
		return "OrderTrans_add";
	}

	/*客户端ajax方式提交添加订单运输信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated OrderTrans orderTrans, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		if(orderTransService.queryOrderTrans(orderTrans.getOrderObj(), orderTrans.getCarRouteObj(), "").size() > 0) {
			message = "该订单已经加入过该调度了！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
        orderTransService.addOrderTrans(orderTrans);
        message = "订单运输添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询订单运输信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("carRouteObj") CarRoute carRouteObj,String joinTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (joinTime == null) joinTime = "";
		if(rows != 0)orderTransService.setRows(rows);
		List<OrderTrans> orderTransList = orderTransService.queryOrderTrans(orderObj, carRouteObj, joinTime, page);
	    /*计算总的页数和总的记录数*/
	    orderTransService.queryTotalPageAndRecordNumber(orderObj, carRouteObj, joinTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderTransService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderTransService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(OrderTrans orderTrans:orderTransList) {
			JSONObject jsonOrderTrans = orderTrans.getJsonObject();
			jsonArray.put(jsonOrderTrans);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询订单运输信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<OrderTrans> orderTransList = orderTransService.queryAllOrderTrans();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(OrderTrans orderTrans:orderTransList) {
			JSONObject jsonOrderTrans = new JSONObject();
			jsonOrderTrans.accumulate("transId", orderTrans.getTransId());
			jsonArray.put(jsonOrderTrans);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询订单运输信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("carRouteObj") CarRoute carRouteObj,String joinTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (joinTime == null) joinTime = "";
		List<OrderTrans> orderTransList = orderTransService.queryOrderTrans(orderObj, carRouteObj, joinTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    orderTransService.queryTotalPageAndRecordNumber(orderObj, carRouteObj, joinTime);
	    /*获取到总的页码数目*/
	    int totalPage = orderTransService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = orderTransService.getRecordNumber();
	    request.setAttribute("orderTransList",  orderTransList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("orderObj", orderObj);
	    request.setAttribute("carRouteObj", carRouteObj);
	    request.setAttribute("joinTime", joinTime);
	    List<CarRoute> carRouteList = carRouteService.queryAllCarRoute();
	    request.setAttribute("carRouteList", carRouteList);
	    List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
	    request.setAttribute("orderInfoList", orderInfoList);
		return "OrderTrans/orderTrans_frontquery_result"; 
	}

     /*前台查询OrderTrans信息*/
	@RequestMapping(value="/{transId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer transId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键transId获取OrderTrans对象*/
        OrderTrans orderTrans = orderTransService.getOrderTrans(transId);

        List<CarRoute> carRouteList = carRouteService.queryAllCarRoute();
        request.setAttribute("carRouteList", carRouteList);
        List<OrderInfo> orderInfoList = orderInfoService.queryAllOrderInfo();
        request.setAttribute("orderInfoList", orderInfoList);
        request.setAttribute("orderTrans",  orderTrans);
        return "OrderTrans/orderTrans_frontshow";
	}

	/*ajax方式显示订单运输修改jsp视图页*/
	@RequestMapping(value="/{transId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer transId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键transId获取OrderTrans对象*/
        OrderTrans orderTrans = orderTransService.getOrderTrans(transId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOrderTrans = orderTrans.getJsonObject();
		out.println(jsonOrderTrans.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新订单运输信息*/
	@RequestMapping(value = "/{transId}/update", method = RequestMethod.POST)
	public void update(@Validated OrderTrans orderTrans, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			orderTransService.updateOrderTrans(orderTrans);
			message = "订单运输更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "订单运输更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除订单运输信息*/
	@RequestMapping(value="/{transId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer transId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  orderTransService.deleteOrderTrans(transId);
	            request.setAttribute("message", "订单运输删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "订单运输删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条订单运输记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String transIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = orderTransService.deleteOrderTranss(transIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出订单运输信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("orderObj") OrderInfo orderObj,@ModelAttribute("carRouteObj") CarRoute carRouteObj,String joinTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(joinTime == null) joinTime = "";
        List<OrderTrans> orderTransList = orderTransService.queryOrderTrans(orderObj,carRouteObj,joinTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "OrderTrans信息记录"; 
        String[] headers = { "运输id","运输订单","加入调度","加入时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<orderTransList.size();i++) {
        	OrderTrans orderTrans = orderTransList.get(i); 
        	dataset.add(new String[]{orderTrans.getTransId() + "",orderTrans.getOrderObj().getOrderId()+"",orderTrans.getCarRouteObj().getRouteId()+"",orderTrans.getJoinTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"OrderTrans.xls");//filename是下载的xls的名，建议最好用英文 
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
