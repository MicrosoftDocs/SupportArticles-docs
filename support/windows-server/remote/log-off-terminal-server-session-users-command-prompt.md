---
title: Log off all Terminal Server Session Users
description: Provides some information about how to log off all Terminal Server Session Users from a Command Prompt. 
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Remote desktop sessions
ms.technology: windows-server-rds
---
# How to Log off all Terminal Server Session Users from a Command Prompt

This article provides some information about how to log off all Terminal Server Session Users from a Command Prompt.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259436

## Summary

Under some conditions, an administrator may want to force a logoff of all users currently logged on to a Windows NT 4.0 Server, Terminal Server Edition-based computer. You can do so by creating a batch file that calls two Terminal Server specific commands, QUERY, and LOGOFF.

> [!WARNING]
> Performing the following procedure logs off all users currently logged onto the Terminal Server. This may result in a loss of unsaved data. Because of this, extreme caution is advised.

## More information

To create a batch file that calls these two Terminal Server specific commands, place the following information into a batch (.bat) file:  

```console
query session >session.txt  
for /f "skip=1 tokens=3," %%i in (session.txt) DO logoff %%i  
del session.txt  
```

This batch file may be run at any time the Administrator desires to force the logoff of all users that are not logged on to the Terminal Server console.

Query is a multi-purpose command found within the Terminal Server environment. In this case, Query Session creates a list of all sessions running on the Terminal Server, complete with Session ID numbers. Within the batch file, this output is redirected to a text file. The FOR statement then parses each line of the text file, skipping the first line, and looking for the Session ID number found in the third column. It then places this variable into Logoff, resulting in that session being logged off.

It is not uncommon to receive an error message when you run this batch file. If a user is logged on to the Terminal Server console, the following error message is generated:

>Could not logoff session ID 0 from session Console, Error code 5  
Error [5]: Access is denied.  

It is due to a limitation of the Logoff command. It cannot force the logoff of the console session. A work-around to this issue would be to modify the batch file to read:  

```console
query session >session.txt  
for /f "skip=2 tokens=3," %%i in (session.txt) DO logoff %%i  
del session.txt  
```

It causes the first two lines of the Session.txt file to be skipped, avoiding the error.
