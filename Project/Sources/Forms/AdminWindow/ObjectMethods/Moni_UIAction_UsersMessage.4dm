C_TEXT:C284($MONI_Users_SendMessageInfos;$message;$send;$cancel)
C_OBJECT:C1216($element)


If (Form:C1466.userSelection.length=0)
	  //impossible car bouton désactivé
	  //ALERT("Please, select users first")
Else 
	If (Form:C1466.userSelection.length<=1)
		$MONI_Users_SendMessageInfos:=Get localized string:C991("MONI_USERS_ThisMessageOneUser")
	Else 
		$MONI_Users_SendMessageInfos:=Get localized string:C991("MONI_USERS_ThisMessageNUsers")  //"This message will be sent to <1> Users.")
		$MONI_Users_SendMessageInfos:=Replace string:C233($MONI_Users_SendMessageInfos;"<1>";String:C10(Form:C1466.userSelection.length))
	End if 
	$cancel:=Get localized string:C991("MONI_USERS_Cancel")
	$send:=Get localized string:C991("MONI_USERS_Send")  //"Send"  
	
	$message:=Request:C163($MONI_Users_SendMessageInfos;"";$Send;$cancel)
	
	If (ok=1)
		
		For each ($element;Form:C1466.userSelection)
			Monitor_SendMessage_Server ($message;$element.ID)
		End for each 
		
	End if 
End if 


