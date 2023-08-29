package com.ezen.kream;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.AccountDTO;
import com.ezen.kream.dto.AddressDTO;
import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.BuyProdDTO;
import com.ezen.kream.dto.BuySellAllDTO;
import com.ezen.kream.dto.CardDTO;
import com.ezen.kream.dto.CartListDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.SellProdDTO;
import com.ezen.kream.service.UserMyMapper;
import com.ezen.kream.service.UserStyleMapper;

import edu.emory.mathcs.backport.java.util.Collections;

@Controller
public class UserMyController {
	@Autowired
	private UserMyMapper userMyMapper;
	@Autowired
	private UserStyleMapper userStyleMapper;
	@Resource(name = "uploadPath")
	private String upPath;

	@RequestMapping("/my.user")
	public ModelAndView user_my(int user_num,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			ModelAndView mav = new ModelAndView("message");
			mav.addObject("msg","로그인을 해주세요.");
			mav.addObject("url","main.login");
			return mav;
		}
		MemberDTO dto = userMyMapper.getUserInfo(user_num);
		ModelAndView mav = new ModelAndView("user/my/main", "myProfile", dto);
		List<BuyProdDTO> buyList = userMyMapper.getBuyList(user_num);
		mav.addObject("buyList", buyList);
		List<SellProdDTO> sellList = userMyMapper.getSellList(user_num);
		mav.addObject("sellList", sellList);
		List<AdminAllDTO> cartList = userMyMapper.getAllInfoCartList(user_num);
		mav.addObject("cartList", cartList);
		return mav;
	}

	@RequestMapping("/myProfileManage.user")
	public ModelAndView user_myProfileManage(int user_num,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		MemberDTO dto = userMyMapper.myProfileManageInfo(user_num);
		return new ModelAndView("user/my/myProfileManage", "memberDTO", dto);
	}

	@PostMapping("/profile_imgEdit.user")
	@ResponseBody
	public String user_profileImgEdit(HttpServletRequest req, HttpSession session) {
		// 파일 꺼내기
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		MultipartFile mf = mr.getFile("img");
		// 파일명
		String profile_img = null;
		// 이미지 변경인지 삭제인지 구분해서 이름 정해주기
		if (mf != null)
			profile_img = mf.getOriginalFilename();
		else
			profile_img = "";
		// 세션에 저장된 내 유저번호
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		// DB에 프로필 이미지 변경
		Map<String, String> map = new HashMap<>();
		map.put("profile_img", profile_img);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editProfileImg(map);
		// 파일저장
		if (mf != null) {
			File file = new File(upPath, profile_img);
			if (mf.getSize() != 0) {
				if (!file.exists())
					file.mkdirs();
				try {
					mf.transferTo(file);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 보낼때 인코드 하기
		try {
			profile_img = URLEncoder.encode(profile_img, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return profile_img;
	}

	@PostMapping("/saveProfileName.user")
	@ResponseBody
	public int user_saveProfileName(@RequestParam(value = "profile_name", required = false) String profile_name,
			HttpSession session) {
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, String> map = new HashMap<>();
		map.put("profile_name", profile_name);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editProfileName(map);
		return res;
	}

	@PostMapping("/saveName.user")
	@ResponseBody
	public int user_saveName(@RequestParam(value = "name", required = false) String name, HttpSession session) {
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editName(map);
		return res;
	}

	@PostMapping("/saveInfo.user")
	@ResponseBody
	public int user_saveInfo(@RequestParam(value = "info", required = false) String info, HttpSession session) {
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, String> map = new HashMap<>();
		if (info == null)
			info = "";
		map.put("info", info);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editInfo(map);
		return res;
	}

	
	@RequestMapping("/loginInfo.user") 
	public ModelAndView user_loginInfo(int user_num,HttpSession session){
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		MemberDTO dto = userMyMapper.myProfileManageInfo(user_num);
		return new ModelAndView("user/my/loginInfo", "memberDTO", dto);
	}
	
	@PostMapping("/savePasswd.user")
	@ResponseBody
	public int user_savePasswd(@RequestParam(value = "passwd", required = false) String passwd, HttpSession session) {
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, String> map = new HashMap<>();
		map.put("passwd", passwd);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editPasswd(map);
		return res;
	}
	
	@PostMapping("/savePhone.user")
	@ResponseBody
	public int user_savePhone(@RequestParam(value = "phone_num", required = false) String phone_num, HttpSession session) {
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, String> map = new HashMap<>();
		map.put("phone_num", phone_num);
		map.put("user_num", String.valueOf(user_num));
		int res = userMyMapper.editPhone(map);
		return res;
	}
	
	@PostMapping("/saveSize.user")
	@ResponseBody
	public int user_saveSize(@RequestParam(value = "size", required = false) int size, HttpSession session) {
		System.out.println(size);
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		Map<String, Integer> map = new HashMap<>();
		map.put("size",size);
		map.put("user_num", user_num);
		int res = userMyMapper.editSize(map);
		return res;
	}
	
	@RequestMapping("/delMember.user")
	public ModelAndView user_delMember(HttpSession session,int user_num) {
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		ModelAndView mav = new ModelAndView("user/login/logoutmessage");
		String socialLogin =(String)session.getAttribute("loginMode");
		if(socialLogin != null) {
			if(socialLogin.equals("naver")){	
				mav.addObject("url","http://nid.naver.com/nidlogin.logout");
			}else if(socialLogin.equals("kakao")) {
				mav.addObject("url","https://accounts.kakao.com/logout?continue=https%3A%2F%2Fcs.kakao.com%2F");
			}
		}else {
			socialLogin = "";
		}
		session.invalidate();
		mav.addObject("social",socialLogin);
		int res = userMyMapper.delMember(user_num);
		if(res > 0) {
			userStyleMapper.deleteMember(user_num);
			mav.addObject("msg", "탈퇴 완료");
		}else {
			mav.addObject("msg", "탈퇴 실패");
		}
		return mav;
	}
	
	@RequestMapping("/address.user")
	public ModelAndView user_address(int user_num,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		List<AddressDTO> list = userMyMapper.getAddressList(user_num);
		int count = 0;
		if(list != null) count = list.size();
		ModelAndView mav = new ModelAndView("user/my/address","addressList",list);
		mav.addObject("count",count);
		return mav;
	}
	
	@RequestMapping(value = "/addAddress.user",method = RequestMethod.GET)
	public String user_addAddress() {
		return "user/my/addAddress";
	}
	
	@RequestMapping(value = "/addAddress.user",method = RequestMethod.POST)
	public String user_addAddressOk(@ModelAttribute AddressDTO dto,HttpServletRequest req,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return "redirect:main.login";
		}
		int count = userMyMapper.getAddressCount(dto.getUser_num());
		if(count == 0) {
			dto.setBasic("Y");
			userMyMapper.insertAddress(dto);
		}else {
			if(dto.getBasic().equals("Y")) userMyMapper.setBasicNAddress(dto.getUser_num());
			userMyMapper.insertAddress(dto);
		}
		req.setAttribute("msg", "주소추가완료");
		req.setAttribute("url", "address.user?user_num="+dto.getUser_num());
		return "closeWindowGo";
	}
	
	@RequestMapping("/changeBasicAddress.user")
	public String user_changeBasicAddress(int address_num,int user_num) {
		userMyMapper.setBasicNAddress(user_num);
		userMyMapper.setBasicYAddress(address_num);
		return "redirect:address.user?user_num="+user_num;
	}
	
	@RequestMapping(value = "/editAddress.user", method = RequestMethod.GET)
	public ModelAndView user_editAddress(int address_num,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		AddressDTO dto = userMyMapper.getAddressInfo(address_num);
		ModelAndView mav = new ModelAndView("user/my/editAddress","addressDTO",dto);
		return mav;
	}
	
	@RequestMapping(value = "/editAddress.user", method = RequestMethod.POST)
	public String user_editAddressOk(@ModelAttribute AddressDTO dto,HttpServletRequest req) {
		if(dto.getBasic().equals("Y")) {
			userMyMapper.setBasicNAddress(dto.getUser_num());
			userMyMapper.setBasicYAddress(dto.getAddress_num());
		}
		int res = userMyMapper.editAddress(dto);
		if(res > 0) {
			req.setAttribute("msg", "주소수정완료");
			req.setAttribute("url", "address.user?user_num="+dto.getUser_num());
			return "closeWindowGo";
		}else {
			req.setAttribute("msg", "주소수정실패");
			req.setAttribute("url", "editAddress.user?address_num="+dto.getAddress_num());
			return "message";
		}
	}
	
	@RequestMapping("/delAddress.user")
	public String user_delAddress(int address_num,int user_num,HttpServletRequest req
			,HttpSession session,@RequestParam(required = false)String mode) {
		if(session.getAttribute("sessionUser_num") == null) {
			return "redirect:main.login";
		}
		int res = userMyMapper.delAddress(address_num);
		if(res > 0)	req.setAttribute("msg", "주소삭제완료");
		else req.setAttribute("msg", "주소삭제실패");
		if(mode != null && mode.equals("D")) return "closeWindow";
		req.setAttribute("url", "address.user?user_num="+user_num);
		return "message";
	}
	
	@RequestMapping("/card.user")
	public ModelAndView user_card(int user_num,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return new ModelAndView("redirect:main.login");
		}
		List<CardDTO> list = userMyMapper.getCardList(user_num);
		int count = 0;
		if(list != null) count = list.size();
		ModelAndView mav = new ModelAndView("user/my/card","cardList",list);
		mav.addObject("count",count);
		return mav;
	}
	
	@RequestMapping(value = "/addCard.user",method = RequestMethod.GET)
	public String user_addCard(HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return "redirect:main.login";
		}
		return "user/my/addCard";
	}
	
	@RequestMapping(value = "/addCard.user",method = RequestMethod.POST)
	public String user_addCardOk(@ModelAttribute CardDTO dto,HttpServletRequest req) {
		int count = userMyMapper.getCardCount(dto.getUser_num());
		if(count == 0) {
			dto.setBasic("Y");
			userMyMapper.insertCard(dto);
		}else {
			if(dto.getBasic().equals("Y")) userMyMapper.setBasicNCard(dto.getUser_num());
			userMyMapper.insertCard(dto);
		}
		req.setAttribute("msg", "카드추가완료");
		req.setAttribute("url", "card.user?user_num="+dto.getUser_num());
		return "closeWindowGo";
	}
	
	@RequestMapping("/changeBasicCard.user")
	public String user_changeBasicCard(int myCard_num,int user_num) {
		userMyMapper.setBasicNCard(user_num);
		userMyMapper.setBasicYCard(myCard_num);
		return "redirect:card.user?user_num="+user_num;
	}
	
	@RequestMapping("/delCard.user")
	public String user_delCard(int myCard_num,int user_num,HttpServletRequest req) {
		int res = userMyMapper.delCard(myCard_num);
		if(res > 0)	req.setAttribute("msg", "카드삭제완료");
		else req.setAttribute("msg", "카드삭제실패");
		req.setAttribute("url", "card.user?user_num="+user_num);
		return "message";
	}
	
	@RequestMapping("/account.user")
	public String user_account(int user_num,HttpServletRequest req,HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) {
			return "redirect:main.login";
		}
		AccountDTO dto = userMyMapper.getAccount(user_num);
		req.setAttribute("accountDTO", dto);
		return "user/my/account";
	}
	
	@RequestMapping("/addAccount.user")
	public String user_addAccount(@ModelAttribute AccountDTO dto,HttpServletRequest req
			,@RequestParam(required = false) String mode) {
		int res = userMyMapper.addAccount(dto);
		if(res > 0) {
			req.setAttribute("msg", "계좌등록성공");
			req.setAttribute("url", "account.user?user_num="+dto.getUser_num());
			if(mode != null) {
				req.setAttribute("msg", "계좌등록성공");
				return "closeWindow";
			}
		}else {
			req.setAttribute("msg", "계좌등록실패");
			req.setAttribute("url", "account.user?user_num="+dto.getUser_num());
		}
		return "message";
	}
	
	@RequestMapping("/editAccount.user")
	public String user_editAccount(@ModelAttribute AccountDTO dto,HttpServletRequest req
			,@RequestParam(required = false) String mode) {
		int res = userMyMapper.editAccount(dto);
		if(res > 0) {
			req.setAttribute("msg", "계좌변경성공");
			req.setAttribute("url", "account.user?user_num="+dto.getUser_num());
			if(mode != null) {
				req.setAttribute("msg", "계좌등록성공");
				return "closeWindow";
			}
		}else {
			req.setAttribute("msg", "계좌변경실패");
			req.setAttribute("url", "account.user?user_num="+dto.getUser_num());
		}
		return "message";
	}
	@RequestMapping("/buyList.user")
	public String user_buyList(HttpServletRequest req, @RequestParam Map<String, String> params
						, HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) return "redirect:main.login";
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		req.setAttribute("mode", "buy");
		if(params.get("cal1") != null && !params.get("cal1").equals("") 
				&& params.get("cal1").length() < 18) {
			params.put("cal1", params.get("cal1")+" 00:00:00");
			params.put("cal2", params.get("cal2")+" 23:59:59");
		}
		List<BuySellAllDTO> findList = userMyMapper.buyList(user_num, params);
		req.setAttribute("auction", params.get("auction"));
		params.put("auction", "all");
		List<BuySellAllDTO> allList = userMyMapper.buyList(user_num, params);
		int waitSu = 0;
		int endSu = 0;
		if (allList != null) {
			for (BuySellAllDTO dto : allList) {
				if (dto.getAuction().equals("W")) {
					waitSu++;
				}else {
					endSu++;
				}
			}
		}
		req.setAttribute("cal1", params.get("cal1"));
		req.setAttribute("cal2", params.get("cal2"));
		req.setAttribute("endSu", endSu);
		req.setAttribute("waitSu", waitSu);
		req.setAttribute("allList", findList);
		req.setAttribute("allListSu", endSu+waitSu);
		return "user/my/buyList";
	}
	
	@RequestMapping("/buyDetail.user")
	public String user_buyDetail(@RequestParam Map<String,String> map,HttpServletRequest req) {
		if(map.get("auction").equals("D")) {
			BuySellAllDTO dto = userMyMapper.getBuyInfo_D(map);
			req.setAttribute("dto", dto);
		}else {
			BuySellAllDTO dto = userMyMapper.getBuyInfo_notD(map);
			req.setAttribute("dto", dto);
		}
		return "user/my/buyDetail";
	}
	
	@RequestMapping("/sellDetail.user")
	public String user_sellDetail(@RequestParam Map<String,String> map,HttpServletRequest req) {
		BuySellAllDTO dto = userMyMapper.getSellInfo(map);
		req.setAttribute("dto", dto);
		List<BuySellAllDTO> list = userMyMapper.getSellInfo_list(map);
		req.setAttribute("priceList", list);
		if(map.get("auction").equals("Y")) {
			BuySellAllDTO sellInfo = userMyMapper.getSellInfo_Y(map);
			req.setAttribute("sellInfo", sellInfo);
		}
		return "user/my/sellDetail";
	}
	
	@RequestMapping("/selectBuy.user")
	public String user_selectBuy(int sell_num) {
		int res = userMyMapper.selectBuy(sell_num);
		if(res>0)System.out.println("낙찰수락성공");
		else System.out.println("낙찰수락실패");
		return "redirect:sellList.user";
	}
	

	@RequestMapping("/sellList.user")
	public String user_sellList(HttpServletRequest req, @RequestParam Map<String, String> params,
						HttpSession session) {
		if(session.getAttribute("sessionUser_num") == null) return "redirect:main.login";
		int user_num = (Integer) session.getAttribute("sessionUser_num");
		if(params.get("cal1") != null && !params.get("cal1").equals("") 
				&& params.get("cal1").length() < 17) {
			params.put("cal1", params.get("cal1")+" 00:00:00");
			params.put("cal2", params.get("cal2")+" 23:59:59");
		}
		List<BuySellAllDTO> findList = userMyMapper.sellList(user_num, params);
		req.setAttribute("auction", params.get("auction"));
		params.put("auction", "all");
		List<BuySellAllDTO> allList = userMyMapper.sellList(user_num, params);
		int waitSu = 0;
		int endSu = 0;
		if (allList != null) {
			for (BuySellAllDTO dto : allList) {
				if (dto.getAuction().equals("W")) {
					waitSu++;
				}else {
					endSu++;
				}
			}
		}
		req.setAttribute("cal1", params.get("cal1"));
		req.setAttribute("cal2", params.get("cal2"));
		req.setAttribute("endSu", endSu);
		req.setAttribute("waitSu", waitSu);
		req.setAttribute("allList", findList);
		req.setAttribute("allListSu", endSu+waitSu);
		return "user/my/sellList";
	}
	
	@RequestMapping("/cartList.user")
	public ModelAndView user_cartList(HttpSession session) {
		int user_num = 0;
		if(session.getAttribute("sessionUser_num") == null) {
			ModelAndView mav = new ModelAndView("message");
			mav.addObject("msg","로그인을 해주세요.");
			mav.addObject("url","main.login");
			return mav;
		}
		user_num = (int) session.getAttribute("sessionUser_num");
		List<AdminAllDTO> list = userMyMapper.getAllInfoCartList(user_num);
		ModelAndView mav = new ModelAndView("user/my/cartList","cartList",list);
		if(list != null) mav.addObject("listSize",list.size());
		else mav.addObject("listSize", 0);
		return mav;
	}
	
	@PostMapping("/cartListScroll.user")
	public String user_cartListScroll(@RequestParam Map<String,String> map
			,HttpServletRequest req) {
		int user_num = Integer.parseInt(map.get("user_num"));
		List<AdminAllDTO> list = userMyMapper.getAllInfoCartList(user_num);
		if(list != null) req.setAttribute("listSize",list.size());
		else req.setAttribute("listSize", 0);
		req.setAttribute("cartList", list);
		req.setAttribute("count", map.get("count"));
		return "user/my/cartListScroll";
	}
	
	@RequestMapping("/point.user")
	public String user_point(int user_num,HttpServletRequest req) {
		int point = userMyMapper.getPoint(user_num);
		List<BuySellAllDTO> list = userMyMapper.getPointList(user_num);
		List<BuySellAllDTO> plusList = new ArrayList<>();
		if(list != null) {
			for(BuySellAllDTO dto : list) {
				dto.setPointCheck("minus");
				BuySellAllDTO a = new BuySellAllDTO();
				a.setProd_subject(dto.getProd_subject());
				a.setBuy_date(dto.getBuy_date());
				a.setPoint((int)(dto.getProd_price()*0.05));
				a.setPointCheck("plus");
				plusList.add(a);
			}
		}
		Comparator<BuySellAllDTO> com = new Comparator<BuySellAllDTO>() {
			@Override
			public int compare(BuySellAllDTO arg0, BuySellAllDTO arg1) {
				return arg1.getBuy_date().compareTo(arg0.getBuy_date());
			}
		};
		list.addAll(plusList);
		Collections.sort(list,com);
		req.setAttribute("point", point);
		req.setAttribute("list", list);
		return "user/my/point";
	}
}
