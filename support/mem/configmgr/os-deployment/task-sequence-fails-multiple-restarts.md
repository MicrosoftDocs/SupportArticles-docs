---
title: Task sequence fails if software updates ask restarts
description: Lists known Windows updates that require dual restarts, and discusses problem mitigation strategies.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj, mikecure
---
# Task sequence fails in Configuration Manager if software updates require multiple restarts

This article provides the information to solve the issue that the **Task Sequence environment not found** error occurs when using a Configuration Manager task sequence.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 2894518

## Summary

The issue is fixed in Cumulative Update 3 for System Center 2012 Configuration Manager Service Pack 2 and System Center 2012 R2 Configuration Manager Service Pack 1, and in Configuration Manager current branch version 1602.

A new optional task sequence variable, `SMSTSWaitForSecondReboot`, is available to better control client behavior when a software update installation requires two restarts.

For more information, see the **Software updates management/operating system deployment** section in [Description of Cumulative Update 3 for Configuration Manager](https://support.microsoft.com/help/3135680).

For Configuration Manager current branch, see [Task sequence variables](/mem/configmgr/osd/understand/task-sequence-variables).

## Symptoms

Assume that a Configuration Manager task sequence that uses the **Install Software Updates** step installs a software update that triggers multiple restarts after the task sequence successfully runs the **Install Software Updates** task. In this situation, the task sequence can fail and generate the following error message:

> Task Sequence environment not found

> [!NOTE]
> You can avoid this issue in Configuration Manager by using the new **Retry** option in the [Install Software Updates](/mem/configmgr/osd/understand/install-software-updates) task sequence step.

## Cause

The first restart that is initiated by the software update is controlled by the task sequence. However, the second restart request is initiated by a Windows component (typically, Component-Based Servicing) and is not controlled by the task sequence. Therefore, the task sequence execution state is not saved before the restart because the second restart is not controlled by the task sequence. When the task sequence resumes after the second restart, no state is available to continue successfully.

## Resolution

To resolve this issue, we recommend that you apply any updates that require dual restarts by using the usual software updates feature of Configuration Manager instead of using task sequences. The following software updates were reported to require multiple restarts.

- [3126446 MS16-017: Description of the security update for Remote Desktop display driver: February 9, 2016](https://support.microsoft.com/help/3126446)
- [3096053 September 2015 servicing stack update for Windows 8 and Windows Server 2012](https://support.microsoft.com/help/3096053)
- [3075222 MS15-082: Description of the security update for RDP in Windows: August 11, 2015](https://support.microsoft.com/help/3075222)
- [3067904 MS15-082: Description of the security update for Windows RDP: July 14, 2015](https://support.microsoft.com/help/3067904)
- [3069762 MS15-067: Description of the security update for Windows RDP: July 14, 2015](https://support.microsoft.com/help/3069762)
- [3003729 April 2015 servicing stack update for Windows 8 and Windows Server 2012](https://support.microsoft.com/help/3003729)
- [3035017 MS15-030: Description of the security update for Remote Desktop protocol: March 10, 2015](https://support.microsoft.com/help/3035017)
- [3039976 MS15-030: Vulnerability in Remote Desktop protocol could allow denial of service: March 10, 2015](https://support.microsoft.com/help/3039976)
- [3036493 MS15-030: Description of the security update for Remote Desktop protocol: March 10, 2015](https://support.microsoft.com/help/3036493)
- [3003743 MS14-074: Vulnerability in Remote Desktop Protocol could allow security feature bypass: November 11, 2014](https://support.microsoft.com/help/3003743)
- [2984976 RDP 8.0 update for restricted administration on Windows 7 or Windows Server 2008 R2](https://support.microsoft.com/help/2984976)
- [2981685 Security updates cannot be installed if BitLocker is not installed on your computer](https://support.microsoft.com/help/2981685)
- [2966034 Description of the security update for Remote Desktop Security Release for Windows 8.1 systems that do not have the 2919355 update installed: June 10, 2014](https://support.microsoft.com/help/2966034)
- [2965788 MS14-030: Description of the security update for Remote Desktop Security Release for Windows: June 10, 2014](https://support.microsoft.com/help/2965788)
- [2920189 Description of the update rollup of revoked noncompliant UEFI modules: May 13, 2014](https://support.microsoft.com/help/2920189)
- [2862330 MS13-081: Description of the security update for USB drivers: October 8, 2013](https://support.microsoft.com/help/2862330)
- [2871777 A servicing stack update is available for Windows RT, Windows 8, and Windows Server 2012: September 2013](https://support.microsoft.com/help/2871777)
- [2871690 Microsoft security advisory: Update to revoke noncompliant UEFI boot loader modules](https://support.microsoft.com/help/2871690)
- [2821895 A servicing stack update is available for Windows RT and Windows 8: June 2013](https://support.microsoft.com/help/2821895)
- [2771431 A servicing stack update is available for Windows 8 and Windows Server 2012](https://support.microsoft.com/help/2771431)
- [2545698 Text in some core fonts appears blurred in Internet Explorer 9 on a computer that is running Windows Vista, Windows Server 2008, Windows 7, or Windows Server 2008 R2](https://support.microsoft.com/help/2545698)
- [2529073 Binary files in some USB drivers are not updated after you install Windows 7 SP1 or Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2529073)

## More information

Because this second restart is not controlled by the task sequence, no execution state is saved before the restart. When the task sequence resumes after the restart, no state is available to continue successfully. Additionally, the following message may be logged to the Smsts.log file when you experience this issue:

> !sVolumeID.empty(), HRESULT=80004005  
> !sTSMDataPath.empty(), HRESULT=80070002  
> TS::Utility::GetTSMDataPath( sDataDir ), HRESULT=80070002  
> Failed to set log directory. Some execution history may be lost.  
> The system cannot find the file specified. (Error: 80070002; Source: Windows)  
> Executing task sequence  
> !sVolumeID.empty(), HRESULT=80004005  
> !sTSMDataPath.empty(), HRESULT=80070002  
> Task Sequence environment not found

Also, clients that are running release versions that are earlier than Microsoft System Center 2012 Configuration Manager Service Pack 1 may contain the following log entry:

> Task sequence completed in Windows PE.

The client computer may also be stuck in provisioning mode after the task sequence fails. To determine whether the computer is in provisioning mode, check the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmExec` registry subkey.

`ProvisioningMode` should be set to **false**. If it is set to **true**, use one of the following methods to take the client out of provisioning mode:

- Use the Windows Management Instrumentation (WMI) method `SetClientProvisioningMode` to take the client out of provisioning mode correctly. The easiest way to do this is to run the following Windows PowerShell command:

    ```powershell
    Invoke-WmiMethod -Namespace root\CCM -Class SMS_Client -Name SetClientProvisioningMode -ArgumentList $false
    ```  

    Or, run the following command at an elevated command prompt:

    ```console
    powershell Invoke-WmiMethod -Namespace root\CCM -Class SMS_Client -Name SetClientProvisioningMode -ArgumentList $false
    ```  

- Reinstall the client.

> [!IMPORTANT]
> Do not try to fix the client by changing the value of `ProvisioningMode` to **false**. This action will not fully take the client out of provisioning mode.
