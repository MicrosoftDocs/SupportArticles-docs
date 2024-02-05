---
title: Installation File Location not behaves
description: Describes how to edit the registry to specify the location of the Installation files and the location of the Service Pack Installation files.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# The Specify Windows Installation File Location and the Specify Windows Service Pack Installation File Location Group Policy objects do not behave as described on the Explain tab

This article describes how to edit the registry to specify the location of the Windows Installation files and the location of the Windows Service Pack Installation files.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 833615

> [!NOTE]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Symptoms

When you view the **Explain** tab in the **Properties** of the **Specify Windows Installation File Location** Group Policy object, the text on the **Explain** tab states as:  

Specifies an alternate location for Windows installation files.  

To enable this setting, enter the fully qualified path to the new location in the "Windows Setup file path" box.  

If you disable this setting or do not configure it, the Windows Service Pack Setup source path will be the location used during the last time Windows Setup was run on the system.  

When you view the **Explain** tab in the **Properties** of the **Specify Windows Service Pack Installation File Location** Group Policy object, the text on the **Explain** tab states as:  

Specifies an alternate location for Windows Service Pack installation files.

To enable this setting, enter the fully qualified path to the new location in the "Windows Service Pack Setup file path" box.

If you disable this setting or do not configure it, the Windows Setup source path will be the location used during the last time Windows Service Pack Setup was run on the system.  

However, if you try to use these Group Policy objects to specify an alternative location for the Windows installation files and the Windows Service Pack installation files, the files are not retrieved from the location that you specify, and you are prompted for the location of the installation media that was originally used.

## Cause

This behavior occurs because the information that is provided on these two **Explain** tabs is inaccurate. The settings for the **Specify Windows Installation File Location** and the **Specify Windows Service Pack Installation File Location** Group Policy objects apply only to Windows File Protection. These settings do not apply to items that use the Setup API to install.

## Resolution

To resolve this problem, edit the registry to specify the location of the Windows installation files and the location of the Windows Service Pack installation files. To do it, follow these steps.

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate the following registry subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup`  

3. Right-click **SourcePath**, and then click **Modify**.
4. In the **Value data** box, type the path of the Windows installation files, and then click **OK**.
5. Right-click **ServicePackSourcePath**, and then click **Modify**.
6. In the **Value data** box, type the path of the Windows Service Pack installation files, and then click **OK**.
7. Locate the following registry subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`  

8. Right-click **SourcePath**, and then click **Modify**.
9. In the **Value data** box, type the path of the Windows installation files, and then click **OK**.

## Status

Microsoft has confirmed that it is a problem in the Microsoft products that are listed in the "Applies to" section of this article.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
