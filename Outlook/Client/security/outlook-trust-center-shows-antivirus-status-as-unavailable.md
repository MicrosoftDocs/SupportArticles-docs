---
title: Outlook Trust Center shows antivirus status as unavailable
description: Windows Security Center is not supported on server operating system versions. For this reason Outlook is unable to check antivirus status when installed on Server 2012 R2.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Antivirus status shown as Unavailable (This version of Windows does not support antivirus detection)

_Original KB number:_ &nbsp; 3190315

## Symptoms

You have a program running that sends out automated emails in Microsoft Outlook. When doing so, you are receiving the following error:

> A program is trying to send an e-mail message on your behalf. If this is unexpected, click Deny and verify your antivirus software is up-to-date.

The Outlook Trust Center Programmatic Access option shows your antivirus status as:

> Unavailable. This version of Windows does not support antivirus detection.

## Cause

Windows Security Center is not supported on server operating system versions. For this reason Outlook is unable to check antivirus status when installed on a Windows Server.

## More information

Outlook depends upon the Windows Security Center (WSC) on the operating system to detect the status of the antivirus software on the machine. Since the antivirus status isn't listed within the WSC on Windows Server Operating Systems, it is unable to obtain this information that results in the message we are seeing within Outlook. You can confirm this if you log into the Windows Server console. In the Action Center, you will not see any antivirus information.

[Windows Security Center](/windows/win32/devnotes/windows-security-center)
