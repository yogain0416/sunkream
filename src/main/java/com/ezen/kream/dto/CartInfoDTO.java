package com.ezen.kream.dto;

public class CartInfoDTO {
	private int user_num;
	private int prod_num;
	private String cate_brand;
	private String prod_subject;
	private int prod_price;
	private String prod_img1;
	
	
	
	public String getProd_img1() {
		return prod_img1;
	}
	public void setProd_img1(String prod_img1) {
		this.prod_img1 = prod_img1;
	}
	public String getCate_brand() {
		return cate_brand;
	}
	public void setCate_brand(String cate_brand) {
		this.cate_brand = cate_brand;
	}
	public String getProd_subject() {
		return prod_subject;
	}
	public void setProd_subject(String prod_subject) {
		this.prod_subject = prod_subject;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	
}
