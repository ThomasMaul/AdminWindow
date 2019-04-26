  //Searchpicker sample code

C_POINTER:C301($ptr)
C_TEXT:C284($ObjectName;$title;$search)

Case of 
		
	: (Form event:C388=On Load:K2:1)
		
		  // Init the var itself
		  // this can be done anywhere else in your code
		$ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		$title:=Get localized string:C991("MONI_USERS_PlaceHolder")
		SearchPicker SET HELP TEXT ($ObjectName;$title)
		
		
	: (Form event:C388=On Data Change:K2:15)
		$ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		$search:=$ptr->  // vsearch  //Form.userSearch
		If ($search#"")
			$search:="@"+$search+"@"
			Form:C1466.user:=Form:C1466.userAll.query("machineName = :1 or systemUserName = :1 or userName = :1";$search)
		Else 
			Form:C1466.user:=Form:C1466.userAll
		End if 
End case 
