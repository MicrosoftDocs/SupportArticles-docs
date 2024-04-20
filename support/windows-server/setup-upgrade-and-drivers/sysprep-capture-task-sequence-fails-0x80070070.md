---
title: SYSPREP and CAPTURE task sequence fails with error 0x80070070
description: Helps fix a 0x80070070 error that occurs when Deployment Toolkit fails to complete sysprep and capture task sequence.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, vineetm
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# SYSPREP and CAPTURE task sequence fails with error 0x80070070

This article helps fix a 0x80070070 error that occurs when Deployment Toolkit fails to complete sysprep and capture task sequence.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2670374

## Symptoms

Microsoft Deployment Toolkit fails to complete sysprep and capture task sequence if there is a drive letter assigned to the first partition or there is no enough free space available in first partition. Following details with error are shown in Summary screen.

> ZTI ERROR - Unhandled error returned by LTIApply: (-2147024784 0x80070070)  
Litetouch deployment failed, Returned Code = -2147467259 0x80004005  
Messages from the task sequence engine:  
Failed to run the action: Apply Windows PE.  
There is not enough space on the disk. (Error: 80070070; Source: Windows)  
The execution of the group (Capture Image) has failed and the execution has been aborted.  
An action failed.  
Operation aborted (Error: 80004004; Source: Windows)  
Failed to run the last action: Apply Windows PE. Execution of task sequence failed.

In BDD.log we can see following information:

> --- Applying bootable Windows PE Image -----  
LTI applying Windows PE  
Will boot into Windows PE architecture x64 to match OS being deployed.
Copying \\\\Server\\Deploymentshare\\Boot\\LiteTouchPE_x64.wim to E:\\sources.boot.wim  
MDT was copying the LiteTouchPE.wim to E:\\LiteTouchPE.wim that is the first partition in hard drive.

## Cause

By default MDT copies the LiteTouchPE.wim from the deployment share to the first partition (which has a drive letter assigned) in the hard drive to complete the sysprep and capture task sequence. In the above example, the drive letter was assigned as E:\\ for 'System Reserved' partition.

## Resolution

To resolve this particular issue, follow the below steps:

- Do not assign any drive letter to the 'System Reserved' partition, so that MDT can copy to next partition that has the drive letter.
- This issue can also occur if you do not have free space in the C drive, wherein C drive is the first partition.

## More information

By default Windows 7 is installed from a media or WDS, you will have first partition as 'System Reserved' partition of 100-MB size, on the disk selected (generally disk 0) and it will NOT have a drive letter assigned. If the image is deployed from MDT (2010), then the 'System Reserved' partition will be 300 MB and will be allocated after the OS partition.

How to capture the image using MDT:
[How to run a Sysprep and Capture Task Sequence From MDT 2010](/archive/blogs/askcore/how-to-run-a-sysprep-and-capture-task-sequence-from-mdt-2010)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
