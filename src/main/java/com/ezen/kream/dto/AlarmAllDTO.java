package com.ezen.kream.dto;

public class AlarmAllDTO {
	private int alarm_num; 
	private int getUser_num; // 받는사람
	private int sendUser_num; // 보내는사람
	private String alarm_kind; // [Style]like , follow ,style_reply,style_subReply,tag_id,
							//[product]cart_qty,cart_price,buy_auction,sell_auction
								//[admin]admin_reply,notice,penalty
	private int alarm_kind_num;//글 혹은 상품번호 
	private String reg_date;//알람 등록일
	private String isChecked;
	private int buy_num;
	private int sell_num;
	private String prod_size;
	private String prod_kr_subject;
	private int prod_price;
	private String profile_name;
	private String profile_img;
	private int penalty;
	private String admin_info;
	private String qna_subject;
	private String style_img1;
	private int followCheck;
	private String myProfile_name;
	private int style_num;
	private String auction;
	private String info;
	public int getAlarm_num() {
		return alarm_num;
	}
	public void setAlarm_num(int alarm_num) {
		this.alarm_num = alarm_num;
	}
	public int getGetUser_num() {
		return getUser_num;
	}
	public void setGetUser_num(int getUser_num) {
		this.getUser_num = getUser_num;
	}
	public int getSendUser_num() {
		return sendUser_num;
	}
	public void setSendUser_num(int sendUser_num) {
		this.sendUser_num = sendUser_num;
	}
	public String getAlarm_kind() {
		return alarm_kind;
	}
	public void setAlarm_kind(String alarm_kind) {
		this.alarm_kind = alarm_kind;
	}
	public int getAlarm_kind_num() {
		return alarm_kind_num;
	}
	public void setAlarm_kind_num(int alarm_kind_num) {
		this.alarm_kind_num = alarm_kind_num;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}
	public String getProd_kr_subject() {
		return prod_kr_subject;
	}
	public void setProd_kr_subject(String prod_kr_subject) {
		this.prod_kr_subject = prod_kr_subject;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProfile_name() {
		return profile_name;
	}
	public void setProfile_name(String profile_name) {
		this.profile_name = profile_name;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public int getPenalty() {
		return penalty;
	}
	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}
	public String getAdmin_info() {
		return admin_info;
	}
	public void setAdmin_info(String admin_info) {
		this.admin_info = admin_info;
	}
	public String getQna_subject() {
		return qna_subject;
	}
	public void setQna_subject(String qna_subject) {
		this.qna_subject = qna_subject;
	}
	public String getStyle_img1() {
		return style_img1;
	}
	public void setStyle_img1(String style_img1) {
		this.style_img1 = style_img1;
	}
	public int getFollowCheck() {
		return followCheck;
	}
	public void setFollowCheck(int followCheck) {
		this.followCheck = followCheck;
	}
	public String getMyProfile_name() {
		return myProfile_name;
	}
	public void setMyProfile_name(String myProfile_name) {
		this.myProfile_name = myProfile_name;
	}
	public int getStyle_num() {
		return style_num;
	}
	public void setStyle_num(int style_num) {
		this.style_num = style_num;
	}
	public String getProd_size() {
		return prod_size;
	}
	public void setProd_size(String prod_size) {
		this.prod_size = prod_size;
	}
	public int getBuy_num() {
		return buy_num;
	}
	public void setBuy_num(int buy_num) {
		this.buy_num = buy_num;
	}
	public int getSell_num() {
		return sell_num;
	}
	public void setSell_num(int sell_num) {
		this.sell_num = sell_num;
	}
	public String getAuction() {
		return auction;
	}
	public void setAuction(String auction) {
		this.auction = auction;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
}
