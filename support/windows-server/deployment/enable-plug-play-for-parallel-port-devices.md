---
title: Enable Plug and Play for parallel port devices
description: Describes how to enable the Plug and Play feature on devices that use a parallel port device.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, IMRANU
ms.custom: sap:devices-and-drivers, csstroubleshoot
ms.subservice: deployment
---
# Enable Plug and Play detection for parallel port devices

This step-by-step article describes how to enable the Plug and Play feature on devices that use a parallel port device.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 254664

## Summary

Some Plug and Play devices that use a parallel port, such as early versions of Iomega Zip drives, may not be detected by Windows.

## Enable Plug and Play detection

1. Right-click the My Computer icon on your desktop, and then click **Properties**.
2. Click the **Hardware** tab, and then click **Device Manager**.
3. Click to expand **Ports**, right-click **Printer Port (LPT1)**, and then click **Properties**.

    > [!NOTE]
    > If have more than one printer port installed on your computer, click LPT2 or LPT3.

4. Click the **Port Settings** tab, click **Enable legacy Plug and Play detection**, and then click **OK**.
5. Restart your computer when you are prompted to do so.

After you restart your computer, Windows detects your Plug and Play hardware and the New Hardware Installation Wizard starts if the hardware is connected to the computer.

> [!NOTE]
> The Legacy Plug and Play detection check box is not selected by default.

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.  

> [!NOTE]
> When Service Pack 2 for Windows Server 2003 is released, some more Parallel Port devices will require that you enable of Plug and Play detection before you can install them successfully. Specifically, you will have to enable Plug and Play detection before you install any Iomega Zip drives.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
