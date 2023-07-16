package com.sk.goodogs.ws;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

@ServerEndpoint(value="/webSocket", configurator =WebSocketConfigurator.class )
public class WebSocket extends Endpoint {

	public static Map<String, Session> clientMap = 
			Collections.synchronizedMap(new HashMap<>());
	
	private static void log() {
		System.out.println("[현재 접속자수 : " + clientMap.size() + "명] " + clientMap);
	}
	
	@Override
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
		try {
		Session wsSession = clientMap.get(receiver);
		Basic basic = wsSession.getBasicRemote();
			basic.sendText(message);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@OnError
	public void onError(Throwable e) {
		System.out.println("error");
		e.printStackTrace();
	}
	
	@Override
	public void onClose(Session session, CloseReason closeReason) {
		System.out.println("close");
		Map<String, Object> sessionProperties = session.getUserProperties();
		String memberId = (String) sessionProperties.get("memberId");
		clientMap.remove(memberId); // 해당 memberId의 WebSocket Session객체 제거
		log();
		
		super.onClose(session, closeReason);
	}

}
