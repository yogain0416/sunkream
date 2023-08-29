package com.ezen.kream.dto;

public class FollowCheckDTO {
	private int user_num;
	private String profile_name;
	private String profile_img;
	private int checkFollowing;
	private String name;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
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
	public int getCheckFollowing() {
		return checkFollowing;
	}
	public void setCheckFollowing(int checkFollowing) {
		this.checkFollowing = checkFollowing;
	}
	
}
