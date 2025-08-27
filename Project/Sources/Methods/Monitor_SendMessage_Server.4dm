//%attributes = {"invisible":true,"executedOnServer":true}
// Send message to server, executed on the server

#DECLARE($user : Text; $message : Text)

SEND MESSAGE TO REMOTE USER:C1632($user; $message)