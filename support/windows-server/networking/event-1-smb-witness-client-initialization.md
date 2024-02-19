---
title: SMB witness client initialization fails
description: This article describes Event 1 that is logged about SMB witness client initialization when you install Windows Server.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jongrkim
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Event 1 about SMB witness client initialization when you install Windows Server

This article describes Event ID 1 that occurs during the deployment of Windows Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4483863

## Symptoms

During the deployment of Windows Server 2019, Windows Server 2016, and Windows Server 2012 R2, the following error message is logged in Event Viewer indicating that Server Message Block (SMB) witness client initialization failed and returned Event 1:

> Log Name: Microsoft-Windows-SMBWitnessClient/Admin  
Source: Microsoft-Windows-SMBWitnessClient  
Event ID:1  
Level: Error  
Description: Witness Client initialization failed with error (The system cannot find the file specified.)

## More information  

You can safely ignore this event if this is a fresh deployment of Windows Server that has no role and no feature is enabled.
