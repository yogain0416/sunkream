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
import com.ezen.kream.dto.BuyProdDTO;
import com.ezen.kream.dto.BuySellAllDTO;
import com.ezen.kream.dto.CardDTO;
import com.ezen.kream.dto.CartListDTO;
import com.ezen.kream.dto.MemberDTO;
import com.ezen.kream.dto.SalesAllDTO;
import com.ezen.kream.dto.SellProdDTO;

@Service
public class UserMyMapper {
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private UserAlarmMapper userAlarmMapper;
	
	public MemberDTO getUserInfo(int user_num) {
		return sqlSession.selectOne("getUserInfo",user_num);
	}
	
	public List<BuyProdDTO> getBuyList(int user_num){
		return sqlSession.selectList("getBuyList",user_num);
	}
	
	public List<SellProdDTO> getSellList(int user_num){
		return sqlSession.selectList("getSellList",user_num);
	}
	
	public List<CartListDTO> getCartList(int user_num){
		return sqlSession.selectList("getCartList",user_num);
	}
	
	public AdminAllDTO getDirectInfo(CartListDTO dto) {
		return sqlSession.selectOne("getDirectInfo",dto);
	}
	
	public AdminAllDTO getAuctionInfo(CartListDTO dto) {
		return sqlSession.selectOne("getAuctionInfo",dto);
	}
	
	public MemberDTO myProfileManageInfo(int user_num) {
		return sqlSession.selectOne("myProfileManageInfo",user_num);
	}
	
	public int editProfileImg(Map<String,String> map) {
		return sqlSession.update("editProfileImg",map);
	}
	
	public int editProfileName(Map<String,String> map) {
		return sqlSession.update("editProfileName",map);
	}
	
	public int editName(Map<String,String> map) {
		return sqlSession.update("editName",map);
	}
	
	public int editInfo(Map<String,String> map) {
		return sqlSession.update("editInfo",map);
	}
	
	public int editPasswd(Map<String,String> map) {
		return sqlSession.update("editPasswd",map);
	}
	
	public int editPhone(Map<String,String> map) {
		return sqlSession.update("editPhone",map);
	}
	
	public int editSize(Map<String,Integer> map) {
		return sqlSession.update("editSize",map);
	}
	
	public List<AddressDTO> getAddressList(int user_num){
		return sqlSession.selectList("getAddressList",user_num);
	}
	
	public int getAddressCount(int user_num) {
		return sqlSession.selectOne("getAddressCount",user_num);
	}
	
	public int setBasicNAddress(int user_num) {
		return sqlSession.update("setBasicNAddress",user_num);
	}
	
	public int setBasicYAddress(int address_num) {
		return sqlSession.update("setBasicYAddress",address_num);
	}
	
	public int insertAddress(AddressDTO dto) {
		return sqlSession.insert("insertAddress",dto);
	}
	
	public AddressDTO getAddressInfo(int address_num) {
		return sqlSession.selectOne("getAddressInfo",address_num);
	}
	
	public int editAddress(AddressDTO dto) {
		return sqlSession.update("editAddress",dto);
	}
	
	public int delAddress(int address_num) {
		return sqlSession.delete("delAddress",address_num);
	}
	
	public int delMember(int user_num) {
		return sqlSession.update("delMember",user_num);
	}
	
	public int getCardCount(int user_num) {
		return sqlSession.selectOne("getCardCount",user_num);
	}
	
	public int insertCard(CardDTO dto) {
		return sqlSession.insert("insertCard",dto);
	}
	
	public int setBasicNCard(int user_num) {
		return sqlSession.update("setBasicNCard",user_num);
	}
	
	public List<CardDTO> getCardList(int user_num) {
		return sqlSession.selectList("getCardList",user_num);
	}
	
	public int setBasicYCard(int myCard_num) {
		return sqlSession.update("setBasicYCard",myCard_num);
	}
	
	public int delCard(int myCard_num) {
		return sqlSession.delete("delCard",myCard_num);
	}
	
