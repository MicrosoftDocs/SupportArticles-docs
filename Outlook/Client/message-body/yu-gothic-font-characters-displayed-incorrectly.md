---
title: Yu Gothic font characters are displayed incorrectly
description: Fixes an issue in which Yu Gothic font characters can't be read in HTML or rich text mails in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: abji
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2013
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Yu Gothic font characters are displayed incorrectly in Outlook

_Original KB number:_ &nbsp; 4013913

## Symptom

When you open HTML or rich text email in Microsoft Outlook 2013, 2010, or 2007 on a Windows 7 or Windows 8.0 based computer, Yu Gothic font multibyte characters are not displayed correctly and are unreadable.

## Cause

Outlook uses the font API of Windows to display email text that has font settings. This issue occurs if the Yu Gothic font isn't installed on the computer.

## Resolution

To fix this issue, [download and install the Yu Gothic font](https://www.microsoft.com/download/details.aspx?id=49114). After you install the font, the font file (**Yu Gothic** or **游ゴシック**) will appear under the default path of the font library (<*SystemDrive*>:\Windows\fonts).

> [!NOTE]
> Yu Gothic is a new font that's included in Microsoft Office 2016. It's also included in Windows 8.1 and later versions of Windows.
