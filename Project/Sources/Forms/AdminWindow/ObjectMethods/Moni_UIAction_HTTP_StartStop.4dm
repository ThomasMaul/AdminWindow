If (Form:C1466.web.started)
	Monitor_runOnServer ("StopHTTPServer")
	OBJECT SET TITLE:C194(*;"Moni_UIAction_HTTP_StartStop";Get localized string:C991("MONI_HTTP_StartHTTPServer"))
Else 
	Monitor_runOnServer ("StartHTTPServer")
	OBJECT SET TITLE:C194(*;"Moni_UIAction_HTTP_StartStop";Get localized string:C991("MONI_HTTP_StopHTTPServer"))
End if 