	public AccountDTO getAccount(int user_num) {
		return sqlSession.selectOne("getAccount",user_num);
	}
	
	public int addAccount(AccountDTO dto) {
		return sqlSession.insert("addAccount",dto);
	}
	
	public int editAccount(AccountDTO dto) {
		return sqlSession.update("editAccount",dto);
	}
	
	public List<BuySellAllDTO> buyList(int user_num, java.util.Map<String, String> params) {
		params.put("user_num", String.valueOf(user_num));
		if (params.get("cal1") != null && params.get("cal2") != null 
				&& !params.get("cal1").equals("") && !params.get("cal2").equals("")) {
			if(params.get("auction") == null || params.get("auction").equals("all")
					|| params.get("auction").equals("")) {
				params.put("a1", "W");
				params.put("a2", "X");
				params.put("a3", "Y");
				List<BuySellAllDTO> alist = sqlSession.selectList("buyList_cal_D",params);
				List<BuySellAllDTO> blist = sqlSession.selectList("buyList_cal_notD",params);
				alist.addAll(blist);
				return alist;
			}else if(params.get("auction").equals("W")){
				params.put("a1","W");
				params.put("a2","W");
				params.put("a3","W");
				return sqlSession.selectList("buyList_cal_notD",params);
			}else if(params.get("auction").equals("end")) {
				params.put("a1", "X");
				params.put("a2", "X");
				params.put("a3", "Y");
				List<BuySellAllDTO> alist = sqlSession.selectList("buyList_cal_D",params);
				List<BuySellAllDTO> blist = sqlSession.selectList("buyList_cal_notD",params);
				alist.addAll(blist);
				return alist;
			}
		}else {
			if(params.get("auction") == null || params.get("auction").equals("all")
					|| params.get("auction").equals("")) {
				params.put("a1", "W");
				params.put("a2", "X");
				params.put("a3", "Y");
				List<BuySellAllDTO> alist = sqlSession.selectList("buyList_all_D",params);
				List<BuySellAllDTO> blist = sqlSession.selectList("buyList_all_notD",params);
				alist.addAll(blist);
				return alist;
			}else if(params.get("auction").equals("W")){
				params.put("a1","W");
				params.put("a2","W");
				params.put("a3","W");
				return sqlSession.selectList("buyList_all_notD",params);
			}else if(params.get("auction").equals("end")) {
				params.put("a1", "X");
				params.put("a2", "X");
				params.put("a3", "Y");
				List<BuySellAllDTO> alist = sqlSession.selectList("buyList_all_D",params);
				List<BuySellAllDTO> blist = sqlSession.selectList("buyList_all_notD",params);
				alist.addAll(blist);
				return alist;
			}
		}
		return null;
	}
	
	public List<BuySellAllDTO> sellList(int user_num, Map<String, String> params){
		params.put("user_num", String.valueOf(user_num));
		if (params.get("cal1") != null && params.get("cal2") != null 
				&& !params.get("cal1").equals("") && !params.get("cal2").equals("")) {
			if(params.get("auction") == null || params.get("auction").equals("all")
					|| params.get("auction").equals("")) {
				params.put("a1", "W");
				params.put("a2", "X");
				params.put("a3", "Y");
				return sqlSession.selectList("sellList_cal",params);
			}else if(params.get("auction").equals("W")){
				params.put("a1","W");
				params.put("a2","W");
				params.put("a3","W");
				return sqlSession.selectList("sellList_cal",params);
			}else if(params.get("auction").equals("end")) {
				params.put("a1", "X");
				params.put("a2", "X");
				params.put("a3", "Y");
				return sqlSession.selectList("sellList_cal",params);
			}
		}else {
			if(params.get("auction") == null || params.get("auction").equals("all")
					|| params.get("auction").equals("")) {
				params.put("a1", "W");
				params.put("a2", "X");
				params.put("a3", "Y");
				return sqlSession.selectList("sellList_all",params);
			}else if(params.get("auction").equals("W")){
				params.put("a1","W");
				params.put("a2","W");
				params.put("a3","W");
				return sqlSession.selectList("sellList_all",params);
			}else if(params.get("auction").equals("end")) {
				params.put("a1", "X");
				params.put("a2", "X");
				params.put("a3", "Y");
				return sqlSession.selectList("sellList_all",params);
			}
		}
		return null;
	}
	
