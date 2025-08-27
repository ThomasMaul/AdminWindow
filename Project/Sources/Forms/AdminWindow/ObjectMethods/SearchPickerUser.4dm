//Searchpicker sample code

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		// Init the var itself
		// this can be done anywhere else in your code
		var $ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		var $ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		var $title:=Localized string:C991("MONI_USERS_PlaceHolder")
		SearchPicker SET HELP TEXT($ObjectName; $title)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		$ptr:=OBJECT Get pointer:C1124(Object current:K67:2)
		
		var $search : Text:=$ptr->  // vsearch  //Form.userSearch
		If ($search#"")
			$search:="@"+$search+"@"
			Form:C1466.user:=Form:C1466.userAll.query("machineName = :1 or systemUserName = :1 or userName = :1"; $search)
		Else 
			Form:C1466.user:=Form:C1466.userAll
		End if 
End case 
