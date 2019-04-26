//%attributes = {"shared":true}

C_OBJECT:C1216($0;$1)

If (This:C1470.uuid=Form:C1466.RTMSelected.uuid)
	If (Bool:C1537(This:C1470.done))
		$0:=New object:C1471("fill";"DarkGrey")
	Else 
		$0:=New object:C1471("fill";"LightBlue")
	End if 
Else 
	
	If (Bool:C1537(This:C1470.done))
		$0:=New object:C1471("fill";"LightGrey")
	Else 
		$0:=New object:C1471("fill";"white")
	End if 
End if 