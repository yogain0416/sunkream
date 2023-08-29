package com.ezen.kream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.AccountDTO;
import com.ezen.kream.dto.AddressDTO;
import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.BuyAllDTO;
import com.ezen.kream.dto.BuySellAllDTO;
import com.ezen.kream.dto.CardDTO;
import com.ezen.kream.dto.CartListDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.PickSearchDTO;
import com.ezen.kream.dto.PopSearchDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.dto.ProdSearchDTO;
import com.ezen.kream.dto.SellAllDTO;
import com.ezen.kream.dto.StyleBoardAllDTO;

@Service
public class UserShopMapper {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private UserAlarmMapper userAlarmMapper;
	public List<ProdCateDTO> shopCateList() {
		List<ProdCateDTO> list = sqlSession.selectList("shopCateList");
		return list;
	}

	public List<ProdCateDTO> shopBrandList(String cate) {
		List<ProdCateDTO> list = sqlSession.selectList("shopBrandList", cate);
		return list;
	}

	public List<ProdCateDTO> shopAllBrandList() {
		List<ProdCateDTO> list = sqlSession.selectList("shopAllBrandList");
		return list;
	}

	public List<ProdCateDTO> shopSubCateList(String cate) {
		List<ProdCateDTO> list = sqlSession.selectList("shopSubCateList", cate);
		return list;
	}

	public List<ProdCateDTO> shopAllSubCateList() {
		List<ProdCateDTO> list = sqlSession.selectList("shopAllSubCateList");
		return list;
	}

	public List<PickSearchDTO> getPickSearchList() {
		return sqlSession.selectList("getPickSearchList");
	}

	public List<ProdCateDTO> getCateList() {
		return sqlSession.selectList("getCateList");
	}

	public List<AdminAllDTO> getSearchProd(String searchString) {
		return sqlSession.selectList("getSearchProd", "%" + searchString + "%");
	}

	public int popCheck(String searchString) {
		return sqlSession.selectOne("popCheck", searchString);
	}

	public int addPopSearchString(String searchString) {
		return sqlSession.insert("addPopSearchString", searchString);
	}

	public int plusPopSearchString(String searchString) {
		return sqlSession.update("plusPopSearchString", searchString);
	}

	public List<PopSearchDTO> getPopSearchList() {
		return sqlSession.selectList("getPopSearchList");
	}

	public List<AdminAllDTO> shopProdList() {
		return sqlSession.selectList("shopProdList");
	}

	public List<ProdSearchDTO> getSearchList(String searchString) {
		return sqlSession.selectList("getSearchList", "%" + searchString + "%");
	}

	public List<ProdSearchDTO> getDelSearchList(String searchString) {
		return sqlSession.selectList("getDelSearchList", "%" + searchString + "%");
	}
	
	public List<ProdSearchDTO> getGenderList(Map<String, String> map) {
		return sqlSession.selectList("genderSearchList",map);
	}
	public List<AdminAllDTO> getSizeList(int prod_num) {
		return sqlSession.selectList("getSizeList",prod_num);
	}

	public AdminAllDTO buySellSizeSelect(AdminAllDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("buySellSizeSelect",dto);
	}
	
	public AdminAllDTO buySellCartUser(int prod_num) {
		return sqlSession.selectOne("buySellCartUser",prod_num);
	}

	public List<AddressDTO> getUserAddress(int user_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getUserAddress",user_num);
	}
	
	public List<CardDTO> getCard(int user_num) {
		return sqlSession.selectList("getCard",user_num);
	}

	public int insertBuyDirect(BuyAllDTO dto) {
	      return sqlSession.insert("insertBuyDirect",dto);
	   }
	public int getBuyNum(BuyAllDTO dto) {
		return sqlSession.selectOne("getBuyNum",dto);
	}
	public int buy_qty(int buy_num) {
		// TODO Auto-generated method stub
		return sqlSession.update("buy_qty",buy_num);
	}
	
	public List<String> checkSell(int prod_num){
		return sqlSession.selectList("checkSell",prod_num);
	}
	
	public AdminAllDTO selectSellSize(Map<String,String> map) {
		return sqlSession.selectOne("selectSellSize",map);
	}
	
	public AccountDTO getAccountInfo(int user_num) {
		return sqlSession.selectOne("getAccountInfo",user_num);
	}
	
	public List<AdminAllDTO> getCartSizeList(int prod_num){
		return sqlSession.selectList("getCartSizeList",prod_num);
	}
	
	public List<CartListDTO> getCartList(int user_num){
		return sqlSession.selectList("agetCartList",user_num);
	}
	
	public int addCart(Map<String,String> map) {
		return sqlSession.insert("addCart",map);
	}
	
