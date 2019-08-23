' Name : distributiongroupswithmanager.vbs
' Description : script to enumerate all distributiongroups with manager
' Author : dirk adamsky - deludi bv
' Version : 1.00
' Date : 01-02-2010
' Level : intermediate

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set adoCommand = CreateObject("ADODB.Command")
Set adoConnection = CreateObject("ADODB.Connection")
adoConnection.Provider = "ADsDSOObject"
adoConnection.Open "Active Directory Provider"
adoCommand.ActiveConnection = adoConnection

Set objRootDSE = GetObject("LDAP://RootDSE")
strDNSDomain = objRootDSE.Get("defaultNamingContext")
strBase = "<LDAP://" & strDNSDomain & ">"

Set oArg = WScript.Arguments
If oArg.Count = 0 Then
	sUID = InputBox("Enter Group Name", "Users per Group", "DMFinancialSecuredProd")
Else
	sUID = oArg(0)
End If


If sUID = "" Then
	
Else
	
	'strFilter = "(&(objectCategory=group)(objectname=" & sUID & "))"
	strFilter = "(&(samaccountname=" & sUID & "))"
	strAttributes = "distinguishedName"
	
	strQuery = strBase & ";" & strFilter & ";" & strAttributes & ";subtree"
	adoCommand.CommandText = strQuery
	
	adoCommand.Properties("Page Size") = 100
	adoCommand.Properties("Timeout") = 30
	adoCommand.Properties("Cache Results") = False
	
	Set objRecordset = adoCommand.Execute
	
	sTemp = "Group" & vbTab & "User Name" & vbCrLf
	
	objRecordSet.MoveFirst
	Do Until objRecordSet.EOF
		On Error Resume Next
		Set objUser = GetObject("LDAP://" & objRecordSet.Fields("distinguishedName").Value)
		
		sTemp2 = objUser.samaccountname & vbCrLf
		arrGroups = objUser.member
		If IsNull(arrGroups) Then
			Wscript.Echo "Nothing found"
			sTemp2 = sTemp2 & vbTab & "(no groups)" & vbCrLf
			'sTemp2 = sGroup & vbCrLf
		Else
			For Each a In arrGroups
				a = Mid(a, 4)
				arr = Split(a, ",")
				a = arr(0) & "," & arr(1)
				'a = Left(a, InStr(1, a, ",", 1) - 1)
				a = Replace(a, "\,", ",")
				sTemp2 = sTemp2 & vbTab & a & vbCrLf
				'Wscript.Echo objUser.DisplayName & " ; " & objUser.Mail & " ; " & a
			Next
		End If
		'Wscript.Echo objGroup.DisplayName & " ; " & objGroup.Mail & " ; " & objGroup.managedBy
		sTemp = sTemp & sTemp2
		
		Set objGroup = Nothing
		objRecordSet.MoveNext
	Loop
	
	
	Set objFile = objFSO.CreateTextFile("C:\AAWork\DWADInfo_User.txt", True)
	objFile.WriteLine(sTemp)
	objFile.Close
	
	CreateObject("WScript.Shell").Run("Excel c:\aawork\dwadinfo_user.txt")
	
End If

Set objRecordset = Nothing
Set objRootDSE = Nothing
Set adoConnection = Nothing
Set adoCommand = Nothing
