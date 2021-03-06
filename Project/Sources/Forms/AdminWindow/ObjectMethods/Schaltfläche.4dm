C_OBJECT:C1216($application;$system;$license;$version;$users;$maintenance;$server;$web)
C_COLLECTION:C1488($result)
C_TEXT:C284($text)

$application:=Monitor_InitValues_Server ("application")
$system:=Monitor_InitValues_Server ("system")
$license:=Monitor_InitValues_Server ("license")
$version:=Monitor_InitValues_Server ("version")
$users:=Monitor_InitValues_Server ("userAndProcess")
$maintenance:=Monitor_InitValues_Server ("maintenance")
$server:=Monitor_InitValues_Server ("applicationServer")
$web:=Monitor_InitValues_Server ("web")

$result:=New collection:C1472(New object:C1471("Application";$application))
$result.push(New object:C1471("System";$system))
$result.push(New object:C1471("License";$license))
$result.push(New object:C1471("Version";$version))
$result.push(New object:C1471("Users";$users))
$result.push(New object:C1471("Maintenance";$maintenance))
$result.push(New object:C1471("ApplicationServer";$server))
$result.push(New object:C1471("HTTP";$web))
$result.push(New object:C1471("RTM";Form:C1466.RTM))

$text:=JSON Stringify:C1217($result;*)
SET TEXT TO PASTEBOARD:C523($text)