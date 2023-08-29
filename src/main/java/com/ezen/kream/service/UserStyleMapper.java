package com.ezen.kream.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

import edu.emory.mathcs.backport.java.util.Collections;

@Service
public class UserStyleMapper {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private UserAlarmMapper userAlarmMapper;
	
	public List<StyleBoardAllDTO> stylePopular() {
		return sqlSession.selectList("stylePopular");
	}

	public List<StyleBoardAllDTO> styleNew() {
		return sqlSession.selectList("styleNew");
	}

	public int styleBoardDelete(int styleNum) {
		List<StyleReplyDTO> list = sqlSession.selectList("getReplyStyleBoard", styleNum);
		for (StyleReplyDTO dto : list) {
			deleteHash(dto.getReply_contents(), dto.getReg_date());
		}

		StyleBoardDTO dto = sqlSession.selectOne("getStyleBoardDTO", styleNum);
		if (dto.getStyle_contents() == null || dto.getStyle_contents().trim().equals("")) {
			dto.setStyle_contents("");
		} else {
			deleteHash(dto.getStyle_contents(), dto.getReg_date());
		}
		// 삭제하면 이미지 삭제 ,상품태그 삭제 ,댓글 삭제 ,좋아요 삭제 , 게시글 삭제 ,해시태그 삭제,해시태그베이스 확인삭제

		sqlSession.delete("deleteBoardReply", styleNum);
		sqlSession.delete("deleteBoard", styleNum);
		sqlSession.delete("deleteBoardImg", styleNum);
		// 여기까지 모든 댓글, 게시글내용과 해시태그 삭제& 해시태그 베이스 (-1or delete)
		sqlSession.delete("deleteBoardProdTag", styleNum);
		sqlSession.delete("deleteBoardLike", styleNum);

		return 1;
	}

	public List<String> getPickHashTag() {
		return sqlSession.selectList("getPickHashTag");
	}

	public int searchWriter(String profile_name) {
		return sqlSession.selectOne("searchWriter", profile_name);
	}

	public List<StyleBoardAllDTO> styleProdTag(String cate, String subType, String mode) {

		List<StyleBoardAllDTO> list = new ArrayList<StyleBoardAllDTO>();
		List<Integer> style_num_all_list = new ArrayList<Integer>();
		if (cate != null && subType != null) {
			List<Integer> prod_num_list = null;
			System.out.println("subtypeall 옴");

			if (subType.equals("all")) {
				prod_num_list = sqlSession.selectList("selectProdNum", cate);
			} else {
				java.util.Map<String, String> map = new HashMap<String, String>();
				map.put("cate", cate);
				map.put("subType", subType);
				prod_num_list = sqlSession.selectList("selectProdNum_subType", map);
			}
			if (prod_num_list != null) {
				for (Integer prod_num : prod_num_list) {
					List<Integer> style_num_list = sqlSession.selectList("styleProdTag", prod_num);
					style_num_all_list.addAll(style_num_list);
				}
			}
		}
		style_num_all_list = style_num_all_list.stream().distinct().collect(Collectors.toList());
		if (style_num_all_list != null) {
			for (Integer style_num : style_num_all_list) {
				StyleBoardAllDTO dto = sqlSession.selectOne("styleRanking", style_num);
				if (dto != null) {
					list.add(dto);
				}
			}
		}
		if (list != null) {
			if (mode.equals("new")) {
				Comparator<StyleBoardAllDTO> com = new Comparator<StyleBoardAllDTO>() {
					@Override
					public int compare(StyleBoardAllDTO o1, StyleBoardAllDTO o2) {
						return o2.getReg_date().compareTo(o1.getReg_date());
					}
				};
				Collections.sort(list, com);
			} else {
				Comparator<StyleBoardAllDTO> com2 = new Comparator<StyleBoardAllDTO>() {
					@Override
					public int compare(StyleBoardAllDTO o1, StyleBoardAllDTO o2) {
						return o2.getStyle_like() - o1.getStyle_like();
					}
				};
				Collections.sort(list, com2);
			}
		}
		return list;

	}

	public List<ProdCateDTO> style_cate_subtype(String cate) {
		return sqlSession.selectList("style_cate_subtype", cate);
	}

