package com.ezen.kream.dto;

public class AlarmDTO {
	private int alarm_num;
	private int getUser_num;
	private int sendUser_num;
	private String alarm_kind;
	private int alarm_kind_num;
	private int prod_price;
	private String cart_alarm_type;
	private String reg_date;
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
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getCart_alarm_type() {
		return cart_alarm_type;
	}
	public void setCart_alarm_type(String cart_alarm_type) {
		this.cart_alarm_type = cart_alarm_type;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
}
