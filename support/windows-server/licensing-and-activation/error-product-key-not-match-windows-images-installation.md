---
title: Error The product key entered does not match any of the Windows images during Windows installation
description: Describes an issue where you receive an error message during the installation of Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Windows installation fails with error: The product key entered does not match any of the Windows images available for installation. Enter a different product key

This article describes the **The product key entered does not match any of the Windows images available for installation. Enter a different product key** error that occurs when you install Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2796988

## Symptoms

During the installation of Windows, the setup may fail after prompting for language and keyboard selections. Additionally, you may receive the following error message:
> The product key entered does not match any of the Windows images available for installation. Enter a different product key.

## Cause

This problem can occur if the supplied product key doesn't match the media that is being used to install Windows. The supplied product key may be in an unattended file, in the EI.CFG file, in the PID.txt file, or in the firmware of the BIOS. Windows computers that come with the operating system installed ship with the product key in the firmware, and if that product key doesn't match the media, you'll see the error message above.

For example: Installing Windows Server on a computer than came from the manufacturer with Windows 10 installed is likely to cause this problem.

## Resolution

To resolve this problem, use one of the following methods that applies to the scenario:

1. If there's an Unattend file, Edition Configuration (EI.cfg) file or the Product ID (PID.txt) file on the system, change the product key to the correct one for the media you're trying to install.
2. If the system has a Product key in the Motherboard (O. A. 3.0 [OEM Activation] supplies an OEM product key in the firmware) you should use an Unattend file, Edition Configuration (EI.cfg) file or the Product ID (PID.txt) file.

## More information

When installing Windows, setup.exe uses the following priority logic for product keys:

1. Answer file (Unattended file, EI.cfg, or PID.txt)
2. OA 3.0 product key in the BIOS/Firmware
3. Product key entry screen

If a key is supplied, the key is attempted to be use with the image that is available on the media being installed. If the supplied product key doesn't match step 1 from above logic, an image in the WIM file, then the setup will fail with the error message mentioned in Symptoms section. If there's no product key supplied in the step 1 and step 2, you'll get the product key prompt during setup.

> [!NOTE]
>
> - Volume License media supplies a product key with the media so it succeeds with step 1 logic.
> - You should not see this issue with Volume License media unless you are using an Unattend file or have modified files on the media to change or replace the EI.cfg or PID.txt.
> - How to drop a PID.txt with the product key specified: [Windows Setup Edition Configuration and Product ID Files (EI.cfg and PID.txt)](https://technet.microsoft.com/library/hh824952.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
