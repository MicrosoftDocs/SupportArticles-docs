---
title: Sysprep and capture task sequence fails
description: Provides a workaround for an issue where the Sysprep and Capture task sequence fails when it tries to capture Windows images.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# Sysprep and Capture task sequence fails when it tries to capture Windows images

This article provides a workaround for an issue where the Sysprep and Capture task sequence fails when it tries to capture Windows images.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2797676

## Symptoms

The issue affects the Sysprep and captures TS in the following products:

- Microsoft Deployment 2012 Update 1
- Microsoft Deployment Toolkit 2013

The Sysprep and Capture task sequence fails when it tries to capture a Windows image that was installed from a media. Additionally, you may receive the following errors:

> Deployment Summary
>
> Failure
Operating system deployment did not complete successfully.  
Review the log files to determine the cause of the problem.  
During the deployment process, 14 errors and 0 warning were reported.  
>
> Details ...  
ZTI ERROR - Unhandled error returned by LTIApply: Not found (-2147217406 0x80041002)  
Litetouch deployment failed, Return Code = -2147467259 0x80004005  
Failed to run the action: Apply Windows PE.  
Not found (Error: 80041002; Source: WMI)  
The execution of the group (Capture Image) has failed and the execution has been aborted.  
An action failed.  
Operation aborted (Error: 80004004; Source: Windows)  
Failed to run the last action: Apply Windows PE. Execution of task sequence failed.  
Not found (Error: 80041002; Source: WMI)  
Task Sequence Engine failed! Code: enExecutionFail  
Task sequence execution failed with error code 80004005  
Error Task Sequence Manaqer failed to execute task sequence. Code 0x80004005  

Also, when you check the BDD.log file, you may notice that the following errors are logged:

> <![LOG[Taking ownership of C:\boot]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">  
> <![LOG[About to run command: takeown.exe /F "C:\boot" /R /A /D Y]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">  
> <![LOG[Command has been started (process ID 2748)]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">  
> <![LOG[Return code from command = 1]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">  
> <![LOG[ResetFolder: TakeOwn for C:\boot, RC = 1]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">  
> <![LOG[ZTI ERROR - Unhandled error returned by LTIApply: Not found (-2147217406 0x80041002)]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="3" thread="" file="LTIApply">  
> <![LOG[Event 41002 sent: ZTI ERROR - Unhandled error returned by LTIApply: Not found (-2147217406 0x80041002)]LOG]!><time="\<time>" date="\<date>" component="LTIApply" context="" type="1" thread="" file="LTIApply">

## Cause

This problem occurs because the LTIApply.wsf script fails to check for the existence of the boot folder on the system partition before the script runs the `takeown.exe` command to change ownership on the folder. The `takeown.exe` command fails with a "Not Found" error if the boot folder doesn't exist. This causes the Sysprep and Capture task sequence to fail.

## Workaround

To work around this problem, edit the following files:  

- %DeployRoot%\Scripts\LTIApply.wsf

    > [!NOTE]
    > %DeployRoot% is the path that you specified when the deployment share was created.

- C:\Program files\Microsoft Deployment Toolkit\Templates\Distribution\Scripts\LTIApply.wsf  

Locate the "Copy bootmgr" section in LTIApply.wsf, and then add the following code above the existing code under the "Copy bootmgr" section:

```vbscript
If not oFSO.FolderExists(sBootDrive & "\Boot") then
 oFSO.CreateFolder(sBootDrive & "\Boot")
End if
```

## More information

This issue doesn't occur if you capture a Windows image that was originally deployed by using MDT 2012 Update 1. This is because when Windows is deployed by using MDT, a System Reserved partition is created that has a size of 499 megabytes (MB). There is enough free space in the System Reserved partition to apply the WinPE image that is required for the capture.

If the Windows image that you are trying to capture with the Sysprep and Capture task sequence was originally deployed from a Windows media, the System Reserved partition that is created has a size of 350 MB. And because it already contains the WinRE image, it does not have enough free space for MDT to apply the WinPE image. In this case, the LTIApply script automatically selects the System Partition to apply the WinPE image. As part of this process, the LTIApply script changes ownership on the bootmgr file and the boot folder on the System Partition. The problem occurs because the LTIApply script doesn't check for the existence of the boot folder on the System Partition before it runs the `takeown.exe` command to change ownership.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
