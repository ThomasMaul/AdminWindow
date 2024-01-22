//%attributes = {"invisible":true}
// called once for displaying each page
// $1 = Page Name, $2 = job

C_OBJECT:C1216($system; $versionobject; $license; $interface; $disk; $ip; $line; $item; $action; $data; $table; $user)
C_COLLECTION:C1488($selected; $selIndices; $existing; $min; $col; $result)
C_TEXT:C284($title; $path; $search; $message; $build; $version; $name; $tablename; $process)
C_POINTER:C301($ptr)
C_PICTURE:C286($mac; $win; $web)
C_REAL:C285($cur; $max)
C_LONGINT:C283($position; $duration; $count; $queryindex)
C_BOOLEAN:C305($isserver)

Case of 
	: ($1="Overview")
		Form:C1466.application:=Monitor_InitValues_Server("application")
		If ($2="init")
			$system:=Monitor_InitValues_Server("system")
			$license:=Monitor_InitValues_Server("license")
			$versionobject:=Monitor_InitValues_Server("version")
			$build:=String:C10($versionobject.build)
			$version:=$versionobject.version
			
			Form:C1466.system:=New object:C1471
			Form:C1466.system.MONI_C_Machine:=$system.machineName+Char:C90(13)+$system.model
			Form:C1466.system.MONI_C_System:=$system.osVersion
			Form:C1466.system.MONI_C_Uptime:=Replace string:C233(Get localized string:C991("MONI_MISC_TmplSecond"); "<1>"; String:C10($system.uptime))
			Form:C1466.system.MONI_C_Uptime:=Monitor_RealToDayHoursMinutes($system.uptime; False:C215)
			Form:C1466.system.MONI_C_Processor:=$system.processor
			Form:C1466.system.MONI_C_Cores:=String:C10($system.cores)+"/"+String:C10($system.cpuThreads)
			Form:C1466.system.MONI_C_Memory:=String:C10(Round:C94($system.physicalMemory/1024; 0))
			Form:C1466.system.MONI_C_IPaddress:=""
			For each ($interface; $system.networkInterfaces)
				Form:C1466.system.MONI_C_IPaddress:=Form:C1466.system.MONI_C_IPaddress+$interface.type+": "+$interface.name+Char:C90(13)
				For each ($ip; $interface.ipAddresses)
					Form:C1466.system.MONI_C_IPaddress:=Form:C1466.system.MONI_C_IPaddress+"  "+$ip.ip+Char:C90(13)
				End for each 
			End for each 
			
			Form:C1466.system.MONI_Info_Disk:=""
			For each ($disk; $system.volumes)
				If (Form:C1466.system.architecture)
					Form:C1466.system.MONI_Info_Disk:=Form:C1466.system.MONI_Info_Disk+$disk.name+" - "+$disk.filesystem+"  "+\
						String:C10($disk.capacity/1024/1024; "#####.# GB")+" ("+String:C10($disk.available/$disk.capacity*100; "#0%")+")"+Char:C90(13)+"  "
					If (Value type:C1509($disk.disk)=Is collection:K8:32)
						Form:C1466.system.MONI_Info_Disk:=Form:C1466.system.MONI_Info_Disk+$disk.disk[0].interface+Char:C90(13)+Char:C90(13)
					Else 
						Form:C1466.system.MONI_Info_Disk:=Form:C1466.system.MONI_Info_Disk+$disk.disk.interface+Char:C90(13)+Char:C90(13)
					End if 
					
				Else   // Windows
					Form:C1466.system.MONI_Info_Disk:=Form:C1466.system.MONI_Info_Disk+$disk.mountPoint+" - "+\
						String:C10($disk.capacity/1024/1024; "#####.# GB")+" ("+String:C10($disk.available/$disk.capacity*100; "#0%")+")   "+\
						$disk.filesystem+" / "+$disk.disk.interface+" / "+$disk.disk.identifier+Char:C90(13)+Char:C90(13)
				End if 
			End for each 
			
			Form:C1466.system.MONI_Info_Version:=$license.version+" Build: "+String:C10($build)
			Form:C1466.system.MONI_VolumeShadowCopy:=Form:C1466.application.volumeShadowCopyStatus
			If (Form:C1466.system.MONI_VolumeShadowCopy#vss available:K5:51)
				OBJECT SET VISIBLE:C603(*; "VolumeShadowCopy.Icon"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "VolumeShadowCopy.Icon"; False:C215)
			End if 
			Form:C1466.system.MONI_C_LicenceName:=$license.name
			Form:C1466.system.MONI_C_LicenceTo:=$license.companyName
			Form:C1466.system.MONI_MaxConnect4D:=0
			Form:C1466.system.MONI_MaxConnectSQL:=0
			Form:C1466.system.MONI_MaxConnectWeb:=0
			Form:C1466.system.MONI_MaxConnectSOAP:=0
			If ($license.products#Null:C1517)
				Form:C1466.system.MONI_MaxConnect4D:=$license.products.query("name=:1"; "4D Client")[0].rights.sum("count")
				$existing:=$license.products.query("name=:1"; "4D SQL Server@")
				If ($existing.length>0)
					Form:C1466.system.MONI_MaxConnectSQL:=$existing[0].rights.sum("count")
				Else 
					Form:C1466.system.MONI_MaxConnectSQL:=Get localized string:C991("MONI_OVER_None")
				End if 
				$existing:=$license.products.query("name=:1"; "4D Web Server@")
				If ($existing.length>0)
					Form:C1466.system.MONI_MaxConnectWeb:=$existing[0].rights.sum("count")
					If (Form:C1466.system.MONI_MaxConnectWeb>32000)
						Form:C1466.system.MONI_MaxConnectWeb:=Get localized string:C991("MONI_OVER_Unlimited")
					End if 
				Else 
					Form:C1466.system.MONI_MaxConnectWeb:=Get localized string:C991("MONI_OVER_None")
				End if 
				$existing:=$license.products.query("name=:1"; "4D WebServices Server@")
				If ($existing.length>0)
					Form:C1466.system.MONI_MaxConnectSOAP:=$existing[0].rights.sum("count")
					If (Form:C1466.system.MONI_MaxConnectSOAP>32000)
						Form:C1466.system.MONI_MaxConnectSOAP:=Get localized string:C991("MONI_OVER_Unlimited")
					End if 
				Else 
					Form:C1466.system.MONI_MaxConnectSOAP:=Get localized string:C991("MONI_OVER_None")
				End if 
			End if 
		End if   // init
		Form:C1466.system.MONI_App_Uptime:=Monitor_RealToDayHoursMinutes(Form:C1466.application.uptime; False:C215)
		Form:C1466.system.MONI_App_CPU:=Form:C1466.application.cpuUsage
		Form:C1466.system.MONI_NetIn:=Form:C1466.application.networkInputThroughput
		Form:C1466.system.MONI_NetOut:=Form:C1466.application.networkOutputThroughput
		
	: ($1="user")
		If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Server:K5:6))
			If ($2="update")
				// store current selected lines
				$selected:=Form:C1466.userSelection.extract("ID")
			End if 
			Form:C1466.userAll:=Monitor_InitValues_Server("user").sessions
			$title:=Get localized string:C991("MONI_D0_Users")
			$title:=Replace string:C233($title; "xxxx"; String:C10(Form:C1466.userAll.length))
			OBJECT SET TITLE:C194(*; "Moni_UIAction_Toolbar_2"; $title)
			$path:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+"Monitor"+Folder separator:K24:12
			READ PICTURE FILE:C678($path+"Logo_Mac.png"; $mac)
			READ PICTURE FILE:C678($path+"Logo_Win.png"; $win)
			READ PICTURE FILE:C678($path+"Logo_Web.png"; $web)
			For each ($line; Form:C1466.userAll)
				Case of 
					: ($line.hostType="mac")
						$line.platform:=$mac
					: ($line.hostType="win")
						$line.platform:=$win
					Else 
						$line.platform:=$web
				End case 
			End for each 
			Form:C1466.user:=Form:C1466.userAll
			If ($2="update")
				$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "SearchPickerUser")
				$search:=$ptr->
				If ($search#"")
					$search:="@"+$search+"@"
					Form:C1466.user:=Form:C1466.userAll.query("machineName = :1 or systemUserName = :1 or userName = :1"; $search)
				End if 
				// store current selected lines
				$selIndices:=Form:C1466.user.indices("ID IN :1"; $selected)
				For each ($position; $selIndices)
					LISTBOX SELECT ROW:C912(*; "Moni_Users_LB"; $position+1; lk add to selection:K53:2)
				End for each 
			End if 
		End if 
		
	: ($1="process")
		If ($2="update")
			// store current selected lines
			$selected:=Form:C1466.processSelection.extract("systemID")
		End if 
		Form:C1466.processAll:=Monitor_InitValues_Server("userAndProcess").processes
		$title:=Get localized string:C991("MONI_D0_Processes")
		$title:=Replace string:C233($title; "xxxx"; String:C10(Form:C1466.processAll.length))
		OBJECT SET TITLE:C194(*; "Moni_UIAction_Toolbar_3"; $title)
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"images"+Folder separator:K24:12+"Monitor"+Folder separator:K24:12
		For each ($item; Form:C1466.processAll)
			If ($item.session#Null:C1517)
				$item.sessionName:=$item.session.systemUserName
			Else 
				$item.sessionName:="-"
			End if 
			$name:="MONI2_ProcessName_"+String:C10($item.type)
			$title:=Get localized string:C991($name)
			$item.typeName:=$title
			$item.cpuUsageText:=String:C10(Round:C94($item.cpuUsage*100; 1))+"%"
			$item.cpuTimeText:=Time string:C180($item.cpuTime)
			$name:="MONI2_ProcessState_"+String:C10($item.state)
			$title:=Get localized string:C991($name)
			$item.stateText:=$title
		End for each 
		Form:C1466.process:=Form:C1466.processAll
		If ($2="update")
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "SearchPickerProcess")
			$search:=$ptr->
			If ($search#"")
				$search:="@"+$search+"@"
				Form:C1466.process:=Form:C1466.processAll.query("name = :1 or sessionName = :1"; $search)
			End if 
			// store current selected lines
			$selIndices:=Form:C1466.process.indices("systemID IN :1"; $selected)
			For each ($position; $selIndices)
				LISTBOX SELECT ROW:C912(*; "Moni_Process_LB"; $position+1; lk add to selection:K53:2)
			End for each 
		End if 
		
	: ($1="maintenance")
		Form:C1466.maintenance:=Monitor_InitValues_Server("maintenance")
		If (Form:C1466.maintenance.debuglog=0)
			$title:=Get localized string:C991("MONI2_Debuglog")+" "+Get localized string:C991("MONI2_Start")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetDebugLog"; False:C215)
		Else 
			$title:=Get localized string:C991("MONI2_Debuglog")+" "+Get localized string:C991("MONI2_Stop")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetDebugLog"; True:C214)
		End if 
		OBJECT SET TITLE:C194(*; "Moni_UIAction_DebugLog"; $title)
		
		If (Form:C1466.maintenance.requestlog=0)
			$title:=Get localized string:C991("MONI2_Requestlog")+" "+Get localized string:C991("MONI2_Start")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetRequestLog"; False:C215)
		Else 
			$title:=Get localized string:C991("MONI2_Requestlog")+" "+Get localized string:C991("MONI2_Stop")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetRequestLog"; True:C214)
		End if 
		OBJECT SET TITLE:C194(*; "Moni_UIAction_RequestLog"; $title)
		
		If (Form:C1466.maintenance.diagnosticlog=0)
			$title:=Get localized string:C991("MONI2_Diagnosticlog")+" "+Get localized string:C991("MONI2_Start")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetDiagnosticLog"; False:C215)
		Else 
			$title:=Get localized string:C991("MONI2_Diagnosticlog")+" "+Get localized string:C991("MONI2_Stop")
			OBJECT SET ENABLED:C1123(*; "Moni_UIAction_GetDiagnosticLog"; True:C214)
		End if 
		OBJECT SET TITLE:C194(*; "Moni_UIAction_DiagnosticLog"; $title)
		
	: ($1="application")
		If (Form:C1466.application.newConnectionsAllowed)
			OBJECT SET TITLE:C194(*; "Moni_UIAction_S4D_Publish"; Get localized string:C991("MONI_S4D_StopPublish"))
		Else 
			OBJECT SET TITLE:C194(*; "Moni_UIAction_S4D_Publish"; Get localized string:C991("MONI_S4D_StartPublish"))
		End if 
		Form:C1466.applicationServer:=Monitor_InitValues_Server("applicationServer")
		If (Form:C1466.application.launchedAsService)
			Form:C1466.applicationServer.Service:=Get localized string:C991("MONI_MISC_Yes")
		Else 
			Form:C1466.applicationServer.Service:=Get localized string:C991("MONI_MISC_No")
		End if 
		If (Form:C1466.application.IPAddressesToListen#Null:C1517)
			Form:C1466.applicationServer.IPtoListen:=Form:C1466.application.IPAddressesToListen.join(", ")
		End if 
		If (Form:C1466.application.TLSEnabled)
			Form:C1466.applicationServer.SSL:=Get localized string:C991("MONI_MISC_Yes")
		Else 
			Form:C1466.applicationServer.SSL:=Get localized string:C991("MONI_MISC_No")
		End if 
		$license:=Monitor_InitValues_Server("license")
		Form:C1466.applicationServer.CurrentConnect4D:=$license.products.query("name=:1"; "4D Client")[0].rights.sum("count")
		Form:C1466.applicationServer.MaxConnect4D:=$license.products.query("name=:1"; "4D Client")[0].allowedCount
		Form:C1466.applicationServer.CacheMemoryUsed:=String:C10(Round:C94(Num:C11(Form:C1466.applicationServer.memory.query("name=:1"; "usedCacheSize")[0].size)/(1024*1024); 1))+" MB"
		Form:C1466.applicationServer.CacheMemoryTotal:=String:C10(Round:C94(Num:C11(Form:C1466.applicationServer.memory.query("name=:1"; "CacheSize")[0].size)/(1024*1024); 1))+" MB"
		
	: ($1="web")
		Form:C1466.web:=Monitor_InitValues_Server("web")
		If (Form:C1466.web.started)
			Form:C1466.web.status:=Get localized string:C991("MONI_MISC_Started")
			OBJECT SET TITLE:C194(*; "Moni_UIAction_HTTP_StartStop"; Get localized string:C991("MONI_HTTP_StopHTTPServer"))
		Else 
			Form:C1466.web.status:=Get localized string:C991("MONI_MISC_Stopped")
			OBJECT SET TITLE:C194(*; "Moni_UIAction_HTTP_StartStop"; Get localized string:C991("MONI_HTTP_StartHTTPServer"))
		End if 
		Form:C1466.web.uptimeText:=Monitor_RealToDayHoursMinutes(Form:C1466.web.uptime; False:C215)
		Form:C1466.web.webIP:=Form:C1466.web.options.webIPAddressToListen.join(", ")
		Form:C1466.web.HSTSAge:=Monitor_RealToDayHoursMinutes(Form:C1466.web.security.HSTSMaxAge; True:C214)
		If (Form:C1466.web.SOAPServerStarted)
			Form:C1466.web.SOAPstatus:=Get localized string:C991("MONI_MISC_Started")
			OBJECT SET TITLE:C194(*; "Moni_UIAction_SOAP_StartStop"; Get localized string:C991("MONI_HTTP_RejectSOAPRequests"))
		Else 
			Form:C1466.web.SOAPstatus:=Get localized string:C991("MONI_MISC_Stopped")
			OBJECT SET TITLE:C194(*; "Moni_UIAction_SOAP_StartStop"; Get localized string:C991("MONI_HTTP_AcceptSOAPRequests"))
		End if 
		
	: ($1="RTM")
		If ($2="init")
			If (Form:C1466.RTM=Null:C1517)
				Form:C1466.RTM:=New collection:C1472
			End if 
		End if 
		
		ARRAY OBJECT:C1221($arrobject; 0)
		GET ACTIVITY SNAPSHOT:C1277($arrobject; *)
		C_OBJECT:C1216($object)
		OB SET ARRAY:C1227($object; "RTM"; $arrobject)
		
		// find and mark finished jobs
		For each ($action; Form:C1466.RTM)
			If (Not:C34(Bool:C1537($action.done)))
				$existing:=$object.RTM.query("uuid = :1"; $action.uuid)
				If ($existing.length=0)  // finished!
					$action.done:=True:C214
				End if 
			End if 
		End for each 
		
		// find or update current jobs
		For each ($action; $object.RTM)
			$message:=$action.message
			$cur:=Num:C11($action.currentValue)
			$max:=Num:C11($action.maxValue)
			If (($cur#0) | ($max#0))
				$message:=$message+" "+String:C10($cur)+" / "+String:C10($max)
			End if 
			If ($message="")
				$message:=String:C10($action.dbOperationDetails.operation.operationType)
			End if 
			$existing:=Form:C1466.RTM.query("uuid=:1"; $action.uuid)
			If ($existing.length=0)
				Form:C1466.RTM.unshift(New object:C1471("done"; False:C215; "uuid"; $action.uuid; "message"; $message; "startTime"; $action.startTime; "duration"; $action.duration/1000; \
					"details"; New object:C1471("operation"; $action.dbOperationDetails; "User"; $action.dbContextInfo)))
			Else 
				//$existing[0].startTime:=$action.startTime  // job uuid is reused for flash cache
				$existing[0].done:=False:C215
				$existing[0].message:=$message
				$existing[0].duration:=$action.duration/1000
				$existing[0].details:=New object:C1471("operation"; $action.dbOperationDetails; "User"; $action.dbContextInfo)
			End if 
		End for each 
		
		// check and delete finished fasted jobs, if too many!
		If (Form:C1466.RTM.length>50)  // modify 50 if needed
			$min:=Form:C1466.RTM.query("done=:1"; True:C214).orderBy("duration asc")
			Form:C1466.RTM.shift()
		End if 
		
		Form:C1466.RTM:=Form:C1466.RTM
		
	: ($1="DBMeasures")
		$data:=Monitor_InitValues_Server("DBMeasures")
		$result:=New collection:C1472
		For each ($tablename; $data.DB.tables)
			$table:=$data.DB.tables[$tablename]
			If ($table.queries#Null:C1517)
				For ($queryindex; 0; $table.queries.length-1)
					$name:=$table.queries[$queryindex].queryStatement
					$count:=Num:C11($table.queries[$queryindex].queryCount.value)
					$duration:=Num:C11($table.queries[$queryindex].duration.value)
					$result.push(New object:C1471("query"; $name; "count"; $count; "duration"; $duration))
				End for 
			End if 
		End for each 
		// only one header could be set, only one order is done, if at all
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Measure_Header3")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("duration asc")
			: ($ptr->=2)
				$result:=$result.orderBy("duration desc")
		End case 
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Measure_Header2")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("count asc")
			: ($ptr->=2)
				$result:=$result.orderBy("count desc")
		End case 
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Measure_Header1")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("query asc")
			: ($ptr->=2)
				$result:=$result.orderBy("query desc")
		End case 
		
		Form:C1466.DBMeasures:=$result
	: ($1="LockedRecords")
		$col:=Monitor_InitValues_Server("LockedRecords").Locked
		$result:=New collection:C1472
		$isserver:=(Application type:C494=4D Remote mode:K5:5)
		For each ($table; $col)
			$title:=$table.table
			For each ($user; $table.locks.records)
				If ((Bool:C1537($user.contextAttributes.is_remote_context)#True:C214) & ($isserver))
					$process:=$user.contextAttributes.task_name+" (on Server)"
				Else 
					$process:=$user.contextAttributes.task_name
				End if 
				$result.push(New object:C1471("Table"; $title; "User"; \
					$user.contextAttributes.user_name+" ("+$user.contextAttributes.host_name+") "+$process; \
					"Record"; String:C10($user.recordNumber)))
			End for each 
		End for each 
		// only one header could be set, only one order is done, if at all
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Lock_Header3")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("Record asc")
			: ($ptr->=2)
				$result:=$result.orderBy("Record desc")
		End case 
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Lock_Header2")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("User asc")
			: ($ptr->=2)
				$result:=$result.orderBy("User desc")
		End case 
		$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Moni_Lock_Header1")
		Case of 
			: ($ptr->=1)
				$result:=$result.orderBy("Table asc")
			: ($ptr->=2)
				$result:=$result.orderBy("Table desc")
		End case 
		Form:C1466.LockedRecords:=$result
End case 