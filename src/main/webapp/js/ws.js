/**
 * ws.js
 * 로그인한 사용자용 웹소켓 연결처리
 */
const ws = new WebSocket(`ws://${location.host}/mvc/helloWebSocket`); // 서버측 endpoint 연결
console.log(location.host);

ws.addEventListener('open', (e) => {
	console.log('open : ', e);
});

ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	
	const {messageType, createdAt, message, sender} = JSON.parse(e.data);
	console.log(messageType, createdAt, message, sender);
	
	switch(messageType) {
		case 'CHAT_MESSAGE' : 
			const ul = document.querySelector("#chat-container ul");
			ul.insertAdjacentHTML('beforeend', `
				<li class="left">
					<span class="badge">${sender}</span>
					${message}
				</li>
			`);
			
			break;
		case 'NEW_BOARD_COMMENT' : 
			const wrapper = document.querySelector("#notification");
			const i = document.createElement("i");
			i.classList.add("fa-solid", "fa-bell", "bell");
			i.onclick = () => {
				alert(message);
				i.remove();
			};
			wrapper.append(i);
			break;
	}
	
	
	
	
	
});

ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});

ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});