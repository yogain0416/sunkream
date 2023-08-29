package com.ezen.kream.dto;

public class SellProdDTO {
	private int sell_num;
	private int prod_group;
	private int user_num;
	private String prod_subject;
	private String cate_brand;
	private String prod_size;
	private int prod_price;
	private String start_date;
	private String end_date;
	private String sell_date;
	private String auction;
	
	public String getProd_subject() {
		return prod_subject;
	}
	public void setProd_subject(String prod_subject) {
		this.prod_subject = prod_subject;
	}
	public String getCate_brand() {
		return cate_brand;
	}
	public void setCate_brand(String cate_brand) {
		this.cate_brand = cate_brand;
	}
	public int getSell_num() {
		return sell_num;
	}
	public void setSell_num(int sell_num) {
		this.sell_num = sell_num;
	}
	public int getProd_group() {
		return prod_group;
	}
	public void setProd_group(int prod_group) {
		this.prod_group = prod_group;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public String getProd_size() {
		return prod_size;
	}
	public void setProd_size(String prod_size) {
		this.prod_size = prod_size;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSell_date() {
		return sell_date;
	}
	public void setSell_date(String sell_date) {
		this.sell_date = sell_date;
	}
	public String getAuction() {
		return auction;
	}
	public void setAuction(String auction) {
		this.auction = auction;
	}
	
}
