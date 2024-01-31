---
title: KMS current count doesn't increase
description: Describes a problem where the number of clients in a Key Management Server (KMS) computer does not increase when you add new Windows Vista-based client computers to the network.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:activation, csstroubleshoot
ms.subservice: deployment
---
# The KMS current count does not increase when you add new Windows Vista or Windows 7-based client computers to the network

This article provides help to fix a problem where the number of clients in a Key Management Server (KMS) computer doesn't increase when you add new Windows Vista-based client computers to the network.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 929829

## Symptoms

When you run the Slmgr.vbs script on a Key Management Server (KMS) computer, you verify that the number of client computers does not increase when you add new Windows-based client computers to the network. Additionally, you may see the following event in the Key Management Service event log for each new Windows-based client computer that you add to the network.
  
When you run the Slmgr.vbs script together with the `-dli` argument, the client computer count information does not increase as expected. In the following event that is logged in the Key Management Service event log, the current count remains the same.

## Cause

This issue can occur when Windows-based client computers that you add to the network have identical KMS client machine IDs (CMIDs). The current count number increases on a KMS computer when the client computers have different CMIDs. Two or more computers can have the same CMIDs in the either of the following scenarios:  

- The custom Windows image that you use to install the client computer is generated even though you do not run the System Preparation tool (Sysprep.exe) together with the /generalize option.
- The custom Windows image is generated together with the /generalize option. However, you specify the \<SkipRearm> setting in the Unattended.xml file.  

To verify that client computers have identical CMIDs, follow these steps:

1. On one of the Windows-based client computers, click **Start**, point to **Programs**, point to
 **Accessories**, right-click **Command Prompt** and then click **Run as Administrator**.
If you are prompted for an administrator password or for a confirmation, type the password, or click **Allow**.
2. At the command prompt, type the following command, and then press ENTER: `cscript c:\windows\system32\slmgr.vbs -dli`  

3. Examine the following results, and note the CMID.

4. Repeat steps 1 through 4 on a second Windows-based client computer. Verify that the CMID of the second client computer is identical to the CMID of first computer.  

## Resolution

We recommend that you rebuild the base image that is used to deploy the affected computers as soon as you determine whether they have identical CMIDs.

## Workaround

The workaround is valid only if the /generalize  option was used in the image that was used to install Windows-based clients. This option is required when you deploy multiple images. To determine whether the /generalize option was used in the image, follow these steps:

1. On one of the affected computers, click **Start**, and then type
 C:\Windows\System32\sysprep\Panther\setupact.log.
2. Examine the "SYSPRP ParseCommands: Found" lines as shown in the following sample log file:

    > Info [0x0f004e] SYSPRP Initialized SysPrep log at C:\Windows\System32\sysprep\Panther
    >
    > Info [0x0f0054] SYSPRP ValidateUser:User has required privileges to sysprep machine  
    Info [0x0f0056] SYSPRP ValidateVersion:OS version is okay  
    Info [0x0f005c] SYSPRP ScreenSaver:Successfully disabled screen saver for sysprep  
    Info [0x0f007e] SYSPRP FCreateTagFile:Tag file C:\Windows\System32\sysprep\Sysprep_succeeded.tag does not already exist, no need to delete anything  
    Info [0x0f005f] SYSPRP ParseCommands:Found supported command line option 'UNATTEND'  
    Info [0x0f005f] SYSPRP ParseCommands:Found supported command line option 'OOBE'  
    Info [0x0f005f] SYSPRP ParseCommands:Found supported command line option 'SHUTDOWN'  
    Info [0x0f005f] SYSPRP ParseCommands:Found supported command line option 'GENERALIZE'

3. If the /generalize option is present, confirm that this option was used on the computer that created the base image.

4. If the /generalize option was used and you have computers that have identical CMIDs, follow these steps to rearm the affected computers and rebuild the base image. Make sure that you do not use the \<SkipRearm> setting is not used:

   1. On one of the Windows-base client computers, click **Start**, point to **Programs**, point to **Accessories**, right-click **Command Prompt**, and then click **Run as Administrator**.  

        If you are prompted for an administrator password or for confirmation, type the password, or click **Allow**.
   2. At the command prompt, type the following command, and then press ENTER: `cscript c:\windows\system32\slmgr.vbs -rearm`  

   3. Restart the computer.  

If the base image was not generated by using Sysprep with the /generalize  option, you must rebuild the base image, and then reinstall Windows on the clients. If you use an Unattended.xml file when you rebuild the base image, make sure that the \<SkipRearm> setting is not used. For more information about the \<SkipRearm> setting, see the Windows Automated Installation Kit (Windows AIK) documentation.  

## More information

To reset the activation timer and to set a unique CMID, the Rearm process must run on the destination computer. This process is used to reset the activation state. In Windows, the Rearm process can be run by using one of the following two methods:  

- Run Sysprep together with the /generalize  option on the computer that is used to build the Custom Windows image.
- Force the Rearm process to occur by running the Slmgr.vbs script in an elevated Command Prompt window. For example, type: `cscript c:\windows\system32\slmgr.vbs -rearm`  

If the Rearm process did not run because Sysprep was run together with the /generalize option or because you used the \<SkipRearm>1\</SkipRearm> setting in the Unattended.xml file, client computers may have identical CMIDs. Therefore, the computer count information does not increase as expected. The /generalize option is required when you deploy multiple images. The \<SkipRearm> setting should not be used in an unattended file when you deploy computers in a production environment. Therefore, for both cases, we recommend that you rebuild the base image.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
