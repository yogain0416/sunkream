package com.ezen.kream;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.AccountDTO;
import com.ezen.kream.dto.AddressDTO;
import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.BuyAllDTO;
import com.ezen.kream.dto.BuySellAllDTO;
import com.ezen.kream.dto.CardDTO;
import com.ezen.kream.dto.CartListDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.PickSearchDTO;
import com.ezen.kream.dto.PopSearchDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.dto.ProdSearchDTO;
import com.ezen.kream.dto.SellAllDTO;
import com.ezen.kream.dto.StyleBoardAllDTO;
import com.ezen.kream.service.AdminMemberMapper;
import com.ezen.kream.service.AdminProdMapper;
import com.ezen.kream.service.UserAlarmMapper;
import com.ezen.kream.service.UserMyMapper;
import com.ezen.kream.service.UserShopMapper;
import com.ezen.kream.service.UserStyleMapper;

@Controller
public class UserShopController {
   @Autowired
   private AdminMemberMapper adminMemberMapper;
   @Autowired
   private UserShopMapper userShopMapper;
   @Autowired
   private AdminProdMapper adminProdMapper;
   @Autowired
   private UserMyMapper userMyMapper;
   @Autowired
   private UserStyleMapper userStyleMapper;
   @Autowired
   private UserAlarmMapper userAlarmMapper;
   @Resource(name = "uploadPath")
   private String upPath;

   @RequestMapping("/shop.user")
   public String user_shop(HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
      if (session.getAttribute("cateList") == null) {
         List<String> cateList = adminProdMapper.cate_kr_typeList();
         session.setAttribute("cateList", cateList);
      }
      List<AdminAllDTO> list = userShopMapper.shopProdList();
      if (list != null) {
         for (AdminAllDTO allDTO : list) {
            int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
            int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
            allDTO.setCartCount(cartCount);
            allDTO.setTagCount(tagCount);
         }
      }

      String cateType = req.getParameter("cateType");
      List<ProdCateDTO> blist = null;
      List<ProdCateDTO> alist = null;
      List<String> cate_kr_type = adminProdMapper.cate_kr_typeList();
      List<ProdCateDTO> twoList = adminProdMapper.twoTypeAnother();
      req.setAttribute("twoA", twoList);
      req.setAttribute("cate_kr_type_list", cate_kr_type);
      if (cateType != null) {
         blist = userShopMapper.shopBrandList(cateType);
         alist = userShopMapper.shopSubCateList(cateType);
         req.setAttribute("cateType", cateType);
      } else {
         blist = userShopMapper.shopAllBrandList();
         alist = userShopMapper.shopCateList();
         req.setAttribute("type_all", "all");
      }

      String searchString = req.getParameter("searchString");
      // 검색어 있을때
      if (searchString != null) {
         // 검색어 최근검색어 저장
         Cookie ck = null;
         try {
            ck = new Cookie(URLEncoder.encode(searchString, "utf-8"), URLEncoder.encode(searchString, "utf-8"));
         } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
         }
         ck.setMaxAge(60 * 60 * 24);
         resp.addCookie(ck);

         // 검색어 카운트
         int popCount = userShopMapper.popCheck(searchString);
         if (popCount == 0) {
            userShopMapper.addPopSearchString(searchString);
         } else {
            userShopMapper.plusPopSearchString(searchString);
         }
         // 검색어 담기
         req.setAttribute("searchString", searchString);
         // 검색한 상품 담기
         list = userShopMapper.getSearchProd(searchString);
      }
      // 카테고리 눌릴시
      if (req.getParameter("cate_kr_type") != null) {
         list = userShopMapper.shopTypeList(req.getParameter("cate_kr_type"));
         System.out.println("cate_kr_type:" + req.getParameter("cate_kr_type"));
         if (list != null) {
            for (AdminAllDTO allDTO : list) {
               int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
               int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
               allDTO.setCartCount(cartCount);
               allDTO.setTagCount(tagCount);
            }
         }
         req.setAttribute("cate_kr_type", req.getParameter("cate_kr_type"));
      }

