package com.ezen.kream.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.AlarmAllDTO;
import com.ezen.kream.dto.BuyProdDTO;
import com.ezen.kream.dto.SellProdDTO;

@Service
public class UserAlarmMapper {
   @Autowired
   private SqlSession sqlSession;

   public void insertAlarm(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.insert("insertAlarm", map);
   }

   public int getStyleBoardUserNum(int styleNum) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getStyleBoardUserNum", styleNum);
   }

   public List<AlarmAllDTO> getAlarmAllList(int user_num) {
      return sqlSession.selectList("getAlarmAllList", user_num);
   }

   public List<AlarmAllDTO> getStyleAlarmList(int user_num) {
      return sqlSession.selectList("getStyleLikeAlarmList", user_num);
   }

   public int userAlarmCheck(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("userAlarmCheck", user_num);
   }
   public List<AlarmAllDTO> getFollowAlarmList(int user_num){
      return sqlSession.selectList("getFollowAlarmList",user_num);
   }
   public void setAlarmCheck(int user_num) {
      // TODO Auto-generated method stub
      sqlSession.update("setAlarmCheck", user_num);
   }

   public List<AlarmAllDTO> getAnnotationList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getAnnotationList",user_num);
   }

   public int getUser_num(String writer) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getUser_num",writer);
   }

   public int getTagCount(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getTagCount",map);
   }

   public int followAlarmCount(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("followAlarmCount",map);
   }

   public int followAlarmCheck(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("followAlarmCheck",map);
   }

   public void setFollowCheck(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.update("setFollowCheck",map);
   }

   public void removeFollowCheck(Map<String, String> aMap) {
      // TODO Auto-generated method stub
      sqlSession.update("removeFollowCheck",aMap);
   }

   public int followerAlarmCount(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("followerAlarmCount",map);
   }
   public List<AlarmAllDTO> getReplyList(int user_num){
      return sqlSession.selectList("getReplyList",user_num);
   }
   public List<AlarmAllDTO> getTag_replyList(int user_num){
      return sqlSession.selectList("getTag_ReplyList",user_num); 
   }

   public List<AlarmAllDTO> getTag_reReplyList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getTag_reReplyList",user_num);
   }

   public List<AlarmAllDTO> getRereplyList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getRereplyList",user_num);
   }

   public int getRereplyUserNum(String name) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getRereplyUserNum",name);
   }

   public int getAlarmNum(int prod_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getAlarmNum",prod_num);
   }

   public void deleteAlarm(int getAlarm_num) {
      // TODO Auto-generated method stub
      sqlSession.delete("deleteAlarm",getAlarm_num);
   }
   public void insertCartAlarm(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.insert("insertCartAlarm",map);
   }

   public int getCartUserNum(int i) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getCartUserNum",i);
   }

   public int getCartCount(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getCartCout",map);
   }

   public void setCartAlarm(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.update("setCartAlarm",map);
   }

   public List<Integer> getAlarmUserList(Map<String, String> hMap) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getAlarm_Num_UserList",hMap);
   }

   public List<AlarmAllDTO> getCartQtyList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getCartQtyList",user_num);
   }

   public List<AlarmAllDTO> getCartPriceList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getCartPriceList",user_num);
   }

   public List<Integer> getCartUserNumList(int prod_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getCartNumList",prod_num);
   }

   public int getSellUserNum(Map<String, String> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("getSellUserNum",map);
   }

   public List<AlarmAllDTO> getBuyAuctionList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getBuy_AuctionList",user_num);
   }

   public List<AlarmAllDTO> getSellAuctionList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getSellAuctionList", user_num);
   }

   public List<AlarmAllDTO> getSellSuccessList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getSellSuccessList",user_num);
   }

   public void setAnnounceAlarm(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.selectList("setAnnounceAlarm",map);
   }

   public void setAsk(Map<String, String> map) {
      // TODO Auto-generated method stub
      sqlSession.update("setAsk",map);
   }

   public List<AlarmAllDTO> getAnnounceList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getAnnounceList",user_num);
   }

   public List<AlarmAllDTO> getReportList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getReportList",user_num);
   }

   public List<AlarmAllDTO> getAskReplyList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getAskReplyList",user_num);
   }

   public List<Integer> getUserAllNumList() {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getUserAllNumList");
   }
   
   public int getWriter_Count(String writer) {
         // TODO Auto-generated method stub
         return sqlSession.selectOne("getWriter_Count",writer);
      }

   public List<BuyProdDTO> getCancelBuyUser(int i) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getCancelBuyUser",i);
   }


   public List<SellProdDTO> sellDeadList() {
      // TODO Auto-generated method stub
      return sqlSession.selectList("sellDead_List");
   }

   public List<AlarmAllDTO> getBuyDeadList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getBuyDeadList",user_num);
   }

   public List<AlarmAllDTO> getSellDeadList(int user_num) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("getSellDeadList",user_num);
   }

}