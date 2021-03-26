---
title: Error when BIOS is in legacy mode with TPM 2.0
description: Describes an issue that triggers an error (TPM is ready for use, with reduced functionality) when the BIOS is in legacy mode with TPM 2.0.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Bitlocker
ms.technology: windows-client-security
---
# "TPM is ready for use, with reduced functionality" message when the BIOS is in legacy mode with TPM 2.0

This article helps fix an error that occurs when you have the operating system installed in Legacy MBR mode (PC/AT) with Trusted Platform Module (TPM) version 2.0.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3123365

## Symptoms  

On a Windows Server-based operating system, you have the operating system installed in Legacy MBR mode (PC/AT) with Trusted Platform Module (TPM) version 2.0. In this situation, you receive a message in the TPM user interface stating that "The TPM is ready for use, with reduced functionality."

## Resolution

On the operating systems that are listed in the Applies To section, TPM 2.0 is supported in UEFI mode only.

## More information

TPM 2.0 is designed to be fully functional in UEFI mode. Systems must be in UEFI mode with TPM enabled and secure boot configured and enabled in order to attain the security status that's described in the following TechNet article:

[Secure the Windows 8.1 boot process](https://technet.microsoft.com/windows/dn168167.aspx)  

For more information about secure boot and TPM, see the following resources:

[Windows hardware certification requirements for Client and Server systems](https://msdn.microsoft.com/library/windows/hardware/jj128256)

[UEFI implications for Windows Server (pdf)](https://members.uefi.org/learning_center/UEFI_PlugFest_UEFI_implications_for_Windows_Server_Microsoft_March_2013.pdf)  

[Trusted computing group](https://www.trustedcomputinggroup.org/)  

Third-party information disclaimer  
Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
