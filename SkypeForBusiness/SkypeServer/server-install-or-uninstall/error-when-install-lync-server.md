---
title: Cannot find any suitable disks for database files
description: Resolves an issue in which you receive the Cannot find any suitable disks for database files. You must manually specify database paths error message. This issue occurs when you try to install or update Lync Server 2013 or Lync Server 2013 databases.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: miadkins
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# "Cannot find any suitable disks for database files" error message when you try to install or update Lync Server 2013 or Lync Server 2013 databases

## Symptoms

You receive the "Cannot find any suitable disks for database files. You must manually specify database paths" error message in the following scenarios:

- You try to install or update Microsoft Lync Server 2013 by using the Lync Server 2013 Deployment Wizard.   
- You try to install or update Lync Server 2013 by using Bootstrapper.exe at a command prompt.    
- You try to install or update Lync Server 2013 databases by using the Install-CsDatabase PowerShell command in the Lync Server Management Shell.    

## Cause

This issue occurs because the drive on the computer on which you try to install or update Lync Server 2013 or Lync Server 2013 databases has less than 16 GB of free space.

To install or update Lync Server 2013 databases, the drive must have at least 16 GB of free space. Therefore, when the Install-CsDatabase PowerShell command discovers that there is less than 16 GB of space on the locally detected or user specified drive, you receive the error message.

## Resolution

To resolve this issue, use one of the following methods.

**Method 1**

If the issue occurs when you try to install Lync Server 2013, make sure that the computer on which you want to install the Lync Server 2013 databases has at least 72 GB of free space on its local drives.

For more information about Lync Server 2013 disk space requirements, see [Server hardware platforms for Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-server-hardware-platforms).

**Method 2**

If the issue occurs when you try to update Lync Server 2013, make sure that the computer on which you want to update the Lync Server 2013 databases has more than 16 GB of free space on its local drives.

## More Information

For more information about Lync Server 2013 Standard Edition database deployment, see [Install Standard Edition server database for Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-install-standard-edition-server-database).

For more information about Lync Server 2013 Enterprise Edition database deployment, see [Configure SQL Server for Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-configure-sql-server-for-lync-server).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).