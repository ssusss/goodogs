
const ws = new WebSocket(`ws://${location.host}/goodogs/webSocket`); // 서버측 endpoint 연결
console.log(location.host);

ws.addEventListener('open', (e) => {
	console.log('open : ', e);
});



ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	
	const {messageType,no, comemt, receiver, hasRead} = JSON.parse(e.data);
	console.log(no, comemt, receiver, hasRead);
	
	switch(messageType) {
	
		case 'ALARM_MESSAGE' : 
			const wrapper = document.querySelector("#notification");
			if(!wrapper.hasChildNodes()){

				const img = document.createElement("img");
				img.src = "<%= request.getContextPath() %>/images/character/goodogs_ureka2.png";
				img.classList.add("bell");
				img.onclick = () => {
					alert(comemt);
					img.remove();
				};
				wrapper.append(img);
				
			}
			break;
				
			
				
				
	}
	
	
	
	
});

ws.addEventListener('error', (e) => {
	console.log('error : ', e);
});

ws.addEventListener('close', (e) => {
	console.log('close : ', e);
});