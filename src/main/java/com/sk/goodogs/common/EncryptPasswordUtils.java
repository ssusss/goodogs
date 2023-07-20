package com.sk.goodogs.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;

/**
 * @author Sookyeong
 * - 비밀번호 암호화
 *
 */
public class EncryptPasswordUtils {

	public static String getEncryptedPassword(String rawPassword, String salt) {
		String encryptedPassword = null;
		// 1. 암호화
		byte[] output = null;
		try {
			// SHA-512 알고리즘 사용
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] input = rawPassword.getBytes("utf-8");
			// salt = memerId 사용
			byte[] saltBytes = salt.getBytes("utf-8");
			md.update(saltBytes); // salt 추가
			output = md.digest(input);
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println(new String(output));
		
		// 2. 인코딩
		Encoder encoder = Base64.getEncoder();
		encryptedPassword = encoder.encodeToString(output);
		System.out.println("encryptedPassword="+encryptedPassword);
		
		return encryptedPassword;
	}

	
	
	
	
}
