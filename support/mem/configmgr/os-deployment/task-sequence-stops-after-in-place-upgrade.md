---
title: Task sequence stops after an in-place upgrade
description: The task sequence in Configuration Manager stops after an in-place upgrade from Windows 7 or Windows 8.1 to Windows 10.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
---
# Configuration Manager task sequence doesn't continue after an in-place upgrade to Windows 10

This article fixes an issue in which the task sequence in Configuration Manager doesn't continue after an in-place upgrade from Window 7 or Windows 8.1 to Windows 10.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4470553

## Symptoms

You run the Windows 10 in-place upgrade task sequence in Configuration Manager to upgrade the operating system on the computer. If you upgrade from Windows 7 or Windows 8.1 to Windows 10, the task sequence doesn't continue after the in-place upgrade completes. Additionally, when you examine the smsts.log file, you find the following entries logged:

> TSManager Start to compile TS policy  
> TSManager spPolicyNamespace.Open(pszNamespace, true), HRESULT=8004100e (..\utils.cpp,3450)  
> TSManager Failed to open WMI Namespace 'root\ccm\policy\defaultmachine\requestedconfig'. WMI Repository may be corrupted  
> Invalid namespace (Error: 8004100E; Source: WMI)  
> TSManager End TS policy compilation  
> TSManager CompileXMLPolicy(c_szRequestedConfigNS, sPolicyID, sPolicyVersion, c_szTSPolicySource, sPolicyRuleID, sPolicyData), HRESULT=8004100e (..\utils.cpp,3680)  
> TSManager CompilePolicy(sPolicyXml, sInstanceList), HRESULT=8004100e (..\utils.cpp,3710)  
> TSManager TS::Utility::CompileConfigPolicyEx(m_bNoSMSClient || m_bInWinPE || STADALONE_MODE == m_StartupMode || bProvMode), HRESULT=8004100e (tsmanager.cpp,1568)  
> TSManager Error compiling client config policies. code 8004100E  
> TSManager Task Sequence Manager could not initialize Task Sequence Environment. code 8004100E  
> TSManager hr = InitializeEnvironment(), HRESULT=8004100e (tsmanager.cpp,1244)  
> TSManager Task sequence execution failed with error code 8004100E

## Cause

This issue can occur if Windows Management Framework (WMF) 5.1 was already installed on the OS (Windows 7 or Windows 8.1) when the in-place upgrade task sequence started.

WMF 5.1 installs a Windows 10 version of the **WMIMigrationPlugin.dll** file in the `C:\Windows\System32\migration` directory. This DLL is responsible for migrating the WMI repository during the in-place upgrade. However, the Windows 10 version of the **WMIMigrationPlugin.dll** file is incompatible with Windows 7 and Windows 8.1. Therefore, the migration of the WMI repository fails during the in-place upgrade. This results in the WMI repository becoming corrupted, and the task sequence can't continue in the new (Windows 10) OS.

## Resolution

This issue is fixed by the latest Windows 7 cumulative update. If the latest Windows 7 cumulative update is installed after WMF 5.1 is installed, the cumulative update correctly replaces **WMIMigrationPlugin.dll** with a Windows 7-compatible version. However, if WMF 5.1 is installed after the last Windows 7 cumulative update is installed, the issue will still occur. The issue will then get corrected when the next Windows 7 cumulative update is installed.

> [!IMPORTANT]
> There is currently no fix for this issue in the Windows 8.1 cumulative updates.

For Windows 7 scenarios where WMF 5.1 was installed after the last cumulative update and for all Windows 8.1 scenarios, or just to make sure that a correct version of **WMIMigrationPlugin.dll** is installed before you run an in-place upgrade in Windows 7 or Windows 8.1, tasks can be added to the task sequence to remediate the issue.

A download of the exported task sequence that contains the steps that should be added to the in-place upgrade task sequence in Configuration Manager is available.

[Download the WMF Fix Exported Task Sequence now](https://download.microsoft.com/download/C/4/D/C4D52EE0-CACF-4D87-BC25-3F5567048765/WMF%20Fix%20-%20Win7%20x64%20&%20Win8.1%20x64%20(1).zip)

For information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591/how-to-obtain-microsoft-support-files-from-online-services).

After the task sequence is downloaded, import the **WMF Fix - Win7 x64 & Win8.1 x64 (1).zip** file into your Configuration Manager environment. Copy the steps from the converted task sequence, and then paste the steps immediately above the **Upgrade Operating System** task in your in-place upgrade task sequence.

For more information about how to import task sequences, see [Process to import task sequences](/mem/configmgr/osd/deploy-use/manage-task-sequences-to-automate-tasks#process-to-import-task-sequences).

> [!IMPORTANT]
> These steps only prevent the issue on devices going forward. These steps don't fix any devices that have experienced this issue. For devices that have experienced this issue, we recommend that you completely reimage the device to fix the WMI corruption.

[!INCLUDE [Virus scan claim](../../../includes/virus-scan-claim.md)]
