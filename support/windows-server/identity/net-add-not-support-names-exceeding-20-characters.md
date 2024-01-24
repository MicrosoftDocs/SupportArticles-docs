---
title: NET ADD doesn't support names exceeding 20 characters
description: Provides a solution to an error that occurs when you use the NET.EXE /ADD command with user or group names longer than 20 characters.
ms.date: 11/29/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, rolandw
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# NET.EXE /ADD command does not support names longer than 20 characters

This article provides a solution to an error that occurs when you use the `NET.EXE /ADD` command with user or group names longer than 20 characters.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324639

## Symptoms

When you use the `NET.EXE` command together with the `/ADD` switch and long user or group names, this only redisplays the NET syntax. You receive no error message.

Example:

```console
C:\>NET.EXE localgroup MyRemoteUsers "REMOTE INTERACTIVE LOGON" /ADD

The syntax of this command is:

NET LOCALGROUP [groupname [/COMMENT:"text"]] [/DOMAIN]
groupname {/ADD [/COMMENT:"text"] | /DELETE} [/DOMAIN]
groupname name [...] {/ADD | /DELETE} [/DOMAIN]
```

The same action *does* work with the GUI Computer Management, Local Users, and Groups Microsoft Management Console (MMC).

## Cause

The NET.EXE command does not support names longer than 20 characters for reasons of backward compatibility with LAN Manager 2.0.

## Resolution

If the graphical user interface (GUI) method cannot be used and a scripting method is required, use the Windows 2000 Resource Kit utility Cusrmgr.exe. Or, use VBScript, using an application programming interface (API) that supports names longer than 20 characters.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## More information

In the example in the "Symptoms" section of this article, use the following Cusrmgr.exe syntax:

```console
C:\>CUSRMGR.EXE -u "REMOTE INTERACTIVE LOGON" -alg "MyRemoteUsers"
```

This issue may also occur with localized versions in which built-in groups exceed the 20 character name limit. For example, with the German name for "Authenticated Users" (19 characters): "Authentifizierte Benutzer" (25 characters).

The following sample VBScript may be adapted and used as an additional workaround. It adds "Authenticated Users" to "Power Users" for the English and German version:

```vbscript
##### VBScript ADDGRP.VBS #####

On Error Resume Next  

Dim oContainer  
Dim oGroup  
Dim oIADs  

Dim oComputerInformation  
Dim bolGroupSet  
bolGroupSet = False  

Set oComputerInformation = CreateObject("WScript.Network")  

Set oContainer = GetObject("WinNT://" +  
oComputerInformation.ComputerName)'get the IADsContainer object for the local computer  

oContainer.Filter = Array("Group")'We only need to enumerate groups,
therefore the filter  
For Each oIADs In oContainer 'for each IADs object we find there  
If oIADs.Name = "Hauptbenutzer" Or oIADs.Name = "Power Users" Then  
'check if it has the name "Power Users" or "Hauptbenutzer"  

Set oGroup = oIADs 'If so put it into the IADsGroup object  
oGroup.Add ("WinNT://S-1-5-11")'add the group "Authenticated Users"  
oGroup.SetInfo 'and save the info  

If Err <> 0 Then 'if error number is not 0 (Error occurred)  
MsgBox Err.Number, vbCritical, "AddGroup" 'print out the error message  
Else 'if everything seems to be ok  
bolGroupSet = True 'set the boolean value to True so we know the group was added  
End If  

End If  
Next  

If bolGroupSet = True Then 'if bolGroupSet is False there was nothing done  
MsgBox "Group added successfully", vbInformation, "AddGroup"  
Else  
MsgBox "No action has taken place!", vbExclamation, "AddGroup"  
End If  
##### script end #####
```

## Workaround

To work around this issue in Windows Server 2008 and later, use the **Add-ADGroupMember** PowerShell command, as described in the following TechNet article:  
[Add-ADGroupMember](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617210(v=technet.10))

If you are using PowerShell 5.1, use the **Add-LocalGroupMember -Group** PowerShell command, as described in the following article:  
[Add-LocalGroupMember](/powershell/module/microsoft.powershell.localaccounts/add-localgroupmember)
