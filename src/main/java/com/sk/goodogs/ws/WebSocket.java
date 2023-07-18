package com.sk.goodogs.ws;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.admin.model.vo.Alarm;

@ServerEndpoint(value="/webSocket", configurator =WebSocketConfigurator.class )
public class WebSocket{
	private static final AdminService adminService =new AdminService();

	public static Map<String, Session> clientMap = 
			Collections.synchronizedMap(new HashMap<>());
	public static Map<String, Session> notLoginClientMap = 
			Collections.synchronizedMap(new HashMap<>());
	private static void log() {
		System.out.println("[현재 접속자수 : " + clientMap.size() + "명] " + clientMap);
	}
	
//	@Override
	@OnOpen
	public void onOpen(Session session, EndpointConfig config) {
		System.out.println("open");
		
		Map<String, Object> configProperties = config.getUserProperties();
		String memberId = (String) configProperties.get("memberId");
		
		clientMap.put(memberId, session);
		
		Map<String, Object> sessionProperties = session.getUserProperties();
		sessionProperties.put("memberId", memberId); 
		
		
		
		log();
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		
		
		System.out.println("message : " + message);
		Map<String, Object> payload = new Gson().fromJson(message, Map.class);
		System.out.println("payload from message : " + payload);
		String receiver =(String)payload.get("receiver");
		System.out.println(receiver);
		
		
		//알람 디비 인설트
		int result=adminService.insertAlarm(payload);
		System.out.println(result);
		
		try {
			Session wsSession = clientMap.get(receiver);
			
			if(wsSession != null && wsSession.isOpen()) {
				Basic basic = wsSession.getBasicRemote();
				basic.sendText(message);
			}else {
				
			}
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@OnError
	public void onError(Throwable e) {
		System.out.println("error");
		e.printStackTrace();
	}
	
//	@Override
	@OnClose
	public void onClose(Session session, CloseReason closeReason) {
		System.out.println("close");
		Map<String, Object> sessionProperties = session.getUserProperties();
		String memberId = (String) sessionProperties.get("memberId");
		clientMap.remove(memberId); // 해당 memberId의 WebSocket Session객체 제거
		log();
		
//		super.onClose(session, closeReason);
	}

}
