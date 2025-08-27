var $element : Object

For each ($element; Form:C1466.processSelection)
	If ($element.ID#0)
		Monitor_HandleProcess_Server($element.ID; "Pause")
	End if 
End for each 
Monitor_InitValues("process"; "update")
