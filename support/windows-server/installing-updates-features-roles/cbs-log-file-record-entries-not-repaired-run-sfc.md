---
title: CBS.log file contains entries that some files aren't repaired after you successfully run the SFC utility
description: Describes the issue in which the CBS.log file records entries when a static file changes. Because the static file isn't protected by the Windows Resource Protection feature, the feature reports the change in the CBS.log file.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kmcniel, kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# The CBS.log file contains entries that some files aren't repaired even after you successfully run the SFC utility on a Windows Server based computer

This article describes an issue where the CBS.log file records entries when a static file changes. Because the static file isn't protected by the Windows Resource Protection feature, the feature reports the change in the CBS.log file.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954402

## Symptoms

You run the System File Checker (SFC) utility (Sfc.exe) to scan for changes in Windows system files in a Windows Server 2008-based computer. When you run the SFC utility, you may receive the following message:
> All files and registry keys listed in this transaction have been successfully repaired.

However, when you view the %windir%\Logs\CBS\CBS.log file that the Sfc.exe program generates, you may see the following entries:

> \<Date> \<Time>, Info CSI 00000142 [SR] Repairing 1 components  
\<Date> \<Time>, Info CSI 00000143 [SR] Beginning Verify and Repair transaction  
\<Date> \<Time>, Info CSI 00000145 [SR] Cannot repair member file [l:18{9}]"img11.jpg" of Microsoft-Windows-Shell-Wallpaper-Common, Version = 6.0.5720.0, pA = PROCESSOR_ARCHITECTURE_INTEL (0), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeName neutral, PublicKey neutral in the store, hash mismatch  
\<Date> \<Time>, Info CSI 00000147 [SR] Cannot repair member file [l:18{9}]"img11.jpg" of Microsoft-Windows-Shell-Wallpaper-Common, Version = 6.0.5720.0, pA = PROCESSOR_ARCHITECTURE_INTEL (0), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeName neutral, PublicKey neutral in the store, hash mismatch  
\<Date> \<Time>, Info CSI 00000149 [SR] Repair complete  
\<Date> \<Time>, Info CSI 0000014a [SR] Committing transaction  
\<Date> \<Time>, Info CSI 0000014e [SR] Verify and Repair Transaction completed. All files and registry keys listed in this transaction have been successfully repaired

## Cause

Static files and mutable files are the two kinds of files that are defined in the system. Static files can't be changed. Mutable files can be changed. Registry files and log files are examples of mutable files. The Windows Resource Protection (WRP) feature doesn't scan mutable files. The WRP feature scans static files when the SFC utility scans the computer. The WRP feature helps protect most of the static files. However, in this case, the WRP feature doesn't protect the Img11.jpg static file. If a static file changes when the WRP feature scans the file, the change is recorded in the CBS.log file. Because the WRP feature doesn't protect the Img11.jpg static file, the WRP feature has no option other than to report the change in the CBS.log file.

## More information

The Sfc.exe program writes the details of each verification operation and of each repair operation to the CBS.log file. Each SFC.exe program entry in the CBS.log file has an [SR] tag.

> [!NOTE]
> The Windows Modules Installer service also writes to the CBS.log file. The Windows Modules Installer service installs optional features, updates, and service packs.

You can search for [SR] tags to help locate SFC.exe program entries. To search for [SR] tags and to redirect the search results to a text file, follow these steps:

1. Click **Start**, type *cmd* in the **Start Search** box, right-click **cmd** in the **Programs** list, and then click **Run as administrator**.

    If you're prompted for an administrator password or for confirmation, type the password, or click **Continue**.

2. At the command prompt, type the following command, and then press ENTER:

    ```console
    findstr /c:"[SR]" %windir%\logs\cbs\cbs.log >sfcdetails.txt
    ```

    > [!NOTE]
    > The Sfcdetails.txt file includes the entries that are logged every time that the SFC.exe program runs on the computer.
3. Type *exit*, and then press ENTER to close the Command Prompt window.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