	public int styleWrite(int user_num, StyleBoardDTO dto, StyleImgDTO imgdto, String[] prod_num) {
		java.util.Map<String, String> map = new HashMap<String, String>();
		if (dto.getStyle_contents() == null) {
			dto.setStyle_contents("");
		}
		String style_contents = dto.getStyle_contents();
		System.out.println("contents" + style_contents);
		map.put("user_num", String.valueOf(user_num));
		map.put("style_contents", style_contents);
		String reg_date = sqlSession.selectOne("sysdate");
		map.put("reg_date", reg_date);
		int res = sqlSession.insert("styleWrite", map);
		Map<String, String> hmap = new HashMap<>();
		hmap.put("date", reg_date);
		hmap.put("user_num", String.valueOf(user_num));
		int style = getStyle_num(hmap);
		inputTag(dto.getStyle_contents(), style, user_num,"tag_id");
		dto.setReg_date(reg_date);
		dto.setUser_num(user_num);
		int style_num = insertHash(dto);
		int res2 = 0;
		if (res > 0) {
			imgdto.setUser_num(user_num);
			imgdto.setStyle_num(style_num);
			res2 = sqlSession.insert("styleImgWrite", imgdto);
			if (prod_num != null) {
				for (String prod : prod_num) {
					java.util.Map<String, String> map2 = new HashMap<String, String>();
					map2.put("style_num", String.valueOf(style_num));
					map2.put("prod_num", prod);
					sqlSession.insert("insertProd_tags", map2);
				}
			}
		}
		return res2;
	}

	public List<ProdSearchDTO> getProdTag(int styleNum) {
		System.out.println("메퍼1");
		List<Integer> prodTagList = sqlSession.selectList("getProdTag", styleNum);
		List<ProdSearchDTO> list = new ArrayList<ProdSearchDTO>();
		System.out.println("prodTagList");
		for (Integer prod_num : prodTagList) {
			ProdSearchDTO dto = sqlSession.selectOne("getProdTagDTO", prod_num);
			list.add(dto);
		}

		return list;
	}

	public StyleBoardAllDTO getContents(int styleNum) {
		return sqlSession.selectOne("getContents", styleNum);
	}

// 글 내용을 #을 기준으로 스플릿한다.

