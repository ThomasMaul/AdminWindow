//%attributes = {"shared":true}
#DECLARE($in : Object)->$out : Object

If (This:C1470.uuid=Form:C1466.RTMSelected.uuid)
	If (Bool:C1537(This:C1470.done))
		$out:=New object:C1471("fill"; "DarkGrey")
	Else 
		$out:=New object:C1471("fill"; "LightBlue")
	End if 
Else 
	
	If (Bool:C1537(This:C1470.done))
		$out:=New object:C1471("fill"; "LightGrey")
	Else 
		$out:=New object:C1471("fill"; "white")
	End if 
End if 