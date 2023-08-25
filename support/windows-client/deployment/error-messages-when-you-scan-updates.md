---
title: Error messages when you scan for updates
description: Describes the download behavior of Windows Update Web site and the error messages that can occur.
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
# "Error: 0x8004005" or "Error: 0x800C0005" error messages when you scan for updates

This article provides a solution to error messages when you scan for updates.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 843499

## Symptoms

When you visit the Windows Update Web site and then select **Scan for updates**, the result of the scan is zero percent. Additionally, you may receive one of the following error messages:
> Error: 0x800C0005

> Error: 0x8004005

## Cause

This behavior may occur if certain dynamic-link library files (.dll files) aren't registered correctly or if there's a firewall between the computer and the Internet that doesn't allow HTTPS (SSL) connections.

## Resolution

To resolve this behavior, use the `regsvr32` command to register several .dll files:

1. Select **Start**, select **Run**, type cmd in the **Open** box, and then select **OK.**  
2. At the command prompt, type the following commands. Press **ENTER** after each line:

    ```console
    regsvr32 Softpub.dll
    regsvr32 Wintrust.dll
    regsvr32 Initpki.dll
    ```

3. Select **OK**.
4. Restart your computer.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
