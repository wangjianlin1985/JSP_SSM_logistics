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
import com.chengxusheji.service.CarRouteService;
import com.chengxusheji.po.CarRoute;
import com.chengxusheji.service.CarService;
import com.chengxusheji.po.Car;

//CarRoute管理控制层
@Controller
@RequestMapping("/CarRoute")
public class CarRouteController extends BaseController {

    /*业务层对象*/
    @Resource CarRouteService carRouteService;

    @Resource CarService carService;
	@InitBinder("carObj")
	public void initBindercarObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("carObj.");
	}
	@InitBinder("carRoute")
	public void initBinderCarRoute(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("carRoute.");
	}
	/*跳转到添加CarRoute视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new CarRoute());
		/*查询所有的Car信息*/
		List<Car> carList = carService.queryAllCar();
		request.setAttribute("carList", carList);
		return "CarRoute_add";
	}

	/*客户端ajax方式提交添加车辆调度信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated CarRoute carRoute, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        carRouteService.addCarRoute(carRoute);
        message = "车辆调度添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询车辆调度信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("carObj") Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (startPlace == null) startPlace = "";
		if (endPlace == null) endPlace = "";
		if (startTime == null) startTime = "";
		if (endTime == null) endTime = "";
		if (routeState == null) routeState = "";
		if(rows != 0)carRouteService.setRows(rows);
		List<CarRoute> carRouteList = carRouteService.queryCarRoute(carObj, startPlace, endPlace, startTime, endTime, routeState, page);
	    /*计算总的页数和总的记录数*/
	    carRouteService.queryTotalPageAndRecordNumber(carObj, startPlace, endPlace, startTime, endTime, routeState);
	    /*获取到总的页码数目*/
	    int totalPage = carRouteService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = carRouteService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CarRoute carRoute:carRouteList) {
			JSONObject jsonCarRoute = carRoute.getJsonObject();
			jsonArray.put(jsonCarRoute);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询车辆调度信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<CarRoute> carRouteList = carRouteService.queryAllCarRoute();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(CarRoute carRoute:carRouteList) {
			JSONObject jsonCarRoute = new JSONObject();
			jsonCarRoute.accumulate("routeId", carRoute.getRouteId());
			jsonCarRoute.accumulate("routeDesc", carRoute.getCarObj().getCarNo() + "【" + carRoute.getStartPlace() + " => " + carRoute.getEndPlace() + "】");
			jsonArray.put(jsonCarRoute);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询车辆调度信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("carObj") Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (startPlace == null) startPlace = "";
		if (endPlace == null) endPlace = "";
		if (startTime == null) startTime = "";
		if (endTime == null) endTime = "";
		if (routeState == null) routeState = "";
		List<CarRoute> carRouteList = carRouteService.queryCarRoute(carObj, startPlace, endPlace, startTime, endTime, routeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    carRouteService.queryTotalPageAndRecordNumber(carObj, startPlace, endPlace, startTime, endTime, routeState);
	    /*获取到总的页码数目*/
	    int totalPage = carRouteService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = carRouteService.getRecordNumber();
	    request.setAttribute("carRouteList",  carRouteList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("carObj", carObj);
	    request.setAttribute("startPlace", startPlace);
	    request.setAttribute("endPlace", endPlace);
	    request.setAttribute("startTime", startTime);
	    request.setAttribute("endTime", endTime);
	    request.setAttribute("routeState", routeState);
	    List<Car> carList = carService.queryAllCar();
	    request.setAttribute("carList", carList);
		return "CarRoute/carRoute_frontquery_result"; 
	}

     /*前台查询CarRoute信息*/
	@RequestMapping(value="/{routeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer routeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键routeId获取CarRoute对象*/
        CarRoute carRoute = carRouteService.getCarRoute(routeId);

        List<Car> carList = carService.queryAllCar();
        request.setAttribute("carList", carList);
        request.setAttribute("carRoute",  carRoute);
        return "CarRoute/carRoute_frontshow";
	}

	/*ajax方式显示车辆调度修改jsp视图页*/
	@RequestMapping(value="/{routeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer routeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键routeId获取CarRoute对象*/
        CarRoute carRoute = carRouteService.getCarRoute(routeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCarRoute = carRoute.getJsonObject();
		out.println(jsonCarRoute.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新车辆调度信息*/
	@RequestMapping(value = "/{routeId}/update", method = RequestMethod.POST)
	public void update(@Validated CarRoute carRoute, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			carRouteService.updateCarRoute(carRoute);
			message = "车辆调度更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "车辆调度更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除车辆调度信息*/
	@RequestMapping(value="/{routeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer routeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  carRouteService.deleteCarRoute(routeId);
	            request.setAttribute("message", "车辆调度删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "车辆调度删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条车辆调度记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String routeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = carRouteService.deleteCarRoutes(routeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出车辆调度信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("carObj") Car carObj,String startPlace,String endPlace,String startTime,String endTime,String routeState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(startPlace == null) startPlace = "";
        if(endPlace == null) endPlace = "";
        if(startTime == null) startTime = "";
        if(endTime == null) endTime = "";
        if(routeState == null) routeState = "";
        List<CarRoute> carRouteList = carRouteService.queryCarRoute(carObj,startPlace,endPlace,startTime,endTime,routeState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "CarRoute信息记录"; 
        String[] headers = { "调度id","调度车辆","出发地","起点经度","起点纬度","终到地","终点经度","终点纬度","当前位置","出发时间","抵达时间","调度状态","运输成本"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<carRouteList.size();i++) {
        	CarRoute carRoute = carRouteList.get(i); 
        	dataset.add(new String[]{carRoute.getRouteId() + "",carRoute.getCarObj().getCarNo(),carRoute.getStartPlace(),carRoute.getStartLongitude() + "",carRoute.getStartLatitude() + "",carRoute.getEndPlace(),carRoute.getEndLongitude() + "",carRoute.getEndLatitude() + "",carRoute.getCurrenPlace(),carRoute.getStartTime(),carRoute.getEndTime(),carRoute.getRouteState(),carRoute.getCostMoney() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"CarRoute.xls");//filename是下载的xls的名，建议最好用英文 
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
