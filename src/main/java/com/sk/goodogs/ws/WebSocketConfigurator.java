package com.sk.goodogs.ws;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import com.sk.goodogs.member.model.vo.Member;

public class WebSocketConfigurator extends Configurator {

		@Override
		public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
			System.out.println("WebSocketConfigurator#modifyHandshake 실행");
			HttpSession httpSession = (HttpSession) request.getHttpSession();
			
			// memberId 관리
			Member loginMember = (Member) httpSession.getAttribute("loginMember");
			String memberId = loginMember.getMemberId();
			
			Map<String, Object> configProperties = sec.getUserProperties();
			configProperties.put("memberId", memberId);
			
		}
		
		
}
