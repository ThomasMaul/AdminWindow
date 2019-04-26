C_TEXT:C284($PauseString;$ResumeString;$current)

$PauseString:=Get localized string:C991("MONI_RTM_Pause")
$ResumeString:=Get localized string:C991("MONI_RTM_Resume")

$current:=OBJECT Get title:C1068(*;"BtnPause")
If ($current=$PauseString)
	OBJECT SET TITLE:C194(*;"BtnPause";$ResumeString)
	SET TIMER:C645(0)
Else 
	OBJECT SET TITLE:C194(*;"BtnPause";$PauseString)
	SET TIMER:C645(60)
End if 