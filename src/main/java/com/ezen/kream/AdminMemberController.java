package com.ezen.kream;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;
import com.ezen.kream.dto.QnAImgDTO;
import com.ezen.kream.service.AdminBoardMapper;
import com.ezen.kream.service.AdminMemberMapper;

@Controller
public class AdminMemberController {
	@Autowired
	private AdminMemberMapper adminMemberMapper;
	@Autowired
	private AdminBoardMapper adminBoardMapper;
	
	@RequestMapping("/memberList.admin")
	public ModelAndView admin_memberList(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/member/memberList");
		int pageSize = 10;
		String del = req.getParameter("del");
		if(del == null) {
			del = "N";
		}
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = adminMemberMapper.getCount(del);
		if (endRow>count) endRow = count;
		List<MemberDTO> list = null;
		if (count>0){
			list = adminMemberMapper.memberList(startRow, endRow,del);
			int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum",rowNum);
		mav.addObject("count", count);
		mav.addObject("memberList", list);
		mav.addObject("del",del);
		return mav;
	}
	
	@RequestMapping("/memberFind.admin")
	public ModelAndView admin_memberFind(HttpServletRequest req, @RequestParam Map<String,String> map) {
		ModelAndView mav = new ModelAndView("admin/member/memberList");
		if(map.get("searchString").equals("")) {
			return new ModelAndView("redirect:memberList.admin");
		}
		mav.addObject("searchString",map.get("searchString"));
		map.put("searchString",map.get("searchString")+"%");
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = adminMemberMapper.getFindCount(map);
		if (endRow>count) endRow = count;
		List<MemberDTO> list = null;
		map.put("start", String.valueOf(startRow));
		map.put("end",String.valueOf(endRow));
		if (count>0){
			list = adminMemberMapper.memberFind(map);
			int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) endPage = pageCount;
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		mav.addObject("rowNum",rowNum);
		mav.addObject("count", count);
		mav.addObject("mode","find");
		mav.addObject("search",map.get("search"));
		
		mav.addObject("memberList", list);
		mav.addObject("del",map.get("del"));
		return mav;
	}
	
	@RequestMapping("/memberDetail.admin")
	public ModelAndView admin_member(int user_num) {
		MemberDTO dto = adminMemberMapper.memberDetail(user_num);
		return new ModelAndView("admin/member/memberDetail","getMember",dto);
	}
	
	@RequestMapping("/memberEdit.admin")
	public String admin_memberEdit(HttpServletRequest req, @RequestParam Map<String,String> map) {
		int res = adminMemberMapper.memberEdit(map);
		if(res>0) {
			req.setAttribute("msg","회원수정성공!");
			req.setAttribute("url", "memberList.admin");
		}else {
			req.setAttribute("msg","회원수정실패!");
			req.setAttribute("url", "memberDetail.admin?user_num="+map.get("user_num"));
		}
		return "message";
	}
	
	@RequestMapping("/memberReport.admin")
	public String admin_memberReport(HttpServletRequest req,
			@RequestParam Map<String,String> map) {
		req.setAttribute("process", map.get("process"));
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = 0;
		
		if(map.get("process").equals("wait")) count = adminMemberMapper.getWaitCount();
		else count = adminMemberMapper.getOkCount();
		if(map.get("process").equals("wait")) map.put("process", "대기중");
		else map.put("process","처리완료");
		
		
		if (endRow>count) endRow = count;
		List<QnABoardAllDTO> list = null;
		if (count>0){
			map.put("start", String.valueOf(startRow));
			map.put("end", String.valueOf(endRow));
			list = adminMemberMapper.memberReportList(map);
			int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) endPage = pageCount;
			req.setAttribute("startPage", startPage);
			req.setAttribute("endPage", endPage);
			req.setAttribute("pageBlock", pageBlock);
			req.setAttribute("pageCount", pageCount);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		req.setAttribute("rowNum",rowNum);
		req.setAttribute("count", count);
		
		if(list != null) {
			for(QnABoardAllDTO dto : list) {
				MemberDTO writer = adminMemberMapper.memberDetail(dto.getUser_num());
				MemberDTO accused = adminMemberMapper.memberDetail(dto.getReport_num());
				dto.setQna_writer(writer.getProfile_name());
				dto.setProfile_img(writer.getProfile_img());
				dto.setQna_reporter(accused.getProfile_name());
			}
		}
		req.setAttribute("reportList", list);
		return "admin/member/memberReportList";
	}
	
	@RequestMapping("/memberReportFind.admin")
	public String admin_memberReportFind(HttpServletRequest req,
			@RequestParam Map<String,String> map) {
		req.setAttribute("process", map.get("process"));
		req.setAttribute("mode", "find");
		req.setAttribute("search", map.get("search"));
		req.setAttribute("searchString", map.get("searchString"));
		
		map.put("searchString", "%"+map.get("searchString")+"%");
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = 0;
		
		if(map.get("process").equals("wait")) map.put("process", "대기중");
		else map.put("process","처리완료");
		
		if(map.get("search").equals("qna_subject")) count = adminMemberMapper.getFindSubjectCount(map);
		else count = adminMemberMapper.getFindWriterCount(map);
		
		System.out.println("카운터:"+count);
		
		if (endRow>count) endRow = count;
		List<QnABoardAllDTO> list = null;
		if (count>0){
			map.put("start", String.valueOf(startRow));
			map.put("end", String.valueOf(endRow));
			if(map.get("search").equals("qna_subject")) list = adminMemberMapper.memberReportFindSubjectList(map);
			else list = adminMemberMapper.memberReportFindWriterList(map);
			
			int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
			int pageBlock = 3;
			int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) endPage = pageCount;
			req.setAttribute("startPage", startPage);
			req.setAttribute("endPage", endPage);
			req.setAttribute("pageBlock", pageBlock);
			req.setAttribute("pageCount", pageCount);
		}
		int rowNum = count - (currentPage - 1) * pageSize;
		req.setAttribute("rowNum",rowNum);
		req.setAttribute("count", count);
		
		if(list != null) {
			for(QnABoardAllDTO dto : list) {
				MemberDTO writer = adminMemberMapper.memberDetail(dto.getUser_num());
				MemberDTO accused = adminMemberMapper.memberDetail(dto.getReport_num());
				dto.setQna_writer(writer.getProfile_name());
				dto.setProfile_img(writer.getProfile_img());
				dto.setQna_reporter(accused.getProfile_name());
			}
		}
		req.setAttribute("reportList", list);
		return "admin/member/memberReportList";
	}
	
