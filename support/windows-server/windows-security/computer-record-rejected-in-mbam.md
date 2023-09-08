---
title: Computer record is rejected in MBAM
description: Describe how to resolve the warning message "Computer Record is Rejected" in MBAM.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: manojse, kaushika
ms.custom: sap:bitlocker, csstroubleshoot
ms.technology: windows-server-security
---
# Computer record is rejected in MBAM

This article provides a solution to an issue where you receive a warning message "computer record is rejected" when using Microsoft BitLocker Administration and Monitoring (MBAM).

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 – all editions  
_Original KB number:_ &nbsp; 2612822

## Symptoms

When using Microsoft BitLocker Administration and Monitoring (MBAM) users may receive a Warning message stating, "Computer Record is Rejected" in the application logs on MBAM Server.

When users experience this problem, they will not see the UI prompt on Windows 7 client to start the encryption process.

Also in some cases you may see the UI prompt to Start Encryption Process, but the process will fail and you will see "Encryption Failed" in the UI prompt.

If we open EventViewer on MBAM Server and check Application Logs, you will see the below warning message.

Application Logs on MBAM Server:

> Log Name: Application  
Source: ASP.NET 2.0.50727.0  
Event ID: 1310  
Task Category: Web Event  
Level: Warning  
Keywords: Classic  
Description:  
Event code: 100002  
Event message: Client Machine Name mismatch  
Event ID: 39949c6a19e84c14a6f3baffee2ad790  
Event sequence: 2  
Event occurrence: 1  
Event detail code: 0  

Application information:

> Application domain: /LM/W3SVC/2/ROOT/MBAMRecoveryAndHardwareService-1-129594585755957178  
 Trust level: Full  
 Application Virtual Path: /MBAMRecoveryAndHardwareService  
 Application Path: C:\\inetpub\\Malta BitLocker Management Solution\\MBAM Recovery And Hardware Service\\

Process information:

> Process ID: 1112  
Process name: w3wp.exe  
Account name: NT AUTHORITY\\NETWORK SERVICE  

Exception information:

> Exception type: FaultException  
Exception message: The computer record is rejected. The request from machine "DOMAIN\\COMPUTERNAME$" contains invalid machine name "COMPUTER.FQDN".

Request information:

> Request URL:  
Request path:  
User host address:  
User:  
Is authenticated: False  
Authentication Type:  
Thread account name: NT AUTHORITY\\NETWORK SERVICE  

Thread information:

> Thread ID: 7  
Thread account name: NT AUTHORITY\\NETWORK SERVICE  
Is impersonating: False  
Stack trace: at Microsoft.Mbam.AgentSupportService.CoreService.PostKeyRecoveryInfo(Message recoveryInfoMessage)

Custom event details:

> Application: MBAMComplianceStatusService  
Error Message: The computer record is rejected. The request from machine "DOMAIN\\COMPUTERNAME$" contains invalid machine name "COMPUTER.FQDN".

On Windows 7 client you will see this error message under Event Viewer > Application and Services Logs > Microsoft > Windows > MBAM:

> Log Name: Microsoft-Windows-MBAM/Admin  
Source: Microsoft-Windows-MBAM  
Event ID: 4  
Task Category: None  
Level: Error  
User: SYSTEM  
Computer: `machinename.domainname.com`  
Description: An error occurred while sending encryption status data.  
Error code: 0x803d0013
>
> Details: A message containing a fault was received from the remote endpoint.

## Cause

This is a known issue with the product specified.

## Resolution

Follow steps below to create a new registry key on MBAM Server where you have MBAM Administration and Monitoring Server role installed.  

> [!NOTE]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](../performance/windows-registry-advanced-users.md).

1. Start Registry Editor.
2. Navigate to the registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft`.
3. On the **Edit** menu, click **New** > **Key**, and add the registry key value: MBAM.
4. Under the newly created registry key name, on the **Edit** menu, click **New** > **DWORD (32-bit) Value** and name it as DisableMachineVerification.
5. Set the value to 1.  
6. Exit Registry Editor.

After you make these changes, you must restart the MBAM server for the modifications to take effect.

> [!NOTE]
> The above registry key has nothing to do with hardware compatibility checking on the server and hardware compatibility check functionality still works as designed.

## More information

For further information on MBAM and how it can help your environment, please consult the following documentation.

- [Planning for MBAM](/previous-versions/hh285653(v=technet.10))

- [Deploying MBAM](/previous-versions/hh285644(v=technet.10))

- [Operations for MBAM](/previous-versions/hh285664(v=technet.10))

- [Troubleshooting MBAM](/previous-versions/hh352745(v=technet.10))
