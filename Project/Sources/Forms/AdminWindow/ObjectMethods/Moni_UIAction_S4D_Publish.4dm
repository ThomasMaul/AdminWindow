If (Form:C1466.application.newConnectionsAllowed)
	Monitor_runOnServer ("DisallowAppServerConnect")
	OBJECT SET TITLE:C194(*;"Moni_UIAction_S4D_Publish";Get localized string:C991("MONI_S4D_StartPublish"))
Else 
	Monitor_runOnServer ("AllowAppServerConnect")
	OBJECT SET TITLE:C194(*;"Moni_UIAction_S4D_Publish";Get localized string:C991("MONI_S4D_StopPublish"))
End if 