	public int styleReplyOk(StyleReplyDTO dto) {
		String reg_date = sqlSession.selectOne("sysdate");
		dto.setReg_date(reg_date);
		//댓글에서 언급할 경우 
		if (dto.getReply_step() == 0 ) {
			inputTag(dto.getReply_contents(),dto.getStyle_num(),dto.getUser_num(),"tag_reply");
		}else {
			inputTag(dto.getReply_contents(),dto.getStyle_num(),dto.getUser_num(),"tag_reReply");
		}
		System.out.println("댓글태그 내용 :"+dto.getReply_contents());
		String str[] = dto.getReply_contents().split("#");
		if (str.length == 1) {
			System.out.println("해시태그 없음");
		} else {
			for (int i = 1; i < str.length; ++i) {
				String hashTag = (str[i].split(" ")[0]).split("<br>")[0];
				if (hashTag.trim().equals(""))
					continue;
				int count = sqlSession.selectOne("getHashTagBaseCount", hashTag);
				Map<String, String> map = new HashMap<>();
				map.put("style_num", String.valueOf(dto.getStyle_num()));
				map.put("user_num", String.valueOf(dto.getUser_num()));
				map.put("reg_date", dto.getReg_date());
				if (count == 0) {
					sqlSession.insert("addHashTagBase", hashTag);
					int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);
					map.put("hashTag_num", String.valueOf(hashTag_num));

					sqlSession.insert("addHashTag", map);
				} else {// 이미 등록된 해시태그일 경우
					sqlSession.update("plusHashTagCount", hashTag);
					int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);// 해시태그 고유번호를 받아와서
					map.put("hashTag_num", String.valueOf(hashTag_num));
					sqlSession.insert("addHashTag", map);// 해시태그체크table에 추가해주기
				}
			}
		}
		return sqlSession.insert("styleReplyOk", dto);

	}

	public int maxRegroup(int styleNum) {
		int count = sqlSession.selectOne("checkRegroupCount", styleNum);
		if (count == 0) {
			return 1;
		} else {
			int reply_group = sqlSession.selectOne("maxRegroup");
			return reply_group + 1;
		}
	}

	public int deleteReply(int reply_num, String mode) {
		if (mode.equals("reply")) {
			List<StyleReplyDTO> list = sqlSession.selectList("getReply", reply_num);
			for (StyleReplyDTO dto : list) {
				deleteHash(dto.getReply_contents(), dto.getReg_date());
			}
			return sqlSession.delete("deleteReply", reply_num);
		} else {
			StyleReplyDTO dto = sqlSession.selectOne("getReReply", reply_num);
			deleteHash(dto.getReply_contents(), dto.getReg_date());
			return sqlSession.delete("deleteReReply", reply_num);
		}
	}

	public void deleteHash(String contents, String reg_date) {
		String str[] = contents.split("#");
		if (str.length == 1) {
			System.out.println("해시태그 없는 글");
		} else {
			for (int i = 1; i < str.length; ++i) {
				String hashTag = (str[i].split(" ")[0]).split("<br>")[0];
				System.out.println("hashTag" + hashTag);
				if (hashTag.trim().equals(""))
					continue;
				int count = sqlSession.selectOne("getHashTagCount", hashTag);
				int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);
				Map<String, String> map = new HashMap<>();
				map.put("hashTag_num", String.valueOf(hashTag_num));
				map.put("reg_date", reg_date);

				int checkCount = sqlSession.selectOne("checkPickList", hashTag_num);
				if (count == 1 && checkCount == 0) {
					sqlSession.delete("deleteHashTagBase", hashTag);
				} else {
					sqlSession.update("minusHashTagCount", hashTag);
				}
				sqlSession.delete("deleteHashTag", map);
			}
		}
	}

	public int maxRestep(int style_num, int reply_group) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("style_num", style_num);
		map.put("reply_group", reply_group);
		int count = sqlSession.selectOne("checkRestepCount", map);
		if (count == 0) {
			return 1;
		} else {
			int reply_step = sqlSession.selectOne("maxRestep", map);
			return reply_step + 1;
		}
	}

	public List<FollowCheckDTO> getFollower(int user_num, int my_num) {
		List<Integer> list = sqlSession.selectList("getFollower", user_num);
		List<FollowCheckDTO> followerList = new ArrayList<FollowCheckDTO>();
		for (int num : list) {
			FollowCheckDTO dto = sqlSession.selectOne("followCheckDTO", num);
			dto.setCheckFollowing(checkFollowing(dto.getUser_num(), my_num));
			followerList.add(dto);
		}
		return followerList;
	}

	public List<FollowCheckDTO> getFollowing(int user_num, int my_num) {
		List<Integer> list = sqlSession.selectList("getFollowing", user_num);
		List<FollowCheckDTO> followingList = new ArrayList<FollowCheckDTO>();
		for (int num : list) {
			FollowCheckDTO dto = sqlSession.selectOne("followCheckDTO", num);
			dto.setCheckFollowing(checkFollowing(dto.getUser_num(), my_num));
			followingList.add(dto);
		}
		return followingList;
	}

	public List<FollowCheckDTO> banList(int user_num) {
		List<Integer> list = sqlSession.selectList("getBanList", user_num);
		List<FollowCheckDTO> banList = new ArrayList<FollowCheckDTO>();
		for (int num : list) {
			FollowCheckDTO dto = sqlSession.selectOne("followCheckDTO", num);
			banList.add(dto);
		}
		return banList;
	}

	public List<FollowCheckDTO> likeList(int style_num, int my_num) {
		List<Integer> list = sqlSession.selectList("likeList", style_num);
		List<FollowCheckDTO> likeList = new ArrayList<FollowCheckDTO>();
		for (int num : list) {
			FollowCheckDTO dto = sqlSession.selectOne("followCheckDTO", num);
			dto.setCheckFollowing(checkFollowing(dto.getUser_num(), my_num));
			likeList.add(dto);
		}
		return likeList;
	}

	public int countFollower(int user_num) {
		return sqlSession.selectOne("countFollower", user_num);
	}

	public int countFollowing(int user_num) {
		return sqlSession.selectOne("countFollowing", user_num);
	}

	public MemberDTO getMemberDTO(int user_num) {
		return sqlSession.selectOne("getMemberDTO", user_num);
	}

	public List<StyleBoardAllDTO> myProfileStyleAll(int user_num) {
		return sqlSession.selectList("myProfileStyleAll", user_num);
	}

	public int getStyleUserNum(String profile_name) {
		return sqlSession.selectOne("getStyleUserNum", profile_name);
	}

	public List<ReplyAllDTO> getAllReply(int styleNum) {
		return sqlSession.selectList("getAllReply", styleNum);
	}

	public int checkFollowing(int user_num, int my_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_num", user_num);
		map.put("my_num", my_num);
		int following = sqlSession.selectOne("isFollowing", map);
		int follower = sqlSession.selectOne("isFollower", map);
		// int 1이면 팔로우 2면 팔로우취소 3이면 맞팔
		if (user_num == my_num) {
			return 4;
		}
		if (following > 0 && follower == 0) {
			return 3;
		} else if (follower > 0) {
			return 2;
		} else {
			return 1;
		}
	}

	public int checkLike(int style_num, int user_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("style_num", style_num);
		map.put("user_num", user_num);
		int count = sqlSession.selectOne("checkLike", map);
		// 좋아요 된것 1 아직 좋아요 안된것 2
		if (count > 0)
			return 1;
		else
			return 2;
	}

	public int checkBan(int user_num, int my_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_num", user_num);
		map.put("my_num", my_num);
		int count = sqlSession.selectOne("checkBan", map);
		// 차단되있으면 1아니면 2
		if (count > 0)
			return 1;
		else
			return 2;
	}

	public int addFollow(int user_num, int my_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_num", user_num);
		map.put("my_num", my_num);
		int following = sqlSession.insert("following", map);
		int follower = sqlSession.insert("follower", map);
		if (following > 0 && follower > 0) {
			return 1;
		}
		return 0;
	}

	public int removeFollow(int user_num, int my_num) {
		System.out.println("remove매퍼로옴");
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_num", user_num);
		map.put("my_num", my_num);
		int following = sqlSession.delete("removefollowing", map);
		int follower = sqlSession.delete("removefollower", map);
		System.out.println(following + follower);
		if (following > 0 && follower > 0) {
			return 1;
		}
		return 0;
	}

	public int likeStyle(int styleNum, int user_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("styleNum", styleNum);
		map.put("user_num", user_num);
		int res = sqlSession.update("likeStyle", styleNum);
		int res2 = sqlSession.insert("addLike", map);
		if (res > 0 && res2 > 0) {
			return 1;
		} else {
			return -1;
		}
	}

	public int removeLikeStyle(int styleNum, int user_num) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("styleNum", styleNum);
		map.put("user_num", user_num);
		int res = sqlSession.update("removeLikeStyle", styleNum);
		int res2 = sqlSession.delete("removeLike", map);
		if (res > 0 && res2 > 0) {
			return 1;
		} else {
			return -1;
		}

	}

	public HashTagBaseDTO getHashTag(String hashTag) {
		return sqlSession.selectOne("getHashTag", hashTag);
	}

	public StyleBoardAllDTO getStyleBoardAll(StyleBoardDTO dto) {
		return sqlSession.selectOne("getStyleBoardAll", dto);
	}

	public StyleBoardAllDTO updateBoard(int style_num) {
		return sqlSession.selectOne("updateBoard", style_num);
	}

	public int updateBoardOk(StyleBoardDTO dto) {
		inputTag(dto.getStyle_contents(),dto.getStyle_num(),dto.getUser_num(),"tag_id");
		return sqlSession.update("updateBoardOk", dto);
	}

	public List<HashTagBaseDTO> CheckSearchHashTag(String search) {
		return sqlSession.selectList("checkSearchHashTag", search + "%");
	}

	public List<MemberDTO> CheckSearchNick(String search) {
		return sqlSession.selectList("checkSearchNick", search + "%");
	}

	public HashTagBaseDTO getHasgTagDTO(String name) {
		return sqlSession.selectOne("getHasgTagDTO", name);
	}

	public List<StyleBoardDTO> getHasgTagStyleBoard(String hashTag) {

		int count = sqlSession.selectOne("getHashTagCount", hashTag);
		List<StyleBoardDTO> styleBoardList = new ArrayList<StyleBoardDTO>();
		if (count > 0) {
			int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);
			List<Integer> list = sqlSession.selectList("getStyle_num", hashTag_num);
			for (Integer style_num : list) {
				StyleBoardDTO dto = sqlSession.selectOne("getStyleBoardDTO", style_num);
				styleBoardList.add(dto);
			}
		}
		return styleBoardList;
	}

	public String getProfileName(int num) {
		return sqlSession.selectOne("getProfileName", num);
	}

	public int insertHash(StyleBoardDTO dto) {
		int style_num = sqlSession.selectOne("getStyleBoardNum", dto);// 해시태그체크DTO의 style_num 은 게시글 번호랑 같기때문에 게시글번호 받아서
																		// 설정.
		String str[] = dto.getStyle_contents().split("#");// 글 내용을 #을 기준으로 스플릿한다.

		if (str.length == 1) {
			System.out.println("해시태그 없음");// #을 기준으로 스플릿했는데 길이가 1이면 #이 없다는 뜻
		} else {// 길이가 1보다 크면 해시태그가 있다는 뜻
			for (int i = 1; i < str.length; ++i) {// 스플릿했을때 최#구일 일경우 0번은 해시태그가 절대 될수 없으므로 1번부터 for문
				String hashTag = (str[i].split(" ")[0]).split("<br>")[0];
				// String hashTag = hashTag1.substring(0, hashTag1.length() - 1);// #뒷부분을 띄어쓰기로
				// 스플릿해서 띄어쓰기 앞부분을 해시태그라고 하고
				if (hashTag.trim().equals(""))
					continue;// 만약 그 부분이 빈칸일 최##구일 처럼 된 경우이므로 continue 시키기
				// List<Integer> list = sqlSession.selectList("getHashTagNum", hashTag);
				int count = sqlSession.selectOne("getHashTagBaseCount", hashTag);// 해시태그table에서 해시태그 고유번호를 가져오기
				Map<String, String> map = new HashMap<>();
				map.put("style_num", String.valueOf(style_num));// 게시글 번호를 style_num에 저장
				map.put("user_num", String.valueOf(dto.getUser_num()));// 유저 번호를 user_num에 저장 (지금은 실험이므로 유저번호 1로 통일)
				map.put("reg_date", dto.getReg_date());
				if (count == 0) {// 해시태그 고유번호 리스트가 0 이면 해시태그가 처음 입력된 경우이다.
					sqlSession.insert("addHashTagBase", hashTag);// 해시태그를 해시태그table에 등록하기
					int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);// 그리고 그 등록한 해시태그 고유번호를 받아와서
					map.put("hashTag_num", String.valueOf(hashTag_num));// 맵에 넣고
					sqlSession.insert("addHashTag", map);// 해시태그체크table에 추가해주기
				} else {// 이미 등록된 해시태그일 경우
					sqlSession.update("plusHashTagCount", hashTag);// 해시태그table의 count를 1추가
					int hashTag_num = sqlSession.selectOne("getHashTagNum", hashTag);// 해시태그 고유번호를 받아와서
					map.put("hashTag_num", String.valueOf(hashTag_num));
					sqlSession.insert("addHashTag", map);// 해시태그체크table에 추가해주기
				}
			}
		}
		return style_num;
	}

	public int getLikeSu(int styleNum) {
		return sqlSession.selectOne("getLikeSu", styleNum);
	}

	public int ban(int my_num, int user_num, String mode) {
		java.util.Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("my_num", my_num);
		map.put("user_num", user_num);
		if (mode.equals("ban")) {
			int ban = sqlSession.insert("ban", map);
			removeFollow(user_num, my_num);
			removeFollow(my_num, user_num);
			return ban;
		} else {
			return sqlSession.delete("removeBan", map);
		}
	}

	public List<StyleBoardAllDTO> userStyleRanking(String mode) {
		System.out.println("랭킹 메퍼로옴");
		java.util.Map<String, String> map = new HashMap<String, String>();
		String todayDateStart = sqlSession.selectOne("todayDateStart");
		String todayDateEnd = sqlSession.selectOne("todayDateEnd");
		String weekAgo = sqlSession.selectOne("weekAgo");
		List<StyleBoardAllDTO> dtoList = new ArrayList<StyleBoardAllDTO>();
		if (mode.equals("weekly")) {
			map.put("todayDate", todayDateEnd);
			map.put("startDate", weekAgo);
			List<Integer> list = sqlSession.selectList("selectRanking", map);
			for (Integer style_num : list) {
				StyleBoardAllDTO dto = sqlSession.selectOne("styleRanking", style_num);
				dtoList.add(dto);
			}
			return dtoList;
		} else {
			System.out.println("여기");
			map.put("todayDate", todayDateEnd);
			map.put("startDate", todayDateStart);
			List<Integer> list = sqlSession.selectList("selectRanking", map);
			for (Integer style_num : list) {
				StyleBoardAllDTO dto = sqlSession.selectOne("styleRanking", style_num);
				dtoList.add(dto);
			}
			return dtoList;
		}

	}

	public List<StyleBoardAllDTO> styleFollowing(int user_num) {
		List<Integer> following_list = sqlSession.selectList("getFollowing", user_num);

		List<StyleBoardAllDTO> allList = new ArrayList<StyleBoardAllDTO>();
		if (following_list != null) {
			for (Integer following_num : following_list) {
				List<StyleBoardAllDTO> list = sqlSession.selectList("styleFollowing", following_num);
				allList.addAll(list);
			}
		}
		int following_num = user_num;
		List<StyleBoardAllDTO> my_list = sqlSession.selectList("styleFollowing", following_num);
		if (my_list != null)
			allList.addAll(my_list);
		if (allList != null) {
			Comparator<StyleBoardAllDTO> com = new Comparator<StyleBoardAllDTO>() {
				@Override
				public int compare(StyleBoardAllDTO o1, StyleBoardAllDTO o2) {
					return o2.getReg_date().compareTo(o1.getReg_date());
				}
			};
			Collections.sort(allList, com);
		}
		return allList;
	}

	// 회원탈퇴 시
	// 좋아요, 팔로우,차단,글(해시태그,댓글,상품태그 다 삭제)
	public int deleteMember(int user_num) {
		List<Integer> style_num_list = sqlSession.selectList("myStyleAllNum", user_num);
		if (style_num_list != null) {
			for (Integer styleNum : style_num_list) {
				sqlSession.delete("deleteBoardReply", styleNum);
				sqlSession.delete("deleteBoardProdTag", styleNum);
				sqlSession.delete("deleteBoardLike", styleNum);
				sqlSession.delete("deleteBoard", styleNum);
				sqlSession.delete("deleteBoardImg", styleNum);
				List<Integer> hashTagNum_list = sqlSession.selectList("getAllHashTag", styleNum);
				if (hashTagNum_list != null) {
					for (Integer hashTag_num : hashTagNum_list) {
						int hashTag_count = sqlSession.selectOne("getHashTagBaseCountNum", hashTag_num);
						int checkCount = sqlSession.selectOne("checkPickList", hashTag_num);
						if (hashTag_count == 1 && checkCount == 0) {
							sqlSession.delete("deleteHashTagBaseNum", hashTag_num);
						} else {
							sqlSession.update("minusHashTagCountNum", hashTag_num);
						}
					}
				}
				sqlSession.delete("deleteAllHashTag", styleNum);
			}
		}
		sqlSession.delete("deleteMemberReply", user_num);
		List<Integer> minusLikeSu_list = sqlSession.selectList("myLikeAll", user_num);
		if (minusLikeSu_list != null) {
			for (Integer styleNum : minusLikeSu_list) {
				sqlSession.update("removeLikeStyle", styleNum);
			}
		}
		sqlSession.delete("deleteMemberLike", user_num);
		sqlSession.delete("deleteFollower", user_num);
		sqlSession.delete("deleteFollowing", user_num);
		sqlSession.delete("deleteBanList", user_num);
		return 1;

	}
	
	public void inputTag(String contents, int style_num, int user_num,String alarm_kind) {
		String str[] = contents.split(" ");
		System.out.println("input에서 종류 :"+alarm_kind);
		Map<String, String> map = new HashMap<>();
		map.put("style_num", String.valueOf(style_num));
		map.put("sendUser_num", String.valueOf(user_num));
		map.put("alarm_kind", alarm_kind);
		map.put("alarm_kind_num", String.valueOf(style_num));
		map.put("followCheck", "0");
		map.put("info","");
			for (int i = 0; i < str.length; i++) {
				if(alarm_kind.equals("tag_reReply") && i == 0) {
					continue;
				}
				String str1[] = str[i].split("<br>");
				if (str1.length == 1) {
					String str2[] = str1[0].split("@");
					for(int k =0; k<str2.length;k++) {
						System.out.println("str2 :"+str2[k]);
					}
					
					if (str2.length > 1) {
						for (int j = 1; j < str2.length; ++j) {
							if (str2[j].trim().equals("")) {
								continue;
							}
							String writer = str2[j];
							if(alarm_kind.equals("tag_reReply")) {
								map.put("alarm_kind", "tag_reReply");
							}
							int count = userAlarmMapper.getWriter_Count(writer);
							System.err.println("Writer:"+writer);
		                     if(count != 0) {
		                        int getUser_num = userAlarmMapper.getUser_num(writer);
		                        map.put("getUser_num", String.valueOf(getUser_num));
		                        userAlarmMapper.insertAlarm(map);
		                        System.out.println("태그 인서트 성공이다 이말이야");
		                     }
						}
					}
				}
			}

	}
	public int getStyle_num(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getStyleBoard_num",map);
	}
}
