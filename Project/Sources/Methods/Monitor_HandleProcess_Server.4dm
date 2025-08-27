//%attributes = {"invisible":true,"executedOnServer":true}
// drop process, executed on the server
#DECLARE($process : Integer; $job : Text)

Case of 
	: ($job="Abort")
		ABORT PROCESS BY ID:C1634($process)
		
	: ($job="Pause")
		PAUSE PROCESS:C319($process)
		
	: ($job="Resume")
		RESUME PROCESS:C320($process)
End case 