---
title: Delete a user profile in Windows Server 2008 and later
description: Describes steps to delete a user profile in Windows Server 2008 and later.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User profiles
ms.technology: windows-server-user-profiles 
---
# Delete a user profile in Windows Server 2008 and later

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;2462308

## Steps to delete a user profile

 1. Open System in Control Panel.
 2. Click Advanced Settings, and on the **Advanced** tab, under **User Profiles**, click **Settings**.
 3. Under **Profiles stored on this computer**, click the user profile you want to delete, and then click **Delete**.

> [!NOTE]
>
> - To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using Run as to perform this procedure.
> - To open System, click **Start** > **Control Panel**, and then double-click **System**.  
> - To open System from a command line as an administrator, type **runas /user:** *computername* **\Administrator "rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl"**.
