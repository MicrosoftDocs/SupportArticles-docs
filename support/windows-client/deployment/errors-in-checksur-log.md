---
title: Fix errors found in CheckSUR.log
description: Describes how to fix errors that are logged by the System Update Readiness tool (CheckSUR) but remain unresolved.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.technology: windows-client-deployment
---
# Fix errors found in the CheckSUR.log

This article describes how to resolve servicing corruption that the System Update Readiness tool (CheckSUR) finds but cannot correct on its own. Output from the tool is recorded in the %WinDir%\Logs\CBS\CheckSUR.log file.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2700601

> [!NOTE]
> Make sure you download and run the most recent version of CheckSUR.exe because the tool is updated periodically. To to this, see [Fix Windows Update errors by using the DISM or System Update Readiness tool](../../windows-server/deployment/fix-windows-update-errors.md).

## Use the CheckSur log

To use the CheckSur log, follow these guidelines:

- If CheckSUR fixed all the errors that it found, the CheckSUR log shows the following information:

    > Summary:  
    Seconds executed: 100  
    Found 10 errors  
    Fixed 10 errors

    In this scenario, you should no longer have any servicing corruption on your computer. If you are still experiencing errors, you have to troubleshoot the specific error message to find the root cause of the failure.

- If you receive an **Unavailable repair files** message, this indicates that some of the inconsistent files that the tool found cannot be fixed. This is because the tool does not carry the correct versions of the replacement files. After this message appears, the CheckSUR.log shows information that resembles the following:

    > Summary:  
    Seconds executed: 264  
    Found 3 errors  
    CBS MUM Missing Total Count: 3  
    Unavailable repair files:
    >
    > servicing\packages\Package_for_KB958690_sc_0~31bf3856ad364e35~amd64`~~`6.0.1.6.mum  
    servicing\packages\Package_for_KB958690_sc~31bf3856ad364e35~amd64`~~`6.0.1.6.mum  
    servicing\packages\Package_for_KB958690~31bf3856ad364e35~amd64`~~`6.0.1.6.mum  
    servicing\packages\Package_for_KB958690_sc_0~31bf3856ad364e35~amd64`~~`6.0.1.6.cat  
    servicing\packages\Package_for_KB958690_sc~31bf3856ad364e35~amd64`~~`6.0.1.6.cat  
    servicing\packages\Package_for_KB958690~31bf3856ad364e35~amd64`~~`6.0.1.6.cat  
    winsxs\manifests\x86_microsoft-windows-servicingstack_31bf3856ad364e35_6.0.6002.18005_none_0b4ada54c46c45b0.manifest  
    winsxs\manifests\amd64_microsoft-windows-servicingstack_31bf3856ad364e35_6.0.6002.18005_none_676975d87cc9b6e6.manifest

    To resolve this issue, follow these steps:

    1. Download the package that contains the missing files. For this example, you would download Windows6.0-KB958690-x64.msu.
    2. In the `%SYSTEMROOT%\CheckSUR` folder, create a folder that is named Packages. Copy the Windows6.0-KB958690-x64.msu to the  `%SYSTEMROOT%\CheckSUR\Packages` folder.
    3. Rerun CheckSUR.
    4. If the source package of the missing files is not obvious, you will have to get the files from another computer. Make sure the computer from which you copy the filhates uses the same OS version and system architecture as the computer that you are working on.
    5. Copy the files to the `%WinDir%\Temp\CheckSUR` folder of the corrupted computer in the following subdirectory format, and then rerun CheckSUR:
        - Put all files of type *.mum and *.cat into the `%WinDir%\Temp\CheckSUR\Packages` folder.
        - Put all files of type *.manifest into the `%WinDir%\Temp\CheckSUR\Manifests` folder.

- If you see a **Payload File Missing** message, this indicates that the required binary file is not available. This means that the issue is not fixed. The CheckSUR.log shows the following information:

    > Summary:  
    Seconds executed: 100  
    Found 3 errors  
    Fix 1 errors  
    CSI Payload File Missing Total count: 3  
    Fix CSI Payload File Missing Total Count: 1
    >
    > (f) CSI Payload File Missing 0x00000000 admparse.dll x86_microsoft-windows-ie-adminkitmostfiles_31bf3856ad364e35_6.0.6000.16386_none_abfb5fd109dad8b8 servicing_31bf3856ad364e35_6.0.6000.16386_none_23ddbf36a8a961bc  
    (f) CSI Payload File Missing 0x00000000 bootmgr x86_microsoft-windows-b..re-bootmanager-pcat_31bf3856ad364e35_6.0.6000.16386_none_c0f2f087b6457236  
    (fix) CSI Payload File Missing 0x00000000 bootmgr x86_microsoft-windows-b..re-bootmanager-pcat_31bf3856ad364e35_6.0.6000.16386_none_c0f2f087b6457236  
    (f) CSI Payload File Missing 0x00000000 winload.exe x86_microsoft-windows-b..environment-windows_31bf3856ad364e35_6.0.6000.16386_none_6701d52e8fdf8d45

    To resolve this issue, follow these steps:

    1. Find out which payload files are missing. To do this, examine the CheckSUR log. Identify any lines that have an **(f)** entry that is not followed by **(fix)**. In the previous example, there are two payload files that were not fixed.
    2. Copy these files from another computer. Make sure the computer from which you copy files uses the same OS version and system architecture as the computer that you are working on.
    3. Paste the files into the appropriate subfolder under `%windir%\winsxs`.

Before you put the files into the indicated locations, you may have to grant yourself permissions to edit the folder contents. To do this, open an elevated Command Prompt window, and run the following commands:

```console
takeown /f <Path_And_Name>
icacls <Path_And_Name> /grant Administrators:F
```

> [!NOTE]
> In these commands, \<Path_And_Name> represents the name of the file or folder that you are targeting. For example, you might target the following folder:  
> `C:\Windows\winsxs\x86_microsoft-windows-ie-adminkitmostfiles_31bf3856ad364e35_6.0.6000.16386_none_abfb5fd109dad8b8`

The following commands take ownership of this folder, grant Full Control of the folder to the Administrators group, and then replace the admparse.dll file:

```console
takeown /f C:\Windows\winsxs\ x86_microsoft-windows-ie-adminkitmostfiles_31bf3856ad364e35_6.0.6000.16386_none_abfb5fd109dad8b8
icacls C:\Windows\winsxs\x86_microsoft-windows-ie-adminkitmostfiles_31bf3856ad364e35_6.0.6000.16386_none_abfb5fd109dad8b8 /grant Administrators:F copy C:\Temp\admparse.dll c:\Windows\winsxs\x86_microsoft-windows-ieadminkitmostfiles_31bf3856ad364e35_6.0.6000.16386_none_abfb5fd109dad8b8\admparse.dll
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
