package com.ezen.kream;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.HashTagBaseDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.PickHashTagDTO;
import com.ezen.kream.dto.PickSearchDTO;
import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;
import com.ezen.kream.dto.QnACateDTO;
import com.ezen.kream.dto.QnAImgDTO;
import com.ezen.kream.dto.StyleBoardAllDTO;
import com.ezen.kream.dto.StyleBoardDTO;
import com.ezen.kream.service.AdminBoardMapper;
import com.ezen.kream.service.AdminMemberMapper;
import com.ezen.kream.service.UserAlarmMapper;

@Controller
public class AdminBoardController {
	@Autowired
	private AdminBoardMapper adminBoardMapper;
	@Autowired
	private AdminMemberMapper adminMemberMapper;
	@Autowired
	private UserAlarmMapper userAlarmMapper;
	@Resource(name = "uploadPath")
	private String upPath;
	
	@RequestMapping("/QnABoardList.admin")
	public String admin_qnaBoardList(String qna_cate,
			@RequestParam(required = false)String process,HttpServletRequest req) {
		if(qna_cate == null || qna_cate.trim().equals("qna")) qna_cate = "공지";
		if(qna_cate.trim().equals("ask")) qna_cate = "1:1문의";
		List<QnABoardAllDTO> list = null;
		req.setAttribute("process", process);
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = 0;
		if(process == null || process.equals("")) {
			count = adminBoardMapper.getQnABoardCount(qna_cate);
		}else {
			if(process.equals("ok")) process = "처리완료";
			else process = "대기중";
			count = adminBoardMapper.agetQnABoardCount(qna_cate,process);
		}
		if (endRow>count) endRow = count;
		if (count>0){
			if(process == null || process.equals("")) {
				list = adminBoardMapper.QnABoardList(qna_cate,startRow, endRow);
			}else {
				list = adminBoardMapper.QnABoardListProcess(process,startRow,endRow);
			}
			System.out.println("adminBoardController 리스트:"+list.size());
			if(qna_cate.equals("1:1문의")) {
				for(QnABoardAllDTO dto : list) {
					MemberDTO writer = adminMemberMapper.memberDetail(dto.getUser_num());
					if(dto.getQna_subCate().equals("신고")) {
						MemberDTO accused = adminMemberMapper.memberDetail(dto.getReport_num());
						dto.setQna_reporter(accused.getProfile_name());
					}
					dto.setQna_writer(writer.getProfile_name());
					dto.setProfile_img(writer.getProfile_img());
					dto.setDel(writer.getDel());
				}
			}
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
		req.setAttribute("QnABoardList", list);
		req.setAttribute("qna_cate", qna_cate);
		return "admin/board/QnABoardList";
	}
	
	@RequestMapping("/qnaFind.admin")
	public String admin_qnaFind(@RequestParam Map<String,String> map,HttpServletRequest req) {
		req.setAttribute("searchString", map.get("searchString"));
		map.put("searchString", "%"+map.get("searchString")+"%");
		if(map.get("qna_cate") == null || map.get("qna_cate").trim().equals("qna")) map.put("qna_cate","공지");
		if(map.get("qna_cate").trim().equals("ask")) map.put("qna_cate","1:1문의");
		List<QnABoardAllDTO> list = null;
		
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = 0;
		if(map.get("process") == null || map.get("process").equals("")) {
			if(map.get("search").equals("profile_name")) count = adminBoardMapper.getQnABoardFindProfileCount(map);
			else count = adminBoardMapper.getQnABoardFindCount(map);
		}else {
			if(map.get("process").equals("ok")) map.put("process","처리완료");
			else map.put("process","대기중");
			if(map.get("search").equals("profile_name")) count = adminBoardMapper.agetQnABoardFindProfileCount(map);
			else count = adminBoardMapper.agetQnABoardFindCount(map);
		}
		System.out.println("카운트:"+count);
		if (endRow>count) endRow = count;
		if (count>0){
			map.put("start", String.valueOf(startRow));
			map.put("end", String.valueOf(endRow));
			if(map.get("process") == null || map.get("process").equals("")) {
				if(map.get("search").equals("profile_name")) list = adminBoardMapper.QnABoardFindProfileList(map);
				else list = adminBoardMapper.QnABoardFindList(map);
			}else {
				if(map.get("search").equals("profile_name")) list = adminBoardMapper.QnABoadFindListProfileProcess(map);
				else list = adminBoardMapper.QnABoardFindListProcess(map);
			}
			
			if(map.get("qna_cate").equals("1:1문의")) {
				if(list != null) {
					System.out.println("리스트:"+list.size());
					for(QnABoardAllDTO dto : list) {
						MemberDTO writer = adminMemberMapper.memberDetail(dto.getUser_num());
						if(dto.getQna_subCate().equals("신고")) {
							MemberDTO accused = adminMemberMapper.memberDetail(dto.getReport_num());
							dto.setQna_reporter(accused.getProfile_name());
						}
						dto.setQna_writer(writer.getProfile_name());
						dto.setProfile_img(writer.getProfile_img());
					}
				}
			}
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
		if(map.get("process").equals("처리완료")) map.put("process","ok");
		else if(map.get("process").equals("대기중"))map.put("process","wait");
		req.setAttribute("process", map.get("process"));
		req.setAttribute("rowNum",rowNum);
		req.setAttribute("count", count);
		req.setAttribute("mode", "find");
		req.setAttribute("QnABoardList", list);
		req.setAttribute("search", map.get("search"));
		req.setAttribute("qna_cate", map.get("qna_cate"));
		return "admin/board/QnABoardList";
	}
	
	@PostMapping("/getQnaSubCate.admin")
	@ResponseBody
	public List<QnACateDTO> getQnASubCate(@RequestParam(value="qna_cate" ,required=false)String qna_cate){
		List<QnACateDTO> list = adminBoardMapper.getQnASubCate(qna_cate);
		return list;
	}
	
	@RequestMapping(value="/QnABoardInput.admin",method=RequestMethod.GET)
	public ModelAndView admin_qnaBoardInput() {
		List<String> list = adminBoardMapper.getQnACate();
		return new ModelAndView("admin/board/QnABoardInputForm","cateList",list);
	}
	
	@RequestMapping(value="/QnABoardInput.admin",method=RequestMethod.POST)
	public String admin_qnaBoardInputOk(@ModelAttribute QnABoardDTO dto,HttpServletRequest req,
									BindingResult result, MultipartFile mf) {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		Iterator<String> it = (Iterator<String>) mr.getFileNames();
		QnAImgDTO imgDTO = new QnAImgDTO();
		Map<String,String> map = new HashMap<>();
		
		String reg_date = adminBoardMapper.setSysdate();
		dto.setReg_date(reg_date);
		int res = adminBoardMapper.QnABoardInput(dto);
		int num	 = adminBoardMapper.getQnANum(reg_date);
		if(dto.getQna_cate().equals("공지")) {
			List<Integer> list = userAlarmMapper.getUserAllNumList();
			map.put("alarm_kind", "announce");
			map.put("alarm_kind_num", String.valueOf(num));
			map.put("sendUser_num", "1");
			map.put("followCheck", "0");
			map.put("info", "");
			for(int user_num:list) {
				map.put("getUser_num",String.valueOf(user_num));
				userAlarmMapper.insertAlarm(map);
			}
		}
		if(res>0) {
			req.setAttribute("url", "QnABoardList.admin");
			int qna_num = adminBoardMapper.getQnANum(reg_date);		
			imgDTO.setUser_num(dto.getUser_num());
			imgDTO.setQna_num(qna_num);
			while (it.hasNext()) {
				String img = it.next();
				mf = mr.getFile(img);
				String qna_img = mf.getOriginalFilename();// han.png
				File file = new File(upPath, qna_img);
				if (mf.getSize() != 0) {
					if (!file.exists())file.mkdirs();
					try {mf.transferTo(file);} catch (IllegalStateException | IOException e){e.printStackTrace();}
				}
				System.out.println(qna_img);
				if (qna_img == null || qna_img.equals("")) {
					break;
				}
				imgDTO.setQna_img(qna_img);
				int res2 = adminBoardMapper.QnAImgInput(imgDTO);
				if(res2>0) {
					req.setAttribute("msg", "QnABoard등록성공,이미지 등록 성공!");
					System.out.println("이미지 넣기 성공!");
				}else {
					req.setAttribute("msg", "QnABoard등록성공,이미지 등록 실패!");
				}
			}
		}else {
			req.setAttribute("msg", "QnABoard등록실패!");
			req.setAttribute("url", "QnABoardInput.admin");
		}
		return "message";
	}
	
	@RequestMapping("/QnACateList.admin")
	public ModelAndView admin_qnaCateList() {
		List<QnACateDTO> list = adminBoardMapper.QnACateList();
		return new ModelAndView("admin/board/QnACateList","qnaList",list);
	}
	
	
	@PostMapping("/checkSubCate.admin")
	@ResponseBody
	public int admin_checkSubCate(@RequestParam(value="qna_cate" ,required=false)String qna_cate,
								@RequestParam(value="qna_subCate" ,required=false)String qna_subCate) {
		Map<String,String> map = new HashMap<>();
		map.put("qna_cate", qna_cate);
		map.put("qna_subCate",qna_subCate);
		int count = adminBoardMapper.checkSubCate(map);
		System.out.println("count:"+count);
		return count;
	}
	
	@RequestMapping(value="/QnACateInput.admin",method = RequestMethod.GET)
	public String admin_qnaCateInput() {
		return "admin/board/QnACateInputForm";
	}
	@RequestMapping(value="/QnACateInput.admin",method = RequestMethod.POST)
	public String admin_qnaCateInputOk(HttpServletRequest req,@ModelAttribute QnACateDTO dto) {
		int res = adminBoardMapper.QnACateInput(dto);
		if(res>0) {
			req.setAttribute("msg", "QnACate등록성공!");
			req.setAttribute("url", "QnACateList.admin");
		}else {
			req.setAttribute("msg", "QnACate등록실패!");
			req.setAttribute("url", "QnACateInput.admin");
		}
		return "message";
	}
	
	@RequestMapping("/QnACateDelete.admin")
	public String admin_qnaCateDelete(HttpServletRequest req, int num) {
		int res = adminBoardMapper.QnACateDelete(num);
		if(res>0) {
			req.setAttribute("msg", "QnACate삭제성공!");
			req.setAttribute("url", "QnACateList.admin");
		}else {
			req.setAttribute("msg", "QnACate삭제실패!");
			req.setAttribute("url", "QnACateList.admin");
		}
		return "message";
	}
	
	@RequestMapping("/QnAView.admin")
	public ModelAndView admin_qnaBoardView(int qna_num) {
		QnABoardDTO dto = adminBoardMapper.getQnABoard(qna_num);
		ModelAndView mav = new ModelAndView("admin/board/QnAView","getBoard",dto);
		List<QnAImgDTO> imgList = adminBoardMapper.getQnAImg(qna_num);
		mav.addObject("imgList",imgList);
		mav.addObject("upPath",upPath);
		return mav;
	}
	
	@RequestMapping("/QnABoardDelete.admin")
	public String admin_qnaBoardDelete(int qna_num,HttpServletRequest req) {
		int res = adminBoardMapper.QnABoardDelete(qna_num);
		if(res>0) {
			req.setAttribute("msg", "QnABoard삭제성공!");
			req.setAttribute("url", "QnABoardList.admin");
		}else {
			req.setAttribute("msg", "QnABoard삭제실패!");
			req.setAttribute("url", "QnABoardList.admin");
		}
		return "message";
	}
	
	@RequestMapping(value="/QnABoardEdit.admin",method=RequestMethod.GET)
	public String admin_qnaBoardEdit(int qna_num,HttpServletRequest req) {
		QnABoardDTO dto = adminBoardMapper.getQnABoard(qna_num);
		List<QnACateDTO> list = adminBoardMapper.getQnASubCate(dto.getQna_cate());
		List<QnAImgDTO> imgList = adminBoardMapper.getQnAImg(qna_num);
		req.setAttribute("imgList", imgList);
		req.setAttribute("upPath",upPath);
		req.setAttribute("getBoard",dto);
		req.setAttribute("subCateList", list);
		return "admin/board/QnABoardEditForm";
	}
	
	@RequestMapping(value="/QnABoardEdit.admin",method=RequestMethod.POST)
	public String admin_qnaBoardEditOk(@ModelAttribute QnABoardDTO dto,HttpServletRequest req
										,BindingResult result, MultipartFile file, String[] file_img) {
		List<QnAImgDTO> imgList = adminBoardMapper.getQnAImg(dto.getQna_num());
		if(file_img != null) {
			for(QnAImgDTO imgDTO : imgList) {
				int co = 0;
				for(String img : file_img) {
					if(img.equals(imgDTO.getQna_img())) {
						co++;
						break;
					}
				}
				if(co != 1) {
					int res = adminBoardMapper.QnAImgDelete(imgDTO);
					if(res>0) System.out.println("기존이미지 삭제 성공!");
					else System.out.println("기존이미지 삭제 실패!");
				}
			}	
		}else {
			int res = adminBoardMapper.QnAImgDeleteAll(dto.getQna_num());
			if(res>0) System.out.println("기존이미지 삭제 성공!");
			else System.out.println("기존이미지 삭제 실패!");
		}
		
		QnAImgDTO imgDTO = new QnAImgDTO();
		imgDTO.setQna_num(dto.getQna_num());
		imgDTO.setUser_num(dto.getUser_num());
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		Iterator<String> it = (Iterator<String>) mr.getFileNames();
		while(it.hasNext()) {
			String str = it.next();
			file = mr.getFile(str);
			System.out.println("================== file start ==================");
			System.out.println("파일 실제 이름: " + file.getOriginalFilename());
			System.out.println("================== file   END ==================");
			File fileSave = new File(upPath, file.getOriginalFilename());
			if (file.getSize() != 0) {
				if (!fileSave.exists())fileSave.mkdirs();
				try {file.transferTo(fileSave);} catch (IllegalStateException | IOException e){e.printStackTrace();}
			}
			if (file.getOriginalFilename() == null || file.getOriginalFilename().equals("")) {
				break;
			}
			imgDTO.setQna_img(file.getOriginalFilename());
			int res = adminBoardMapper.QnAImgInput(imgDTO);
			if(res>0)System.out.println("수정 이미지 등록 성공!");
			else System.out.println("수정 이미지 등록 실패!");
		}
		int res = adminBoardMapper.QnABoardEdit(dto);
		Map<String,String> map = new HashMap<>();
		if(dto.getQna_cate().equals("공지")) {
			map.put("alarm_kind_num", String.valueOf(dto.getQna_num()));
			map.put("alarm_kind", "announce_set");
			userAlarmMapper.setAnnounceAlarm(map);
		}
		if(res>0) {
			req.setAttribute("msg", "QnABoard수정성공!");
			req.setAttribute("url", "QnABoardList.admin");
		}else {
			req.setAttribute("msg", "QnABoard수정실패!");
			req.setAttribute("url", "QnAView.admin?qna_num="+dto.getQna_num());
		}
		return "message";
	}
	
	@RequestMapping(value="/askReply.admin",method=RequestMethod.GET)
	public ModelAndView admin_askReply(int qna_num) {
		QnABoardDTO dto = adminBoardMapper.getQnABoard(qna_num);
		return new ModelAndView("admin/board/askReply","getBoard",dto);
	}
	
	@RequestMapping(value="/askReply.admin",method=RequestMethod.POST)
	public String admin_askReply(@ModelAttribute QnABoardDTO dto,HttpServletRequest req,
									@RequestParam(required = false)String admin_info) {
		if(dto.getQna_subCate().equals("신고")) {
			Map<String,String> map = new HashMap<>();
			map.put("report_num", String.valueOf(dto.getReport_num()));
			map.put("admin_info", admin_info+"\n");
			int res = adminBoardMapper.setPenalty(map);
			System.out.println("패널티 처리 : "+res);
			//알람 패널티 처리 보내기 요기이이이!!!!
			map.put("getUser_num", String.valueOf(dto.getReport_num()));
			map.put("sendUser_num", "1");
			map.put("followCheck", "0");
			map.put("alarm_kind", "report");
			map.put("alarm_kind_num", String.valueOf(dto.getQna_num()));
			map.put("info", admin_info);
			userAlarmMapper.insertAlarm(map);
		}
		adminBoardMapper.processCommit(dto);
		Map<String,String> map = new HashMap<>();
		int res = adminBoardMapper.askReply(dto);
		int qna_num = adminBoardMapper.getQnAReplyNum(dto);
		map.put("getUser_num", String.valueOf(dto.getUser_num()));
		map.put("sendUser_num", "1");
		map.put("followCheck", "0");
		map.put("alarm_kind", "ask");
		map.put("alarm_kind_num", String.valueOf(qna_num));
		map.put("info","");
		userAlarmMapper.insertAlarm(map);
		if(res>0) {
			if(dto.getQna_cate().equals("1:1문의")) {
				req.setAttribute("url", "QnABoardList.admin?qna_cate=ask");
			}else {
				req.setAttribute("url", "QnABoardList.admin");
			}
			req.setAttribute("msg", "askReply등록성공!");
		}else {
			req.setAttribute("msg", "askReply등록실패!");
			req.setAttribute("url", "QnAView.admin?qna_num="+dto.getQna_num());
		}
		return "message";
	}
	
	@RequestMapping(value="/askReplyEdit.admin",method=RequestMethod.GET)
	public ModelAndView admin_askReplyEdit(int qna_num) {
		QnABoardDTO dto = adminBoardMapper.getQnABoard(qna_num);
		return new ModelAndView("admin/board/askReplyEdit","getBoard",dto);
	}
	
	@RequestMapping(value="/askReplyEdit.admin",method=RequestMethod.POST)
	public String admin_askReplyEditOk(QnABoardDTO dto,HttpServletRequest req) {
		int res = adminBoardMapper.askReplyEdit(dto);
		Map<String,String> map = new HashMap<>();
		map.put("getUser_num", String.valueOf(dto.getUser_num()));
		map.put("sendUser_num", "1");
		map.put("followCheck", "0");
		map.put("alarm_kind", "ask_set");
		map.put("alarm_kind_num", String.valueOf(dto.getQna_num()));
		userAlarmMapper.setAsk(map);
		if(res>0) {
			req.setAttribute("msg", "askReply수정성공!");
			req.setAttribute("url", "QnABoardList.admin");
		}else {
			req.setAttribute("msg", "askReply수정실패!");
			req.setAttribute("url", "askReplyEdit.admin?qna_num="+dto.getQna_num());
		}
		return "message";
	}
	

	
	
	
	@RequestMapping("/pickHashTag.admin")
	public ModelAndView admin_pickHashTag() {
		List<PickHashTagDTO> list = adminBoardMapper.getPickHashTagList();
		return new ModelAndView("admin/board/pickHashTagList","pickList",list);
	}
	
	@PostMapping("/pickHashTagInput.admin")
	@ResponseBody
	public int admin_pickHashTagInput(@RequestParam(value="pick_name" ,required=false)String pick_name){
		int total = adminBoardMapper.countPickHashTag();
		if(total > 10) return -1;
		int count = adminBoardMapper.checkPickHashTag(pick_name);
		if(count != 0) return 0;
		HashTagBaseDTO dto = adminBoardMapper.checkHashTag(pick_name);
		if(dto == null) {
			adminBoardMapper.plusPickHashTag(pick_name);
			adminBoardMapper.addPickHashTag(pick_name);
			System.out.println("새로추가");
			return 1;
		}else {
			adminBoardMapper.addPickHashTag(pick_name);
			System.out.println("있는곳에서 추가");
			return 2;
		}
	}
	
	@RequestMapping("/pickHashTagDel.admin")
	public String admin_pickHashTagDel(int num,HttpServletRequest req) {
		int res = adminBoardMapper.delPickHashTag(num);
		if(res>0) {
			req.setAttribute("msg", "삭제성공!");
		}else {
			req.setAttribute("msg", "삭제실패!");
		}
		req.setAttribute("url", "pickHashTag.admin");
		return "message";
	}
	
	@RequestMapping("/pickSearch.admin")
	public ModelAndView admin_pickSearch() {
		List<PickSearchDTO> list = adminBoardMapper.getPickSearchList();
		return new ModelAndView("admin/board/pickSearchList","pickList",list);
	}
	
	@PostMapping("/pickSearchInput.admin")
	@ResponseBody
	public int admin_pickSearchInput(@RequestParam(value="search_name" ,required=false)String search_name){
		int total = adminBoardMapper.countPickSearch();
		if(total > 10) return -1;
		int count = adminBoardMapper.checkPickSearch(search_name);
		if(count != 0) return 0;
		adminBoardMapper.addPickSearch(search_name);
		return 1;
	}
	
	@RequestMapping("/pickSearchDel.admin")
	public String admin_pickSearchDel(int num,HttpServletRequest req) {
		int res = adminBoardMapper.delPickSearch(num);
		if(res>0) {
			req.setAttribute("msg", "삭제성공!");
		}else {
			req.setAttribute("msg", "삭제실패!");
		}
		req.setAttribute("url", "pickSearch.admin");
		return "message";
	}
	
	
	
	
	
	
	
	
	
	@RequestMapping("/styleList.admin")
	public String admin_styleList(HttpServletRequest req) {
		List<StyleBoardDTO> styleList = adminBoardMapper.styleBoardList();
		List<StyleBoardAllDTO> list = new ArrayList<>();
		for(StyleBoardDTO dto : styleList) {
			StyleBoardAllDTO styledto = adminBoardMapper.styleBoardAllList(dto);
			list.add(styledto);
		}
		System.out.println("스타일 리스트 사이즈:"+list.size());
		req.setAttribute("styleList", list);
		req.setAttribute("upPath", upPath);
		return "admin/board/styleList";
	}
	
}
