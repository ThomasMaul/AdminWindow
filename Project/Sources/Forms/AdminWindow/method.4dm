Case of 
	: (Form event:C388=On Load:K2:1)
		Form:C1466.MasterTime:=600  // 10 seconds - *****
		Monitor_InitValues ("overview";"init")
		
	: (Form event:C388=On Page Change:K2:54)
		Case of 
			: (FORM Get current page:C276=1)
				SET TIMER:C645(Form:C1466.MasterTime)
				Monitor_InitValues ("overview";"init")
				
			: (FORM Get current page:C276=2)
				SET TIMER:C645(60*5)  // 5 seconds
				Monitor_InitValues ("user";"init")
				
			: (FORM Get current page:C276=3)
				SET TIMER:C645(60*2)  // 2 Seconds
				Monitor_InitValues ("process";"init")
				
			: (FORM Get current page:C276=4)
				SET TIMER:C645(Form:C1466.MasterTime*10)
				Monitor_InitValues ("maintenance";"init")
				
			: (FORM Get current page:C276=5)
				SET TIMER:C645(Form:C1466.MasterTime*10)  // 100 seconds!
				Monitor_InitValues ("application";"init")
				
			: (FORM Get current page:C276=7)
				SET TIMER:C645(Form:C1466.MasterTime*10)  // 100 seconds!
				Monitor_InitValues ("web";"init")
				
			: (FORM Get current page:C276=8)
				SET TIMER:C645(60)  // 1 second
				Monitor_InitValues ("RTM";"init")
				
			: (FORM Get current page:C276=9)
				SET TIMER:C645(60*5)  // 5 second
				Monitor_InitValues ("DBMeasures";"init")
			: (FORM Get current page:C276=10)
				SET TIMER:C645(Form:C1466.MasterTime)
				Monitor_InitValues ("LockedRecords";"init")
		End case 
		
	: (Form event:C388=On Timer:K2:25)
		Case of 
			: (FORM Get current page:C276=1)
				Monitor_InitValues ("overview";"update")
			: (FORM Get current page:C276=2)
				Monitor_InitValues ("user";"update")
			: (FORM Get current page:C276=3)
				Monitor_InitValues ("process";"update")
			: (FORM Get current page:C276=4)
				Monitor_InitValues ("maintenance";"update")
			: (FORM Get current page:C276=5)
				Monitor_InitValues ("application";"update")
			: (FORM Get current page:C276=7)
				Monitor_InitValues ("web";"update")
			: (FORM Get current page:C276=8)
				Monitor_InitValues ("RTM";"update")
			: (FORM Get current page:C276=9)
				Monitor_InitValues ("DBMeasures";"update")
			: (FORM Get current page:C276=10)
				Monitor_InitValues ("LockedRecords";"update")
		End case 
		
End case 