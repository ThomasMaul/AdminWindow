If (Form:C1466.userSelection.length=0)
	//impossible car bouton désactivé
	//ALERT("Please, select users first")
Else 
	If (Form:C1466.userSelection.length<=1)
		var $MONI_Users_SendMessageInfos:=Localized string:C991("MONI_USERS_ThisMessageOneUser")
	Else 
		$MONI_Users_SendMessageInfos:=Localized string:C991("MONI_USERS_ThisMessageNUsers")  //"This message will be sent to <1> Users.")
		$MONI_Users_SendMessageInfos:=Replace string:C233($MONI_Users_SendMessageInfos; "<1>"; String:C10(Form:C1466.userSelection.length))
	End if 
	var $cancel:=Localized string:C991("MONI_USERS_Cancel")
	var $send:=Localized string:C991("MONI_USERS_Send")  //"Send"  
	
	var $message:=Request:C163($MONI_Users_SendMessageInfos; ""; $Send; $cancel)
	
	If (ok=1)
		var $element : Object
		For each ($element; Form:C1466.userSelection)
			Monitor_SendMessage_Server($message; $element.ID)
		End for each 
		
	End if 
End if 


