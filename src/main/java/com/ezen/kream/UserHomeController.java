package com.ezen.kream;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.CartListDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.service.UserHomeMapper;

import edu.emory.mathcs.backport.java.util.Collections;

@Controller
public class UserHomeController {
@Resource(name = "uploadPath")
String upPath;
@Autowired
private UserHomeMapper userHomeMapper;
	@RequestMapping("/main.main")
	public String user_home(HttpServletRequest req,HttpSession session) {
		session.setAttribute("upPath", upPath);
		session.setAttribute("admin_num", "1");
		List<String> list = new ArrayList<>();
		list = userHomeMapper.userTabList();
		List<PickCateListDTO> blist = new ArrayList<>();
		if(list == null || list.size() ==0){
			return "user/home/main";
		}
		if (list != null || list.size() !=	0 ) {
			Collections.reverse(list);
			blist = userHomeMapper.userTabTypeList(list.get(0));
		}
		List<AdminAllDTO> alist = new ArrayList<>();
		if (blist.size() != 0) {
			for (int i = 0; i < blist.size(); i++) {
				List<AdminAllDTO> l = userHomeMapper.userHomeList(blist.get(i).getPick_name());
				alist.addAll(l);
			}
		}
		Collections.reverse(blist);
		session.setAttribute("tabList", blist);
		req.setAttribute("userMainList", alist);
		session.setAttribute("userTabList", list);
		return "user/home/main";
	}
	@RequestMapping("/tab.user")
	public String user_tab(String tab_name,HttpServletRequest req,HttpSession session) {
		List<PickCateListDTO> tabType = userHomeMapper.userTabTypeList(tab_name);
		List<AdminAllDTO> list = new ArrayList<>();
		for(int i =0; i <tabType.size();i++) {
			List<AdminAllDTO> l = userHomeMapper.userHomeList(tabType.get(i).getPick_name());
			list.addAll(l);
		}
		Collections.reverse(tabType);
		session.setAttribute("tabList", tabType);
		req.setAttribute("userMainList", list);
		return "user/home/main";
	}
	
	
}
