package com.ezen.kream.dto;

public class BuyInfoDTO {
   private int buyInfo_num;
   private int buy_num;
   private int user_num;
   private int prod_group;
   private String name;
   private String phone_num;
   private String address1;
   private String address2;
   private String address3;
   public int getBuyInfo_num() {
      return buyInfo_num;
   }
   public void setBuyInfo_num(int buyInfo_num) {
      this.buyInfo_num = buyInfo_num;
   }
   public int getBuy_num() {
      return buy_num;
   }
   public void setBuy_num(int buy_num) {
      this.buy_num = buy_num;
   }
   public int getUser_num() {
      return user_num;
   }
   public void setUser_num(int user_num) {
      this.user_num = user_num;
   }
   public int getProd_group() {
      return prod_group;
   }
   public void setProd_group(int prod_group) {
      this.prod_group = prod_group;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getPhone_num() {
      return phone_num;
   }
   public void setPhone_num(String phone_num) {
      this.phone_num = phone_num;
   }
   public String getAddress1() {
      return address1;
   }
   public void setAddress1(String address1) {
      this.address1 = address1;
   }
   public String getAddress2() {
      return address2;
   }
   public void setAddress2(String address2) {
      this.address2 = address2;
   }
   public String getAddress3() {
      return address3;
   }
   public void setAddress3(String address3) {
      this.address3 = address3;
   }
   public String getBank_name() {
      return bank_name;
   }
   public void setBank_name(String bank_name) {
      this.bank_name = bank_name;
   }
   public String getCard_num() {
      return card_num;
   }
   public void setCard_num(String card_num) {
      this.card_num = card_num;
   }
   public String getCard_date() {
      return card_date;
   }
   public void setCard_date(String card_date) {
      this.card_date = card_date;
   }
   private String bank_name;
   private String card_num;
   private String card_date;
   
   
}