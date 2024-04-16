---
title: NTDS replication warning Event ID 1093
description: Provides a solution to an NTDS warning event ID 1093.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bobbiez, tonnyp
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# NTDS replication warning with Event ID 1093

This article provides a solution to an NTDS warning event ID 1093.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2889671

## Symptoms

When troubleshooting another issue, we found NTDS warning event ID 1093.

> Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1093  
Date:  MM/DD/YYYY  
Time:  hh:mm:ss  
User:  NT AUTHORITY\ANONYMOUS LOGON  
Computer: DC02  
Description:  
Active Directory could not update the following object with attribute changes because the incoming change caused the object to exceed the maximum object record size. The incoming change to the following attribute will be reversed in an attempt to complete the update.
>
> Object:  
CN=user01,OU=OU1,OU=OU2,OU=Users,DC=contoso,DC=com  
Object GUID:  
*\<GUID>*  
Attribute:  
24 (userCertificate)  
>
> The current value (without changes) of the attribute on this domain controller will replicate to all other domain controllers. This will counteract the change to the rest of the replicated forest. The reversal values may be recognized as follows:  
Version:  
10277  
Time of change:  
*\<DateTime>*  
Update sequence number:  
614514713  
For more information, see Help and Support Center at `https://go.microsoft.com/fwlink/events.asp`.

This warning event ID 1093 indicates that the incoming change will not be replicated on the current domain controller and it will be reversed. That is, the incoming updates on the related object will be aborted to complete the AD replication. This warning will not influence the AD replication.

## Cause

The userCertificate attribute of the identified user (user01) holds a large number of certificates, which is exceeding the maximum object record size.

## Resolution

To solve the issue, the unwanted certificates need to be removed from userCertificate attribute of the user object in Active Directory.

To identify which certificates are unwanted, you can refer to the method in the following section.

## More information

You may use this method to export the user data of the user object who reach the maximum object size. Then identify the related certificates by the scripts and decide which unwanted certificates can be deleted from this user object.

1. Export the user data by running the command on one of the domain controllers: (output user_data.txt)

    ```console
    ldifde -f user_data.txt -d "distinguishedname of the problem user account" -p base
    ```

2. Prepare the script LDF2Certs.vbs with following contents:

    ```vb
    Option explicit
    Const strVBSfile = "LDF2Certs.vbs"
    Const ForReading = 1
    Const StatusLookingForStart = 0
    Const StatusLookingForEnd = 1
    Dim strLDFFile
    Call CommandParser()
    WScript.Echo "!Open the input LDF file " & strLDFFile
    Dim oFS
    Set oFS = CreateObject("Scripting.FileSystemObject")
    Dim objLDFFile
    Set objLDFFile = oFS.OpenTextFile(strLDFFile, ForReading, False)
    Dim strReadLine, lngStatus, objCertFile, lngCertNumber, strCertFile
    lngStatus = StatusLookingForStart
    lngCertNumber = 0
    Do While objLDFFile.AtEndOfStream <> True
     strReadLine = objLDFFile.ReadLine
     If lngStatus = StatusLookingForEnd Then
       If Not IsNull(strReadLine) Then
         If InStr(strReadLine,":") > 0 Then
           objCertFile.Close
           Set objCertFile = Nothing
           lngCertNumber = lngCertNumber + 1
           lngStatus = StatusLookingForStart
         Else
           objCertFile.Write strReadLine
         End If
       End If
     End If
     If lngStatus = StatusLookingForStart Then
       If Not IsNull(strReadLine) Then
         If InStr(strReadLine,"userCertificate::") > 0 Then
           WScript.Echo "!Found " & (lngCertNumber + 1) & " certificate"
           strCertFile = "Cert" & Right("0000" & CStr(lngCertNumber), 4) & ".cer"
           Set objCertFile = oFS.CreateTextFile(strCertFile, True, False)
           lngStatus = StatusLookingForEnd
         End If
       End If
     End If
    Loop
    objLDFFile.Close
    Set objLDFFile = Nothing

    Dim WshShell
    Set WshShell = WScript.CreateObject("WScript.Shell")
    Sub CommandParser()'Glable variables: strLDFFile
      If WScript.Arguments.Named.Exists("LDFFile") = True Then
        strLDFFile = WScript.Arguments.Named.Item("LDFFile")
        WScript.Echo "CommandParser: the LDF file name: " & strLDFFile
      Else
        Call ShowUsage()
      End If
    End Sub
    Sub ShowUsage()
      WScript.Echo " "
      WScript.Echo "Usage: CScript " & strVBSfile & " /LDFFile:<Input LDF file name, such as input.txt>"
      WScript.Quit
    End Sub
    ```

3. Prepare the script doit.bat with following commands:

    ```console
    cscript LDF2Certs.vbs /LDFFile:user_data.txt  
    dir /B Cert*.* > listofcerts.txt  
    FOR /F %%i IN (listofcerts.txt) DO echo %%i >> allcerts.txt && certutil -dump %%i >> allcerts.txt
    ```

4. Put two scripts (LDF2Certs.vbs and doit.bat) and the user data (user_data.txt) in the same folder and run script doit.bat.
    After running the script, text file allcerts.txt will be generated, which contains all the certificates in the user data with detailed information. Meanwhile, all the certificates will be dumped as .cer files in the same folder as well.

    > [!NOTE]
    > It may take some time as there are lots of certificates need to be dumped.

5. You can identify the certificates with their text or UI format and decide with certificates can be removed from this user object.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
