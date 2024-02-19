---
title: Log off all Remote Desktop Session Users
description: Provides some information about how to log off all Remote Desktop Session Users from a Command Prompt.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# How to Log off all Remote Desktop Session Users from a Command Prompt

Under some conditions, an administrator may want to force a logoff of all users currently logged on to a Remote Desktop server. You can do so by using a batch file, or a PowerShell script.

> [!WARNING]
> Performing the following procedure logs off all users currently logged onto the Remote Desktop server. This may result in a loss of unsaved data. Because of this, extreme caution is advised.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259436

## Using PowerShell

To log off all user sessions, run the following Powershell cmdlets on the Connection Broker:

```powershell
$sessions = Get-RDUserSession

foreach($session in $sessions)
{
    Invoke-RDUserLogoff -HostServer $session.HostServer -UnifiedSessionID $session.UnifiedSessionId -Force
}
```

To log off only disconnected user sessions, run the following Powershell cmdlets on the Connection Broker:

```powershell
$sessions = Get-RDUserSession |  ? {$_.SessionState -eq "STATE_DISCONNECTED"}

foreach($session in $sessions)
{
    Invoke-RDUserLogoff -HostServer $session.HostServer -UnifiedSessionID $session.UnifiedSessionId -Force
}
```

## Using batch file

Place the following information into a batch (.bat) file:  

```console
query session >session.txt  
for /f "skip=1 tokens=3," %%i in (session.txt) DO logoff %%i  
del session.txt  
```

This batch file may be run at any time the Administrator desires to force the logoff of all users that are not logged on to the Remote Desktop server console.

Query is a multi-purpose command found within the Remote Desktop server environment. In this case, Query Session creates a list of all sessions running on the Remote Desktop server, complete with Session ID numbers. Within the batch file, this output is redirected to a text file. The FOR statement then parses each line of the text file, skipping the first line, and looking for the Session ID number found in the third column. It then places this variable into Logoff, resulting in that session being logged off.

It is not uncommon to receive an error message when you run this batch file. If a user is logged on to the Remote Desktop server console, the following error message is generated:

```output
Could not logoff session ID 0 from session Console, Error code 5
Error [5]: Access is denied.
```

It is due to a limitation of the `Logoff` command. It cannot force the logoff of the console session. A workaround to this issue would be to modify the batch file to read:  

```console
query session >session.txt  
for /f "skip=2 tokens=3," %%i in (session.txt) DO logoff %%i  
del session.txt  
```

It causes the first two lines of the Session.txt file to be skipped, avoiding the error.
