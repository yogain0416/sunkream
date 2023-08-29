package com.ezen.kream.dto;

public class QnABoardDTO {
	private int qna_num;
	private int user_num;
	private int qna_step;
	private String qna_cate;
	private String qna_subCate;
	private String qna_subject;
	private String qna_contents;
	private int report_num;
	private String qna_process;
	private String reg_date;
	
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getQna_num() {
		return qna_num;
	}
	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
	}
	public int getUser_num() {
		return user_num;
	}
	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}
	public int getQna_step() {
		return qna_step;
	}
	public void setQna_step(int qna_step) {
		this.qna_step = qna_step;
	}
	public String getQna_cate() {
		return qna_cate;
	}
	public void setQna_cate(String qna_cate) {
		this.qna_cate = qna_cate;
	}
	public String getQna_subCate() {
		return qna_subCate;
	}
	public void setQna_subCate(String qna_subCate) {
		this.qna_subCate = qna_subCate;
	}
	public String getQna_subject() {
		return qna_subject;
	}
	public void setQna_subject(String qna_subject) {
		this.qna_subject = qna_subject;
	}
	public String getQna_contents() {
		return qna_contents;
	}
	public void setQna_contents(String qna_contents) {
		this.qna_contents = qna_contents;
	}
	public int getReport_num() {
		return report_num;
	}
	public void setReport_num(int report_num) {
		this.report_num = report_num;
	}
	public String getQna_process() {
		return qna_process;
	}
	public void setQna_process(String qna_process) {
		this.qna_process = qna_process;
	}
	
}
