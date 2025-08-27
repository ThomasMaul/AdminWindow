If (Form:C1466.userSelection.length>0)
	If (Form:C1466.userSelection.length>1)
		var $Confirm:=Localized string:C991("MONI_USERS_DropNusers")
		$Confirm:=Replace string:C233($Confirm; "<1>"; String:C10(Form:C1466.userSelection.length))
	Else 
		$Confirm:=Localized string:C991("MONI_USERS_Drop1user")
	End if 
	CONFIRM:C162($Confirm)
	If (OK=1)
		var $element : Object
		For each ($element; Form:C1466.userSelection)
			Monitor_DropUser_Server($element.ID)
		End for each 
	End if 
	Monitor_InitValues("user"; "update")
End if 