	public List<AdminAllDTO> getAllInfoCartList(int user_num){
		return sqlSession.selectList("getAllInfoCartList",user_num);
	}
	
	public BuySellAllDTO getBuyInfo_D(Map<String,String> map) {
		return sqlSession.selectOne("getBuyInfo_D",map);
	}
	
	public BuySellAllDTO getBuyInfo_notD(Map<String,String>map) {
		return sqlSession.selectOne("getBuyInfo_notD",map);
	}
	
	public BuySellAllDTO getSellInfo(Map<String,String> map) {
		return sqlSession.selectOne("getSellInfo",map);
	}
	
	public List<BuySellAllDTO> getSellInfo_list(Map<String,String> map) {
		return sqlSession.selectList("getSellInfo_list",map);
	}
	
	public BuySellAllDTO getSellInfo_Y(Map<String,String> map) {
		return sqlSession.selectOne("getSellInfo_Y",map);
	}
	
	public int selectBuy(int sell_num) {
	      Map<String,String> map = new HashMap<>();
	      String sysdate = sqlSession.selectOne("sysdate");
	      map.put("date", sysdate);
	      map.put("sell_num", String.valueOf(sell_num));
	      List<BuyProdDTO> list = getBuyAuctionList(sell_num);
	      int buy_num = sqlSession.selectOne("selectBuy_max",map);
	      map.put("buy_num", String.valueOf(buy_num));
	      sqlSession.update("selectBuy_X",map);
	      sqlSession.update("selectBuy_Y",map);
	      int buyInfo_num = sqlSession.selectOne("selectBuy_info",map);
	      map.put("buyInfo_num", String.valueOf(buyInfo_num));
	      sqlSession.update("selectBuy_sell",map);
	      SalesAllDTO dto = sqlSession.selectOne("getAuctionSalesInfo",sell_num);
	      dto.setReg_date(sysdate);
	      dto.setProd_price(sqlSession.selectOne("selectBuyPrice",buy_num));
	      dto.setMoney((int)(dto.getProd_price()*0.1));
	      sqlSession.insert("auctionSales",dto);
	      int max_price = sqlSession.selectOne("getMax_Price",buy_num);
	      map.put("sendUser_num", String.valueOf(sell_num));
	      
	      map.put("info", "");
	      for(BuyProdDTO bdto :list) {
	         if(bdto.getProd_price() == max_price ) {
	            map.put("getUser_num", String.valueOf(bdto.getUser_num()));
	            map.put("alarm_kind_num", String.valueOf(buy_num));
	            map.put("followCheck", String.valueOf(bdto.getProd_price()));
	            map.put("alarm_kind","sell_success");
	            userAlarmMapper.insertAlarm(map);
	         }
	         if(bdto.getProd_price() != max_price) {
	            map.put("alarm_kind_num", String.valueOf(bdto.getBuy_num()));
	            map.put("getUser_num", String.valueOf(bdto.getUser_num()));
	            map.put("followCheck", String.valueOf(bdto.getProd_price()));
	            map.put("alarm_kind", "sell_auction");
	            userAlarmMapper.insertAlarm(map);
	         }
	      }
	      return sqlSession.update("selectBuy",map);
	   }
	
	private List<BuyProdDTO> getBuyAuctionList(int sell_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("getBuyAuctionList",sell_num);
	}
	
	public int getPoint(int user_num) {
		return sqlSession.selectOne("getPoint",user_num);
	}
	
	public List<BuySellAllDTO> getPointList(int user_num){
		return sqlSession.selectList("getPointList",user_num);
	}
}
