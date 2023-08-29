package com.ezen.kream.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;
import com.ezen.kream.dto.QnAImgDTO;

@Service
public class UserCSMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<QnABoardDTO> announceList(){
		return sqlSession.selectList("announceList");
	}
	
	public QnABoardDTO getQnABoard(int qna_num) {
		return sqlSession.selectOne("getQnABoard",qna_num);
	}
	
	public List<QnAImgDTO> getQnAImg(int qna_num){
		return sqlSession.selectList("getQnAImg",qna_num);
	}
	
	public int getUserFaqSubCateCount(Map<String,String> map) {
		if(map.get("qna_subCate").equals("All")) return sqlSession.selectOne("getUserFaqAllCount",map);
		else return sqlSession.selectOne("getUserFaqSubCateCount",map);
	}
	
	public List<QnABoardAllDTO> faqList(Map<String,String> map){
		if(map.get("qna_subCate").equals("All")) return sqlSession.selectList("faqAllList",map);
		else return sqlSession.selectList("faqList",map);
	}
	
	public List<String> faqSubList(){
		return sqlSession.selectList("faqSubList");
	}
	
	public List<QnABoardAllDTO> faqSearch(Map<String,String> map){
		return sqlSession.selectList("faqSearch",map);
	}
	
	public List<QnABoardAllDTO> qnaList(Map<String,String> map){
		return sqlSession.selectList("qnaList",map);
	}
	
	public List<String> getQnaSubCate(){
		return sqlSession.selectList("getQnaSubCate");
	}
	
	public int qnaWrite(QnABoardDTO dto) {
		//sqlSession.update("inputStep");
		return sqlSession.insert("qnaWrite",dto);
	}
	
	public String setSysdate() {
		return sqlSession.selectOne("sysdate");
	}
	
	public int getQnANum(String reg_date) {
		return sqlSession.selectOne("getQnANum",reg_date);
	}
	
	public int QnAImgInput(QnAImgDTO dto) {
		return sqlSession.insert("QnAImgInput",dto);
	}
	
	public String getReportName(int report_num) {
		return sqlSession.selectOne("getReportName",report_num);
	}
	
	public List<QnABoardDTO> qnaSearch(Map<String,String> map){
		map.put("searchString", "%"+map.get("searchString")+"%");
		return sqlSession.selectList("qnaSearch",map);
	}
	
	public int getUserQnACount(String qna_cate) {
		return sqlSession.selectOne("getUserQnACount",qna_cate);
	}
	
	public List<QnABoardAllDTO> userQnAList(Map<String,String> map){
		return sqlSession.selectList("userQnAList",map);
	}
	
	public int getUserSearchCount(Map<String,String> map) {
		return sqlSession.selectOne("getUserSearchCount",map);
	}
	
	public int getUserAskCount(Map<String,String> map) {
		return sqlSession.selectOne("getUserAskCount",map);
	}
	
	public int getUserAskSearchCount(Map<String,String> map) {
		return sqlSession.selectOne("getUserAskSearchCount",map);
	}
	
	public List<QnABoardAllDTO> askSearch(Map<String,String> map){
		return sqlSession.selectList("askSearch",map);
	}

	public int QnAImgDelete(QnAImgDTO imgDTO) {
		return sqlSession.delete("QnAImgDelete",imgDTO);
	}

	public int QnAImgDeleteAll(int qna_num) {
		return sqlSession.delete("QnAImgDeleteAll",qna_num);
	}

	public int QnABoardEdit(QnABoardDTO dto) {
		return sqlSession.update("QnABoardEdit",dto);
	}
}
