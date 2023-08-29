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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.kream.dto.FollowCheckDTO;
import com.ezen.kream.dto.HashTagBaseDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.dto.ProdSearchDTO;
import com.ezen.kream.dto.ReplyAllDTO;
import com.ezen.kream.dto.StyleBoardAllDTO;
import com.ezen.kream.dto.StyleBoardDTO;
import com.ezen.kream.dto.StyleImgDTO;
import com.ezen.kream.dto.StyleReplyDTO;
import com.ezen.kream.service.UserAlarmMapper;
import com.ezen.kream.service.UserStyleMapper;

@Controller
public class UserStyleController {
	@Autowired
	private UserStyleMapper userStyleMapper;
	@Autowired
	private UserAlarmMapper userAlarmMapper;
	@Resource(name = "uploadPath")
	private String upPath;

	@RequestMapping("/styleFollowing.user")
	public String user_styleFollowing(HttpSession session, HttpServletRequest req) {
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}else {
			return "redirect:main.login";
		}
		List<StyleBoardAllDTO> list = userStyleMapper.styleFollowing(user_num);
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				if(co == 4)break;
				List<String> contentList = new ArrayList<>();
				List<String> writerList = new ArrayList<>();
				List<HashTagBaseDTO> hashTagList = new ArrayList<>();
				if (dto.getStyle_contents() == null || dto.getStyle_contents().trim().equals("")) {
				} else {
					viewContents(dto.getStyle_contents(), contentList, writerList, hashTagList);// 뽑을 때 해시태그와 언급 눌릴 수 있게
				}
				dto.setContentList(contentList);
				dto.setWriterList(writerList);
				dto.setHashTagList(hashTagList);
				List<ProdSearchDTO> prod_tag_list = userStyleMapper.getProdTag(dto.getStyle_num());
				dto.setProd_tag_list(prod_tag_list);
				int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);// 서로 팔로잉 되어있는지
				dto.setCheckFollowing(checkFollowing);
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);// 좋아요 눌렀는지
				dto.setCheckLike(checkLike);
				co++;
				realList.add(dto);
			}
			req.setAttribute("listSize", list.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		
		req.setAttribute("list", realList);
		return "user/style/styleFollowing";
	}
	
	@PostMapping("/styleFollowingScroll.user")
	public String user_styleFollowingScroll(@RequestParam (value="count",required = false) int count
			,HttpSession session, HttpServletRequest req) {
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		List<StyleBoardAllDTO> list = userStyleMapper.styleFollowing(user_num);
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				if(co == count) break;
				List<String> contentList = new ArrayList<>();
				List<String> writerList = new ArrayList<>();
				List<HashTagBaseDTO> hashTagList = new ArrayList<>();
				if (dto.getStyle_contents() == null || dto.getStyle_contents().trim().equals("")) {
				} else {
					viewContents(dto.getStyle_contents(), contentList, writerList, hashTagList);// 뽑을 때 해시태그와 언급 눌릴 수 있게
				}
				dto.setContentList(contentList);
				dto.setWriterList(writerList);
				dto.setHashTagList(hashTagList);
				List<ProdSearchDTO> prod_tag_list = userStyleMapper.getProdTag(dto.getStyle_num());
				dto.setProd_tag_list(prod_tag_list);
				int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);// 서로 팔로잉 되어있는지
				dto.setCheckFollowing(checkFollowing);
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);// 좋아요 눌렀는지
				dto.setCheckLike(checkLike);
				co++;
				realList.add(dto);
			}
		}
		req.setAttribute("list", realList);
		req.setAttribute("count", count);
		return "user/style/styleFollowingScroll";
	}

	@RequestMapping("/styleProdTag.user")
	public String user_styleProdTag(String cate, HttpServletRequest req, HttpSession session, String subType,
			String mode) {
		//cate는 대분류 subType은 소분류 mode는 최신순,인기순(디폴트값)		
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		if (subType == null || subType.trim().equals("")) {
			subType = "all";
		}
		if (mode == null || mode.trim().equals("")) {
			mode = "pop";	//인기순
		}
		List<ProdCateDTO> subList = userStyleMapper.style_cate_subtype(cate);
		List<StyleBoardAllDTO> list = userStyleMapper.styleProdTag(cate, subType, mode);
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				if(co == 8) break;
				int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);//서로 차단여부 확인 차단당했든 차단했든 상대방 게시글 안뜸
				int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
				if (checkBan == 1 || checkBan1 == 1) {
					dto.setCheckBan(1); //차단
				} else {
					dto.setCheckBan(2);
				}
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);
				dto.setCheckLike(checkLike);
				String contents = dto.getStyle_contents();
				if (contents == null || contents.trim().equals("")) {
					dto.setStyle_contents("");
				} else {
					String conArr[] = contents.split("<br>"); //뽑을 때 다 붙여서 한줄만 나오게 하고 길면 ... 하려고 =>style적용시에 엔터 없애기 하려면 <br>로 저장된거 "\n"으로 바꿈
					String newContents = "";
					for (int i = 0; i < conArr.length - 1; i++) {
						newContents = newContents + conArr[i] + "\n";
					}
					newContents = newContents + conArr[conArr.length - 1];
					dto.setStyle_contents(newContents);
				}
				co++;
				realList.add(dto);
			}
			req.setAttribute("listSize", list.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		
		req.setAttribute("cate", cate);
		req.setAttribute("subType", subType);
		req.setAttribute("mode", mode);
		req.setAttribute("subList", subList);
		req.setAttribute("prodTag", "prodTag");
		req.setAttribute("list", realList);
		return "user/style/styleProdTag";
	}
	
	@PostMapping("/styleProdTagScroll.user")
	public String user_styleProdTagScroll(@RequestParam Map<String,String> map
			, HttpServletRequest req, HttpSession session) {
		//cate는 대분류 subType은 소분류 mode는 최신순,인기순(디폴트값)		
		System.out.println("styleProdTagScroll들어옴");
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		if (map.get("subType").trim().equals("")) {
			map.put("subType", "all");
		}
		if (map.get("mode").trim().equals("")) {
			map.put("mode", "pop");	//인기순
		}
		List<ProdCateDTO> subList = userStyleMapper.style_cate_subtype(map.get("cate"));
		List<StyleBoardAllDTO> list = userStyleMapper.styleProdTag(map.get("cate"), map.get("subType"), map.get("mode"));
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				if(co == Integer.parseInt(map.get("count"))) break;
				int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);//서로 차단여부 확인 차단당했든 차단했든 상대방 게시글 안뜸
				int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
				if (checkBan == 1 || checkBan1 == 1) {
					dto.setCheckBan(1); //차단
				} else {
					dto.setCheckBan(2);
				}
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);
				dto.setCheckLike(checkLike);
				String contents = dto.getStyle_contents();
				if (contents == null || contents.trim().equals("")) {
					dto.setStyle_contents("");
				} else {
					String conArr[] = contents.split("<br>"); //뽑을 때 다 붙여서 한줄만 나오게 하고 길면 ... 하려고 =>style적용시에 엔터 없애기 하려면 <br>로 저장된거 "\n"으로 바꿈
					String newContents = "";
					for (int i = 0; i < conArr.length - 1; i++) {
						newContents = newContents + conArr[i] + "\n";
					}
					newContents = newContents + conArr[conArr.length - 1];
					dto.setStyle_contents(newContents);
				}
				co++;
				realList.add(dto);
			}
		}
		req.setAttribute("cate", map.get("cate"));
		req.setAttribute("subType", map.get("subType"));
		req.setAttribute("mode", map.get("mode"));
		req.setAttribute("count", map.get("count"));
		req.setAttribute("subList", subList);
		req.setAttribute("prodTag", "prodTag");
		req.setAttribute("list", list);
		return "user/style/styleProdTagScroll";
	}
	

	@RequestMapping("/styleRanking.user")
	public String user_styleRanking(String mode, HttpServletRequest req, HttpSession session) {
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		List<StyleBoardAllDTO> list = null;
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (mode == null || mode.equals("weekly")) {
			mode = "weekly";
			list = userStyleMapper.userStyleRanking("weekly");
			if(list != null) {
				for (StyleBoardAllDTO dto : list) {
					if(co == 5) break;
					int followerSu = userStyleMapper.countFollower(dto.getUser_num());//팔로워수 뽑기
					dto.setFollowerSu(followerSu);
					int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);
					dto.setCheckFollowing(checkFollowing);
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					co++;
					realList.add(dto);
				}
				req.setAttribute("listSize", list.size());
			}else {
				req.setAttribute("listSize", 0);
			}
		} else {
			list = userStyleMapper.userStyleRanking(mode);
			if(list != null) {
				for (StyleBoardAllDTO dto : list) {
					if(co == 4);
					int followerSu = userStyleMapper.countFollower(dto.getUser_num());
					dto.setFollowerSu(followerSu);
					int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);
					dto.setCheckFollowing(checkFollowing);
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					co++;
					realList.add(dto);
				}
				req.setAttribute("listSize", list.size());
			}else {
				req.setAttribute("listSize", 0);
			}
		}
		req.setAttribute("mode", mode);
		req.setAttribute("list", realList);
		return "user/style/styleRanking";
	}
	
	@RequestMapping("/styleRankingScroll.user")
	public String user_styleRankingScroll(@RequestParam Map<String,String> map, HttpServletRequest req, HttpSession session) {
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		List<StyleBoardAllDTO> list = null;
		List<StyleBoardAllDTO> realList = new ArrayList<>();
		int co = 0;
		if (map.get("mode").equals("") || map.get("mode").equals("weekly")) {
			map.put("mode", "weekly");
			list = userStyleMapper.userStyleRanking("weekly");
			if(list != null) {
				for (StyleBoardAllDTO dto : list) {
					if(co == Integer.parseInt(map.get("count"))) break;
					int followerSu = userStyleMapper.countFollower(dto.getUser_num());//팔로워수 뽑기
					dto.setFollowerSu(followerSu);
					int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);
					dto.setCheckFollowing(checkFollowing);
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					co++;
					realList.add(dto);
				}
				req.setAttribute("listSize", list.size());
			}else {
				req.setAttribute("listSize", 0);
			}
		} else {
			list = userStyleMapper.userStyleRanking(map.get("mode"));
			if(list != null) {
				for (StyleBoardAllDTO dto : list) {
					if(co == Integer.parseInt(map.get("count"))) break;
					int followerSu = userStyleMapper.countFollower(dto.getUser_num());
					dto.setFollowerSu(followerSu);
					int checkFollowing = userStyleMapper.checkFollowing(dto.getUser_num(), user_num);
					dto.setCheckFollowing(checkFollowing);
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					co++;
					realList.add(dto);
				}
				req.setAttribute("listSize", list.size());
			}else {
				req.setAttribute("listSize", 0);
			}
		}
		req.setAttribute("count", map.get("count"));
		req.setAttribute("list", realList);
		return "user/style/styleRankingScroll";
	}
	

	@RequestMapping("/style.user")
	public String user_style(HttpServletRequest req, String mode, HttpSession session) {
		//인기순(디폴트값) 최신순
		req.setAttribute("upPath", upPath);
		List<String> pickHashTag = userStyleMapper.getPickHashTag();//관리자 추천해시태그 가져오기
		List<String> showHashTagList = new ArrayList<String>();
		if (pickHashTag != null) {
			for (String name : pickHashTag) {
				showHashTagList.add(name);
			}
		}
		req.setAttribute("showHashTagList", showHashTagList);
		List<StyleBoardAllDTO> list = null;
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		if (mode == null) {
			list = userStyleMapper.stylePopular();
			if (list != null) {
				for (StyleBoardAllDTO dto : list) {
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					// 좋아요 된것 1 아직 좋아요 안된것 2
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
		} else {
			list = userStyleMapper.styleNew();
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
		}
		if(list != null) {
			req.setAttribute("listSize", list.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		req.setAttribute("List", list);
		req.setAttribute("mode", mode);
		return "user/style/style";
	}
	
	@PostMapping("/styleScroll.user")
	public String user_styleScroll(HttpServletRequest req,HttpSession session
				,@RequestParam Map<String,String> map) {
		List<String> pickHashTag = userStyleMapper.getPickHashTag();//관리자 추천해시태그 가져오기
		List<String> showHashTagList = new ArrayList<String>();
		if (pickHashTag != null) {
			for (String name : pickHashTag) {
				showHashTagList.add(name);
			}
		}
		req.setAttribute("showHashTagList", showHashTagList);
		List<StyleBoardAllDTO> list = null;
		int user_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			user_num = (int) session.getAttribute("sessionUser_num");
		}
		
		if (map.get("mode").equals("")) {
			list = userStyleMapper.stylePopular();
			if (list != null) {
				for (StyleBoardAllDTO dto : list) {
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						dto.setCheckBan(1);
					} else {
						dto.setCheckBan(2);
					}
					// 좋아요 된것 1 아직 좋아요 안된것 2
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
		} else if(map.get("mode").equals("new")){
			list = userStyleMapper.styleNew();
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
		}
		req.setAttribute("count", map.get("count"));
		req.setAttribute("List", list);
		return "user/style/styleScroll";
	}
	
	

	@RequestMapping(value = "/styleWrite.user", method = RequestMethod.GET)
	public String user_styleWriteForm(HttpServletRequest req, @RequestParam(required = false) String mode) {
		if (mode == null)
			mode = "style";
		if (mode.equals("my"))
			return "user/my/styleWriteForm";
		else
			return "user/style/styleWriteForm";
	}

	@RequestMapping("/styleBoardDelete.user")
	public String user_styleBoardDelete(int styleNum, HttpSession session) {
		userStyleMapper.styleBoardDelete(styleNum);
		int user_num = (int) session.getAttribute("sessionUser_num");
		return "forward:myProfile.user?user_num=" + user_num;
	}

	@RequestMapping(value = "/styleSearch.user", method = RequestMethod.GET)
	public String user_SearchForm() {
		return "user/style/searchForm";
	}

	@RequestMapping(value = "/styleBoardSearch.user")
	public String user_styleSearch(HttpServletRequest req, @RequestParam(required = false) String search,
			HttpSession session) {
		req.setAttribute("upPath", upPath);
		if (search == null || search.trim().equals("")) {
			System.out.println("안넘어옴");
			return "redirect:styleSearch.user";
		}
		if (search.charAt(0) == '#') {
			int user_num = 0;
			if (session.getAttribute("sessionUser_num") != null) {
				user_num = (int) session.getAttribute("sessionUser_num");
			}
			String searchString = search.substring(1).trim();
			List<StyleBoardDTO> list = new ArrayList<StyleBoardDTO>();
			list = userStyleMapper.getHasgTagStyleBoard(searchString);
			List<StyleBoardAllDTO> styleBoardAllList = new ArrayList<>();
			if (list != null) {
				for (StyleBoardDTO dto : list) {
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						continue;
					}
					StyleBoardAllDTO styleBoardAlldto = new StyleBoardAllDTO();
					styleBoardAlldto = userStyleMapper.getStyleBoardAll(dto);
					int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);
					styleBoardAlldto.setCheckLike(checkLike);
					styleBoardAllList.add(styleBoardAlldto);
					String contents = styleBoardAlldto.getStyle_contents();
					String conArr[] = contents.split("<br>");
					String newContents = "";
					for (int i = 0; i < conArr.length - 1; i++) {
						newContents = newContents + conArr[i] + "\n";
					}
					newContents = newContents + conArr[conArr.length - 1];
					styleBoardAlldto.setStyle_contents(newContents);
				}
			}
			if(styleBoardAllList != null) {
				req.setAttribute("listSize", styleBoardAllList.size());
			}
			req.setAttribute("styleBoardAllList", styleBoardAllList);

		} else if (search.charAt(0) == '@') {
			String searchString = search.substring(1).trim();
			int user_num = userStyleMapper.getStyleUserNum(searchString);
			return "forward:myProfile.user?user_num=" + user_num;
		}
		req.setAttribute("search", search);
		return "user/style/styleBoard";
	}
	
	@PostMapping("/styleBoardScroll.user")
	public String user_styleBoardScroll(HttpServletRequest req,HttpSession session,
				@RequestParam Map<String,String> map) {
		if (map.get("search").charAt(0) == '#') {
			int user_num = 0;
			if (session.getAttribute("sessionUser_num") != null) {
				user_num = (int) session.getAttribute("sessionUser_num");
			}
			String searchString = map.get("search").substring(1).trim();
			List<StyleBoardDTO> list = new ArrayList<StyleBoardDTO>();
			list = userStyleMapper.getHasgTagStyleBoard(searchString);
			List<StyleBoardAllDTO> styleBoardAllList = new ArrayList<>();
			if (list != null) {
				for (StyleBoardDTO dto : list) {
					int checkBan = userStyleMapper.checkBan(dto.getUser_num(), user_num);
					int checkBan1 = userStyleMapper.checkBan(user_num, dto.getUser_num());
					if (checkBan == 1 || checkBan1 == 1) {
						continue;
					}
					StyleBoardAllDTO styleBoardAlldto = new StyleBoardAllDTO();
					styleBoardAlldto = userStyleMapper.getStyleBoardAll(dto);
					int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), user_num);
					styleBoardAlldto.setCheckLike(checkLike);
					styleBoardAllList.add(styleBoardAlldto);
					String contents = styleBoardAlldto.getStyle_contents();
					String conArr[] = contents.split("<br>");
					String newContents = "";
					for (int i = 0; i < conArr.length - 1; i++) {
						newContents = newContents + conArr[i] + "\n";
					}
					newContents = newContents + conArr[conArr.length - 1];
					styleBoardAlldto.setStyle_contents(newContents);
				}
			}
			req.setAttribute("styleBoardAllList", styleBoardAllList);

		} else if (map.get("search").charAt(0) == '@') {
			String searchString = map.get("search").substring(1).trim();
			int user_num = userStyleMapper.getStyleUserNum(searchString);
			return "forward:myProfile.user?user_num=" + user_num;
		}
		req.setAttribute("search", map.get("search"));
		req.setAttribute("count", map.get("count"));
		return "user/style/styleBoardScroll";
	}
	

	@PostMapping("/searchCheckHash")//searchForm에서 #해시태그 목록띄우기
	@ResponseBody
	public List<HashTagBaseDTO> searchCheckHash(@RequestParam(value = "search", required = false) String search,
			HttpSession session) {

		List<HashTagBaseDTO> list = userStyleMapper.CheckSearchHashTag(search);

		return list;
	}

	@PostMapping("/searchCheckNick")//searchForm에서 @회원 목록띄우기
	@ResponseBody
	public List<MemberDTO> searchCheckNick(@RequestParam(value = "search", required = false) String search) {

		List<MemberDTO> list = userStyleMapper.CheckSearchNick(search);
		return list;
	}

	@RequestMapping(value = "/styleWrite.user", method = RequestMethod.POST)
	public String user_styleWrite(HttpSession session, HttpServletRequest req, @ModelAttribute StyleBoardDTO dto,
			BindingResult result, MultipartFile mf, String[] prod_num, @RequestParam(required = false) String mode) {
		if (mode == null)
			mode = "style";
		List<String> list = new ArrayList<>();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
		Iterator<String> it = (Iterator<String>) mr.getFileNames();
		StyleImgDTO imgdto = new StyleImgDTO();
		while (it.hasNext()) {
			String img = it.next();
			mf = mr.getFile(img);
			String real = mf.getOriginalFilename();
			File file = new File(upPath, real);
			if (mf.getSize() != 0) {
				if (!file.exists()) {
					file.mkdirs();
				}
				try {
					mf.transferTo(file);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
			System.out.println(real);
			if (real == null || real.equals("")) {
				break;
			}
			list.add(real);
			if (imgdto.getStyle_img1() == null) {
				imgdto.setStyle_img1(real);
			} else if (imgdto.getStyle_img2() == null) {
				imgdto.setStyle_img2(real);
			} else if (imgdto.getStyle_img3() == null) {
				imgdto.setStyle_img3(real);
			} else if (imgdto.getStyle_img4() == null) {
				imgdto.setStyle_img4(real);
			} else if (imgdto.getStyle_img5() == null) {
				imgdto.setStyle_img5(real);
			}

		}
		if (imgdto.getStyle_img1() == null)
			imgdto.setStyle_img1("");
		if (imgdto.getStyle_img2() == null)
			imgdto.setStyle_img2("");
		if (imgdto.getStyle_img3() == null)
			imgdto.setStyle_img3("");
		if (imgdto.getStyle_img4() == null)
			imgdto.setStyle_img4("");
		if (imgdto.getStyle_img5() == null)
			imgdto.setStyle_img5("");
		System.out.println(list.size());
		int user_num = (int) session.getAttribute("sessionUser_num");
		int res = userStyleMapper.styleWrite(user_num, dto, imgdto, prod_num);
		if (res > 0) {
			req.setAttribute("msg", "게시글 등록 성공");
		} else if (res < 0) {
			req.setAttribute("msg", "게시글 등록 실패");
		}
		// myProfile
		if (mode.equals("my"))
			req.setAttribute("url", "myProfile.user?user_num=" + user_num + "&mode=my");
		else
			req.setAttribute("url", "myProfile.user?user_num=" + user_num);

		return "message";
	}

	public void viewContents(String contents, List<String> contentList, List<String> writerList,
			List<HashTagBaseDTO> hashTagList) {
		String str[] = contents.split(" ");
		for (int i = 0; i < str.length; i++) {
			//System.out.println("띄어쓰기로 스필릿한 후 :" + i + "번쨰" + str[i]);
			String str1[] = str[i].split("<br>");
			if (str1.length == 1) {
				String str2[] = str1[0].split("@");// 단어를 @를 기준으로 스플릿해본다.
				if (str2.length > 1) {// @가 없는데 @를 기준으로 스플릿하면 그냥 원래 단어 그대로이기에 길이가 1
					contentList.add(str2[0]);// 1보다 크면 @가 하나라도 있다는 뜻이기에 @를 기준으로 0부분은 @앞부분이라 앞부분을 contentList에 넣기
					// 이렇게 하는 이유는 : 에를들어 나는 최@곰구일 을 부른다. 에서
					// 최@곰구일 이란 단어를 최,@곰구일을 나눠서 contentList에 넣을려고 한다.
					for (int j = 1; j < str2.length; ++j) {// 0부분은 최에 해당하기에 1부터 확인하기
						if (str2[j].trim().equals("")) {// 최@@구일 이라고 나오는 경우 1부분이 빈칸이랑 같기때문에 빈칸만 따로 스플릿해서
														// contentList에 넣기
							contentList.add("@");// 스플릿만해서 넣으면 빈칸이기때문에 @를 붙여서 넣기 그래야 최,@ 이렇게 두개를 넣을수 있다.
							continue;// 빈칸이면 밑애꺼에서 언급부분을 찾고 writerList에 넣는부분을 할 필요가 없으므로 continue로 다시 for문 가동.
						}
						String writer = str2[j];// 빈칸이 아니면 그부분은 언급부분이기 때문에 writer라고 스트링값으로 설정
						int count = userStyleMapper.searchWriter(writer);
						//System.out.println("count" + count);
						if (count > 0)
							writerList.add(writer);
						contentList.add("@" + writer);// 그리고 최@@구일 에서 구일만 넣지 않고 @구일 이라고 넣어야하기때문에 @를 붙이고 contentList에
														// 넣어준다.
					}
					continue;// @언급부분이 있었던 것이기 때문에 @스플릿을 실행하면 다시 단어 나눈걸로 이동.
				}
				String str3[] = str1[0].split("#");// 단어를 #를 기준으로 스플릿
				if (str3.length > 1) {// 위에서 설명한것과 동일
					contentList.add(str3[0]);
					for (int u = 1; u < str3.length; ++u) {
						if (str3[u].trim().equals("")) {
							contentList.add("#");
							continue;
						}
						String hashTag = str3[u];
						HashTagBaseDTO hashTagBaseDTO = userStyleMapper.getHashTag(hashTag);// 해시태그DTO에 저장되어있는
																							// 해시태그DTO를
																							// 가져옴
						// 왜냐하면 우리가 해시태그를 눌렸을때 이동하기 위해서 해시태그 고유 번호가 필요하기때문에
						hashTagList.add(hashTagBaseDTO);// DTO를 hashTagList에 넣어준다.

						contentList.add("#" + hashTag);
					}
					continue;
				}
				contentList.add(str1[0]);// #,@ 둘다 안된 단어 추가하기.
			} else if (str1.length > 1) {
				for (int k = 0; k < str1.length; k++) {
					String str2[] = str1[k].split("@");
					if (str2.length > 1) {
						contentList.add(str2[0]);
						for (int j = 1; j < str2.length; ++j) {
							if (str2[j].trim().equals("")) {
								contentList.add("@");
								continue;
							}
							String writer = str2[j];// 빈칸이 아니면 그부분은 언급부분이기 때문에 writer라고 스트링값으로 설정
							int count = userStyleMapper.searchWriter(writer);
							//System.out.println("count:" + count);
							if (count > 0)
								writerList.add(writer);
							// 그리고 최@@구일 에서 구일만 넣지 않고 @구일 이라고 넣어야하기때문에 @를 붙이고 contentList에
							// 넣어준다.
							if (k < str1.length - 1) {
								contentList.add("@" + writer);
								contentList.add("<br>");
							} else {
								contentList.add("@" + writer);
							}
						}
						continue;
					}
					String str3[] = str1[k].split("#");
					if (str3.length > 1) {
						contentList.add(str3[0]);
						for (int u = 1; u < str3.length; ++u) {
							if (str3[u].trim().equals("")) {
								contentList.add("#");
								continue;
							}
							String hashTag = str3[u];
							//System.out.println("해시태그 : #" + hashTag);
							HashTagBaseDTO hashTagBaseDTO = userStyleMapper.getHashTag(hashTag);// 해시태그DTO에 저장되어있는
																								// 해시태그DTO를
																								// 가져옴
							hashTagList.add(hashTagBaseDTO);
							if (k < str1.length - 1) {
								contentList.add("#" + hashTag);
								contentList.add("<br>");
							} else {
								contentList.add("#" + hashTag);
							}
						}
						continue;
					}
					if (k < str1.length - 1) {
						contentList.add(str1[k]);
						contentList.add("<br>");
					} else {
						contentList.add(str1[k]);// #,@ 둘다 안된 단어 추가하기.
					}
				}
			}

		}
	}

	@RequestMapping("/styleView.user")
	public String user_styleView(int styleNum, int userNum, HttpServletRequest req, HttpSession session) {
		req.setAttribute("upPath", upPath);
		StyleBoardAllDTO styleBoardAlldto = new StyleBoardAllDTO();
		StyleBoardDTO dto = new StyleBoardDTO();
		dto.setStyle_num(styleNum);
		dto.setUser_num(userNum);
		List<ProdSearchDTO> prod_tag_list = userStyleMapper.getProdTag(styleNum);
		styleBoardAlldto = userStyleMapper.getStyleBoardAll(dto);
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
			int checkFollowing = userStyleMapper.checkFollowing(userNum, my_num);
			req.setAttribute("checkFollowing", checkFollowing);
		}
		int checkLike = userStyleMapper.checkLike(styleNum, my_num);
		styleBoardAlldto.setCheckLike(checkLike);
		List<String> contentList = new ArrayList<>();// 글 내용을 단어마다 스플릿해서 contentList에 넣을것이다.
		List<String> writerList = new ArrayList<>();// @Id 되어있는 것만 writerList에 넣을것이다.
		List<HashTagBaseDTO> hashTagList = new ArrayList<>();// #hashTag 되어있는 것만 hashTagList에 넣을것이다.
		System.out.println("contents:" + styleBoardAlldto.getStyle_contents());
		if (styleBoardAlldto.getStyle_contents() == null || styleBoardAlldto.getStyle_contents().trim().equals("")) {
		} else {

			viewContents(styleBoardAlldto.getStyle_contents(), contentList, writerList, hashTagList);
		}
		req.setAttribute("writerList", writerList);
		req.setAttribute("hashTagList", hashTagList);
		req.setAttribute("contentList", contentList);
		req.setAttribute("getBoard", styleBoardAlldto);// 다 req에 저장해서 content로 보내기
		req.setAttribute("prod_tag_list", prod_tag_list);
		req.setAttribute("prod_tag_su", prod_tag_list.size());
		req.setAttribute("styleBoardAlldto", styleBoardAlldto);
		return "user/style/styleView";
	}

	@PostMapping("/likeStyle.user")
	@ResponseBody
	public int user_likeStyle(int styleNum, HttpSession session) {
		int user_num = (int) session.getAttribute("sessionUser_num");
		int get_num = userAlarmMapper.getStyleBoardUserNum(styleNum);
		userStyleMapper.likeStyle(styleNum, user_num);
		Map<String, String> map = new HashMap<>();
		map.put("sendUser_num", String.valueOf(user_num));
		map.put("getUser_num", String.valueOf(get_num));
		map.put("alarm_kind", "like");
		map.put("alarm_kind_num", String.valueOf(styleNum));
		map.put("followCheck", "0");
		map.put("info", "");
		userAlarmMapper.insertAlarm(map);
		int likeSu = userStyleMapper.getLikeSu(styleNum);
		return likeSu;
	}

	@PostMapping("/removeLikeStyle.user")
	@ResponseBody
	public int user_removeLikeStyle(int styleNum, HttpSession session) {
		int user_num = (int) session.getAttribute("sessionUser_num");
		userStyleMapper.removeLikeStyle(styleNum, user_num);
		int likeSu = userStyleMapper.getLikeSu(styleNum);
		return likeSu;
	}

	@RequestMapping(value = "/styleReply.user", method = RequestMethod.GET)
	public String user_styleReply(int styleNum, HttpServletRequest req) {

		StyleBoardAllDTO styleBoardAllDTO = userStyleMapper.getContents(styleNum);
		String contents = styleBoardAllDTO.getStyle_contents();
		System.out.println("reply+" + contents);
		List<String> contentList = new ArrayList<>();
		List<String> writerList = new ArrayList<>();
		List<HashTagBaseDTO> hashTagList = new ArrayList<>();
		if (contents == null || contents.trim().equals("")) {
		} else {
			viewContents(contents, contentList, writerList, hashTagList);
		}
		List<ReplyAllDTO> replyList = userStyleMapper.getAllReply(styleNum);
		for (ReplyAllDTO replyDTO : replyList) {
			List<String> replyContentList = new ArrayList<>();
			List<String> replyWriterList = new ArrayList<>();
			List<HashTagBaseDTO> replyHashTagList = new ArrayList<>();
			viewContents(replyDTO.getReply_contents(), replyContentList, replyWriterList, replyHashTagList);
			replyDTO.setReplyContentList(replyContentList);
			replyDTO.setReplyHashTagList(replyHashTagList);
			replyDTO.setReplyWriterList(replyWriterList);
		}
		req.setAttribute("styleBoardAllDTO", styleBoardAllDTO);
		req.setAttribute("writerList", writerList);
		req.setAttribute("hashTagList", hashTagList);
		req.setAttribute("contentList", contentList);
		req.setAttribute("replyList", replyList);
		System.out.println("get");
		return "user/style/styleReply";
	}

	@RequestMapping(value = "/updateBoard.user", method = RequestMethod.GET)
	public String user_updateBoard(int style_num, HttpServletRequest req) {
		List<ProdSearchDTO> prod_tag_list = userStyleMapper.getProdTag(style_num);
		StyleBoardAllDTO dto = userStyleMapper.updateBoard(style_num);
		String conArr[] = dto.getStyle_contents().split("<br>");
		String newContents = "";
		for (int i = 0; i < conArr.length - 1; i++) {
			newContents = newContents + conArr[i] + "\n";
		}
		newContents = newContents + conArr[conArr.length - 1];
		dto.setStyle_contents(newContents);
		req.setAttribute("prod_tag_list", prod_tag_list);
		req.setAttribute("dto", dto);
		return "user/style/updateForm";
	}

	@RequestMapping(value = "/updateBoard.user", method = RequestMethod.POST)
	public String user_updateBoardOk(StyleBoardDTO dto, String ex_style_contents) {
		userStyleMapper.deleteHash(ex_style_contents, dto.getReg_date());
		dto.setStyle_contents(dto.getStyle_contents());
		userStyleMapper.updateBoardOk(dto);
		userStyleMapper.insertHash(dto);

		return "redirect:styleView.user?userNum=" + dto.getUser_num() + "&styleNum=" + dto.getStyle_num();
	}

	@RequestMapping("/deleteReply.user")
	public String user_deleteReply(int reply_num, int style_num, String mode) {
		System.out.println("deletereply 옴 reply_num" + reply_num + "style_num" + style_num + "mode" + mode);
		userStyleMapper.deleteReply(reply_num, mode);
		return "redirect:styleReply.user?styleNum=" + style_num;
	}

	@RequestMapping(value = "/styleReply.user", method = RequestMethod.POST)
	public String user_styleReplyOk(int styleNum, String reply, HttpServletRequest req, HttpSession session,
			@RequestParam(required = false) String group) {
		if (session.getAttribute("sessionUser_num") == null) {
			req.setAttribute("url", "main.login");
			return "user/style/closeAndGo";
		}
		StyleReplyDTO replyDTO = new StyleReplyDTO();
		int user_num = (int) session.getAttribute("sessionUser_num");

		replyDTO.setUser_num(user_num);
		replyDTO.setReply_contents(reply);
		replyDTO.setStyle_num(styleNum);
		Map<String,String> map = new HashMap<>();
		
		map.put("sendUser_num", String.valueOf(user_num));
		map.put("followCheck", "0");
		if (group == null || group.trim().equals("")) {
			replyDTO.setReply_step(0);
			int regroup = userStyleMapper.maxRegroup(styleNum);
			replyDTO.setReply_group(regroup);
			map.put("alarm_kind", "style_reply");
			map.put("alarm_kind_num", String.valueOf(replyDTO.getStyle_num()));
			int get_user = userAlarmMapper.getStyleBoardUserNum(styleNum);
			map.put("getUser_num",String.valueOf(get_user));
			System.out.println("댓글달때");
		} 
		else {
			int restep = userStyleMapper.maxRestep(styleNum, Integer.parseInt(group));
			replyDTO.setReply_group(Integer.parseInt(group));
			replyDTO.setReply_step(restep);
			map.put("alarm_kind", "style_reReply");
			map.put("alarm_kind_num", String.valueOf(replyDTO.getStyle_num()));
			String[] str = replyDTO.getReply_contents().split(" ");
			String name = str[0].split("@")[1];
			int getUser_num = userAlarmMapper.getRereplyUserNum(name);
			map.put("getUser_num", String.valueOf(getUser_num));
			System.out.println("대댓글 달때");
		}
		map.put("info", "");
		userAlarmMapper.insertAlarm(map);
		userStyleMapper.styleReplyOk(replyDTO);
		// req.setAttribute("styleNum", styleNum);
		return "redirect:styleReply.user?styleNum=" + styleNum;
	}

	@RequestMapping("/likeList.user")
	public String user_likeList(int style_num, HttpSession session, HttpServletRequest req) {
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		List<FollowCheckDTO> likeList = userStyleMapper.likeList(style_num, my_num);
		if(likeList != null) {
			req.setAttribute("listSize", likeList.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		req.setAttribute("style_num", style_num);
		req.setAttribute("list", likeList);
		req.setAttribute("mode", "like");
		return "user/style/followList";
	}

	@RequestMapping("/followList.user")
	public String user_followList(int userNum, String mode, HttpServletRequest req, HttpSession session) {
		req.setAttribute("upPath", upPath);
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		
		List<FollowCheckDTO> list = null;
		if (mode.equals("follower")) {
			list = userStyleMapper.getFollower(userNum, my_num);
		} else if (mode.equals("following")) {
			list = userStyleMapper.getFollowing(userNum, my_num);
		}
		if(list != null) {
			req.setAttribute("listSize", list.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		
		req.setAttribute("mode", mode);
		req.setAttribute("list", list);
		req.setAttribute("profileUser_num", userNum);
		return "user/style/followList";
	}
	
	@PostMapping("/followListScroll.user")
	public String user_followListScroll(@RequestParam Map<String,String>map
			,HttpServletRequest req,HttpSession session) {
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		
		List<FollowCheckDTO> list = null;
		if (map.get("mode").equals("follower")) {
			list = userStyleMapper.getFollower(Integer.parseInt(map.get("user_num")), my_num);
		}else if (map.get("mode").equals("following")) {
			list = userStyleMapper.getFollowing(Integer.parseInt(map.get("user_num")), my_num);
		}else if(map.get("mode").equals("ban")){
			list = userStyleMapper.banList(my_num);
		}else {
			list = userStyleMapper.likeList(Integer.parseInt(map.get("style_num")), my_num);
		}
		
		req.setAttribute("count", map.get("count"));	
		req.setAttribute("list", list);
		req.setAttribute("profileUser_num", map.get("user_num"));
		return "user/style/followListScroll";
	}

	@RequestMapping("/banList.user")
	public String user_banList(int userNum, HttpServletRequest req) {
		System.out.println(userNum);
		List<FollowCheckDTO> banList = userStyleMapper.banList(userNum);
		if(banList != null) {
			req.setAttribute("listSize", banList.size());
		}else {
			req.setAttribute("listSize", 0);
		}
		req.setAttribute("list", banList);
		req.setAttribute("mode", "ban");
		return "user/style/followList";
	}

	@RequestMapping("/myProfile.user")
	public String user_myProfile(int user_num, @RequestParam(required = false) String mode, HttpServletRequest req,
			HttpSession session) {
		if (mode == null)
			mode = "style";
		MemberDTO memberDTO = userStyleMapper.getMemberDTO(user_num);
		req.setAttribute("memberDTO", memberDTO);
		List<StyleBoardAllDTO> list = userStyleMapper.myProfileStyleAll(user_num);
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
			int checkBan = userStyleMapper.checkBan(user_num, my_num);
			int checkBan1 = userStyleMapper.checkBan(my_num, user_num);
			if (checkBan == 1 || checkBan1 == 1) {
				req.setAttribute("msg", "사용자를 찾을 수 없음");
				return "user/style/message";
			}
			int checkFollowing = userStyleMapper.checkFollowing(user_num, my_num);
			req.setAttribute("checkFollowing", checkFollowing);
		}
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), my_num);
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
		int followerSu = userStyleMapper.countFollower(user_num);
		int followingSu = userStyleMapper.countFollowing(user_num);

		req.setAttribute("followerSu", followerSu);
		req.setAttribute("followingSu", followingSu);

		req.setAttribute("boardSu", list.size());
		req.setAttribute("list", list);
		if (mode.equals("my"))
			return "user/my/myProfile";
		else
			return "user/style/myProfile";
	}
	
	@PostMapping("/myProfileScroll.user")
	public String user_myProfileScroll(@RequestParam(value="user_num",required = false) int user_num,
			@RequestParam(value="count",required = false) int count,HttpServletRequest req,HttpSession session) {
		MemberDTO memberDTO = userStyleMapper.getMemberDTO(user_num);
		req.setAttribute("memberDTO", memberDTO);
		List<StyleBoardAllDTO> list = userStyleMapper.myProfileStyleAll(user_num);
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
			int checkFollowing = userStyleMapper.checkFollowing(user_num, my_num);
			req.setAttribute("checkFollowing", checkFollowing);
		}
		if (list != null) {
			for (StyleBoardAllDTO dto : list) {
				int checkLike = userStyleMapper.checkLike(dto.getStyle_num(), my_num);
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
		int followerSu = userStyleMapper.countFollower(user_num);
		int followingSu = userStyleMapper.countFollowing(user_num);
		req.setAttribute("followerSu", followerSu);
		req.setAttribute("followingSu", followingSu);
		req.setAttribute("count", count);
		req.setAttribute("list", list);
		System.out.println("listSize="+list.size());
		return "user/style/myProfileScroll";
	}

	@PostMapping("/addFollow.user")
	@ResponseBody
	public int user_addFollow(int userNum, HttpSession session) {
		System.out.println("addfollow컨트롤러 옴");
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		Map<String, String> map = new HashMap<>();
		map.put("getUser_num", String.valueOf(userNum));
		map.put("sendUser_num", String.valueOf(my_num));
		map.put("alarm_kind_num", String.valueOf(userNum));
		map.put("alarm_kind", "follow");
		map.put("info","");
		int followCheck = userStyleMapper.checkFollowing(userNum, my_num);
		int check = userAlarmMapper.followAlarmCount(map);
		if (check == 0) {
			if (followCheck == 1) {
				System.out.println("팔로우쳌 1:" + followCheck);
				map.put("followCheck", String.valueOf(followCheck + 2));
				userAlarmMapper.insertAlarm(map);
				System.out.println("팔로우체크 1일때 인서트");
			}
			if (followCheck == 2) {
				System.out.println("팔로우쳌2" + (followCheck + 1));
				map.put("followCheck", String.valueOf(followCheck + 1));
				userAlarmMapper.setFollowCheck(map);
			}
			if (followCheck == 3) {
				map.put("followCheck", "2");
				userAlarmMapper.insertAlarm(map);
				System.out.println("팔로우체크 3일때 인서트");
			}
		}
		if (check != 0) {
			if (followCheck == 1) {
				System.out.println("팔로우쳌 수정1:" + followCheck);
				int a = followCheck + 2;
				map.put("followCheck", String.valueOf(a));
				userAlarmMapper.setFollowCheck((map));
				System.out.println("팔로우체크 1일때 수정");
			}
			if (followCheck == 3) {
				map.put("followCheck", "2");
				userAlarmMapper.setFollowCheck((map));
				System.out.println("팔로우체크 3일때 수정");
			}
		}
		int ok = userStyleMapper.addFollow(userNum, my_num);
		int followerSu = userStyleMapper.countFollower(userNum);
		return followerSu;
	}

	@PostMapping("/removeFollow.user")
	@ResponseBody
	public java.util.Map<String, Integer> user_removeFollow(int userNum, HttpSession session) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		int ok = userStyleMapper.removeFollow(userNum, my_num);
		int followerSu = userStyleMapper.countFollower(userNum);
		int checkFollowing = userStyleMapper.checkFollowing(userNum, my_num);
		Map<String, String> aMap = new HashMap<>();
		aMap.put("sendUser_num", String.valueOf(my_num));
		aMap.put("getUser_num", String.valueOf(userNum));
		aMap.put("alarm_kind_num", String.valueOf(userNum));
		if (checkFollowing == 3) {
			aMap.put("followCheck", "3");
		}
		if (checkFollowing == 1) {
			aMap.put("followCheck", "1");
		}
		userAlarmMapper.removeFollowCheck(aMap);
		map.put("followerSu", followerSu);
		map.put("checkFollowing", checkFollowing);
		return map;
	}

	@RequestMapping("/reportOpen.user")
	public ModelAndView reportOpen(int report_num) {
		return new ModelAndView("user/style/reportOpen", "report_num", report_num);
	}

	@RequestMapping("/ban.user")
	public String user_ban(int user_num, String mode, HttpSession session, HttpServletRequest req) {
		System.out.println(mode);
		int my_num = 0;
		if (session.getAttribute("sessionUser_num") != null) {
			my_num = (int) session.getAttribute("sessionUser_num");
		}
		int res = userStyleMapper.ban(my_num, user_num, mode);

		System.out.println("여기까지옴 삭제되고" + res);
		if (mode.equals("ban")) {
			req.setAttribute("url", "style.user");
			return "user/style/closeAndGo";
		} else if (mode.equals("removeBan")) {
			System.out.println("삭제하고 주소이동전까지도착");
			return "redirect:banList.user?userNum=" + my_num;
		}
		return null;

	}

}
