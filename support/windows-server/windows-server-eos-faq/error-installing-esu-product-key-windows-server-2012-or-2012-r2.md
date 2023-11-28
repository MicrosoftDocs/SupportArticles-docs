---
title: Error when installing ESU product key for Windows Server 2012 R2 or Windows Server 2012
description: Describes how to resolve error messages that might occur when you install ESU product keys for Windows Server 2012 R2 or Windows Server 2012.
ms.date: 11/30/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
ms.technology: windows-server-eos
ms.custom: sap:troubleshoot-issues-in-esu, csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika
keywords: Windows Server 2012 R2 ESU, Windows Server 2012 ESU, ESU, ESU product key
---

# Error when installing ESU product key for Windows Server 2012 R2 or Windows Server 2012

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2012

## Symptoms

To configure your system for End of Service Updates (ESU), you have to install ESU product keys. In the following circumstances, you might see error messages when you install the product keys:

- After you enter the product key, you see the following error message:
  > Error: 0xC004E016 on a computer running microsoft windows non-core edition, run 'slui.exe 0x2a 0xC004E016' to display the error  
- When you use the Volume Activation Management Tool (VAMT) to install an ESU product key, you see the following error message:
  > Unable to verify product key  
  >The specified product key is invalid, or is unsupported by this version of VAMT. An update to support additional products may be available online.
- When you use VAMT to acquire confirmation IDs as part of the [MAK Proxy scenario](/windows/deployment/volume-activation/proxy-activation-vamt), you get an error message that resembles the following:  
  > Successfully acquire confirmation ID's for 0 out of X products. The action was not applicable for 0 products in the file  
  > The results were saved back to : filename.cilx  
  > [!NOTE]  
  > The quantities and the filename are specific to your situation. However, "the action was not applicable" is consistent in this message.

## Cause

Windows doesn't recognize the ESU key.

## Resolution

To resolve these error messages, install and configure the following prerequisites for ESU:

- Licensing Preparation Package.
  - Windows Server 2012 R2: [KB5017220: Update for the Extended Security Updates Licensing Preparation Package for Windows Server 2012 R2](https://support.microsoft.com/help/5017220).  
  - Windows Server 2012: [KB5017221: Update for the Extended Security Updates Licensing Preparation Package for Windows Server 2012](https://support.microsoft.com/help/5017221).
  > [!NOTE]  
  > Check the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com) to make sure that you have the most recent Licensing Preparation Package updates.  

- The VAMT component of [Windows ADK for Windows 10, version 2004](https://go.microsoft.com/fwlink/?linkid=2120254). For more information about this tool, see the following articles:
  - [Download and install the Windows ADK](windows-hardware/get-started/adk-install).
  - [Introduction to VAMT](/windows/deployment/volume-activation/introduction-vamt)

- Update to the VAMT configuration files.
  1. Download [VAMT - Configuration](https://www.microsoft.com/download/details.aspx?id=104503), and then extract the files from the download.
  1. Place the files in the following folder:  

      ```
      C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\VAMT3\pkconfig
      ```

      > [!NOTE]  
      > Overwrite any existing files.
  1. If VAMT is running, close the tool and then restart it.

# More information

For more information about ESU for Windows Server 2012 R2 and Windows Server 2012, see [KB5031043: Procedure to continue receiving security updates after extended support has ended on October 10, 2023 - Microsoft Support](https://support.microsoft.com/topic/kb5031043-procedure-to-continue-receiving-security-updates-after-extended-support-has-ended-on-october-10-2023-c1a20132-e34c-402d-96ca-1e785ed51d45).
