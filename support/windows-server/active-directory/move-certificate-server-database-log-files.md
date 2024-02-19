---
title: Move certificate server database and log files
description: Describes how to move a certificate server's database and log files.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# Move the Certificate Server database and log files

This article describes how to move a certificate server's database and log files.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 283193

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Move the Certificate Server Database and Log Files

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

Use these steps to change the location of the certificate server database and log files:

1. Stop the Certificate Services service.
2. Copy the database files and log files to new location. The default database path is:  %SystemRoot%\System32\CertLog

3. Modify the database paths in the following registry entries to reflect the new path:  

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBDirectory`

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBLogDirectory`

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBSystemDirectory`

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertSvc\Configuration\DBTempDirectory`

4. Start the Certificate Services service.
5. Check the Application event log for CertSvc event 26 to verify that the Certificate Services service started successfully. A warning message is displayed if the service does not start successfully. If this occurs, check the syntax of the paths in the registry.

You may need to edit the NTFS permissions to grant Full Control permissions to the System account. By default, the System account and the Administrators and Enterprise Administrators groups have Full Control access for the CertLog folder.
