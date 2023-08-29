package com.ezen.kream.dto;

import java.util.List;

public class ReplyAllDTO {
	private int reply_num;
	private int style_num;
	private int user_num;
	private int reply_group;
	private int reply_step;
	private String reply_contents;
	private String reg_date;
	private String profile_name;
	private String profile_img;
	private List<String> replyContentList;
	private List<String> replyWriterList;
	private List<HashTagBaseDTO> replyHashTagList;

	public List<String> getReplyContentList() {
		return replyContentList;
	}
	public void setReplyContentList(List<String> replyContentList) {
		this.replyContentList = replyContentList;
	}
	public List<String> getReplyWriterList() {
		return replyWriterList;
	}
	public void setReplyWriterList(List<String> replyWriterList) {
		this.replyWriterList = replyWriterList;
	}
	public List<HashTagBaseDTO> getReplyHashTagList() {
		return replyHashTagList;
	}
	public void setReplyHashTagList(List<HashTagBaseDTO> replyHashTagList) {
		this.replyHashTagList = replyHashTagList;
	}
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public int getStyle_num() {
		return style_num;
	}
	public void setStyle_num(int style_num) {
		this.style_num = style_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getReply_group() {
		return reply_group;
	}
	public void setReply_group(int reply_group) {
		this.reply_group = reply_group;
	}
	public int getReply_step() {
		return reply_step;
	}
	public void setReply_step(int reply_step) {
		this.reply_step = reply_step;
	}
	public String getReply_contents() {
		return reply_contents;
	}
	public void setReply_contents(String reply_contents) {
		this.reply_contents = reply_contents;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
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
	
}
