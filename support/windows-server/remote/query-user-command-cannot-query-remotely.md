---
title: Query User command can't query from remote server
description: Fixes an issue where the QUERY USER command doesn't query information from a remote server.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Query user command does not query information from remote server

This article provides help to fix an issue where the `query user` command doesn't query information from a remote server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 235567

## Symptoms

When you use the **query user** command to obtain information from a remote server, it reports that the user does not exist.

For example:  
 `query user username /server:remoteserver`  

The following error may also be displayed:
> No user exists for **username**  

## Cause

This problem occurs when you use the `query user` command and specify a user name. The Query command assumes this to be local and only looks at the local server for this user.

Using `query user /SERVER:REMOTESERVER` does report this information but lists all users currently logged on to the remote server.

## Resolution

To resolve this problem, obtain the latest service pack for Windows NT Server 4.0, Terminal Server Edition.

## Workaround

To work around this problem, use one of the following methods:

- Query the remote server and do not type username. This command lists all users on that server.  
 `query user / server:remoteserver`  

- To obtain a single user listing, you could send the output of the above command through find:  
 `query user / server:remoteserver | find "username"`  

- Create a batch file to query for a single user.  
`Batch File Name: Q.bat`  
Type the following text in the batch file, and then save the file:
`query user / server :%1 | find "%2"`  
Type the following at a command prompt:

    `q remoteserver username`
  
    > [!NOTE]
    > REMOTESERVER and USERNAME are the respective server and user that you are are trying to query.

## Status

Microsoft has confirmed that this is a problem in Microsoft Windows NT Server versions 4.0, 4.0 SP, Terminal Server Edition.  

This problem was first corrected in Windows NT Server 4.0, Terminal Server Edition, Service Pack 5.
