C_OBJECT:C1216($reportobject)
C_TEXT:C284($path)
$reportobject:=Monitor_InitValues_Server ("RequestLog")
If ($reportobject#Null:C1517)
	$path:=Temporary folder:C486+"report.txt"
	TEXT TO DOCUMENT:C1237($path;$reportobject.document)
	OPEN URL:C673($path)
Else 
	  // nothing
End if 