      // 서브카테 눌릴시
      if (req.getParameter("cate_kr_subType") != null) {
         list = userShopMapper.shopSubTypeList(req.getParameter("cate_kr_subType"));
         System.out.println("cate_kr_subType:" + req.getParameter("cate_kr_subType"));
         if (list != null) {
            for (AdminAllDTO allDTO : list) {
               int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
               int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
               allDTO.setCartCount(cartCount);
               allDTO.setTagCount(tagCount);
            }
         }
         req.setAttribute("cate_kr_subType", req.getParameter("cate_kr_subType"));
      }
      // 브랜드 눌릴시
      if (req.getParameter("cate_brand") != null) {
         list = userShopMapper.shopListBrandList(req.getParameter("cate_brand"));
         System.out.println("cate_brand:" + req.getParameter("cate_brand"));
         if (list != null) {
            for (AdminAllDTO allDTO : list) {
               int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
               int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
               allDTO.setCartCount(cartCount);
               allDTO.setTagCount(tagCount);
            }
         }
         req.setAttribute("cate_brand", req.getParameter("cate_brand"));
      }
      // 사이즈 눌릴시
      if (req.getParameter("prod_size") != null) {
         list = userShopMapper.shopProdSizeList(req.getParameter("prod_size"));
         System.out.println("prod_size:" + req.getParameter("prod_size"));
         if (list != null) {
            for (AdminAllDTO allDTO : list) {
               int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
               int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
               allDTO.setCartCount(cartCount);
               allDTO.setTagCount(tagCount);
            }
         }
         req.setAttribute("prod_size", req.getParameter("prod_size"));
      }
      // 성별 눌릴시
      if (req.getParameter("prod_gender") != null) {
         list = userShopMapper.shopProdGenderList(req.getParameter("prod_gender"));
         System.out.println("prod_gender:" + req.getParameter("prod_gender"));
         if (list != null) {
            for (AdminAllDTO allDTO : list) {
               int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
               int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
               allDTO.setCartCount(cartCount);
               allDTO.setTagCount(tagCount);
            }
         }
         req.setAttribute("prod_gender", req.getParameter("prod_gender"));
      }

      // 상품 갯수
      if (list != null) {
         req.setAttribute("listSize", list.size());
         System.out.println("listSize=" + list.size());
      } else {
         req.setAttribute("listSize", 0);
      }
      List<String> brandList = adminProdMapper.brandList();
      req.setAttribute("brandList", brandList);
      
