package com.ezen.kream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.AdminProdDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.dto.PickProdListDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.dto.ProdImgDTO;
import com.ezen.kream.dto.SalesAllDTO;

@Service
public class AdminProdMapper {
	@Autowired
	private SqlSession sqlSession;

	// 관리자 상품 카테고리 등록
	public int prodCateInput(ProdCateDTO dto) {
		return sqlSession.insert("prodCateInput", dto);
	}
	//브랜드 리스트 한글
	public List<String> brand_kr_list(){
		return sqlSession.selectList("brand_kr_list");
	}
	//브랜드 리스트 영문
		public List<String> brandList(){
			return sqlSession.selectList("brandList");
		}
	//대분류 리스트 한글 
	public List<String> cate_kr_typeList(){
		return sqlSession.selectList("cate_kr_typeList");
	}
	//대분류 리스트 영문
		public List<String> cate_typeList(){
			return sqlSession.selectList("cate_typeList");
		}
	//소분류 리스트 한글
	public List<String> cate_kr_subtypeList(){
		return sqlSession.selectList("cate_kr_subtypeList");
	}
	//소분류 리스트 한글
		public List<String> cate_subtypeList(){
			return sqlSession.selectList("cate_subTypeList");
		}
	// 관리자 기본상품 등록
	public int prodBaseInput(AdminProdDTO dto) {
		return sqlSession.insert("prodBaseInput", dto);
	}

	// 사이즈 상품 등록
	public int prodInput(AdminProdDTO dto) {
		return sqlSession.insert("prodInput", dto);
	}

	// 관리자 상품이미지 등록
	public int prodImgInput(ProdImgDTO dto) {
		return sqlSession.insert("prodImgInput", dto);
	}
	//관리자 상품 이미지 수정
	public int prodImgEdit(ProdImgDTO dto) {
		return sqlSession.update("prodImgEdit",dto);
	}
	// 카테고리 리스트
	public List<ProdCateDTO> prodCateList() {
		return sqlSession.selectList("prodCateList");
	}
	
	public List<ProdCateDTO> prodCateList(Map<String,String> map) {
		return sqlSession.selectList("prodCatePageList",map);
	}

	// 상품이미지 제외 전체 리스트
	public List<AdminProdDTO> prodList() {
		// 쿼리문 size 0 으로 표기할것
		return sqlSession.selectList("prodList");
	}
	//이미지 포함 전체리스트
	public List<AdminAllDTO> prod_allList(){
		return sqlSession.selectList("allList");
	}
	//맞는 상품 리스트
	public List<AdminAllDTO> prodTypeList(String cate_kr_subType){
		return sqlSession.selectList("prodTypeList",cate_kr_subType);
	}
	//상품 조인 
	public AdminAllDTO prodAllList(int prod_num){
		return sqlSession.selectOne("prodJoin",prod_num);
	}
	//삭제 안된상품 번호 반환
	public List<Integer> allNumList(){
		return sqlSession.selectList("AllNumList");
	}
	//두가지 타입 반환
	public List<ProdCateDTO> twoType(){
		return sqlSession.selectList("cate_two");
	}
	//이미지 상품 넘버
	public List<Integer> prodImgNumList(){
		List<Integer> list = sqlSession.selectList("prodImgNumList");
		System.out.println(list.get(0));
		return list;
	}
	// 관리자 카테고리 찾기
	public List<ProdCateDTO> prodCateFind(@RequestParam Map<String, String> map) {
		// where 절 제대로 작성할것
		return sqlSession.selectList("prodCateFind", map);
	}

	// 관리자 상품찾기
	public List<AdminProdDTO> prodFind(@RequestParam Map<String, String> map) {
		return sqlSession.selectList("prodFind", map);
	}

	// 카테고리 삭제
	public int prodCateDelete(int cateNum) {
		return sqlSession.delete("prodCateDelete", cateNum);
	}
	//브랜드별 상품 컬럼수
	public int prodCount(String cate_brand) {
		return sqlSession.selectOne("prodCount",cate_brand);
	}
	//카테고리 한개 반환
	public ProdCateDTO getCate(int cate_num) {
		return sqlSession.selectOne("getCate",cate_num);
	}
	//이름 중복검사
	public int prodSubjectCount (AdminProdDTO dto) {
		return sqlSession.selectOne("prodSubjectCount",dto);
	}
	// 상품삭제
	public int prodDelete(int prodNum) {
		// prodGroup 값 가진 상품 동시삭제 쿼리문 작성
		return sqlSession.update("prodDelete", prodNum);
	}
	//삭제상품 번호 불러오기
	public List<Integer> delNumList(){
		return sqlSession.selectList("delNumList");
	}
	//관리자 상품,상품이미지 수정
	public int prodEdit(AdminProdDTO dto) {
		int prod_res = sqlSession.update("prodEdit", dto);
		return prod_res;
	}

