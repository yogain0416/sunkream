package com.ezen.kream;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.service.AdminProdMapper;
import com.ezen.kream.service.LoginMapper;
import com.ezen.kream.service.UserHomeMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class LoginController {
	@Autowired
	private NaverLoginBO naverLoginBO;
	@Autowired
	private KakaoLoginBO kakaoLoginBO;
	@Autowired
	private UserHomeMapper userHomeMapper;
	@Autowired
	private AdminProdMapper adminProdMapper;

	@Resource(name = "uploadPath")
	private String upPath;
	private String apiResult = null;

	@Autowired
	private LoginMapper loginMapper;

	@RequestMapping("/main.login")
	public ModelAndView login_main(HttpSession session,HttpServletRequest req) {
		if (session.getAttribute("upPath") == null)
			session.setAttribute("upPath", upPath);
		if (session.getAttribute("admin_num") == null)
			session.setAttribute("admin_num", "1");
		
		ModelAndView mav = new ModelAndView();
		String loginMode = (String) session.getAttribute("loginMode");
		if (session.getAttribute("sessionEmail") == null) {
			String naverUrl = naverLoginBO.getAuthorizationUrl(session);
			String kakaoUrl = kakaoLoginBO.getAuthorize();
			mav.addObject("naverUrl", naverUrl);
			mav.addObject("kakaoUrl", kakaoUrl);
			mav.addObject("loginMode", loginMode);
			mav.setViewName("user/login/main");
		} else {
			String email = (String) session.getAttribute("sessionEmail");
			MemberDTO dto = loginMapper.getMember(email);
			mav.addObject("dto", dto);
			mav.setViewName("user/home/main");
		}
		session.setAttribute("upPath", upPath);
		session.setAttribute("admin_num", "1");
		List<ProdCateDTO> cate_list = adminProdMapper.twoType();
		session.setAttribute("cate_list", cate_list);
		List<String> cateList = adminProdMapper.cate_kr_typeList();
		session.setAttribute("cateList", cateList);
		
		List<String> list = null;
		list = userHomeMapper.userTabList();
		List<PickCateListDTO> blist = new ArrayList<>();
		if (list.size() != 0) {
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
		return mav;
	}

	@RequestMapping("/socialNewMember.login")
	public String socialNewMember() {
		return "user/login/socialNewMember";
	}

	@PostMapping("/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam(value = "email", required = false) String email) {
		int cnt = loginMapper.socialCheckMember(email);
		return cnt;
	}

	@RequestMapping(value = "/newMember.login", method = RequestMethod.GET)
	public String login_newMember() {
		return "user/login/newMember";
	}

	@RequestMapping(value = "/newMember.login", method = RequestMethod.POST)
	public ModelAndView login_newMemberOk(HttpServletRequest req, @ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView("message");
		String loginMode = req.getParameter("loginMode");
		if (loginMode == null) {
			String birth = req.getParameter("yy") + req.getParameter("mm") + req.getParameter("dd");
			dto.setBirth(birth);
		}
		System.out.println("사이즈:"+dto.getUser_size());
		int res = loginMapper.newMember(dto);
		if (res > 0) {
			mav.addObject("msg", "회원가입성공");
			mav.addObject("url", "main.login");
		} else {
			mav.addObject("msg", "회원가입실패");
			mav.addObject("url", "main.login");
		}
		return mav;
	}

	@RequestMapping("/sendSMS")
	@ResponseBody
	public String sendSMS(String phone_num) {
		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		loginMapper.CertifiedPhoneNumber(phone_num, numStr);
		return numStr;
	}

	@RequestMapping("/checkPhoneNum")
	@ResponseBody
	public int checkPhoneNum(@RequestParam(value = "phoneNum", required = false) String phoneNum) {
		int cnt3 = loginMapper.checkPhoneNum(phoneNum);
		return cnt3;
	}

	@RequestMapping("/checkProfileName")
	@ResponseBody
	public int checkProfileName(@RequestParam(value = "profile_name", required = false) String profile_name) {
		boolean bol = loginMapper.checkProfileName(profile_name);
		if (bol) {
			int cnt2 = 1;
			return cnt2;
		} else {
			int cnt2 = 0;
			return cnt2;
		}
	}

	@RequestMapping("/loginCheck.login")
	public ModelAndView login_loginCheck(HttpSession session, @RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView();
		int res = loginMapper.loginCheck(params);
		if (res > 0) {
			MemberDTO dto = loginMapper.getMember(params.get("email"));
			session.setAttribute("sessionEmail", dto.getEmail());
			session.setAttribute("sessionUser_num", dto.getUser_num());
			session.setAttribute("sessionProfileName", dto.getProfile_name());
			session.setMaxInactiveInterval(60*60); //로그인유지시간 
			mav.addObject("msg", "로그인하셨습니다.");
			mav.addObject("url", "main.main");
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "이메일 또는 비밀번호를 확인해주세요");
			mav.addObject("url", "main.login");
			mav.setViewName("message");
		}
		return mav;
	}

	@RequestMapping("/logout.login")
	public ModelAndView logout(HttpSession session, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("user/login/logoutmessage");
		String socialLogin = (String) session.getAttribute("loginMode");
		if (socialLogin != null) {
			if (socialLogin.equals("naver")) {
				mav.addObject("url", "http://nid.naver.com/nidlogin.logout");
			} else if (socialLogin.equals("kakao")) {
				mav.addObject("url", "https://accounts.kakao.com/logout?continue=https%3A%2F%2Fcs.kakao.com%2F");
			}
		} else {
			socialLogin = "";
		}
		session.invalidate();
		mav.addObject("social", socialLogin);
		mav.addObject("msg", "로그아웃되었습니다.");

		return mav;
	}

	@RequestMapping(value = "/findId.login", method = RequestMethod.GET)
	public String login_findId(HttpServletRequest req) {
		req.setAttribute("mode", "id");
		req.setAttribute("title", "이메일 아이디 찾기");
		return "user/login/find";
	}

	@RequestMapping(value = "/findId.login", method = RequestMethod.POST)
	public ModelAndView login_checkId(String phoneNum) {
		ModelAndView mav = new ModelAndView();
		String email = loginMapper.findId(phoneNum);
		if (email == null) {
			mav.addObject("msg", "일치하는 사용자가 없습니다.");
			mav.addObject("url", "findId.login");
			mav.setViewName("message");
		} else {
			mav.addObject("email", email);
			mav.addObject("mode", "id");
			mav.setViewName("user/login/findOk");
		}
		return mav;
	}

	@RequestMapping(value = "/findPw.login", method = RequestMethod.GET)
	public String login_findPw(HttpServletRequest req) {
		req.setAttribute("mode", "pw");
		req.setAttribute("title", "비밀번호 찾기");
		return "user/login/find";
	}

	@RequestMapping(value = "/findPw.login", method = RequestMethod.POST)
	public ModelAndView login_checkPw(@RequestParam Map<String, String> params) {
		ModelAndView mav = new ModelAndView();
		int res = loginMapper.findPw(params);
		if (res < 0) {
			mav.addObject("msg", "일치하는 사용자가 없습니다.");
			mav.addObject("url", "findPw.login");
			mav.setViewName("message");
		} else {
			mav.addObject("mode", "pw");
			mav.setViewName("user/login/findOk");
		}
		return mav;
	}

	@RequestMapping("/naverLoginOk") // callback 처리주소
	public ModelAndView naverLoginOk(HttpServletRequest req, HttpSession session,
			@RequestParam(required = false) String code, @RequestParam String state)
			throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		String error = req.getParameter("error_description");
		if (error != null) {
			if (error.equals("Canceled By User")) {
				return new ModelAndView("user/login/socialLoginOk", "url", "main.login");
			}
		}
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken);

		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		String email = (String) response_obj.get("email");
		String name = (String) response_obj.get("name");
		String birthYear = (String) response_obj.get("birthyear");
		String birthDay = (String) response_obj.get("birthday");
		String[] day = birthDay.split("-");
		String birth = birthYear + day[0] + day[1];
		String gender = (String) response_obj.get("gender");
		String hp = (String) response_obj.get("mobile");
		String[] hpS = hp.split("-");
		String phone = hpS[0] + hpS[1] + hpS[2];
		String loginMode = "naver";
		session.setAttribute("loginMode", loginMode);
		ModelAndView mav = new ModelAndView();
		int res = loginMapper.socialCheckMember(email);
		if (res > 0) {
			MemberDTO dto = loginMapper.getMember(email);
			session.setAttribute("sessionEmail", dto.getEmail());
			session.setAttribute("sessionUser_num", dto.getUser_num());
			session.setAttribute("sessionProfileName", dto.getProfile_name());
			session.setAttribute("loginMode", loginMode);
			mav.addObject("url", "main.login");
			mav.setViewName("user/login/socialLoginOk");
		} else {
			session.setAttribute("SNMEmail", email);
			session.setAttribute("SNMName", name);
			session.setAttribute("SNMBirth", birth);
			session.setAttribute("SNMGender", gender);
			session.setAttribute("SNMLoginMode", "naver");
			mav.addObject("url", "socialNewMember.login");
			mav.setViewName("user/login/socialLoginOk");
		}
		return mav;
	}

	@RequestMapping("/kakaoLoginOk")
	public ModelAndView kakaoLoginOk(@RequestParam String code, HttpSession session) {
		System.out.println(code);
		session.setAttribute("code", code);
		String accessToken = kakaoLoginBO.getAccessToken(code);
		session.setAttribute("accessToken", accessToken);

		HashMap<String, Object> userInfo = kakaoLoginBO.kakaoUserInfo(accessToken);
		String email = (String) userInfo.get("email");
		String name = (String) userInfo.get("name");
		String birth = (String) userInfo.get("birth");
		String gender = (String) userInfo.get("gender");
		if (gender.equals("male")) {
			gender = "M";
		} else {
			gender = "F";
		}
		;
		String phone = (String) userInfo.get("phone");
		String loginMode = "kakao";
		session.setAttribute("loginMode", loginMode);
		ModelAndView mav = new ModelAndView();
		int res = loginMapper.socialCheckMember(email);
		if (res > 0) {
			MemberDTO dto = loginMapper.getMember(email);
			session.setAttribute("sessionEmail", dto.getEmail());
			session.setAttribute("sessionUser_num", dto.getUser_num());
			session.setAttribute("sessionProfileName", dto.getProfile_name());
			session.setAttribute("loginMode", loginMode);
			mav.addObject("url", "main.login");
			mav.setViewName("user/login/socialLoginOk");
		} else {
			session.setAttribute("SNMEmail", email);
			session.setAttribute("SNMName", name);
			session.setAttribute("SNMBirth", birth);
			session.setAttribute("SNMGender", gender);
			session.setAttribute("SNMLoginMode", "kakao");
			mav.addObject("url", "socialNewMember.login");
			mav.setViewName("user/login/socialLoginOk");
		}
		return mav;
	}
}
