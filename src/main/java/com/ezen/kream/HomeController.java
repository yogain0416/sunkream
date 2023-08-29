package com.ezen.kream;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.service.AdminProdMapper;
import com.ezen.kream.service.UserHomeMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
   @Autowired
   private UserHomeMapper userHomeMapper;
   @Autowired
   private AdminProdMapper adminProdMapper;
   @Resource(name = "uploadPath")
   private String upPath;

   @RequestMapping(value = { "/", "/main.main" }, method = RequestMethod.GET)
   public String home(Locale locale, Model model, HttpSession session, HttpServletRequest req) {
	   session = req.getSession();
	   upPath = session.getServletContext().getRealPath("images");
      if (session.getAttribute("upPath") == null)
         session.setAttribute("upPath", upPath);
      if (session.getAttribute("admin_num") == null)
         session.setAttribute("admin_num", "1");
      if (session.getAttribute("cate_list") == null) {
         List<ProdCateDTO> cate_list = adminProdMapper.twoType();
         session.setAttribute("cate_list", cate_list);
      }
      if (session.getAttribute("cateList") == null) {
         List<String> cateList = adminProdMapper.cate_kr_typeList();
         session.setAttribute("cateList", cateList);
      }

      List<String> list = null;
      list = userHomeMapper.userTabList();
      if (list == null || list.size() == 0) {
         return "user/home/main";
      }
      List<PickCateListDTO> blist = new ArrayList<>();
      if (list != null || list.size() != 0) {
         Collections.reverse(list);
         blist = userHomeMapper.userTabTypeList(list.get(0));
      }
      List<AdminAllDTO> alist = new ArrayList<>();
      if (blist != null) {
         for (int i = 0; i < blist.size(); i++) {
            List<AdminAllDTO> l = userHomeMapper.userHomeList(blist.get(i).getPick_name());
            alist.addAll(l);
         }
      }
      Collections.reverse(blist);
      session.setAttribute("tabList", blist);
      session.setAttribute("userTabList", list);
      req.setAttribute("userMainList", alist);
      
      //판매등록된것중에 날짜 지난거 취소 시키기.
      userHomeMapper.cancelSellBuyProd();
      
      return "user/home/main";
   }
}