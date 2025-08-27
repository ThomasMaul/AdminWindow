var $n : Integer:=Form:C1466.processSelection.length

If ($n>1)
	var $Confirm:=Localized string:C991("MONI_PROCESS_KillNprocesses")
	$Confirm:=Replace string:C233($Confirm; "<1>"; String:C10($n))
Else 
	$Confirm:=Localized string:C991("MONI_PROCESS_Kill1process")
End if 
CONFIRM:C162($Confirm)

If (OK=1)
	var $element : Object
	For each ($element; Form:C1466.processSelection)
		If ($element.ID#0)
			Monitor_HandleProcess_Server($element.ID; "abort")
		End if 
	End for each 
	Monitor_InitValues("process"; "update")
End if 