//%attributes = {"invisible":true,"executedOnServer":true}
  // drop process, executed on the server
C_LONGINT:C283($1)
C_TEXT:C284($2)

Case of 
	: ($2="Abort")
		ABORT PROCESS BY ID:C1634($1)
		
	: ($2="Pause")
		PAUSE PROCESS:C319($1)
		
	: ($2="Resume")
		RESUME PROCESS:C320($1)
End case 