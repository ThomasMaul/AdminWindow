var $reportobject:=Monitor_InitValues_Server("DiagnosticLog")
If ($reportobject#Null:C1517)
	var $path : Text:=Temporary folder:C486+"report.txt"
	TEXT TO DOCUMENT:C1237($path; $reportobject.document)
	OPEN URL:C673($path)
Else 
	// nothing
End if 