package com.wss.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Message {

	private int code;

	private String msg;

	private Map<String, Object> extend = new HashMap<String, Object>();
	
	public static Message success() {
		Message message = new Message();
		message.setCode(200);
		message.setMsg("request success");
		return message;
	}
	public static Message fail() {
		Message message = new Message();
		message.setCode(100);
		message.setMsg("request fail");
		return message;
	}

	public Message add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}
