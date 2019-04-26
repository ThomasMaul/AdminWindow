//%attributes = {"invisible":true}
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)  //display seconds or not

C_TEXT:C284($0)

C_BOOLEAN:C305($DisplaySeconds)

C_LONGINT:C283($Duration)
C_LONGINT:C283($Seconds;$Minuts;$Hours;$Days)
C_LONGINT:C283($CalcDuration)

C_TEXT:C284($TemplateDays)
C_TEXT:C284($TemplateHours)
C_TEXT:C284($TemplateMinutes)
C_TEXT:C284($TemplateSeconds)
C_TEXT:C284($Template)
C_TEXT:C284($TemplateMinuts)


$Duration:=$1  //duration in seconds
$CalcDuration:=$Duration

If (Count parameters:C259>=2)
	$DisplaySeconds:=$2
Else 
	$DisplaySeconds:=False:C215
End if 


$Seconds:=$CalcDuration%60
$CalcDuration:=($CalcDuration-$Seconds)/60  //duration in minuts

$Minuts:=$CalcDuration%60
$CalcDuration:=($CalcDuration-$Minuts)/60  //duration in hours

$Hours:=$CalcDuration%24
$CalcDuration:=($CalcDuration-$Hours)/24  //duration in days

$Days:=$CalcDuration


  // ---------------------------    calcul des templates -----------------------

Case of 
	: ($Days>1)
		$TemplateDays:=Get localized string:C991("MONI_MISC_TmplDays")  //<1> days
	: ($Days<=1)
		$TemplateDays:=Get localized string:C991("MONI_MISC_TmplDay")  //<1> day
End case 
$TemplateDays:=Replace string:C233($TemplateDays;"<1>";String:C10($Days))  //115 days  1 day   ou   0 day

Case of 
	: ($Hours>1)
		$TemplateHours:=Get localized string:C991("MONI_MISC_TmplHours")  //<1> hours
	: ($Hours<=1)
		$TemplateHours:=Get localized string:C991("MONI_MISC_TmplHour")  //<1> hour
End case 
$TemplateHours:=Replace string:C233($TemplateHours;"<1>";String:C10($Hours))  //115 hours  1 hour   ou   0 hour

Case of 
	: ($Minuts>1)
		$TemplateMinuts:=Get localized string:C991("MONI_MISC_TmplMinuts")  //<1> minutes
	: ($Minuts<=1)
		$TemplateMinuts:=Get localized string:C991("MONI_MISC_TmplMinut")  //<1> minute
End case 
$TemplateMinuts:=Replace string:C233($TemplateMinuts;"<1>";String:C10($Minuts))  //45 minutes  1 minute   ou   0 minute

Case of 
	: ($Seconds>1)
		$TemplateSeconds:=Get localized string:C991("MONI_MISC_TmplSeconds")  //<1> secondes
	: ($Seconds<=1)
		$TemplateSeconds:=Get localized string:C991("MONI_MISC_TmplSecond")  //<1> seconde
End case 
$TemplateSeconds:=Replace string:C233($TemplateSeconds;"<1>";String:C10($Seconds))  //45 secondes  1 seconde   ou   0 seconde


  // affectation "intelligente" des templates

If ($Days>=1)
	$Template:=$TemplateDays
Else 
	$Template:=""
End if 


If ($Template#"")
	  //il y a déjà un ou des jours
	$Template:=$Template+" "+$TemplateHours  //on ajoute "0 heure" / "1 heure" / "N heures"
Else 
	  // encore vide (moins d'un jour)
	If ($Hours>=1)
		$Template:=$TemplateHours  //on affecte "1 heure"  / "N heures"
	Else 
		  //on laisse vide  (on ne commence pas par "0 heure"
	End if 
End if 

If ($Template#"")
	  //il ya déjà des jours ou des heures ou les deux
	$Template:=$Template+" "+$TemplateMinuts  //on ajoute les minutes"
Else 
	If ($Minuts>=1)
		$Template:=$TemplateMinuts  //on affecte les minutes
	Else 
		  //on laisse vide        (on ne commence pas par "0 minute"
	End if 
End if 


If ($Template#"")
	  //il ya déjà des jours ou des heures ou des minutes
	If ($DisplaySeconds)
		$Template:=$Template+" "+$TemplateSeconds
	End if 
	
Else 
	  // encore vide
	If ($DisplaySeconds)
		$Template:=$Template+" "+$TemplateSeconds
	Else 
		Case of 
			: ($Duration<=0)
				$Template:="--:--"
			: ($Duration<60)
				$Template:=Get localized string:C991("MONI_MISC_LessThanOneMinute")
		End case 
	End if 
End if 


$0:=$Template


