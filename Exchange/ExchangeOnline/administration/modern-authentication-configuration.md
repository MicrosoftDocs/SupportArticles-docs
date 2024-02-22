---
title: Modern Authentication configuration requirements for transition
description: Configuration requirements by Outlook version for transition from Microsoft Office 365 dedicated/ITAR to vNext.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
---
# Modern Authentication configuration requirements for transition from Office 365 dedicated/ITAR to vNext

## Summary

This article describes configuration requirements for Modern Authentication after a transition from Microsoft Office 365 dedicated/ITAR to vNext, depending on Outlook version.

## More Information

The configuration requirements vary, depending on the Outlook version. The following table outlines the requirements and includes links to related articles.

| **Outlook version**| **Modern auth support**| **EnableADAL reg key required**| **AlwaysUseMSOAuthForAutodiscover reg key required**| **MAPI/HTTP required** **(remove any blocks currently)**  |
|---|---|---|---|---|
| Outlook 2016| Yes| No| Yes| Yes  |
| Outlook 2013| Yes| Yes| Yes| Yes  |
| Outlook 2010| No| Not available| Not available| Not available  |

> [!IMPORTANT]
> Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Outlook 2010

- Modern Authentication is not supported.
- Users use Basic Authentication and may be prompted multiple times for credentials.

### Outlook 2013

- Modern Authentication is not enabled by default.
- Modern Authentication can be enabled by setting the **DWORD** value to **1** in the following registry subkeys:

  `HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity\EnableADAL`

  `HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity\Version`

  For more information, see [Enable Modern Authentication for Office 2013 on Windows devices](https://support.office.com/article/Enable-Modern-Authentication-for-Office-2013-on-Windows-devices-7dc1c01a-090f-4971-9677-f1b192d6c910).
- It is recommended that users force Outlook to use Modern Authentication by setting the **DWORD** value of the following registry key to **1**.

  HKEY_CURRENT_USER\Software\Microsoft\Exchange\AlwaysUseMSOAuthForAutoDiscover

### Outlook 2016

- Modern Authentication is enabled by default.
- It is recommended that users force Outlook to use Modern Authentication by setting the **DWORD** value of the following registry key to **1**:

  HKEY_CURRENT_USER\Software\Microsoft\Exchange\AlwaysUseMSOAuthForAutoDiscover

  For more information, see [Outlook prompts for password and doesn't use Modern Authentication to connect to Microsoft 365](/outlook/troubleshoot/authentication/outlook-prompt-password-modern-authentication-enabled).
- MAPI/HTTP cannot be disabled. For more information, see [Outlook 2010, 2013, 2016, or Outlook for Microsoft 365 doesn't connect Exchange using MAPI over HTTP as expected](/outlook/troubleshoot/connectivity/outlook-not-connect-exchange-use-mapi-over-http).

### Skype for Business or Lync 2013

- Recommend that users enable Modern Authentication after the Skype migration is completed.
- Recommend that users enable the following registry keys if you use Modern Authentication for Exchange. To do that, set the **DWORD** value to **1**.

  `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Lync\ AllowAdalForNonLyncIndependentOfLync`

  `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Lync\ AllowAdalForNonLyncIndependentOfLync`
