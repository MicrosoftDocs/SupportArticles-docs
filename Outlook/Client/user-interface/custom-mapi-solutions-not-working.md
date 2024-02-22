---
title: MAPI custom solutions do not work as expected
description: Your custom MAPI solution may not work because Outlook.exe is not properly registered in the Windows registry.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# MAPI solutions do not work because Outlook.exe is not properly registered under the \App Paths key in the Registry

_Original KB number:_ &nbsp; 2698523

## Symptoms

If you are using a custom MAPI solution (for example, an Outlook add-in), the solution may not work because Outlook.exe is not properly registered in the Windows registry.

> [!NOTE]
> The actual problem you experience with the custom solution depends on how it uses the Outlook.exe registration information.

## Cause

This problem can occur if Outlook.exe is not registered correctly under the following keys in the Windows registry:

- 32-bit versions of Windows

  `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths`

- 64-bit versions of Windows

  `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths`

If Outlook.exe is properly registered, you will find an \Outlook.exe subkey under the above key, and under the \Outlook.exe subkey you will find a string value called Path whose data references the correct path to Outlook.exe on your computer. The following figure shows the correct Outlook.exe registration on a 32-bit version of Windows.

:::image type="content" source="media/custom-mapi-solutions-not-working/outlook-exe-registration.png" alt-text="Screenshot for the Outlook.exe registration." border="false":::

> [!NOTE]
> The path to Outlook.exe on your computer may vary from the above figure if you installed Office in a non-default location.

## Resolution

To resolve this problem, [repair your installation of Office](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
