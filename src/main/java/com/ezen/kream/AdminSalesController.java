package com.ezen.kream;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.kream.dto.SalesAllDTO;
import com.ezen.kream.service.AdminSalesMapper;

@Controller
public class AdminSalesController {
	@Autowired
	private AdminSalesMapper adminSalesMapper;
	
	@RequestMapping("/sales.admin")
	public String admin_sales(@RequestParam(required = false) String date,HttpServletRequest req) {
		if(date == null) {
			date = adminSalesMapper.getSysDate().split(" ")[0];
		}
		List<SalesAllDTO> todayList = adminSalesMapper.todaySalesList(date);
		int income = adminSalesMapper.todayIncome(date);
		int outcome = adminSalesMapper.todayOutcome(date);
		int allCount = adminSalesMapper.todayCount(date,"All");
		int mCount = adminSalesMapper.todayCount(date,"M");
		int fCount = adminSalesMapper.todayCount(date,"F");
		
		if(todayList != null) req.setAttribute("listSize", todayList.size());
		else req.setAttribute("listSize", 0);
		
		req.setAttribute("list", todayList);
		req.setAttribute("income", income);
		req.setAttribute("outcome", outcome);
		req.setAttribute("allCount", allCount);
		req.setAttribute("mCount", mCount);
		req.setAttribute("fCount", fCount);
		req.setAttribute("cal1", date);
		req.setAttribute("mode", "day");
		return "admin/sales/todaySales";
	}
	
	@RequestMapping("/salesMonthly.admin")
	public String admin_salesMonthly(HttpServletRequest req) {
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) +1;
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM"); 
		String date = simpleDateFormat.format(new Date()); 
		List<SalesAllDTO> monthList = adminSalesMapper.monthSalesList(date,lastDay);
		int income = adminSalesMapper.monthIncome(date,lastDay);
		int outcome = adminSalesMapper.monthOutcome(date,lastDay);
		
		if(monthList != null) req.setAttribute("listSize", monthList.size());
		else req.setAttribute("listSize", 0);
		
		req.setAttribute("list", monthList);
		req.setAttribute("income", income);
		req.setAttribute("outcome", outcome);
		req.setAttribute("month", month);
		req.setAttribute("mode", "month");
		return "admin/sales/monthSales";
	}
	
	@RequestMapping("/salesYearly.admin")
	public String admin_salesYearly(HttpServletRequest req) {
		String date = adminSalesMapper.getSysDate().split("/")[0];
		List<SalesAllDTO> yearList = adminSalesMapper.yearSalesList(date);
		int income = adminSalesMapper.yearIncome(date);
		int outcome = adminSalesMapper.yearOutcome(date);
		
		if(yearList != null) req.setAttribute("listSize", yearList.size());
		else req.setAttribute("listSize", 0);
		
		req.setAttribute("list", yearList);
		req.setAttribute("income", income);
		req.setAttribute("outcome", outcome);
		req.setAttribute("year", date);
		req.setAttribute("mode", "year");
		return "admin/sales/yearSales";
	}
	
	@PostMapping("/salesScroll.admin")
	public String admin_salesListScroll(@RequestParam Map<String,String> map
			,HttpServletRequest req) {
		List<SalesAllDTO> list = null;
		if(map.get("mode").equals("day")) {
			list = adminSalesMapper.todaySalesList(map.get("cal1"));
		}else if(map.get("mode").equals("month")) {
			Calendar cal = Calendar.getInstance();
			int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy/MM"); 
			String date = simpleDateFormat.format(new Date()); 
			list = adminSalesMapper.monthSalesList(date,lastDay);
		}else {
			String date = adminSalesMapper.getSysDate().split("/")[0];
			list = adminSalesMapper.yearSalesList(date);
		}
		
		req.setAttribute("list", list);
		req.setAttribute("count", map.get("count"));
		return "admin/sales/salesScroll";
	}
}
