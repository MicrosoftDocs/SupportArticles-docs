---
title: DLP Policy Tip notifications are not displayed in Outlook for Windows
description: This article describes an issue in which Outlook for Windows can't display DLP Policy Tip notification messages. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - Outlook for Windows
  - CI 106436
  - CSSTroubleshoot
ms.reviewer: aruiz, EXOL_Triage
appliesto: 
  - Outlook 2019
  - Outlook 2016
ms.date: 01/30/2024
---

# DLP Policy Tip notifications are not displayed in Outlook for Windows

## Symptoms

After you configure some data loss prevention (DLP) policies that include Policy Tip notification messages, you notice that the Outlook for Windows clients don't display the notification messages or that they display the wrong messages. However, Outlook on the Web (OWA) displays the expected notification messages.

## Cause

This issue occurs because the compatible version criteria that's processed by the policy evaluator is based on the version of *mso20win32client.dll*, not the version of Outlook. In many cases, the version of *mso20win32client.dll* is not the same as the version of Outlook and Office.

For example, an administrator may configure a very restrictive policy that applies only to version 16.0.11727.20244 or a later version of Outlook. However, the policy evaluator uses version 16.0.11727.20222 of *mso20win32client.dll* and determines that the rule should not be applied. In this example, the rule would have to indicate the minimum required version of 16.0.11727.20222 to have the policy tip appear in Outlook.

## Resolution

To make sure that Outlook applies all expected DLP policies, the administrator must verify that the Policy Nudge Rule for **minRequiredVersion** has a value that's not greater than the client-installed version of *mso20win32client.dll*. The *mso20win32client.dll* file could be located in either of the following folders:

- C:\Program Files (x86)\Microsoft Office\root\vfs\ProgramFilesCommonX86\Microsoft Shared\OFFICE16
- C:\Program Files (x86)\Common Files\Microsoft Shared\Office16

## More information

In similar cases, the Outlook client can be forced to update the local policies and definition files. To do this, delete the following registry value from the "Policy Nudges" section of the indicated registry subkey:

Subkey: **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook\PolicyNudges**

Value: **LastDownloadTimesPerAccount**

> [!NOTE]
> - This troubleshooting step doesn't fix the problem that is caused by the condition that's described in the **Cause** section.
> - OWA isn't affected by the problem that's caused by the condition that's described in the **Cause** section.

## Related article

[Outlook DLP policy tips not working for certain conditions in email body and attachments](https://support.microsoft.com/office/outlook-dlp-policy-tips-not-working-for-certain-conditions-in-email-body-and-attachments-8a32496a-3478-403c-b2eb-04a218f7443c)
