C_LONGINT:C283($n)
C_TEXT:C284($Confirm)
C_OBJECT:C1216($element)

$n:=Form:C1466.processSelection.length

If ($n>1)
	$Confirm:=Get localized string:C991("MONI_PROCESS_KillNprocesses")
	$Confirm:=Replace string:C233($Confirm;"<1>";String:C10($n))
Else 
	$Confirm:=Get localized string:C991("MONI_PROCESS_Kill1process")
End if 
CONFIRM:C162($Confirm)

If (OK=1)
	For each ($element;Form:C1466.processSelection)
		If ($element.ID#0)
			Monitor_HandleProcess_Server ($element.ID;"abort")
		End if 
	End for each 
	Monitor_InitValues ("process";"update")
End if 