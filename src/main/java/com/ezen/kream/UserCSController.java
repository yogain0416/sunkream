package com.ezen.kream;

import java.io.File;
import java.io.IOException;
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

import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;
import com.ezen.kream.dto.QnAImgDTO;
import com.ezen.kream.service.UserCSMapper;

@Controller
public class UserCSController {
	@Autowired
	private UserCSMapper userCSMapper;
	
	@Resource(name = "uploadPath")
	private String upPath;
	
	@RequestMapping("/announce.user")
	public ModelAndView user_announce(HttpServletRequest req,@RequestParam Map<String,String> map) {
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = userCSMapper.getUserQnACount("공지");
		if (endRow>count) endRow = count;
		List<QnABoardAllDTO> list = null;
		if (count>0){
			map.put("qna_cate", "공지");
			map.put("start",String.valueOf(startRow));
			map.put("end",String.valueOf(endRow));
			list = userCSMapper.userQnAList(map);
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
		return new ModelAndView("user/cs/announce","QnABoardList",list);
	}
	
	@RequestMapping("/announceSearch.user")
	public String user_announceSearch(HttpServletRequest req,@RequestParam Map<String,String> map) {
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		req.setAttribute("searchString", map.get("searchString"));
		map.put("searchString","%"+map.get("searchString")+"%");
		map.put("qna_cate", "공지");
		map.put("start",String.valueOf(startRow));
		int count = userCSMapper.getUserSearchCount(map);
		if (endRow>count) endRow = count;
		map.put("end",String.valueOf(endRow));
		List<QnABoardAllDTO> list = null;
		if (count>0){
			list = userCSMapper.faqSearch(map);
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
		req.setAttribute("QnABoardList",list);
		req.setAttribute("mode", "find");
		return "user/cs/announce";
	}
	
	@RequestMapping("/qnaView.user")
	public ModelAndView user_qnaView(int qna_num) {
		QnABoardDTO dto = userCSMapper.getQnABoard(qna_num);
		ModelAndView mav = new ModelAndView("user/cs/QnAView","getBoard",dto);
		List<QnAImgDTO> imgList = userCSMapper.getQnAImg(qna_num);
		mav.addObject("imgList",imgList);
		return mav;
	}
	
	@RequestMapping("/faq.user")
	public String user_faq(HttpServletRequest req,@RequestParam Map<String,String> map) {
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int count = userCSMapper.getUserQnACount("FAQ");
		if (endRow>count) endRow = count;
		List<QnABoardAllDTO> list = null;
		if (count>0){
			map.put("qna_cate", "FAQ");
			map.put("start",String.valueOf(startRow));
			map.put("end",String.valueOf(endRow));
			list = userCSMapper.userQnAList(map);
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
		List<String> subCateList = userCSMapper.faqSubList();
		req.setAttribute("subCateList",subCateList);
		req.setAttribute("QnABoardList",list);
		req.setAttribute("qna_subCate", "All");
		return "user/cs/faq";
	}
	
	@RequestMapping("/faqList.user")
	public String user_faqList(HttpServletRequest req,@RequestParam Map<String,String> map){
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		map.put("qna_cate", "FAQ");
		map.put("start",String.valueOf(startRow));
		int count = userCSMapper.getUserFaqSubCateCount(map);
		if (endRow>count) endRow = count;
		map.put("end",String.valueOf(endRow));
		List<QnABoardAllDTO> list = null;
		if (count>0){
			list = userCSMapper.faqList(map);
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
		List<String> subCateList = userCSMapper.faqSubList();
		req.setAttribute("subCateList",subCateList);
		req.setAttribute("QnABoardList",list);
		req.setAttribute("mode", "list");
		req.setAttribute("qna_subCate", map.get("qna_subCate"));
		return "user/cs/faq";
	}
	
	@RequestMapping("/faqSearch.user")
	public String user_faqSearch(HttpServletRequest req,@RequestParam Map<String,String> map) {
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		req.setAttribute("searchString", map.get("searchString"));
		map.put("searchString","%"+map.get("searchString")+"%");
		map.put("qna_cate", "FAQ");
		map.put("start",String.valueOf(startRow));
		int count = userCSMapper.getUserSearchCount(map);
		if (endRow>count) endRow = count;
		map.put("end",String.valueOf(endRow));
		List<QnABoardAllDTO> list = null;
		if (count>0){
			list = userCSMapper.faqSearch(map);
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
		List<String> subCateList = userCSMapper.faqSubList();
		req.setAttribute("subCateList",subCateList);
		req.setAttribute("QnABoardList",list);
		req.setAttribute("mode", "find");
		req.setAttribute("qna_subCate", "검색");
		return "user/cs/faq";
	}
	
	@RequestMapping("/qna.user")
	public String user_qna(HttpServletRequest req,@RequestParam Map<String,String> map) {
		int pageSize = 10;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		map.put("qna_cate", "1:1문의");
		map.put("start",String.valueOf(startRow));
		int count = userCSMapper.getUserAskCount(map);
		if (endRow>count) endRow = count;
		map.put("end",String.valueOf(endRow));
		List<QnABoardAllDTO> list = null;
		if (count>0){
			list = userCSMapper.qnaList(map);
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
		req.setAttribute("qnaList",list);
		return "user/cs/qna";
	}
	
	@RequestMapping(value="/qnaWriteForm.user",method=RequestMethod.GET)
	public ModelAndView user_qnaWriteForm(@RequestParam(required = false)String report_num) {
		if(report_num != null) {
			String report_name = userCSMapper.getReportName(Integer.parseInt(report_num));
			ModelAndView mav = new ModelAndView("user/cs/qnaWriteForm","report_num", report_num);
			mav.addObject("report_name",report_name);
			return mav;
		}
		List<String> list = userCSMapper.getQnaSubCate();
		return new ModelAndView("user/cs/qnaWriteForm","subCateList", list);
	}

	@RequestMapping(value="/qnaWriteForm.user",method=RequestMethod.POST)
	public String user_qnaWriteFormOk(@ModelAttribute QnABoardDTO dto,HttpServletRequest req,
			MultipartFile mf) {
		dto.setReg_date(userCSMapper.setSysdate());
		int res = userCSMapper.qnaWrite(dto);
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		Iterator<String> it = (Iterator<String>) mr.getFileNames();
		QnAImgDTO imgDTO = new QnAImgDTO();
		if(res>0) {
			int qna_num = userCSMapper.getQnANum(dto.getReg_date());		
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
				int res2 = userCSMapper.QnAImgInput(imgDTO);
				System.out.println("이미지 등록 :"+res2);
			}
			req.setAttribute("msg", "문의글 등록 성공");
			req.setAttribute("url", "qna.user?user_num="+dto.getUser_num());
		}else {
			req.setAttribute("msg", "문의글 등록 실패!");
			req.setAttribute("url", "qnaWriteForm.user?user_num="+dto.getUser_num());
		}
		return "message";
	}

	@RequestMapping("/qnaSearch.user")
	public String user_qnaSearch(HttpServletRequest req,@RequestParam Map<String,String> map) {
		if(map.get("searchString") == null || map.get("searchString").equals("")) 
			return "redirect:qna.user?user_num="+map.get("user_num");
		int pageSize = 5;
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		req.setAttribute("searchString", map.get("searchString"));
		map.put("searchString","%"+map.get("searchString")+"%");
		map.put("qna_cate", "1:1문의");
		map.put("start",String.valueOf(startRow));
		int count = userCSMapper.getUserAskSearchCount(map);
		if (endRow>count) endRow = count;
		map.put("end",String.valueOf(endRow));
		List<QnABoardAllDTO> list = null;
		if (count>0){
			list = userCSMapper.askSearch(map);
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
		req.setAttribute("qnaList",list);
		req.setAttribute("mode", "find");
		return "user/cs/qna";
	}

	@RequestMapping(value = "/qnaEditForm.user",method = RequestMethod.GET)
	public String user_qnaEditForm(HttpServletRequest req,int qna_num) {
		QnABoardDTO dto = userCSMapper.getQnABoard(qna_num);
		List<QnAImgDTO> imgList = userCSMapper.getQnAImg(qna_num);
		req.setAttribute("imgList", imgList);
		req.setAttribute("getBoard",dto);
		return "user/cs/qnaEditForm";
	}
	
	@RequestMapping(value = "/qnaEditForm.user",method = RequestMethod.POST)
	public String user_qnaEditFormOk(@ModelAttribute QnABoardDTO dto,HttpServletRequest req
			,BindingResult result, MultipartFile file, String[] file_img) {
		List<QnAImgDTO> imgList = userCSMapper.getQnAImg(dto.getQna_num());
		if(file_img != null) {
			for(QnAImgDTO imgDTO : imgList) {
				int co = 0;
				for(String img : file_img) {
					if(img.equals(imgDTO.getQna_img())) {
						co++;
						break;
					}
				}
				if(co != 1 && co != 0) {
					int res = userCSMapper.QnAImgDelete(imgDTO);
					if(res>0) System.out.println("기존이미지 삭제 성공!");
					else System.out.println("기존이미지 삭제 실패!");
				}
			}	
		}else {
			int res = userCSMapper.QnAImgDeleteAll(dto.getQna_num());
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
			int res = userCSMapper.QnAImgInput(imgDTO);
			if(res>0)System.out.println("수정 이미지 등록 성공!");
			else System.out.println("수정 이미지 등록 실패!");
		}
		int res = userCSMapper.QnABoardEdit(dto);
		if(res>0) {
			req.setAttribute("msg", "QnABoard수정성공!");
			req.setAttribute("url", "qna.user?user_num="+dto.getUser_num());
		}else {
			req.setAttribute("msg", "QnABoard수정실패!");
			req.setAttribute("url", "qnaView.user?qna_num="+dto.getQna_num());
		}
		return "message";
	}

}
