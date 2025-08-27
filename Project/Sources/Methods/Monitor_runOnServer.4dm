//%attributes = {"invisible":true,"executedOnServer":true}
#DECLARE($job : Text)

Case of 
	: ($1="Backup")
		BACKUP:C887
		
	: ($1="Restart")
		RESTART 4D:C1292
		
	: ($1="Verify")
		VERIFY CURRENT DATA FILE:C1008
		
	: ($1="DebugLog")
		var $status:=Get database parameter:C643(Debug log recording:K37:34)
		If ($status=0)
			SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 3)
		Else 
			SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 0)
		End if 
		
	: ($1="RequestLog")
		$status:=Get database parameter:C643(4D Server log recording:K37:28)
		If ($status=0)
			SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 1)
		Else 
			SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)
		End if 
		
	: ($1="DiagnosticLog")
		$status:=Get database parameter:C643(Diagnostic log recording:K37:69)
		If ($status=0)
			SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 1)
		Else 
			SET DATABASE PARAMETER:C642(Diagnostic log recording:K37:69; 0)
		End if 
		
	: ($1="AllowAppServerConnect")
		REJECT NEW REMOTE CONNECTIONS:C1635(False:C215)
	: ($1="DisallowAppServerConnect")
		REJECT NEW REMOTE CONNECTIONS:C1635(True:C214)
		
	: ($1="StartHTTPServer")
		WEB START SERVER:C617
	: ($1="StopHTTPServer")
		WEB STOP SERVER:C618
		
End case 