<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="com.sh.mvc.member.model.vo.Gender"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	// 기본적으로 다 String 으로 출력됨. not null 이랑 null 만 구별 잘 해주면 됨
	String memberId = loginMember.getMemberId();
	String name = loginMember.getName();
	Date _birthday = loginMember.getBirthday();
	Gender gender = loginMember.getGender();
	String email = loginMember.getEmail();
	String phone = loginMember.getPhone();
	int point = loginMember.getPoint();
	String hobby = loginMember.getHobby();
	
	// null값 노출 방지용
	String birthday = _birthday != null ? _birthday.toString() : "";
	email = email != null ? email : ""; 
	
	// 취미 List로 처리하기
	// why ? 예를들어 취미에 운동, 개운동시키기 두개가 있다고 가정했을 때 내 취미가 개운동시키기인데 List 없이 일반 String 처리 후 contains로 코드를 짜면
	// '운동' 이 들어간게 체크되기 때문에 운동, 개운동시키기 모두 내 취미로 보기 때문에 List 처리해주는게 좋다.
	List<String> hobbies = null;
	if(hobby != null){
		// asList ? asList(~~) ~~부분을 List로 바꿔줌
		hobbies = Arrays.asList(hobby.split(","));
	}
%>
<section id=enroll-container>
	<h2>회원 정보</h2>
	<form name="memberUpdateFrm" method="post">
		<table>
			<tr>
				<th>아이디<sup>*</sup></th>
				<td>
					<input type="text" name="memberId" id="memberId" value="<%= memberId %>" readonly>
				</td>
			</tr>
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="name" id="name" value="<%= name %>"  required><br>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>	
				<input type="date" name="birthday" id="birthday" value="<%= birthday %>"><br>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" name="email" id="email" value="<%= email %>"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="<%= phone %>" required><br>
				</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>	
					<input type="text" placeholder="" name="point" id="point" value="<%= point %>" readonly><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>	
						 <!-- 이넘 비교는 equals 아니고 == 해도 아무 상관 없음 -->
			       		 <input type="radio" name="gender" id="gender0" value="M" <%= gender == Gender.M ? "checked" : "" %>>
						 <label for="gender0">남</label>
						 <input type="radio" name="gender" id="gender1" value="F" <%= gender == Gender.M ? "checked" : "" %>>
						 <label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동" <%= hobbies != null && hobbies.contains("운동") ? "checked" : "" %>><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산" <%= hobbies != null && hobbies.contains("등산") ? "checked" : "" %>><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서" <%= hobbies != null && hobbies.contains("독서") ? "checked" : "" %>><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임" <%= hobbies != null && hobbies.contains("게임") ? "checked" : "" %>><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행" <%= hobbies != null && hobbies.contains("여행") ? "checked" : "" %>><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
        <input type="submit" value="정보수정"/>
        <input type="button" onclick="deleteMember();" value="탈퇴"/>
	</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
