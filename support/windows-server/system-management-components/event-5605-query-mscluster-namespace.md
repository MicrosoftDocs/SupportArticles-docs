---
title: Warning Event ID 5605 is logged in Application log
description: Describes an issue that Warning Event ID 5605 is logged in Application log when querying MSCluster namespace through WMI.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wmi, csstroubleshoot
---
# Warning Event ID 5605 is logged in Application log when querying MSCluster namespace through WMI

This article describes an issue where Warning Event ID 5605 is logged in Application log when querying MSCluster namespace through WMI.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2590230

## Symptoms

When you query the MSCluster  namespace or run an application that queries properties of this namespace, you might get the following warning events, despite the Authentication is set to PacketPrivacy:

> Log Name: Application  
Source: Microsoft-Windows-WMI  
Event ID: 5605  
Level: Warning  
Description:  
The Root\MSCluster namespace is marked with the RequiresEncryption flag. Access to this namespace might be denied if the script or application does not have the appropriate authentication level. Change the authentication level to Pkt_Privacy and run the script or application again.

> [!NOTE]
> This isn't specific to the Root\MSCluster namespace only, and the event may be logged with any namespace which is marked with RequiresEncryption flag (like root\cimv2\TerminalServices).
>
> This warning can be logged even when the Authentication is set to PacketPrivacy and can be safely ignored as long as the queries work as expected.

## Workaround

To work around this issue and prevent the warnings from being logged, there are two possible solutions. From a security perspective, it's preferable to use workaround b.

a. Modify the ClusWMI.mof

For this, follow the steps:

1. Open C:\Windows\system32\wbem\ClusWMI.mof for editing and set [RequiresEncryption(FALSE)].
2. Recompile the ClusWMI.mof file by running "mofcomp C:\Windows\system32\wbem\ClusWMI.mof".
3. Restart the winmgmt service.  

> [!NOTE]
> This workaround will have to be reapplied if the ClusWMI.mof file is updated through hotfix or service pack.
>
> This workaround has not been tested and confirmed by Microsoft for any security/supportability implications.

b. Modify the authenticationLevel of the application doing the query

For this, modify the registry with the following script on the System, from which the query is done/started:

Windows Registry Editor Version 5.00  

[HKEY_CLASSES_ROOT\AppID\{\<Guid>}]  
 @="Applicationname.exe"  
 "AuthenticationLevel"=dword:00000006  

[HKEY_CLASSES_ROOT\AppID\Applicationname.exe]  
 "AppID"="{\<Guid>}"  

Where \<Guid> is an AppID Guid and the Applicationname.exe is the name of the application doing the WMI query.  

For example, wbemtest.exe in case you do the connection with the BuildIn WMI Test utility.

## More information

By applying the workaround mentioned under a, querying information from the ClusWMI namespace can be done without packet privacy and the connection becomes less secure by not requiring an encrypted connection for this namespace.

By applying the workaround mentioned under b, the connect call to the namespace is already done with packet privacy and thus as a result, the event 5605 isn't logged.

[Setting the Default Process Security Level Using VBScript](https://msdn.microsoft.com/library/aa393618%28vs.85%29.aspx)  

[Securing Remote WMI connection](https://msdn.microsoft.com/library/aa393266.aspx)  

[Requiring an Encrypted Connection to a Namespace](https://msdn.microsoft.com/library/aa393068%28vs.85%29.aspx)
