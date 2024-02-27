---
title: Office add-ins not shown correctly
description: Some fields in custom add-ins cannot be correctly displayed because the add-in requires Internet Explorer 11 and Outlook version 1809 (build 10827.20181) enforces Internet Explorer 10.
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
  - Outlook
  - Outlook Development
search.appverid: MET150
ms.date: 01/30/2024
---
# Office add-ins are not displayed correctly in Outlook

_Original KB number:_ &nbsp; 4482725

## Symptoms

After you update Microsoft Outlook to version 1809 (build 10827.20181) or later versions, data from some Office add-ins may not be displayed correctly or may be missing from the user interface of the add-in within Outlook.

## Cause

This problem occurs because a change was made to Outlook version 1809 to enforce Internet Explorer 10 browser emulation.

> [!NOTE]
> When Outlook displays Office add-in content, it uses component parts of Internet Explorer to show information. Starting in Outlook version 1809 (build 10827.20181), this change improves the rendering of the Outlook Today feature. This improvement also changes the emulated browser behavior to match that of Internet Explorer 10. In this situation, this issue may occur if the add-in requires Internet Explorer 11, or if the value of the `FEATURE_BROWSER_EMULATION` registry key is set to **11000**.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, disable this change in Outlook to revert to the previous browser emulation experience. To do this, set the following registry key:

`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options`  
Value: **BrowserEmulationModeConfig** = dword: **00000003**

> [!NOTE]
> Setting this registry key may affect the rendering of the Outlook Today feature.
