package com.ezen.kream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.SalesAllDTO;

@Service
public class AdminSalesMapper {
	@Autowired
	private SqlSession sqlSession;

	public List<SalesAllDTO> allSalesList() {
		return sqlSession.selectList("allSalesList");
	}

	public String getSysDate() {
		return sqlSession.selectOne("sysdate");
	}

	public List<SalesAllDTO> todaySalesList(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+" 00:00:00");
		map.put("end",date+" 23:59:59");
		return sqlSession.selectList("salesList",map);
	}

	public int todayIncome(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+" 00:00:00");
		map.put("end",date+" 23:59:59");
		return sqlSession.selectOne("income",map);
	}

	public int todayOutcome(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+" 00:00:00");
		map.put("end",date+" 23:59:59");
		return sqlSession.selectOne("outcome",map);
	}

	public int todayCount(String date, String gender) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+" 00:00:00");
		map.put("end",date+" 23:59:59");
		map.put("gender",gender);
		return sqlSession.selectOne("todayCount",map);
	}

	public List<SalesAllDTO> monthSalesList(String date, int lastDay) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01 00:00:00");
		map.put("end",date+"/"+String.valueOf(lastDay)+" 23:59:59");
		return sqlSession.selectList("salesList",map);
	}

	public int monthIncome(String date, int lastDay) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01 00:00:00");
		map.put("end",date+"/"+String.valueOf(lastDay)+" 23:59:59");
		return sqlSession.selectOne("income",map);
	}

	public int monthOutcome(String date, int lastDay) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01 00:00:00");
		map.put("end",date+"/"+String.valueOf(lastDay)+" 23:59:59");
		return sqlSession.selectOne("outcome",map);
	}

	public List<SalesAllDTO> yearSalesList(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01/01 00:00:00");
		map.put("end",date+"12/31 23:59:59");
		return sqlSession.selectList("salesList",map);
	}

	public int yearIncome(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01/01 00:00:00");
		map.put("end",date+"12/31 23:59:59");
		return sqlSession.selectOne("income",map);
	}

	public int yearOutcome(String date) {
		Map<String,String> map = new HashMap<>();
		map.put("start", date+"/01/01 00:00:00");
		map.put("end",date+"12/31 23:59:59");
		return sqlSession.selectOne("outcome",map);
	}
	
	
	
	
	
	
	
}
