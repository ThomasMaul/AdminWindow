//%attributes = {}
/* internal method, only to build/update
handles component build, notarize (needs to run on Mac) and upload to git

to use setup build application settings using dialog.requires to enter an Apple certificate
certificate such as "Developer ID Application: Companyname (id)"
follow https://blog.4d.com/how-to-notarize-your-merged-4d-application/

in case you have several xcode, select the 'good' one with
###########
sudo xcode-select -s /path/to/Xcode13.app

Tested with XCode 13. Minimum Version XCode 13, for older you need to use altool, see:
https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow/notarizing_apps_when_developing_with_xcode_12_and_earlier

Run XCode at least once manual to make sure it is correctly installed and license is accepted.
After an XCode/System update another manual run might be necesssary to accept modified license.

###########
expects that you have installed your password in keychain named "altool" with:
xcrun altool --list-providers -u "AC_USERNAME" -p secret_2FA_password
Sign in to your Apple ID account page. In the Security section, click the “Generate Password” option below the “App-Specific Passwords” option, enter a password label as requested and click the “Create” button.
If unclear, read Apple docu above!

###########  NOTES
you might need to start Xcode once manually after every macOS update to accept Xcode changes
you might need to start Xcode to accept Apple contract changes or update expired certificates (visit developer.apple.com)
*/


/* JOB:
Build (and sign)

// for Mac user (also useable on Windows if expanded on Mac)
create img
upload img for notarize
staple img
convert img to be read only

// for Win user
zip
*/

If (Is Windows:C1573)
	ALERT:C41("It is only possible on Mac to create a signed/notarized .img file, so we stop here")
	return 
End if 

var $builder : cs:C1710._Build

$builder:=cs:C1710._Build.new()

var $progress : Integer
$progress:=Progress New
Progress SET MESSAGE($progress; "Compile...")

var $error : Object
$error:=$builder.Compile()
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Build...")
	$error:=$builder.Build()  // $1 could be path to settings, if you have other than default ones
End if 

If ($error.success=True:C214)
	var $sourcepath:=$builder.getSourcePath()
	If ($sourcepath="@:")
		$sourcepath:=Substring:C12($sourcepath; 1; Length:C16($sourcepath)-1)
	End if 
	var $sourcefile:=File:C1566($sourcepath; fk platform path:K87:2)
End if 

// for Windows
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Zip...")
	var $targetpath : Text:=$sourcefile.parent.parent.platformPath+$sourcefile.name+".zip"
	$error:=$builder.Zip($sourcepath; $targetpath)
End if 

// run only on Mac
If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Build IMG...")
	var $tempimgpath : Text:=$sourcefile.parent.parent.platformPath+"tmp.dmg"
	$error:=$builder.CreateImage($sourcepath; $tempimgpath; $sourcefile.name)
End if 

If ($error.success=True:C214)
	Progress SET MESSAGE($progress; "Notarize and wait for Apple's approval...")
	$error:=$builder.Notarize($tempimgpath)
End if 

If ($error.success=True:C214)
	$error:=$builder.Staple($tempimgpath)
End if 

If ($error.success=True:C214)
	var $finalimgpath : Text:=$sourcefile.parent.parent.platformPath+$sourcefile.name+".dmg"
	$error:=$builder.ConvertImage($tempimgpath; $finalimgpath)
	If ($error.success=True:C214)
		DELETE DOCUMENT:C159($tempimgpath)
	End if 
End if 


Progress QUIT($progress)


If ($error.success=False:C215)
	ALERT:C41(JSON Stringify:C1217($error; *))
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($error; *))
End if 