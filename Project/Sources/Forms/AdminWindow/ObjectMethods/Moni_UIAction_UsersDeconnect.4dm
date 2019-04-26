C_TEXT:C284($Confirm)
C_OBJECT:C1216($element)

If (Form:C1466.userSelection.length>0)
	If (Form:C1466.userSelection.length>1)
		$Confirm:=Get localized string:C991("MONI_USERS_DropNusers")
		$Confirm:=Replace string:C233($Confirm;"<1>";String:C10(Form:C1466.userSelection.length))
	Else 
		$Confirm:=Get localized string:C991("MONI_USERS_Drop1user")
	End if 
	CONFIRM:C162($Confirm)
	If (OK=1)
		For each ($element;Form:C1466.userSelection)
			Monitor_DropUser_Server ($element.ID)
		End for each 
	End if 
	Monitor_InitValues ("user";"update")
End if 