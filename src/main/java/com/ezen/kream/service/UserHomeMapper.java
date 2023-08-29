package com.ezen.kream.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.BuyProdDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.dto.SellProdDTO;

@Service
public class UserHomeMapper {
   @Autowired
   SqlSession sqlSession;

   public List<AdminAllDTO> userHomeList(String pick_name) {
      return sqlSession.selectList("userHomeList", pick_name);
   }

   public List<String> userTabList() {
      return sqlSession.selectList("userTabList");
   }

   public List<PickCateListDTO> userMainCate() {
      // TODO Auto-generated method stub
      return sqlSession.selectList("userMainCate");
   }

   public List<PickCateListDTO> userTabTypeList(String tab_name) {
      return sqlSession.selectList("userTabTypeList", tab_name);
   }

   @Autowired
   private UserAlarmMapper userAlarmMapper;

   // 기한 지난 상품 취소
   public int cancelSellBuyProd() {
      List<Integer> list = sqlSession.selectList("cancelSellProdNum");
      List<BuyProdDTO> getUserList = new ArrayList<BuyProdDTO>();
      Map<String, String> map = new HashMap<>();
      map.put("sendUser_num", "0");
      map.put("info", "");
      map.put("followCheck", "0");
      if (list != null) {
         map.put("alarm_kind", "buyDead");
         for (int i : list) {
            sqlSession.update("cancelBuyProd", i);
            getUserList = userAlarmMapper.getCancelBuyUser(i);
            if (getUserList != null && getUserList.size() != 0 ) {
               for(BuyProdDTO dto : getUserList) {
                  map.put("getUser_num", String.valueOf(dto.getUser_num()));
                  map.put("alarm_kind_num", String.valueOf(dto.getBuy_num()));
                  userAlarmMapper.insertAlarm(map);
                  System.out.println("구매자 등록 성공:" + i);
               }
               }
            }
         }

      List<SellProdDTO> dlist = userAlarmMapper.sellDeadList();
      System.out.println("여기까진 왔고");
      if (dlist != null) {
         map.put("alarm_kind", "sellDead");
         System.out.println("등록시작");
         for (SellProdDTO dto : dlist) {
            map.put("alarm_kind_num", String.valueOf(dto.getSell_num()));
            map.put("getUser_num", String.valueOf(dto.getUser_num()));
            userAlarmMapper.insertAlarm(map);
            System.out.println("등록성공 ! " + dto.getSell_num());
         }
      }
      sqlSession.update("cancelSellProd");
      return 0;
   }

}