	public AdminProdDTO getProd(@RequestParam int prod_num) {
		// num 값은 group 값으로 받기
		return sqlSession.selectOne("getProd",prod_num);
	}

	// 추천목록 입력
	public int prodPickInput(String name) {
		return sqlSession.insert("prodPickInput", name);
	}
	public String cate_brand(String cate_code) {
		return sqlSession.selectOne("cate_brand", cate_code);
	}
	public String cate_type(String cate_code) {
		return sqlSession.selectOne("cate_type",cate_code);
	}
	public String cate_subType(String cate_code) {
		return sqlSession.selectOne("cate_subType",cate_code);
	}
	// 추천목록 리스트
	public List<PickProdListDTO> prodPickList() {
		return sqlSession.selectList("prodPickList");
	}

	public int prodPickDelete(int pick_num) {
		return sqlSession.delete("prodPickDelete", pick_num);
	}

	public int getProdGroup(String prod_kr_subject) {
		return sqlSession.selectOne("getProdGroup",prod_kr_subject);
	}
	public List<AdminAllDTO> brandSelectList(String brand){
		return sqlSession.selectList("brandSelectList",brand);
	}
	public ProdImgDTO imgList(int prod_num) {
		return sqlSession.selectOne("imgList",prod_num);
	}
	public AdminAllDTO delList(int prod_num) {
		return sqlSession.selectOne("delList",prod_num);
	}
	public int prodRegist(int prod_num) {
		return sqlSession.update("prodRegist",prod_num);
	}
	public List<ProdCateDTO> cateTypeList(Map<String, String> map) {
		return sqlSession.selectList("cateTypeList",map);
	}
	public int cateCheck(ProdCateDTO dto) {
		return sqlSession.selectOne("cateCheck",dto);
	}
	public int cateKrCheck(ProdCateDTO dto) {
		return sqlSession.selectOne("cateKrCheck",dto);
	}
	//추천상품 카테고리 중복체크
	public int pickCateCheck(PickCateListDTO dto) {
		return sqlSession.selectOne("pickCateCheck",dto);
	}
	//추천상품 카테고리 등록
	public int pickCateInput(PickCateListDTO dto) {
		return sqlSession.insert("pickCateInput",dto);
	}
	//추천상품 카테고리 전체목록
	public List<PickCateListDTO> pickCateList(Map<String, String> map){
		return sqlSession.selectList("pickCatePageList",map);
	}
	public int pickProdCheck(PickProdListDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("pickProdCheck",dto);
	}
	public int pickProdInput(PickProdListDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.insert("pickProdInput",dto);
	}
	public List<Integer> pickProdNum() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("pickProdNumList");
	}
	//추천상품 전체리스트
	public List<AdminAllDTO> pickProd(){
		return sqlSession.selectList("pickProd");
	}
	//추천상품 카테고리 반환
	public List<PickCateListDTO> selectPickList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectPickList",map);
	}
	//추천상품 카테고리 최종선택시
	public List<PickCateListDTO> selectLastPick(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectLastPick",map);
	}
	//추천상품카테고리 삭제
	public int pickCateDelete(int cate_num) {
		// TODO Auto-generated method stub
		return sqlSession.delete("pickCateDelete",cate_num);
	}
	public int pickProdDelete(PickProdListDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.delete("pickProdDelete",dto);
	}
	public List<String> pickCateTab() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("pickCateTab");
	}
	public List<AdminAllDTO> searchList(String searchString) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("searchProdList",searchString+"%");
	}
	public List<AdminAllDTO> searchDelList(String searchString) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("searchProdDelList",searchString+"%");
	}
	//제품 사이즈 수량 수정
	public int edit_prod_qty(AdminProdDTO dto) {
		return sqlSession.update("edit_prod_qty",dto);
	}
	public List<AdminAllDTO> prodQTyList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("prodQtyList");
	}
	public AdminAllDTO prod_qty_edit(int prod_num) {
		return sqlSession.selectOne("prod_qty_edit",prod_num);
	}
	public int getDeadCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("deadCount");
	}
	public List<AdminAllDTO> deadList(Map<String,Integer> map){
		return sqlSession.selectList("deadLine",map);
	}
	public List<AdminAllDTO> shopAddList(String pick_name) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("shopAddList",pick_name);
	}
	public int qtyCount(int prod_group) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("qtyCount",prod_group);
	}
	public AdminAllDTO getProdAll(int prod_group) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getProdAll",prod_group);
	}
	public AdminAllDTO getSizeDTO(int prod_num) {
		return sqlSession.selectOne("getSizeDTO",prod_num);
	}
	public List<ProdCateDTO> twoTypeAnother() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("twoTypeAnother");
	}
	public List<AdminAllDTO> brandDelSelectList(String string) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("brandDelSelectList",string);
	}
	public List<AdminAllDTO> typeDelList(String string) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("typeDelList",string);
	}
	public SalesAllDTO getSalesInfo(AdminProdDTO dto) {
		return sqlSession.selectOne("getSalesInfo",dto);
	}
	public String getSysDate() {
		return sqlSession.selectOne("sysdate");
	}
	public void directExport(SalesAllDTO salesDTO) {
		sqlSession.insert("directExport",salesDTO);
	}
	public int getProdCateCount() {
		return sqlSession.selectOne("getProdCateCount");
	}
	public int getProdCateFindCount(Map<String, String> map) {
		map.put("searchString", map.get("searchString")+"%");
		if(map.get("search").equals("brand")) {
			return sqlSession.selectOne("geteProdCateBrandCount",map);
		}else if(map.get("search").equals("type")){
			return sqlSession.selectOne("geteProdCateTypeCount",map);
		}else {
			return sqlSession.selectOne("geteProdCateSubTypeCount",map);
		}
	}
	public List<ProdCateDTO> prodCateFindList(Map<String, String> map) {
		map.put("searchString", map.get("searchString")+"%");
		if(map.get("search").equals("brand")) {
			return sqlSession.selectList("geteProdCateBrandFind",map);
		}else if(map.get("search").equals("type")){
			return sqlSession.selectList("geteProdCateTypeFind",map);
		}else {
			return sqlSession.selectList("geteProdCateSubTypeFind",map);
		}
	}
	public int pickCateCount() {
		return sqlSession.selectOne("pickCateCount");
	}
	public List<AdminAllDTO> pickProd(Map<String, String> map) {
		return sqlSession.selectList("pickProdPage",map);
	}
	public int pickProdCount() {
		return sqlSession.selectOne("pickProdCount");
	}
	public int pickProdFindCount(Map<String, String> map) {
		map.put("searchString", map.get("searchString")+"%");
		if(map.get("search").equals("tab_name")) {
			return sqlSession.selectOne("pickProdTabFindCount",map);
		}else if(map.get("search").equals("pick_name")){
			return sqlSession.selectOne("pickProdPickFindCount",map);
		}else {
			return sqlSession.selectOne("pickProdProdFindCount",map);
		}
		
	}
	public List<AdminAllDTO> pickProdFind(Map<String, String> map) {
		map.put("searchString", map.get("searchString")+"%");
		if(map.get("search").equals("tab_name")) {
			return sqlSession.selectList("pickProdTabFind",map);
		}else if(map.get("search").equals("pick_name")){
			return sqlSession.selectList("pickProdPickFind",map);
		}else {
			return sqlSession.selectList("pickProdProdFind",map);
		}
	}
	
	//상품 목록
	public List<AdminAllDTO> delNProdList() {
		return sqlSession.selectList("delNProdList");
	}
	public List<AdminAllDTO> delNModeProdList(Map<String, String> map) {
		//성별 All 일때
		if(map.get("type").equals("prod_gender") && map.get("subType").equals("All")) {
			return sqlSession.selectList("delNProdList");
		}
		//사이즈일때
		if(map.get("type").equals("prod_size")) {
			List<Integer> list = sqlSession.selectList("getProdNumList",map);
			if(list == null || list.size() == 0) {
				return null;
			}
			return sqlSession.selectList("getProdSizeProdList",list);
		}
		return sqlSession.selectList("delNTypeProdList",map);
	}
	public List<AdminAllDTO> delYProdList() {
		return sqlSession.selectList("delYProdList");
	}
	public List<AdminAllDTO> delYModeProdList(Map<String, String> map) {
		if(map.get("type").equals("prod_gender") && map.get("subType").equals("All")) {
			return sqlSession.selectList("delYProdList");
		}
		//사이즈일때
		if(map.get("type").equals("prod_size")) {
			List<Integer> list = sqlSession.selectList("getProdNumList",map);
			if(list == null || list.size() == 0) {
				return null;
			}
			return sqlSession.selectList("getProdSizeProdList",list);
		}
		return sqlSession.selectList("delYTypeProdList",map);
	}
	public int getProdPrice(int prod_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getProdPrice",prod_num);
	}
	public int getProdQty(int prod_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getProdQty",prod_num);
	}
	public List<Integer> prodNumList(AdminProdDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("prodNumList",dto);
	}
	public AdminProdDTO getProduct(int i) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getProduct",i);
	}
	public AdminProdDTO getProd_before(AdminProdDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("getProd_num",dto);
	}
}
