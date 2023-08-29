package com.ezen.kream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.HashTagBaseDTO;
import com.ezen.kream.dto.PickHashTagDTO;
import com.ezen.kream.dto.PickSearchDTO;
import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;
import com.ezen.kream.dto.QnACateDTO;
import com.ezen.kream.dto.QnAImgDTO;
import com.ezen.kream.dto.StyleBoardAllDTO;
import com.ezen.kream.dto.StyleBoardDTO;

@Service
public class AdminBoardMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<QnABoardAllDTO> QnABoardList(String qna_cate,int start,int end){
		Map<String,String> map = new HashMap<>();
		map.put("qna_cate",qna_cate);
		map.put("start",String.valueOf(start));
		map.put("end",String.valueOf(end));
		return sqlSession.selectList("QnABoardList",map);
	}
	
	public List<QnABoardAllDTO> QnABoardListProcess(String process,int start,int end){
		Map<String,String> map = new HashMap<>();
		map.put("process",process);
		map.put("start",String.valueOf(start));
		map.put("end",String.valueOf(end));
		return sqlSession.selectList("QnABoardListProcess",map);
	}
	
	public int QnACateInput(QnACateDTO dto) {
		return sqlSession.insert("QnACateInput",dto);
	}
	
	public List<QnACateDTO> QnACateList(){
		return sqlSession.selectList("QnACateList");
	}
	
	public List<String> getQnACate(){
		return sqlSession.selectList("getQnACate");
	}
	
	public int QnACateDelete(int qna_cate_num) {
		return sqlSession.delete("QnACateDelete",qna_cate_num);
	}
	
	public List<QnACateDTO> getQnASubCate(String qna_cate){
		return sqlSession.selectList("getQnASubCate",qna_cate);
	}
	
	public int QnABoardInput(QnABoardDTO dto) {
		//sqlSession.update("inputStep");
		return sqlSession.insert("QnABoardInput",dto);
	}
	
	public QnABoardDTO getQnABoard(int qna_num) {
		return sqlSession.selectOne("getQnABoard",qna_num);
	}
	
	public int QnABoardDelete(int qna_num) {
		return sqlSession.delete("QnABoardDelete",qna_num);
	}
	
	public int QnABoardEdit(QnABoardDTO dto) {
		return sqlSession.update("QnABoardEdit",dto);
	}
	
	public int askReply(QnABoardDTO dto) {
		//sqlSession.update("askStep",dto.getQna_step());
		return sqlSession.insert("askReply",dto);
	}
	
	public int askReplyEdit(QnABoardDTO dto) {
		sqlSession.update("editProcess",dto);
		return sqlSession.update("askReplyEdit",dto);
	}
	
	public int processCommit(QnABoardDTO dto) {
		return sqlSession.update("processCommit",dto);
	}
	
	public int getQnANum(String reg_date) {
		return sqlSession.selectOne("getQnANum",reg_date);
	}
	
	public String setSysdate() {
		return sqlSession.selectOne("sysdate");
	}
	
	public int QnAImgInput(QnAImgDTO dto) {
		return sqlSession.insert("QnAImgInput",dto);
	}
	
	public List<QnAImgDTO> getQnAImg(int qna_num){
		return sqlSession.selectList("getQnAImg",qna_num);
	}
	
	public int QnAImgDelete(QnAImgDTO dto) {
		return sqlSession.delete("QnAImgDelete",dto);
	}
	
	public int QnAImgDeleteAll(int qna_num) {
		return sqlSession.delete("QnAImgDeleteAll",qna_num);
	}
	
	public List<StyleBoardDTO> styleBoardList(){
		return sqlSession.selectList("styleBoardList");
	}
	
	public StyleBoardAllDTO styleBoardAllList(StyleBoardDTO dto) {
		return sqlSession.selectOne("styleBoardAllList",dto);
	}
	
	public int setPenalty(Map<String,String> map) {
		String info = sqlSession.selectOne("getAdminInfo", map.get("report_num"));
		if(info == null) info = "";
		map.put("admin_info", info+map.get("admin_info"));
		return sqlSession.update("setPenalty",map);
	}
	
	public List<PickHashTagDTO> getPickHashTagList(){
		return sqlSession.selectList("getPickHashTagList");
	}
	
	public HashTagBaseDTO checkHashTag(String pick_name) {
		return sqlSession.selectOne("checkHashTag",pick_name);
	}
	
	public int addPickHashTag(String pick_name) {
		return sqlSession.insert("addPickHashTag",pick_name);
	}
	
	public int plusPickHashTag(String pick_name) {
		return sqlSession.insert("plusPickHashTag",pick_name);
	}
	
	public int checkPickHashTag(String pick_name) {
		return sqlSession.selectOne("checkPickHashTag",pick_name);
	}
	
	public int delPickHashTag(int num) {
		return sqlSession.delete("delPickHashTag",num);
	}
	
	public int checkSubCate(Map<String,String> map) {
		return sqlSession.selectOne("checkSubCate",map);
	}
	
	public List<PickSearchDTO> getPickSearchList(){
		return sqlSession.selectList("getPickSearchList");
	}
	
	public int checkPickSearch(String search_name) {
		return sqlSession.selectOne("checkPickSearch",search_name);
	}
	
	public int addPickSearch(String search_name) {
		return sqlSession.insert("addPickSearch",search_name);
	}
	
	public int delPickSearch(int num) {
		return sqlSession.delete("delPickSearch",num);
	}
	
	public int getQnABoardCount(String qna_cate) {
		return sqlSession.selectOne("getQnABoardCount",qna_cate);
	}
	
	public int agetQnABoardCount(String qna_cate,String process) {
		Map<String,String> map = new HashMap<>();
		map.put("qna_cate", qna_cate);
		map.put("process",process);
		return sqlSession.selectOne("agetQnABoardCount",map);
	}
	
	public int getQnABoardFindProfileCount(Map<String,String> map) {
		return sqlSession.selectOne("getQnABoardFindProfileCount",map);
	}
	
	public int getQnABoardFindCount(Map<String,String> map) {
		return sqlSession.selectOne("getQnABoardFindCount",map);
	}
	
	public int agetQnABoardFindCount(Map<String,String> map) {
		return sqlSession.selectOne("agetQnABoardFindCount",map);
	}
	
	public int agetQnABoardFindProfileCount(Map<String,String> map) {
		return sqlSession.selectOne("agetQnABoardFindProfileCount",map);
	}
	
	public List<QnABoardAllDTO> QnABoardFindList(Map<String,String> map){
		return sqlSession.selectList("QnABoardFindList",map);
	}
	
	public List<QnABoardAllDTO> QnABoardFindProfileList(Map<String,String> map){
		return sqlSession.selectList("QnABoardFindProfileList",map);
	}
	
	public List<QnABoardAllDTO> QnABoadFindListProfileProcess(Map<String,String> map){
		return sqlSession.selectList("QnABoadFindListProfileProcess",map);
	}
	
	public List<QnABoardAllDTO> QnABoardFindListProcess(Map<String,String> map){
		return sqlSession.selectList("QnABoardFindListProcess",map);
	}
	
	public int countPickHashTag() {
		return sqlSession.selectOne("countPickHashTag");
	}
	
	public int countPickSearch() {
		return sqlSession.selectOne("countPickSearch");
	}
	public int getQnAReplyNum(QnABoardDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getQnAReplyNum",dto);
	}
}
