package com.ezen.kream.dto;

import java.util.List;

public class StyleBoardAllDTO {
	private int style_num;
	private int user_num;
	private String style_contents;
	private int style_like;
	private String reg_date;
	private String profile_name;
	private String style_img1;
	private String style_img2;
	private String style_img3;
	private String style_img4;
	private String style_img5;
	private String profile_img;
	private int checkLike;
	private int checkBan;
	private int checkFollowing;
	private List<String> contentList;
	private List<String> writerList;
	private List<HashTagBaseDTO> hashTagList;
	private List<ProdSearchDTO> prod_tag_list;
	private int followerSu;
	
	public int getFollowerSu() {
		return followerSu;
	}

	public void setFollowerSu(int followerSu) {
		this.followerSu = followerSu;
	}

	public List<ProdSearchDTO> getProd_tag_list() {
		return prod_tag_list;
	}

	public void setProd_tag_list(List<ProdSearchDTO> prod_tag_list) {
		this.prod_tag_list = prod_tag_list;
	}

	public List<String> getContentList() {
		return contentList;
	}

	public void setContentList(List<String> contentList) {
		this.contentList = contentList;
	}

	public List<String> getWriterList() {
		return writerList;
	}

	public void setWriterList(List<String> writerList) {
		this.writerList = writerList;
	}

	public List<HashTagBaseDTO> getHashTagList() {
		return hashTagList;
	}

	public void setHashTagList(List<HashTagBaseDTO> hashTagList) {
		this.hashTagList = hashTagList;
	}

	public int getCheckFollowing() {
		return checkFollowing;
	}

	public void setCheckFollowing(int checkFollowing) {
		this.checkFollowing = checkFollowing;
	}

	public int getCheckBan() {
		return checkBan;
	}

	public void setCheckBan(int checkBan) {
		this.checkBan = checkBan;
	}

	public int getCheckLike() {
		return checkLike;
	}

	public void setCheckLike(int checkLike) {
		this.checkLike = checkLike;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getStyle_img1() {
		return style_img1;
	}

	public void setStyle_img1(String style_img1) {
		this.style_img1 = style_img1;
	}

	public String getStyle_img2() {
		return style_img2;
	}

	public void setStyle_img2(String style_img2) {
		this.style_img2 = style_img2;
	}

	public String getStyle_img3() {
		return style_img3;
	}

	public void setStyle_img3(String style_img3) {
		this.style_img3 = style_img3;
	}

	public String getStyle_img4() {
		return style_img4;
	}

	public void setStyle_img4(String style_img4) {
		this.style_img4 = style_img4;
	}

	public String getStyle_img5() {
		return style_img5;
	}

	public void setStyle_img5(String style_img5) {
		this.style_img5 = style_img5;
	}

	public int getStyle_num() {
		return style_num;
	}

	public void setStyle_num(int style_num) {
		this.style_num = style_num;
	}

	public String getStyle_contents() {
		return style_contents;
	}

	public void setStyle_contents(String style_contents) {
		this.style_contents = style_contents;
	}

	public int getStyle_like() {
		return style_like;
	}

	public void setStyle_like(int style_like) {
		this.style_like = style_like;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
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

}
