---
title: Can't set up Folder Redirection with Group Policy
description: Resolves an issue where you fail to set up Folder Redirection component of Group Policy.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:folder-redirection, csstroubleshoot
ms.subservice: user-profiles
---
# Event ID 101 and Event ID 1000 may be displayed when Folder Redirection is set up with Group Policy

This article provides a solution to an issue where you fail to set up Folder Redirection component of Group Policy and Event ID 1000 and 101 are logged.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 291087

## Symptoms

The following Event ID 1000 and Event ID 101 messages may be logged in the Application log when the Folder Redirection component of Group Policy is set up:

> Event Type: Error  
Error Event Source: Userenv  
Event Category: None  
Event ID: 1000  
Date: Date  
Time: Time  
User: Nt Authority\System  
Computer: Computername  
Description: The Group Policy client-side extension Folder Redirection was passed flags (0) and returned a failure status code of (1307).

> Event Type: Error  
Event Source: Folder Redirection  
Event Category: None Event ID: 101  
Date: Date  
Time: Time  
User: Domain\User  
Computer: Computername  
Description: Failed to perform redirection of folder Desktop. The new directories for the redirected folder could not be created. The folder is configured to be redirected to \\\\Computername\Redirected shared folder, the final expanded path was \\\\Computername\Redirected shared folder. The following error occurred: This security ID may not be assigned as the owner of this object.

## Cause

This problem can occur when you use Group Policy to set up its Folder Redirection component. Group Policy has an option to set up the Folder Redirection component as Basic, Advanced, or None. On the Target tab, if you click the Basic setting, and then under Settings, you click to select the **Grant the user exclusive rights to the folder name** check box, the Folder Redirection component is unsuccessful and event messages can be displayed.

## Resolution

To resolve this problem, follow these steps:

1. Load the appropriate Group Policy from the domain.
2. Click **User Configuration**, click **Windows Setting**, and then click **Folder Redirection**.
3. Right-click the appropriate Folder Redirection component, and then click **Properties**.
4. Click the **Basic setting** in the **Target** tab, and then under **Settings**, clear the **Grant the user exclusive rights to the folder name** check box.
5. Save the settings, and then quit.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
