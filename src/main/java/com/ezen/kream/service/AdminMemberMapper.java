package com.ezen.kream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.QnABoardAllDTO;
import com.ezen.kream.dto.QnABoardDTO;

@Service
public class AdminMemberMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<MemberDTO> memberList(int start,int end,String del){
		Map<String,String> map = new HashMap<>();
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		map.put("del",del);
		return sqlSession.selectList("memberList",map);
	}
	
	public int getCount(String del) {
		return sqlSession.selectOne("getCount",del);
	}
	
	public List<MemberDTO> memberFind(Map<String,String> map){
		return sqlSession.selectList("memberFind",map);
	}
	
	public int getFindCount(Map<String,String> map) {
		return sqlSession.selectOne("getFindCount",map);
	}
	
	public MemberDTO memberDetail(int user_num) {
		return sqlSession.selectOne("memberDetail",user_num);
	}
	
	public int memberEdit(Map<String,String> map) {
		return sqlSession.update("memberEdit",map);
	}
	
	public List<QnABoardAllDTO> memberReportWaiting(){
		return sqlSession.selectList("memberReport","대기중");
	}
	
	public List<QnABoardAllDTO> memberReportOk(){
		return sqlSession.selectList("memberReport","처리완료");
	}
	
	public QnABoardDTO agetQnABoard(int qna_num) {
		return sqlSession.selectOne("agetQnABoard",qna_num);
	}
	
	public int getWaitCount() {
		return sqlSession.selectOne("getWaitCount");
	}
	
	public int getOkCount() {
		return sqlSession.selectOne("getOkCount");
	}
	
	public List<QnABoardAllDTO> memberReportList(Map<String,String> map){
		return sqlSession.selectList("memberReportList",map);
	}
	
	public int getFindSubjectCount(Map<String,String> map) {
		return sqlSession.selectOne("getFindSubjectCount",map);
	}
	
	public int getFindWriterCount(Map<String,String> map) {
		return sqlSession.selectOne("getFindWriterCount",map);
	}
	
	public List<QnABoardAllDTO> memberReportFindSubjectList(Map<String,String> map){
		return sqlSession.selectList("memberReportFindSubjectList",map);
	}

	public List<QnABoardAllDTO> memberReportFindWriterList(Map<String,String> map){
		return sqlSession.selectList("memberReportFindWriterList",map);
	}
}
