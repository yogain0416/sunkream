package com.ezen.kream;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverLoginApi extends DefaultApi20 {
	
	 protected NaverLoginApi(){
	    }
	 
	    private static class InstanceHolder{
	        private static final NaverLoginApi INSTANCE = new NaverLoginApi();
	    }
	 
	 
	    public static NaverLoginApi instance(){
	        return InstanceHolder.INSTANCE;
	    }
	    // 토큰과 관련된 API는 해당 메소드가 반환하는 URL을 토대로 사용
	    @Override
	    public String getAccessTokenEndpoint() {
	        return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	    }                   
	    //인증과 관련된 API는 해당 메소드가 반환하는 URL을 토대로 사용
	    @Override
	    protected String getAuthorizationBaseUrl() {
	        return "https://nid.naver.com/oauth2.0/authorize";
	    }   
	}

