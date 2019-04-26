//%attributes = {"invisible":true,"executedOnServer":true}
  // executed on 4D Server to get server values
  // $1 = what values, $0 result as object

C_TEXT:C284($1)
C_OBJECT:C1216($0)

C_OBJECT:C1216($maintenance;$object;$sql;$obactivity)
C_TEXT:C284($compact;$dom;$Found;$verify;$text)
C_COLLECTION:C1488($col)
C_LONGINT:C283($i;$sqlconnectionhandler)

Case of 
	: ($1="system")
		$0:=Get system info:C1571
		If (Is macOS:C1572)
			$0.architecture:="Mac"
		Else 
			$0.architecture:="Windows"
		End if 
		
	: ($1="application")
		$0:=Get application info:C1599
		
	: ($1="license")
		$0:=Get license info:C1489
		
	: ($1="version")
		C_LONGINT:C283($build)
		C_TEXT:C284($version)
		$version:=Application version:C493($build)
		C_OBJECT:C1216($result)
		$result:=New object:C1471("version";$version;"build";$build)
		$0:=$result
		
	: ($1="user")
		$0:=Get process activity:C1495(Sessions only:K5:36)
		If ($0=Null:C1517)
			$0:=New object:C1471("sessions";New object:C1471)
		End if 
	: ($1="process")
		$0:=Get process activity:C1495(Processes only:K5:35)
	: ($1="userAndProcess")
		$0:=Get process activity:C1495
		
	: ($1="maintenance")
		$maintenance:=New object:C1471
		C_DATE:C307($date1)
		C_TIME:C306($time1)
		C_TEXT:C284($text1)
		C_REAL:C285($num1)
		GET BACKUP INFORMATION:C888(Last backup date:K54:1;$date1;$time1)
		$maintenance.lastBackupText:=String:C10($date1)+" - "+String:C10($time1)
		GET BACKUP INFORMATION:C888(Next backup date:K54:3;$date1;$time1)
		$maintenance.nextBackupText:=String:C10($date1)+" - "+String:C10($time1)
		GET BACKUP INFORMATION:C888(Last backup status:K54:2;$num1;$text1)
		$maintenance.BackupStatus:=$text1
		
		
		$compact:=Get 4D file:C1418(Compacting log file:K5:38)
		If ($compact#"")
			$dom:=DOM Parse XML source:C719($compact)
			If (OK=0)
				$maintenance.compact:=Get localized string:C991("MONI_MNTCE_VerificationLogDamaged")
			Else 
				$Found:=DOM Find XML element:C864($dom;"verifylog/stop_timer")
				If (OK=1)
					C_TEXT:C284($time;$success;$cancel)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"time";$time)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"success";$success)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"user_canceled";$cancel)
					$maintenance.compact:=$time
					If ($cancel="true")
						$maintenance.compact:=$maintenance.compact+"  "+Get localized string:C991("MONI_MNTCE_VerificationCanceledByUser")
					Else 
						If ($success="true")
							$maintenance.compact:=$maintenance.compact+"  "+Get localized string:C991("MONI_MNTCE_CompactingSucceeded")
						Else 
							$maintenance.compact:=$maintenance.compact+"  "+Get localized string:C991("MONI_MNTCE_CompactingFailed")
						End if 
					End if 
				End if 
				DOM CLOSE XML:C722($dom)
			End if 
		Else 
			$maintenance.compact:=Get localized string:C991("MONI_MNTCE_Unknown")
		End if 
		
		
		$verify:=Get 4D file:C1418(Verification log file:K5:37)
		If ($verify#"")
			$dom:=DOM Parse XML source:C719($verify)
			If (OK=0)
				$maintenance.verify:=Get localized string:C991("MONI_MNTCE_VerificationLogDamaged")
			Else 
				$Found:=DOM Find XML element:C864($dom;"verifylog/stop_timer")
				If (OK=1)
					C_TEXT:C284($time;$success;$cancel)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"time";$time)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"success";$success)
					DOM GET XML ATTRIBUTE BY NAME:C728($Found;"user_canceled";$cancel)
					$maintenance.verify:=$time
					If ($cancel="true")
						$maintenance.verify:=$maintenance.verify+"  "+Get localized string:C991("MONI_MNTCE_VerificationCanceledByUser")
					Else 
						If ($success="true")
							$maintenance.verify:=$maintenance.verify+"  "+Get localized string:C991("MONI_MNTCE_VerificationSucceeded")
						Else 
							$maintenance.verify:=$maintenance.verify+"  "+Get localized string:C991("MONI_MNTCE_VerificationFailed")
						End if 
					End if 
				End if 
				DOM CLOSE XML:C722($dom)
			End if 
		Else 
			$maintenance.verify:=Get localized string:C991("MONI_MNTCE_Unknown")
		End if 
		
		$maintenance.debuglog:=Get database parameter:C643(Debug log recording:K37:34)
		$maintenance.requestlog:=Get database parameter:C643(4D Server log recording:K37:28)
		$maintenance.diagnosticlog:=Get database parameter:C643(Diagnostic log recording:K37:69)
		
		$0:=$maintenance
		
	: ($1="SQL")
		$sql:=New object:C1471
		$sql.sqlPort:=Get database parameter:C643(SQL Server Port ID:K37:74)
		$sql.sqlCase:=Get database parameter:C643(SQL engine case sensitivity:K37:43)
		$sqlconnectionhandler:=0
		$obActivity:=Get process activity:C1495
		For ($i;0;$obActivity.processes.length-1)
			If ($obActivity.processes[$i].name="SQL connection handler")
				$sqlconnectionhandler:=$sqlconnectionhandler+1
			End if 
		End for 
		$sql.connectionhandler:=$sqlconnectionhandler
		
		
	: ($1="VerifyLog")
		$verify:=Get 4D file:C1418(Verification log file:K5:37)
		If ($verify#"")
			$text:=Document to text:C1236($verify)
			$0:=New object:C1471("document";$text)
		Else 
			$0:=Null:C1517
		End if 
		
	: ($1="CompactLog")
		$verify:=Get 4D file:C1418(Compacting log file:K5:38)
		If ($verify#"")
			$text:=Document to text:C1236($verify)
			$0:=New object:C1471("document";$text)
		Else 
			$0:=Null:C1517
		End if 
		
	: ($1="DebugLog")
		$verify:=Get 4D file:C1418(Debug log file:K5:44)
		If ($verify#"")
			$text:=Document to text:C1236($verify)
			$0:=New object:C1471("document";$text)
		Else 
			$0:=Null:C1517
		End if 
		
	: ($1="RequestLog")
		$verify:=Get 4D file:C1418(Request log file:K5:42)
		If ($verify#"")
			$text:=Document to text:C1236($verify)
			$0:=New object:C1471("document";$text)
		Else 
			$0:=Null:C1517
		End if 
		
	: ($1="DiagnosticLog")
		$verify:=Get 4D file:C1418(Diagnostic log file:K5:43)
		If ($verify#"")
			$text:=Document to text:C1236($verify)
			$0:=New object:C1471("document";$text)
		Else 
			$0:=Null:C1517
		End if 
		
	: ($1="applicationServer")
		$object:=New object:C1471
		$object.structure:=Structure file:C489
		$object.data:=Data file:C490
		$object.journal:=Log file:C928
		If (Is compiled mode:C492)
			$object.interpreted:=Get localized string:C991("MONI_S4D_Compiled")
		Else 
			$object.interpreted:=Get localized string:C991("MONI_S4D_Interpreted")
		End if 
		ARRAY TEXT:C222($arr1;0)
		ARRAY REAL:C219($arr2;0)
		ARRAY REAL:C219($arr3;0)
		GET MEMORY STATISTICS:C1118(1;$arr1;$arr2;$arr3)
		$col:=New collection:C1472
		For ($i;1;Size of array:C274($arr1))
			$col.push(New object:C1471("name";$arr1{$i};"size";$arr2{$i}))
		End for 
		$object.memory:=$col
		$0:=$object
		
	: ($1="web")
		$object:=WEB Get server info:C1531(True:C214)
		C_REAL:C285($num1)
		WEB GET OPTION:C1209(Web log recording:K73:9;$num1)
		Case of 
			: ($num1=0)
				$object.log:="-"
			: ($num1=1)
				$object.log:="CLF"
			: ($num1=2)
				$object.log:="DLF"
			: ($num1=3)
				$object.log:="ELF"
			: ($num1=4)
				$object.log:="WLF"
		End case 
		$0:=$object
	: ($1="DBMeasures")
		$0:=Get database measures:C1314(New object:C1471("path";"DB.tables"))
	: ($1="LockedRecords")
		$col:=New collection:C1472
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				$object:=Get locked records info:C1316(Table:C252($i)->)
				If ($object.records.length>0)
					$col.push(New object:C1471("table";Table name:C256($i);"locks";$object))
				End if 
			End if 
		End for 
		$0:=New object:C1471("Locked";$col)
End case 