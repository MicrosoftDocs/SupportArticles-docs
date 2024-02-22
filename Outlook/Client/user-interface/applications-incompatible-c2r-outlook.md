---
title: Extensibility support for Outlook 2010
description: Describes an issue in which some applications such as Windows Mobile Device Center don't detect Outlook 2010 as installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz, gregmans, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2010
ms.date: 10/30/2023
---
# Some applications are incompatible with a Click-to-Run installation of Outlook 2010

_Original KB number:_ &nbsp; 981242

## Symptoms

Some applications are incompatible with a Click-to-Run installation of Outlook 2010. For example, Windows Mobile Device Center or Exchange ActiveSync doesn't detect Outlook 2010 as installed.

## More information

For more information about extensibility support matrix for the Outlook platform on Click-to-Run, see the following table.

|Extensibility feature|Click-to-Run on a 32-bit version of operating system without Outlook installed|Click-to-Run on a 32-bit version of operating system with Microsoft Office Outlook 2007 or earlier versions installed|Click-to-Run on a 32-bit version of operating system with Outlook 2010 installed|Click-to-Run on a 64-bit version of operating system without Outlook installed|Click-to-Run on a 64-bit version of operating system with 32-bit version of Outlook installed|Click-to-Run on a 64-bit version of operating system with 64-bit version of Outlook installed|
|---|---|---|---|---|---|---|
|Outlook add-ins that use Outlook Object Model (OM)|Supported|Supported|Supported|Supported|Supported|Add-ins should work, with the understanding that older add-ins might break because of deprecation of command bars in Outlook 2010, not load or install because of setup issues, or other compatibility issues.|
|External applications that use Outlook OM only|Not supported|Not supported|Not supported|Not supported|Not supported|Not supported|
|Outlook add-ins that use Outlook OM and extended MAPI|Not supported|Not supported|Not supported|Not supported|Not supported|Not supported|
|External applications that use simple MAPI MAPISendMail|Supported|Supported|Supported|Supported|Supported|Not supported|
|External applications that use simple MAPI calls other than MAPISendMail|Not supported|Not supported|Not supported|Not supported|Not supported|Not supported|
|External applications that use extended MAPI|Not supported|Not supported|Not supported|Not supported|Not supported|Not supported|
|Mailto protocol handler|Supported|Supported|Supported|Supported|Supported|Supported|
