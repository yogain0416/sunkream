package com.ezen.kream.dto;

public class PickCateListDTO {
	private int cate_num;
	private String tab_name;
	private String pick_name;
	private String pick_kr_name;
	
	public String getPick_kr_name() {
		return pick_kr_name;
	}
	public void setPick_kr_name(String pick_kr_name) {
		this.pick_kr_name = pick_kr_name;
	}
	public int getCate_num() {
		return cate_num;
	}
	public void setCate_num(int cate_num) {
		this.cate_num = cate_num;
	}
	public String getPick_name() {
		return pick_name;
	}
	public void setPick_name(String pick_name) {
		this.pick_name = pick_name;
	}
	public String getTab_name() {
		return tab_name;
	}
	public void setTab_name(String tab_name) {
		this.tab_name = tab_name;
	}
	
}
