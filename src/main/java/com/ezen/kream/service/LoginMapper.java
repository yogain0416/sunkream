package com.ezen.kream.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.kream.dto.MemberDTO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class LoginMapper {
   @Autowired
   private SqlSession sqlSession;
   
   public int newMember(MemberDTO dto) {
      return sqlSession.insert("newMember", dto);
   }
   public MemberDTO getMember(String email) {
      return sqlSession.selectOne("getMember", email);
   }
   public int loginCheck(Map<String,String> params) {
      return sqlSession.selectOne("loginCheck",params);
   }
   public String findId(String phoneNum) {
      return sqlSession.selectOne("findId",phoneNum);
   }
   public int findPw(Map<String,String> params) {
      MemberDTO dto = sqlSession.selectOne("findPw", params);
      if(dto ==null) {
         return -1;
      }else {
         String pw =getRandomPassword();
         dto.setPasswd(pw);
         sqlSession.update("changePw", dto);
         SendTemp_Passwd(dto.getPhone_num(), pw);
         return 1;
      }
   }
   public int socialCheckMember(String email) {
      return sqlSession.selectOne("socialCheckMember", email);
   }
   public boolean checkProfileName(String str) {
      int res = sqlSession.selectOne("checkProfileName",str);
      if(res>0) {
         return true;
      }else {
         return false;
      }
   }
   public int checkPhoneNum(String phoneNum) {
      return sqlSession.selectOne("checkPhoneNum",phoneNum);
   }
   
   public String getRandomPassword() {
      char[] num_char= new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
      char[] str_char= new char[] {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
               'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
      char[] spa_char= new char[] {'!', '@', '#', '$', '%', '^', '&',',','-'};
      
      char num = num_char[(int)(Math.random()*10)];
      char spa = spa_char[(int)(Math.random()*9)];
      char[] random = new char[8];
      for(int i=0; i<6; i++) {
      random[i] = str_char[(int)(Math.random()*52)];
      }
      random[6] = num;
      random[7] = spa;
      List<String> list = new ArrayList();
      String pw = "";
      for(int i=0; i<8; i++) {
         String str = String.valueOf(random[i]);
         list.add(str);
      }
      Collections.shuffle(list);
      for(String a : list) {
         pw += a;
      }
      return pw;
   }
   public void SendTemp_Passwd(String phoneNumber, String numstr) {
      
      String api_key = "NCSL8DW9FAXCNPJC";
      String api_secret = "DRV3Z8Y52WFXQYQ368A52LMKGIIB8ARP";
      Message coolsms = new Message(api_key, api_secret);
      HashMap<String,String> params = new HashMap<String,String>();
      params.put("to",phoneNumber);
      params.put("from","01052603994");
      params.put("type", "SMS");
      params.put("text", "[EzenKream] 임시비밀번호는"+"["+numstr+"]입니다.");
      params.put("app_version", "test app 1.2");
      try {
         JSONObject obj = (JSONObject) coolsms.send(params);
      }catch(CoolsmsException e) {
         e.printStackTrace();
      }   
   }
   public void CertifiedPhoneNumber(String phoneNumber, String numstr) {
      String api_key = "NCSL8DW9FAXCNPJC";
      String api_secret = "DRV3Z8Y52WFXQYQ368A52LMKGIIB8ARP";
      Message coolsms = new Message(api_key, api_secret);
      HashMap<String,String> params = new HashMap<String,String>();
      params.put("to", phoneNumber);
      params.put("from","01052603994");
      params.put("type", "SMS");
      params.put("text", "[EzenKream] 인증번호는"+"["+numstr+"]입니다.");
      params.put("app_version", "test app 1.2");
      try {
         JSONObject obj = (JSONObject) coolsms.send(params);
      }catch(CoolsmsException e) {
         e.printStackTrace();
      }   
   
   }
}