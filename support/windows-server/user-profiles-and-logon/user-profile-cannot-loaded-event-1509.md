---
title: User profile cannot be loaded with Event ID 1509
description: Provides resolutions to fix the error User Profile Service failed the logon. User profile cannot be loaded.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
---
# User profile cannot be loaded with Event ID 1509: DETAIL - The filename or extension is too long

This article provides resolutions to fix the error "User Profile Service failed the logon. User profile cannot be loaded".

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2536571

## Symptoms

Some clients log on with temporary profile with error "User Profile Service failed the logon. User profile cannot be loaded". Event ID 1509 can be found in the application Event Log. The detail of the event ID 1509 is something like below:

> Log Name: Application  
Source: Microsoft-Windows-User Profiles Service  
Date: *\<DateTime>*  
Event ID: 1509  
Task Category: None  
Level: Warning  
Computer: `mycomputer.CONTOSO.com`  
Description:  
Windows cannot copy file  
\\\\`fileserver1.contoso.com`\share\profiles\studentacct111.V2\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5ELSJ1AXB\=,cm-9416518_1285174050,  
66b6f8276f22fbe  
,Miscellaneous,;;dc=s;cmw=owl;env=ifr;ord1=982256;sz=160x600;contx=Miscellaneous;btg=;ord=[timestamp][1] to location C:\Users\studentacct111.CONTOSO\AppData\Local\Microsoft\Windows\Temporary Internet  Files\Low\Content.IE5\ELSJ1AXB\=,cm-9416518_1285174050,  
66b6f8276f22fbe  
,Miscellaneous,;;dc=s;cmw=owl;env=ifr;ord1=982256;sz=160x600;contx=Miscellaneous;btg=;ord=[timestamp][1]. This error may be caused by network problems or insufficient security rights.  
>
> DETAIL - The filename or extension is too long.  

## Cause

This can happen if the destination path of the user's profile is on a server with a long name and share folder name. For example, \\\\servername\\thisistheprofileshare. As the file is stored locally on c:\\users\\username, the filename for copying to the destination will increase when this prefix is changed to \\\\servername\\thisistheprofileshare\\ leading to a pathname longer than the supported 260 chars.

## Resolution

Use one of the following methods to resolve the issue:

1. You can use the "Empty Temporary Internet Files folder when browser is closed" option in Internet Explorer to delete all cached Internet files when a user quits Internet Explorer. This option doesn't delete cookie information. Cookie information (which is usually small) is copied when the profile is saved. To use this option, follow these steps:

    1. In **Internet Explorer**, click **Internet Options** on the **View** (or **Tools**) menu.

    2. Click the **Advanced** tab.

    3. Under **Security**, click the **Delete saved pages when browser closed** or **Empty Temporary Internet Files folder when browser is closed** check box to select it.

    4. Click **OK**.

2. Enable the Group Policy Setting for "Delete cached copies of roaming profiles", located under in the following location:

    Computer Configuration\\Administrative Templates\\System\\User Profiles
