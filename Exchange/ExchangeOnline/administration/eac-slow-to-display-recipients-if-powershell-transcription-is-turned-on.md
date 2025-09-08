---
title: EAC slowly shows recipient if PowerShell Transcription is on
description: Describes an issue in which Exchange admin center is slow to display recipients if PowerShell Transcription is turned on. Provides one possible resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: akashb, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# EAC is slow to display recipients if PowerShell Transcription is turned on

_Original KB number:_ &nbsp; 4505746

## Symptoms

In Exchange admin center (EAC), it may take several minutes to display the **Recipients** list if it contains lots of mailboxes or groups.

## Cause

The issue is caused by a latency that occurs when PowerShell Transcription runs. When PowerShell Transcription logs a cmdlet that was run, it sends the command output to a text file on the file system. The latency is caused by the I/O that is required to complete these steps, and is more noticeable when the number of mailboxes or groups is large.

## Resolution

To fix this issue, you can disable PowerShell Transcription. To do this, follow these steps:

1. Open a Command Prompt window or PowerShell, and then type *gpedit.msc* to open the Local Group Policy Editor.
2. Navigate to **Computer Configuration**, and select **Administrative Templates**.
3. Select **Windows Components**, then select **Windows PowerShell**.
4. Double-click **Turn on PowerShell Transcription**, select **Disable**, then select **OK**.

   :::image type="content" source="media/eac-slow-to-display-recipients-if-powershell-transcription-is-turned-on/disable-powershell-transcription.png" alt-text="Screenshot of selecting Disabled for Turn on PowerShell Transcription window.":::

5. At a command prompt, run `gpupdate /force` to make sure that your settings are applied.

## More information

If PowerShell Transcription is enabled and command logging is visible in EAC, you see `Out-Default -Transcript:$true -OutVariable $null` after every cmdlet that EAC calls.

There might be other reasons for the slow performance that you would have to investigate if this solution does not resolve the issue.