	@RequestMapping("/memberReportView.admin")
	public ModelAndView admin_memberReportView(int qna_num) {
		QnABoardDTO dto = adminMemberMapper.agetQnABoard(qna_num);
		MemberDTO writer = adminMemberMapper.memberDetail(dto.getUser_num());
		MemberDTO accused = adminMemberMapper.memberDetail(dto.getReport_num());
		QnABoardAllDTO qna = new QnABoardAllDTO();
		qna.setQna_num(dto.getQna_num());
		qna.setQna_cate(dto.getQna_cate());
		qna.setQna_subCate(dto.getQna_subCate());
		qna.setUser_num(writer.getUser_num());
		qna.setQna_writer(writer.getProfile_name());
		qna.setProfile_img(writer.getProfile_img());
		qna.setReport_num(accused.getUser_num());
		qna.setQna_reporter(accused.getProfile_name());
		qna.setQna_subject(dto.getQna_subject());
		qna.setQna_process(dto.getQna_process());
		qna.setQna_contents(dto.getQna_contents());
		ModelAndView mav = new ModelAndView("admin/member/memberReportView");
		List<QnAImgDTO> imgList = adminBoardMapper.getQnAImg(qna_num);
		mav.addObject("imgList",imgList);
		mav.addObject("qna",qna);
		return mav;
	}
	
	@RequestMapping("/qnaAnswer.admin")
	public ModelAndView admin_qnaAnswer(@ModelAttribute QnABoardAllDTO qna){	
		return new ModelAndView("admin/member/qnaAnswer","qna",qna);
	}

}
