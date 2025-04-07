---
title: An OS deployment task sequence doesn't continue
description: Describes an issue in which a task sequence doesn't continue after Windows Setup or the in-place upgrade finishes if an OEM product key is used during Windows deployment.
ms.date: 04/07/2025
ms.custom: sap:Operating Systems Deployment (OSD)\Operating System In-place Upgrade Deployments
ms.reviewer: kaushika, frankroj, Jowiswel
---
# An OSD task sequence doesn't continue after Windows Setup or an in-place upgrade finishes

_Original product version:_ &nbsp; Configuration Manager (current branch), System Center Configuration Manager 2012 R2  
_Original KB number:_ &nbsp; 4494015

This article fixes an issue in which a task sequence doesn't continue after Windows Setup or an in-place upgrade finishes if an OEM product key is used during Windows deployment.

## Symptoms

When you run an OS deployment task sequence in Configuration Manager, you experience the following issues:

- A **Refresh** or **New Computer** task sequence doesn't continue after Windows Setup finishes during the **Setup Windows and ConfigMgr** step.

    The following entry is logged in the `%windir%\panther\unattendGC\Setupact.log` file:

    > [windeploy.exe] OEM license detected, will not run SetupComplete.cmd

- An **In-Place Upgrade** task sequence doesn't continue after the in-place upgrade finishes during the **Upgrade Operating System** step.

    The following is logged in the `%windir%\panther\unattendGC\Setupact.log` file:

    > [windeploy.exe] Client OS detected: 1  
    > [windeploy.exe] OEM Licensing detected: 1  
    > [windeploy.exe] EnterpriseS or Enterprise or EnterpriseSN or EnterpriseN edition detected: 0  
    > [windeploy.exe] Client OS edition and OEM license detected and no enterprise edition detected, will not run SetupComplete.cmd  
    > [windeploy.exe] Not allowed to run the Setupcomplete.cmd, will not run SetupComplete.cmd

These issues usually occur when you deploy a nonenterprise edition of Windows, such as Windows Professional edition, Windows Embedded, or Windows IoT.

## Cause

These issues occur because an OEM product key is used during Windows deployment. When an OEM product key is used, **Setupcomplete.cmd** is disabled. This behavior occurs in both Windows 10 and Windows 11. See the following information from [Windows Deployment Issues](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825613(v=win.10)#windows-deployment-issues):

- [September 2012] Changes in Out-Of-Box (OOBE) Experience

  **Oobe.cmd** and **Setupcomplete.cmd** are disabled if an OEM product key is used. This is to ensure that end-users reach **Start** as quickly as possible. If you have any tools or services that use this infrastructure, these must be changed to tasks that occur after the OOBE.

[SetupComplete.cmd](/windows-hardware/manufacture/desktop/add-a-custom-script-to-windows-setup) is a custom script that runs during or after the Windows Setup process. It contains commands to restart the Configuration Manager task sequence after Windows Setup finishes. When **SetupComplete.cmd** is disabled, the task sequence can't continue after Windows Setup finishes.

## Resolution

To fix the issue, specify the [KMS client setup keys](/windows-server/get-started/kmsclientkeys) in the locations where the OEM product key is specified for the version of Windows that you want to deploy. For example, specify the KMS client setup key in the **Apply Windows Settings** or the **Upgrade Operating System** step.

If the OEM product key must be used, follow these steps in addition to specifying the KMS client setup key:

1. Add a **Run Command Line** step after the **Setup Windows and ConfigMgr** step in a **Refresh** or **New Computer** task sequence, or after the **Upgrade Operating System** step in an **In-Place Upgrade** task sequence.
2. In the **Run Command Line** step, use [changepk.exe or slmgr.vbs](/windows/deployment/upgrade/windows-10-edition-upgrades#upgrade-using-a-command-line-tool) to specify the OEM key in **Command line**.

If the OEM key in the BIOS or firmware of the device must be used, run the following PowerShell command to get the key:

```powershell
Get-CIMInstance SoftwareLicensingService | Select -ExpandProperty OA3xOriginalProductKey
```

## OEM product key locations

The OEM product key can be specified in the following locations:

- In a **Refresh** or **New Computer** task sequence:
  - In the **Apply Windows Settings** step.
  - In a custom answer file (Unattend.xml). This file is usually specified in the **Apply Operating System** step.
  - Through variables such as `OSDProductKey` or `ProductKey` (in an MDT-integrated task sequence).
- In an **In-Place Upgrade** task sequence:
  - In the **Upgrade Operating System** step.
  - Through the `OSDSetupAdditionalUpgradeOptions` variable by using the `/PKey` command line option.

The OEM product key can also be obtained automatically by Windows Setup from the BIOS or firmware of the device. In this case, the following entry is logged in the `%windir%\panther\Setupact.log` file:

> MOUPG ProductKey: Product key found in Digital Marker.  
> MOUPG ProductKey: Validating Product Key for Image.  
> SPValidateProductKey: Calling PidGenX  
> MOUPG ProductKey: Product key using pkey edition = [Professional].  
> MOUPG ProductKey: Matching Install Wim For Exact Editions  
> MOUPG ProductKey: Matching Install Wim.  
> MOUPG ProductKey: Matched Professional with Professional  
> MOUPG ProductKey: Matching Install Wim: Found [1] matching images.  
> MOUPG ProductKey: Extracting Eula  
> MOUPG ProductKey: Product key was successfully validated.  
> MOUPG ProductKey: Product EditionID = Professional  
> MOUPG ProductKey: Product InstallChannel = OEM  
> MOUPG ProductKey: Eula = C:\\$WINDOWS.~BT\Sources\Panther\\\<file>.tmp  
> MOUPG ProductKey: Valid product key found = [TRUE].
