
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

			
			wrapper.innerHTML =`<img src="/goodogs/images/character/goodogs_ureka2.png" class="bell" style="width: 150px">`;
            const img = document.createElement("img");
 
 			const notificationContainer = document.querySelector("#notification-container");
				notificationContainer.insertAdjacentHTML('beforeend', `
					<div class="alarmMenu">
						
		 			</div>	
			`);
			
			const alarmMenuBox = document.querySelector(".alarmMenu");
			alarmMenuBox.innerHTML=`
				<p>${comemt}</P>
			`;
 				
            img.onclick = () => {
        	
            const memberId=`${receiver}`;
            console.log(memberId);
		    $.ajax({
		        url : "/goodogs/alarm/liveAlarmChecked",
		        data : memberId,
		        method : "POST",
		        dataType : "json",
		        success(response) {
		            console.log(response.result);
		     		}	
	   		 });
               
            };
            
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