package com.ezen.kream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class KakaoLoginBO {
	private final static String K_CLIENT_ID="fe10a9d0080a3c5ccd8c56674f011006";
	private final static String  K_REDIRECT_URI = "http://localhost:8081";
	private final static String KL_REDIRECT_URI = "http://localhost:8081/kream/kakaoLoginOk";//callback
	public String getAuthorize() {
		return "https://kauth.kakao.com/oauth/authorize?client_id="+K_CLIENT_ID+"&redirect_uri="+KL_REDIRECT_URI+"&response_type=code";
	}
	public String getAccessToken(String code) {
		String accessToken = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=fe10a9d0080a3c5ccd8c56674f011006");
			sb.append("&redirect_uri=http://localhost:8081/kream/kakaoLoginOk");
			sb.append("&code="+code);
			bw.write(sb.toString());
			bw.flush();
			int res = con.getResponseCode();
			//결과 코드 200이면 성공
			System.out.println("res = "+res);
			//여기까지 오는데 401?
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = "";
			String result = "";
			while((line=br.readLine())!=null) {
				result += line;
			}
			System.out.println("response body ="+result);
			JsonParser parser = new JsonParser();
			JsonElement el = parser.parse(result);
			accessToken = el.getAsJsonObject().get("access_token").getAsString();
			System.out.println("accessToken="+accessToken);
			refresh_Token = el.getAsJsonObject().get("refresh_token").getAsString();
			System.out.println("accessToken="+accessToken);
			System.out.println("refreshToken="+refresh_Token);
			br.close();
			bw.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return accessToken;
	}
	
	public HashMap<String,Object> kakaoUserInfo(String accessToken){
		HashMap<String,Object> userInfo	 = new HashMap<String,Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		System.out.println(reqURL);
		try {
			URL url = new URL(reqURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", "Bearer "+accessToken);
			int res = con.getResponseCode();
			System.out.println("response code = "+res);
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = "";
			String result = "";
			while((line = br.readLine())!=null) {
				result += line;
			}
			JsonParser parser = new JsonParser();
			JsonElement el = parser.parse(result);
			JsonObject kakao_account = el.getAsJsonObject().get("kakao_account").getAsJsonObject();
			JsonObject properties = el.getAsJsonObject().get("properties").getAsJsonObject();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			String name = kakao_account.getAsJsonObject().get("name").getAsString();
			String birthyear = kakao_account.getAsJsonObject().get("birthyear").getAsString();
			String birthday = kakao_account.getAsJsonObject().get("birthday").getAsString();
			String birth = birthyear + birthday;
			String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
			String hp = kakao_account.getAsJsonObject().get("phone_number").getAsString();
			String[] hpS = hp.substring(4).split("-");
			String phone = "0"+hpS[0]+hpS[1]+hpS[2];
			userInfo.put("email", email);
			userInfo.put("name", name);
			userInfo.put("birth", birth);
			userInfo.put("gender", gender);
			userInfo.put("phone", phone);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
}