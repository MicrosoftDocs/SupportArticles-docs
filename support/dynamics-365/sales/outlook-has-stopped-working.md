---
title: Outlook closes unexpectedly during startup
description: Fix an issue in which you get the "Microsoft Outlook has stopped working" error when starting Outlook with the Microsoft Dynamics CRM 2011 client installed.
ms.reviewer: snulph, debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Outlook closes unexpectedly with the error (Microsoft Outlook has stopped working) during startup with the Microsoft Dynamics CRM 2011 client installed

This article helps you fix an issue in which you get the "Microsoft Outlook has stopped working" error when starting Outlook with the Microsoft Dynamics CRM 2011 client installed.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2821083

## Symptoms

Starting Microsoft Office Outlook configured to a Microsoft Exchange Online mailbox with the Microsoft Dynamics CRM 2011 client installed results in the following error:

> Microsoft Outlook has stopped working  
> Windows is collecting more information about the problem. This might take several minutes.

Furthermore, the following message will also be displayed:

> Do you want to send more information about the problem?  
> Additional details about what went wrong can help Microsoft create a solution.

In addition, the following error will be logged in the application event log on the affected computer:

> Log Name: Application  
> Source:        Application Error  
> Date:          2/25/2013 1:48:54 PM  
> Event ID:      1000  
> Task Category: (100)  
> Level:         Error  
> Keywords:      Classic  
> User:          N/A  
> Computer: computer.domain.local  
> Description:  
> Faulting application name: OUTLOOK.EXE, version: 14.0.4760.1000, time stamp: 0x4ba8fefd
Faulting module name: System.DirectoryServices.AccountManagement.ni.dll, version: 4.0.30319.1, time stamp: 0x4ba1e39f  
> Exception code: 0xc0000005  
> Fault offset: 0x000b145a  
> Faulting process id: 0xf40  
> Faulting application start time: 0x01ce1388bca5f53f  
> Faulting application path: C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE  
> Faulting module path: C:\Windows\assembly\NativeImages_v4.0.30319_32\System.DirectorySer#\\\<ID>\System.DirectoryServices.AccountManagement.ni.dll  
> Report Id: \<ID>

## Cause

This issue can occur if the Microsoft Outlook user's password for Microsoft Exchange Online recently changed (or is a temporary password) and the user has not updated the password in the Credential Manager applet within the Control Panel.

## Resolution

Update the user's password in Credential Manager.

> [!NOTE]
> If the user's password is only a temporary password, they will need to change it first by logging on to [Office 365 portal](https://portal.microsoftonline.com).

1. On the affected computer, open the **Control Panel**.
2. Select **User Accounts**.
3. Select **Manage Your Credentials**.
4. Locate and select the affected user account that is configured for Exchange Online.
5. Click **Edit**.
6. Type in the new password in the **Password** field.
7. Click the **Save** button.
8. Close the **Credential Manager**.