      req.setAttribute("list", list);
      req.setAttribute("pageMode", "shop");
      req.setAttribute("blist", blist);
      req.setAttribute("alist", alist);
      return "user/shop/shopList";
   }

   @RequestMapping("/subCateFilter")
   @ResponseBody
   public List<ProdCateDTO> subCateFilter(@RequestParam(value = "cateType", required = false) String cateType) {
      List<ProdCateDTO> list = null;
      List<ProdCateDTO> alist = null;
      if (cateType != null) {
         list = userShopMapper.shopSubCateList(cateType);
         return list;
      } else {
         alist = userShopMapper.shopAllSubCateList();
         return alist;
      }
   }

   @RequestMapping("/search.user")
   public String user_search(HttpServletRequest req) {
      List<String> ck = new ArrayList<>();
      Cookie[] cookies = req.getCookies(); // 모든 쿠키 가져오기
      if (cookies != null) {
         for (Cookie c : cookies) {
            String name = null;
            try {
               name = URLDecoder.decode(c.getName(), "utf-8");
            } catch (UnsupportedEncodingException e) {
            } // 쿠키 이름 가져오기
            String value = null;
            try {
               value = URLDecoder.decode((c.getValue()), "utf-8");
            } catch (UnsupportedEncodingException e) {
            } // 쿠키 값 가져오기
            if (name.equals("JSESSIONID"))
               continue;
            ck.add(value);
         }
      }

      List<PickSearchDTO> pickList = userShopMapper.getPickSearchList();
      List<PopSearchDTO> popList = userShopMapper.getPopSearchList();

      req.setAttribute("popList", popList);
      req.setAttribute("ck", ck);
      req.setAttribute("pickList", pickList);
      return "user/shop/search";
   }

   @RequestMapping("/searchList.user")
   @ResponseBody
   public List<ProdSearchDTO> user_searchList(@RequestParam(value = "mode", required = false) String mode,
         @RequestParam(value = "searchString", required = false) String searchString,
         @RequestParam(value = "gender", required = false) String gender) {
      System.out.println("검색어:" + searchString);
      // 추천상품 성별검색
      if (gender != null) {
         if (!gender.equals("All")) {
            Map<String, String> map = new HashMap<>();
            map.put("gender", gender);
            map.put("searchString", searchString + "%");
            List<ProdSearchDTO> genderList = userShopMapper.getGenderList(map);
            System.out.println("성별리스트:" + genderList.size());
            return genderList;
         }
      }
      // 삭제상품목록
      if (mode != null) {
         if (mode.equals("Y")) {
            List<ProdSearchDTO> list = userShopMapper.getDelSearchList(searchString);
            return list;
         }
      }
      List<ProdSearchDTO> searchList = userShopMapper.getSearchList(searchString);
      return searchList;
   }

   @RequestMapping("/searchTagList.user")
   @ResponseBody
   public List<ProdSearchDTO> user_searchTagList(
         @RequestParam(value = "searchString", required = false) String searchString) {
      System.out.println("검색어:" + searchString);
      List<ProdSearchDTO> searchList = userShopMapper.getSearchList(searchString);
      for (ProdSearchDTO dto : searchList) {
         dto.setProd_img1(upPath + "/" + dto.getProd_img1());
      }
      return searchList;
   }

   @RequestMapping("/clearAllCookie.user")
   @ResponseBody
   public void user_clearAllCookie(HttpServletRequest req, HttpServletResponse resp) {
      Cookie[] cookies = req.getCookies(); // 모든 쿠키의 정보를 cookies에 저장
      if (cookies != null) { // 쿠키가 한개라도 있으면 실행
         for (int i = 0; i < cookies.length; i++) {
            cookies[i].setMaxAge(0); // 유효시간을 0으로 설정
            resp.addCookie(cookies[i]); // 응답에 추가하여 만료시키기.
         }
      }
   }

   @RequestMapping("/shop_addList")
   @ResponseBody
   public List<AdminAllDTO> shop_addList(@RequestParam(value = "pick_name", required = false) String pick_name) {
      List<AdminAllDTO> list = adminProdMapper.shopAddList(pick_name);
      System.out.println(list.size());
      return list;
   }

   @RequestMapping("/removeCookie.user")
   @ResponseBody
   public void user_removeCookie(HttpServletRequest req, HttpServletResponse resp,
         @RequestParam(value = "searchString", required = false) String searchString) {
      Cookie ck = null;
      try {
         ck = new Cookie(URLEncoder.encode(searchString, "utf-8"), URLEncoder.encode(searchString, "utf-8"));
      } catch (UnsupportedEncodingException e) {
      }
      ck.setMaxAge(0); // 유효시간을 0으로 설정해서 바로 만료시킨다.
      resp.addCookie(ck); // 응답에 추가해서 없어지도록 함
   }

   @RequestMapping("/prodView.user")
   public String user_prodView(@RequestParam int prod_num, HttpServletRequest req, HttpSession session) {
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      List<String> list = new ArrayList<>();
      list.add(dto.getProd_img1());
      if (dto.getProd_img2() != null) {
         if (!dto.getProd_img2().equals("")) {
            list.add(dto.getProd_img2());
         }
      }
      if (dto.getProd_img3() != null) {
         if (!dto.getProd_img3().equals("")) {
            list.add(dto.getProd_img3());
         }
      }
      if (dto.getProd_img4() != null) {
         if (!dto.getProd_img4().equals("")) {
            list.add(dto.getProd_img4());
         }
      }
      if (dto.getProd_img5() != null) {
         if (!dto.getProd_img5().equals("")) {
            list.add(dto.getProd_img5());
         }
      }
      req.setAttribute("imgList", list);
      req.setAttribute("upPath", upPath);
      req.setAttribute("dto", dto);
      MemberDTO member = null;
      if (session.getAttribute("sessionUser_num") != null) {
         int user_num = (Integer) session.getAttribute("sessionUser_num");
         member = userShopMapper.getMember(user_num);
         req.setAttribute("member", member);
      }
      return "user/shop/prodView";
   }

   @RequestMapping("/selectSize.user")
   public String user_selectSize(@RequestParam int prod_num, HttpServletRequest req,
         @RequestParam(required = false) String mode, HttpSession session) {
      if (session.getAttribute("sessionUser_num") == null) {
         req.setAttribute("msg", "로그인후 이용가능합니다.");
         req.setAttribute("url", "main.login");
         return "/message";
      }
      List<AdminAllDTO> list = userShopMapper.getSizeList(prod_num);
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      req.setAttribute("dto", dto);
      req.setAttribute("list", list);
      req.setAttribute("upPath", upPath);
      req.setAttribute("mode", mode);
      return "user/shop/selectSize";
   }

   @RequestMapping("/buySellAgree.user")
   public String user_buySellAgree(HttpServletRequest req, @RequestParam Map<String, String> map) {
      AdminAllDTO dto = new AdminAllDTO();
      if (map.get("selectSize") == null) {
         dto = userShopMapper.buySellCartUser(Integer.parseInt(map.get("prod_num")));
         if (dto.getProd_qty() == 0) {
            req.setAttribute("msg", "재고가 없는 상품입니다.");
            req.setAttribute("url", "cartList.user?user_num=" + map.get("user_num"));
            return "message";
         }
      } else {
         dto.setProd_num(Integer.parseInt(map.get("prod_num")));
         dto.setProd_size(map.get("selectSize"));
         dto = userShopMapper.buySellSizeSelect(dto);
      }
      req.setAttribute("upPath", upPath);
      req.setAttribute("dto", dto);
      req.setAttribute("mode", map.get("mode"));
      return "user/shop/buyAgree";
   }

   @RequestMapping("/sellAgree.user")
   public String user_sellAgree(HttpServletRequest req, @RequestParam Map<String, String> map) {
      AdminAllDTO dto = userShopMapper.selectSellSize(map);
      req.setAttribute("dto", dto);
      return "user/shop/sellAgree";
   }

   @RequestMapping("/buySellInfo.user")
   public String user_buySellInfo(HttpServletRequest req, int prod_num, HttpSession session, String mode) {
      AdminAllDTO dto = adminProdMapper.getSizeDTO(prod_num);
      int user_num = 0;
      if (session.getAttribute("sessionUser_num") != null) {
         user_num = (int) session.getAttribute("sessionUser_num");
      }
      if (session.getAttribute("sessionUser_num") == null) {
         req.setAttribute("msg", "로그인후 이용 가능합니다");
         req.setAttribute("url", "shop.user");
         return "/message";
      }
      List<AddressDTO> address = userShopMapper.getUserAddress(user_num);
      MemberDTO member = adminMemberMapper.memberDetail(user_num);
      List<CardDTO> card = userShopMapper.getCard(user_num);
      AccountDTO account = userMyMapper.getAccount(user_num);
      req.setAttribute("accountDTO", account);
      req.setAttribute("card", card);
      req.setAttribute("addressList", address);
      req.setAttribute("member", member);
      req.setAttribute("dto", dto);
      req.setAttribute("upPath", upPath);
      req.setAttribute("mode", mode);
      return "user/shop/buyInfo";
   }

   @RequestMapping("/sellInfo.user")
   public String user_sellInfo(HttpServletRequest req, @RequestParam Map<String, String> map) {
      AdminAllDTO dto = userShopMapper.selectSellSize(map);
      AccountDTO accountDTO = userShopMapper.getAccountInfo(Integer.parseInt(map.get("user_num")));
      List<AddressDTO> addressList = userShopMapper.getUserAddress(Integer.parseInt(map.get("user_num")));
      req.setAttribute("dto", dto);
      req.setAttribute("accountDTO", accountDTO);
      req.setAttribute("addressList", addressList);
      return "user/shop/sellInfo";
   }

   @RequestMapping("/addSellProd.user")
   public String user_addSellProd(@ModelAttribute SellAllDTO dto, HttpServletRequest req) {
      System.out.println("===================================");
      System.out.println("sell_num:" + dto.getSell_num());
      System.out.println("prod_group:" + dto.getProd_group());
      System.out.println("user_num:" + dto.getUser_num());
      System.out.println("prod_size:" + dto.getProd_size());
      System.out.println("prod_price:" + dto.getProd_price());
      System.out.println("start_date:" + dto.getStart_date());
      System.out.println("end_date:" + dto.getEnd_date());
      System.out.println("sell_date:" + dto.getSell_date());
      System.out.println("auction:" + dto.getAuction());
      System.out.println("sellInfo_num:" + dto.getSellInfo_num());
      System.out.println("name:" + dto.getName());
      System.out.println("phone_num:" + dto.getPhone_num());
      System.out.println("address1:" + dto.getAddress1());
      System.out.println("address2:" + dto.getAddress2());
      System.out.println("address3:" + dto.getAddress3());
      System.out.println("bank_name:" + dto.getBank_name());
      System.out.println("account_num:" + dto.getAccount_num());
      System.out.println("account_owner:" + dto.getAccount_owner());
      System.out.println("buyInfo_num:" + dto.getBuyInfo_num());
      System.out.println("===================================");
      dto.setEnd_date(dto.getEnd_date() + " 23:59:59");
      System.out.println("end_date:" + dto.getEnd_date());
      String start_date = userShopMapper.getSysDate();
      dto.setStart_date(start_date);
      System.out.println("start_date:" + dto.getStart_date());
      int res = userShopMapper.addSellProd(dto);
      if (res > 0) {
         int sell_num = userShopMapper.getSellNum(dto);
         dto.setSell_num(sell_num);
         System.out.println("sell_num:" + dto.getSell_num());
         int res2 = userShopMapper.addSellInfo(dto);
         if (res2 > 0) {
            req.setAttribute("msg", "판매상품등록성공!");
            req.setAttribute("url", "sellList.user");
         }
      }
      return "message";
   }

   @RequestMapping("/sellAccount.user")
   public ModelAndView user_sellAccount(int user_num) {
      AccountDTO accountDTO = userShopMapper.getAccountInfo(user_num);
      return new ModelAndView("user/shop/sellAccount", "accountDTO", accountDTO);
   }

   @RequestMapping("/changeAddress.user")
   public String user_changeAddressForm(int user_num, @RequestParam(required = false) String mode,
         HttpServletRequest req) {
      List<AddressDTO> list = userShopMapper.getUserAddress(user_num);
      if (mode.equals("D"))
         req.setAttribute("mode", mode);
      req.setAttribute("addressList", list);
      return "user/shop/shop_address";
   }

   @RequestMapping(value = "/shop_addAddress.user", method = RequestMethod.GET)
   public String user_addAddresssForm(HttpServletRequest req, int prod_num, String mode) {
      System.out.println(prod_num);
      req.setAttribute("prod_num", prod_num);
      req.setAttribute("mode", mode);
      return "user/shop/shop_addAddress";
   }

   @RequestMapping(value = "/shop_addCard.user", method = RequestMethod.GET)
   public String shop_addCard(HttpServletRequest req) {
      return "user/shop/shop_addCard";
   }

   @RequestMapping(value = "/shop_addCard.user", method = RequestMethod.POST)
   public String shop_addCard_ok(HttpServletRequest req, CardDTO dto) {
      int count = userMyMapper.getCardCount(dto.getUser_num());
      if (count == 0) {
         dto.setBasic("Y");
         userMyMapper.insertCard(dto);
      } else if (count >= 3) {
         req.setAttribute("msg", "카드를 더 이상 추가하실 수 없습니다.");
         return "closeWindow";
      } else {
         if (dto.getBasic().equals("Y"))
            userMyMapper.setBasicNCard(dto.getUser_num());
         userMyMapper.insertCard(dto);
      }
      req.setAttribute("msg", "카드추가완료");
      return "closeWindow";
   }

   @RequestMapping(value = "/shop_addAddress.user", method = RequestMethod.POST)
   public String user_addAddress(@ModelAttribute AddressDTO dto, HttpServletRequest req, HttpSession session,
         int prod_num, String mode) {
      if (session.getAttribute("sessionUser_num") == null) {
         return "redirect:main.login";
      }
      int count = userMyMapper.getAddressCount(dto.getUser_num());
      if (count == 0) {
         dto.setBasic("Y");
         userMyMapper.insertAddress(dto);
      } else if (count >= 5) {
         req.setAttribute("msg", "배송지를 더 이상 추가하실 수 없습니다");
         return "closeWindow";
      } else {
         if (dto.getBasic().equals("Y"))
            userMyMapper.setBasicNAddress(dto.getUser_num());
         userMyMapper.insertAddress(dto);
      }
      req.setAttribute("msg", "주소추가완료");
      return "closeWindow";
   }

   @RequestMapping("/buy_ok.user")
   public String user_buy_ok(HttpServletRequest req, @ModelAttribute BuyAllDTO dto, BindingResult bres,
         HttpSession session, @RequestParam(required = false) Map<String, String> map) {
      System.out.println("=====계좌정보=====");
      System.out.println("포인트:" + map.get("point"));
      System.out.println("은행명:" + dto.getBank_name());
      System.out.println("은행명2" + map.get("bank_name"));
      System.out.println("라디오버튼:" + map.get("payChoice"));
      dto.setBank_name(map.get("bank_name"));
      System.out.println("카드번호:" + dto.getCard_num());
      int user_num = (int) session.getAttribute("sessionUser_num");
      // 계좌로 구매 처리
      if (map.get("payChoice").equals("account")) {
         System.out.println("계좌");
         dto.setCard_date("cash");
         dto.setCard_num(map.get("account_num"));
      }
      if (map.get("needs").equals("6")) {
         map.put("needs", map.get("requestUser"));
      }
      // 즉시구매 처리
      if (dto.getAuction().equals("D")) {
         dto.setUser_num(user_num);
         userShopMapper.plusPoint(map);
         dto.setStart_date(userShopMapper.getSysDate());
         int res = userShopMapper.insertBuyDirect(dto);
         if (res == 0) {
            System.out.println("구매시 오류가 발생했습니다.");
         } else {
            req.setAttribute("msg", "결제 및 구매완료  구매목록으로 이동합니다.");
            req.setAttribute("url", "buyList.user");
            dto.setBuy_num(userShopMapper.getBuyNum(dto));
            userShopMapper.directIncome(dto);
            int infoRes = userShopMapper.insertBuyInfoDirect(dto);
            if (infoRes == 0) {
               System.out.println("구매정보 입력시 오류발생");
            }
            int qty_set = userShopMapper.buy_qty(dto.getProd_num());
            if (qty_set == 0) {
               System.out.println("상품 수량변경 오류발생");
            }
         }
      }
      return "/message";
   }

   @RequestMapping("/selectSizeSell.user")
   public String user_selectSizeSell(int prod_num, HttpServletRequest req) {
      List<AdminAllDTO> list = userShopMapper.getSizeList(prod_num);
      List<String> sizeList = userShopMapper.checkSell(prod_num);
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      req.setAttribute("dto", dto);
      req.setAttribute("prodList", list);
      req.setAttribute("sizeList", sizeList);
      return "user/shop/selectSizeSell";
   }

   @RequestMapping("/cartSelectSize.user")
   public String user_cartSelectSize(int prod_group, HttpSession session, HttpServletRequest req) {
      List<AdminAllDTO> list = userShopMapper.getCartSizeList(prod_group);
      List<CartListDTO> cart = userShopMapper.getCartList((Integer) session.getAttribute("sessionUser_num"));
      req.setAttribute("productList", list);
      req.setAttribute("cartList", cart);
      return "user/shop/selectCartSize";
   }

   @RequestMapping("/addCart.user")
   @ResponseBody
   public int user_addCart(@RequestParam Map<String, String> map) {
      int res = userShopMapper.addCart(map);
      return res;
   }

   @RequestMapping("/delCart.user")
   @ResponseBody
   public int user_delCart(@RequestParam Map<String, String> map) {
      int res = userShopMapper.delCart(map);
      return res;
   }

   @RequestMapping(value = "/shop_changeCard.user", method = RequestMethod.GET)
   public String shop_changeCard(HttpServletRequest req, HttpSession session) {
      int user_num = (int) session.getAttribute("sessionUser_num");
      List<CardDTO> list = userMyMapper.getCardList(user_num);
      req.setAttribute("cardList", list);
      return "user/shop/shop_card";
   }

   @RequestMapping("/selectSizeAuction.user")
   public String user_selectSizeAuction(int prod_num, HttpServletRequest req, HttpSession session) {
      if (session.getAttribute("sessionUser_num") == null) {
         req.setAttribute("msg", "로그인후 이용가능합니다.");
         req.setAttribute("url", "main.login");
         return "message";
      }
      List<AdminAllDTO> list = userShopMapper.getSizeList(prod_num);
      List<String> sizeList = userShopMapper.checkSell(prod_num);
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      req.setAttribute("dto", dto);
      req.setAttribute("prodList", list);
      req.setAttribute("sizeList", sizeList);
      return "user/shop/selectSizeAuction";
   }

   @RequestMapping("/buyAuctionAgree.user")
   public String user_buyAuctionAgree(HttpServletRequest req, @RequestParam Map<String, String> map) {
      BuySellAllDTO dto = userShopMapper.selectBuyAuction(map);
      req.setAttribute("dto", dto);
      return "user/shop/buyAuctionAgree";
   }

   @RequestMapping("/buyAuctionInfo.user")
   public String user_buyAuctionInfo(HttpServletRequest req, @RequestParam Map<String, String> map) {
      BuySellAllDTO dto = userShopMapper.selectBuyAuction(map);
      int count = userShopMapper.getCountMember(map);
      if (count != 0) {
         int max_price = userShopMapper.getMaxPrice(map);
         req.setAttribute("max_price", max_price);
      } else {
         req.setAttribute("max_price", 0);
      }
      AccountDTO accountDTO = userShopMapper.getAccountInfo(Integer.parseInt(map.get("user_num")));
      List<AddressDTO> addressList = userShopMapper.getUserAddress(Integer.parseInt(map.get("user_num")));
      req.setAttribute("dto", dto);
      req.setAttribute("accountDTO", accountDTO);
      req.setAttribute("addressList", addressList);
      return "user/shop/buyAuctionInfo";
   }

   @RequestMapping("/addBuyAuctionProd.user")
   public String user_addBuyAuctionProd(@ModelAttribute BuySellAllDTO dto,HttpServletRequest req) {
      if(dto.getNeeds().equals("6"))dto.setNeeds(dto.getRequestUser());
      dto.setStart_date(userShopMapper.getSysDate());
      int res = userShopMapper.addBuyAuctionProd(dto);
      if(res > 0) System.out.println("구매입찰 완료");
      else System.out.println("구매입찰 실패");
      return "redirect:buyList.user";
   }

   @RequestMapping("/showTagStyle.user")
   public String user_showTagStyle(@RequestParam int prod_group, HttpSession session, HttpServletRequest req) {
      int user_num = 0;
      if (session.getAttribute("sessionUser_num") != null) {
         user_num = (int) session.getAttribute("sessionUser_num");
      }
      AdminAllDTO allDTO = userShopMapper.getProdInfo(prod_group);
      List<StyleBoardAllDTO> list = userShopMapper.showTagStyle(prod_group);
      if (list != null) {
         for (StyleBoardAllDTO dto : list) {
            int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
            int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
            if (checkBan == 1 || checkBan1 == 1) {
               dto.setCheckBan(1);
            } else {
               dto.setCheckBan(2);
            }
            int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);
            dto.setCheckLike(checkLike);
            String contents = dto.getStyle_contents();
            if (contents == null || contents.trim().equals("")) {
               dto.setStyle_contents("");
            } else {
               String conArr[] = contents.split("<br>");
               String newContents = "";
               for (int i = 0; i < conArr.length - 1; i++) {
                  newContents = newContents + conArr[i] + "\n";
               }
               newContents = newContents + conArr[conArr.length - 1];
               dto.setStyle_contents(newContents);
            }
         }
      }
      req.setAttribute("dto", allDTO);
      req.setAttribute("List", list);
      return "user/shop/showTagStyle";
   }

   @PostMapping("/shopScroll.user")
   public String user_shopScroll(@RequestParam Map<String, String> map, HttpServletRequest req) {
      List<AdminAllDTO> list = null;
      // 검색 아닐떄
      if (map.get("searchString").equals("")) {
         list = userShopMapper.shopProdList();
         if (!map.get("cate_kr_type").equals("")) {
            list = userShopMapper.shopTypeList(map.get("cate_kr_type"));
         } else if (!map.get("cate_kr_subType").equals("")) {
            list = userShopMapper.shopSubTypeList(map.get("cate_kr_subType"));
         } else if (!map.get("cate_brand").equals("")) {
            list = userShopMapper.shopListBrandList(req.getParameter("cate_brand"));
         } else if (!map.get("prod_size").equals("")) {
            list = userShopMapper.shopProdSizeList(req.getParameter("prod_size"));
         } else if (!map.get("prod_gender").equals("")) {
            list = userShopMapper.shopProdGenderList(req.getParameter("prod_gender"));
         }
      }
      // 검색일때
      else {
         list = userShopMapper.getSearchProd(map.get("searchString"));
      }

      // 관심수 태그수
      if (list != null) {
         for (AdminAllDTO allDTO : list) {
            int cartCount = userShopMapper.cartCount(allDTO.getProd_num());
            int tagCount = userShopMapper.tagCount(allDTO.getProd_num());
            allDTO.setCartCount(cartCount);
            allDTO.setTagCount(tagCount);
         }
      }

      req.setAttribute("list", list);
      req.setAttribute("count", map.get("count"));
      return "user/shop/shopScroll";
   }

}