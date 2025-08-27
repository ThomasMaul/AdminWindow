var $PauseString:=Localized string:C991("MONI_RTM_Pause")
var $ResumeString:=Localized string:C991("MONI_RTM_Resume")

var $current:=OBJECT Get title:C1068(*; "BtnPause")
If ($current=$PauseString)
	OBJECT SET TITLE:C194(*; "BtnPause"; $ResumeString)
	SET TIMER:C645(0)
Else 
	OBJECT SET TITLE:C194(*; "BtnPause"; $PauseString)
	SET TIMER:C645(60)
End if 