	public int delCart(Map<String,String> map) {
		return sqlSession.delete("delCart",map);
	}
	
	public String getSysDate() {
		return sqlSession.selectOne("sysdate");
	}
	
	public int addSellProd(SellAllDTO dto) {
		return sqlSession.insert("addSellProd",dto);
	}
	
	public int getSellNum(SellAllDTO dto) {
		return sqlSession.selectOne("getSellNum",dto);
	}
	
	public int addSellInfo(SellAllDTO dto) {
		return sqlSession.insert("addSellInfo",dto);
	}

	public MemberDTO getMember(int user_num) {
		return sqlSession.selectOne("getMemberDTO",user_num);
	}
	public int insertBuyInfoDirect(BuyAllDTO dto) {
	      sqlSession.update("usingPoint",dto);	//포인트 사용
	      return sqlSession.insert("insertBuyInfoDirect",dto);
	}
	
	public BuySellAllDTO selectBuyAuction(Map<String,String> map) {
		return sqlSession.selectOne("selectBuyAuction",map);
	}
	
	public int getCountMember(Map<String,String> map) {
		return sqlSession.selectOne("getCountMember",map);
	}
	
	public int getMaxPrice(Map<String,String> map) {
		return sqlSession.selectOne("getMaxPrice",map);
	}

	public int addBuyAuctionProd(BuySellAllDTO dto) {
		sqlSession.insert("addBuyAuctionProd",dto);
		int buy_num = sqlSession.selectOne("getBuyAuctionNum",dto);
		dto.setBuy_num(buy_num);
		Map<String,String> map = new HashMap<>();
		map.put("alarm_kind_num", String.valueOf(dto.getBuy_num()));
		map.put("sell_num", String.valueOf(dto.getProd_num()));
		map.put("alarm_kind","buy_auction");
		map.put("prod_group", String.valueOf(dto.getProd_group()));
		map.put("prod_size", dto.getProd_size());
		int sellUser_num = userAlarmMapper.getSellUserNum(map);
		map.put("getUser_num", String.valueOf(sellUser_num));
		map.put("sendUser_num", String.valueOf(dto.getUser_num()));
		map.put("followCheck", String.valueOf(dto.getProd_price()));
		map.put("info","");
		userAlarmMapper.insertAlarm(map);
		return sqlSession.insert("addBuyInfoAuctionProd",dto);
	}
	
	public int plusPoint(Map<String,String> params) {
		Map<String,Integer> map = new HashMap<>();
		int user_num = Integer.parseInt(params.get("user_num"));
		int price = Integer.parseInt(params.get("prod_price"));
		int point = (int) (price * 0.05);
		map.put("point", point);
		map.put("user_num", user_num);
		int res = sqlSession.update("plusPoint",map);
		System.out.println("res:"+res);
		return res;
	}

	public void directIncome(BuyAllDTO dto) {
		BuyAllDTO subdto = sqlSession.selectOne("getProdNames",dto);
		dto.setProd_subject(subdto.getProd_subject());
		dto.setProd_kr_subject(subdto.getProd_kr_subject());
		dto.setGender(subdto.getGender());
		int res = sqlSession.insert("directIncome",dto);
		System.out.println("수입결과:"+res);
	}

	public int cartCount(int prod_num) {
		return sqlSession.selectOne("cartCount",prod_num);
	}

	public int tagCount(int prod_num) {
		return sqlSession.selectOne("tagCount",prod_num);
	}

	public AdminAllDTO getProdInfo(int prod_group) {
		return sqlSession.selectOne("getProdInfo",prod_group);
	}

	public List<StyleBoardAllDTO> showTagStyle(int prod_group) {
		return sqlSession.selectList("showTagStyle",prod_group);
	}

	public List<AdminAllDTO> shopTypeList(String cate_kr_type) {
		return sqlSession.selectList("shopTypeList",cate_kr_type);
	}

	public List<AdminAllDTO> shopSubTypeList(String cate_kr_subType) {
		return sqlSession.selectList("shopSubTypeList",cate_kr_subType);
	}

	public List<AdminAllDTO> shopListBrandList(String cate_brand) {
		return sqlSession.selectList("shopListBrandList",cate_brand);
	}

	public List<AdminAllDTO> shopProdSizeList(String prod_size) {
		List<Integer> list = sqlSession.selectList("shopProdSizeProdGroup",prod_size);
		if(list == null || list.size() == 0) {
			return null;
		}
		return sqlSession.selectList("shopProdSizeList",list);
	}

	public List<AdminAllDTO> shopProdGenderList(String parameter) {
		if(parameter.equals("All")) return sqlSession.selectList("shopProdList");
		else return sqlSession.selectList("shopProdGenderList",parameter);
	}
	
	
	
}
