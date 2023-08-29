package com.ezen.kream.dto;

public class ProdSearchDTO {
	private int prod_num;
	private String prod_img1;
	private String subject;
	private int prod_price;
	private String del;
	
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	public String getProd_img1() {
		return prod_img1;
	}
	public void setProd_img1(String prod_img1) {
		this.prod_img1 = prod_img1;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
}
