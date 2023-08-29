package com.ezen.kream.dto;

public class CardDTO {
	private int myCard_num;
	private int user_num;
	private String bank_name;
	private String card_num;
	private String card_date;
	private String basic;

	
	public int getMyCard_num() {
		return myCard_num;
	}
	public void setMyCard_num(int myCard_num) {
		this.myCard_num = myCard_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getCard_num() {
		return card_num;
	}
	public void setCard_num(String card_num) {
		this.card_num = card_num;
	}
	public String getCard_date() {
		return card_date;
	}
	public void setCard_date(String card_date) {
		this.card_date = card_date;
	}
	
	public String getBasic() {
		return basic;
	}
	public void setBasic(String basic) {
		this.basic = basic;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	
}
