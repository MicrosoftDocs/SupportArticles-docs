---
title: Unattended Setup doesn't Use Computer Name Specified by User during OOBE to Join the Domain
description: Provides a resolution for the issue that unattended setup doesn't use Computer Name Specified by User during OOBE to Join the Domain
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Unattended Setup doesn't Use Computer Name Specified by User during OOBE to Join the Domain

This article provides a resolution for the issue that unattended setup doesn't use Computer Name Specified by User during OOBE to Join the Domain.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 944353

## Rapid publishing

Rapid publishing articles provide information directly from within the microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.

## Result

After you deploy a Windows Vista image or Windows Server 2008 image, you may encounter the following issues:

- When logging into the computer, you receive the following error message "The trust relationship between this workstation and the primary domain failed."
- The computer account in Active Directory is a random computer name instead of the computer name specified during OOBE when the image booted up for the first time.

## Cause

This behavior is by design. Domain joining occurs much earlier in the process than the Computer Name page in OOBE. The OOBE phase of setup can't correctly change the computer name in the domain if the computer has already been joined to a domain during installation.

## Resolution

A workaround is as follows:

1. Don't use the Microsoft-Windows-UnattendedJoin section to auto join the domain.

2. Use the Microsoft-Windows-Shell-Setup\FirstLogonCommands section to automatically run a script post setup. This script is to join the computer to the domain and reboot.

## More information

This issue is resolved in Windows 7 since a random computer name is used and users are no longer prompted to enter the computer name during the OOBE phase.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

## Disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.
