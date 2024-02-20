---
title: Fail to install Network Policy Server role
description: Describes an issue in Windows Server 2008 R2 in which you cannot install the Network Policy Server role service and in which you cannot start the Network Policy Server service.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Error 0x80004005 when you try to install or start the Network Policy Server role service

This article provides a solution to fix the error 0x80004005 that occurs when you install or start the Network Policy Server role service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 981478

## Symptoms

When you try to install or start the Network Policy Server role service on a computer that is running Windows Server 2008 R2, the role is not installed, or the service is not started. Additionally, you receive an error message that resembles the following: Windows could not start the Network Policy Server service on Local Computer.
Error 0x80004005 Unspecified error

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this problem, set the **NT AUTHORITY\NETWORK SERVICE** subkey in the registry to 1. To do this, follow these steps:

1. Start Registry Editor. To do this, click **Start**, type regedit in the **Start Search** box, and then press ENTER.

    If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.
2. Locate and then click to select the following registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VSS\VssAccessControl`  

3. Right-click **NT AUTHORITY\NETWORK SERVICE**, and then click **Modify**.
4. In the **Value data** box, type 1, and then click **OK**.
5. On the **File** menu, click **Exit** to exit Registry Editor.
6. Stop all instances of the Lashost.exe process.
7. Restart the Network Policy Server service.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
