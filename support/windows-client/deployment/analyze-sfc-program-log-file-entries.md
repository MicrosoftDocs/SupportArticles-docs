---
title: Analyze log file entries that SFC.exe generates
description: Describes how to use the SFC.exe program to help diagnose problems that are caused by missing or damaged operating system files.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
---
# Analyze the log file entries that *SFC.exe* generates in Windows

This article describes how to analyze the log files that the Microsoft Windows Resource Checker (*SFC.exe*) program generates in Windows.

_Applies to:_ &nbsp; Windows Vista and later versions  
_Original KB number:_ &nbsp; 928228

## Overview

You can use the *SFC.exe* program to help you troubleshoot crashes that occur in the user mode part of Windows. These crashes may be related to missing or damaged operating system files.

The *SFC.exe* program performs the following operations:

- It verifies that non-configurable Windows system files have not changed. Also, it verifies that these files match the operating system's definition of which files are expected to be installed on the computer.
- It repairs non-configurable Windows system files, when it is possible.

## View the log file

The *SFC.exe* program writes the details of each verification operation and of each repair operation to the *CBS.log* file. Each *SFC.exe* program entry in this file has an **\[SR\]** tag. The *CBS.log* file is located in the *%windir%\Logs\CBS* folder.

> [!NOTE]
> The Windows Modules Installer service also writes to this log file. (The Windows Modules Installer service installs optional features, updates, and service packs.)

You can search for **\[SR\]** tags to help locate *SFC.exe* program entries. To perform this kind of search and to redirect the results to a text file, follow these steps:

1. Click **Start**, type *cmd* in the **Start Search** box, right-click **cmd** in the **Programs** list, and then click **Run as administrator**.
    If you are prompted for an administrator password or for a confirmation, type your password, or click **Continue**.
2. Type the following command, and then press ENTER:

    ```console
    findstr /c:"[SR]" %windir%\logs\cbs\cbs.log >sfcdetails.txt
    ```

The Sfcdetails.txt file includes the entries that are logged every time that the *SFC.exe* program runs on the computer.

## Interpret the log file entries

The *SFC.exe* program verifies files in groups of 100. Therefore, there will be many groups of *SFC.exe* program entries. Each entry has the following format:

**date** **time** **entry_type details**

The following sample excerpt from a *CBS.log* file shows that the *SFC.exe* program did not identify any problems with the Windows system files:

```output
<date> <time>, Info CSI 00000006 [SR] Verifying 100 (0x00000064) components  
<date> <time>, Info CSI 00000007 [SR] Beginning Verify and Repair transaction  
<date> <time>, Info CSI 00000009 [SR] Verify complete  
<date> <time>, Info CSI 0000000a [SR] Verifying 100 (0x00000064) components  
<date> <time>, Info CSI 0000000b [SR] Beginning Verify and Repair transaction  
<date> <time>, Info CSI 0000000d [SR] Verify complete  
<date> <time>, Info CSI 0000000e [SR] Verifying 100 (0x00000064) components  
<date> <time>, Info CSI 0000000f [SR] Beginning Verify and Repair transaction  
<date> <time>, Info CSI 00000011 [SR] Verify complete  
<additional entries>  
<additional entries>  
<date> <time>, Info CSI 00000011 [SR] Verify complete
```

The following sample excerpt from a *CBS.log* file shows that the *SFC.exe* program has identified problems with the Windows system files:

```output
<date> <time>, Info CSI 00000006 [SR] Verifying 100 (0x00000064) components  
<additional entries>  
<additional entries>  
<date> <time>, Info CSI 00000007 [SR] Beginning Verify and Repair transaction  
<date> <time>, Info CSI 00000008 [SR] Repairing corrupted file [ml:520{260},l:108{54}]"??\E:\Program Files\Common Files\Microsoft Shared\DAO"[l:20{10}]"dao360.dll" from store  
<date> <time>, Info CSI 0000000a [SR] Verify complete
```

> [!NOTE]
> Although the log file entry states that the *SFC.exe* program is repairing the changed file, no actual repair operation occurs when a file is verified.

The following list describes other messages that may be logged in the *SFC.exe* program entries of the *CBS.log* file after verification is completed.

- Entry 1: Cannot repair member file **file details**. For example:

  ```output
  Cannot repair member file [l:14{7}]"url.dll" of Microsoft-Windows-IE-WinsockAutodialStub, Version = 6.0.5752.0, pA = PROCESSOR_ARCHITECTURE_INTEL (0), Culture neutral, VersionScope = 1 nonSxS, PublicKeyToken = {l:8 b:31bf3856ad364e35}, Type neutral, TypeN
  ```

  This entry indicates that the file content does not match the operating system definition for the file. In this situation, the *SFC.exe* program cannot repair the file.

- Entry 2: Repaired file **file details** by copying from backup. For example:

  ```output
  Repaired file \SystemRoot\WinSxS\Manifests\[ml:24{12},l:18{9}]"netnb.inf" by copying from backup
  ```

  This entry indicates that a problem exists with a file. The *SFC.exe* program can repair this file by copying a version from a private system store backup.

- Entry 3: Repairing corrupted file **file details** from store. For example:

  ```output
  Repairing corrupted file [ml:520{260},l:36{18}]"??\C:\Windows\inf"[l:18{9}]"netnb.inf" from store
  ```

  This entry indicates that a problem exists with a file. The *SFC.exe* program can repair this file by copying a version from the system store.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
