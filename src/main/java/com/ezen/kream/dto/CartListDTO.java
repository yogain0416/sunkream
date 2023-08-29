package com.ezen.kream.dto;

public class CartListDTO {
	private int user_num;
	private int prod_num;
	private int prod_group;
	
	
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
	public int getProd_num() {
		return prod_num;
	}
	public void setProd_num(int prod_num) {
		this.prod_num = prod_num;
	}
	
}
