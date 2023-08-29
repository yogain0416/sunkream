package com.ezen.kream;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.kream.dto.AlarmAllDTO;
import com.ezen.kream.service.UserAlarmMapper;
import com.ezen.kream.service.UserStyleMapper;

import edu.emory.mathcs.backport.java.util.Collections;

@Controller
public class UserAlarmController {
   @Autowired
   private UserAlarmMapper userAlarmMapper;
   @Autowired
   private UserStyleMapper userStyleMapper;
   @RequestMapping("/userAlarm.user")
   public String userAlarm(HttpSession session,HttpServletRequest req) {
      List<AlarmAllDTO> list = new ArrayList<>();
      
      int user_num = 0;
      if(session.getAttribute("sessionUser_num") != null) {
         user_num = (int) session.getAttribute("sessionUser_num");
      }
      if(session.getAttribute("sessionUser_num") == null) {
         req.setAttribute("msg", "로그인을 해주세요 !");
         req.setAttribute("url","main.login");
         return "message";
      }
      userAlarmMapper.setAlarmCheck(user_num);
      System.out.println("번호는:"+user_num);
      //좋아요 리스트
      List<AlarmAllDTO> likeList =  userAlarmMapper.getStyleAlarmList(user_num);
      //팔로우 리스트
      List<AlarmAllDTO> followList = userAlarmMapper.getFollowAlarmList(user_num);
      if(followList != null && followList.size() != 0) {
         System.out.println("팔로우 : " +followList.get(0).getFollowCheck());
      }
      //언급 리스트
      List<AlarmAllDTO> annotationList = userAlarmMapper.getAnnotationList(user_num);
      List<AlarmAllDTO> replyList = userAlarmMapper.getReplyList(user_num);
      List<AlarmAllDTO> reReplyList = userAlarmMapper.getRereplyList(user_num);
      List<AlarmAllDTO> tag_replyList = userAlarmMapper.getTag_replyList(user_num);
      List<AlarmAllDTO> tag_reReplyList =userAlarmMapper.getTag_reReplyList(user_num);
      List<AlarmAllDTO> cartQtyList = userAlarmMapper.getCartQtyList(user_num);
      List<AlarmAllDTO> cartPriceList = userAlarmMapper.getCartPriceList(user_num);
      List<AlarmAllDTO> buyAuctionList = userAlarmMapper.getBuyAuctionList(user_num);
      List<AlarmAllDTO> sellAuctionList = userAlarmMapper.getSellAuctionList(user_num);
      List<AlarmAllDTO> sellSuccessList = userAlarmMapper.getSellSuccessList(user_num);
      List<AlarmAllDTO> announceList =  userAlarmMapper.getAnnounceList(user_num);
      List<AlarmAllDTO> reportList = userAlarmMapper.getReportList(user_num);
      List<AlarmAllDTO> askReplyList = userAlarmMapper.getAskReplyList(user_num);
      List<AlarmAllDTO> buyDeadList = userAlarmMapper.getBuyDeadList(user_num);
      List<AlarmAllDTO> sellDeadList = userAlarmMapper.getSellDeadList(user_num);
      System.out.println("sellDead:"+sellDeadList.size());
      System.out.println("buyDead:"+buyDeadList.size());
      list.addAll(sellDeadList);
      list.addAll(buyDeadList);
      list.addAll(announceList);
      list.addAll(reportList);
      list.addAll(askReplyList);
      list.addAll(sellSuccessList);
      list.addAll(sellAuctionList);
      list.addAll(reReplyList);
      list.addAll(buyAuctionList);
      list.addAll(tag_reReplyList);
      list.addAll(replyList);
      list.addAll(tag_replyList);
      list.addAll(followList);
      list.addAll(annotationList);
      list.addAll(likeList);
      list.addAll(cartPriceList);
      list.addAll(cartQtyList);
      Comparator<AlarmAllDTO> com = new Comparator<AlarmAllDTO>() {
         @Override
         public int compare(AlarmAllDTO o1, AlarmAllDTO o2) {
            // TODO Auto-generated method stub
            return o2.getReg_date().compareTo(o1.getReg_date());
         }
      };
      Collections.sort(list, com);
      System.out.println("속도좀 볼까.");
      req.setAttribute("allList", list);
      return "user/alarm/alarm";
   }
   @RequestMapping("/alarmCheck.user")
   @ResponseBody
   public int user_alarmCheck(HttpSession session) {
      if(session.getAttribute("sessionUser_num")!=null) {
         int user_num = (int) session.getAttribute("sessionUser_num");
         int co = userAlarmMapper.userAlarmCheck(user_num);
         return co;
      }
      return 0;
   }
}