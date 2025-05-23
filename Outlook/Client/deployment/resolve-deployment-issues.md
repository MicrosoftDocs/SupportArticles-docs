---
title: Resolve deployment issues in the new Outlook for Windows
description: Provides instructions to resolve deployment issues when transitioning to the new Outlook for Windows.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.collection:
- administer-new-outlook
ms.custom: 
  - sap:Install, Update, Activate, and Deploy
  - intro-overview
  - CI 5977
  - CSSTroubleshoot
ms.reviewer: janellem
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 05/20/2025
---
# Resolve deployment issues in new Outlook for Windows

As organizations transition to new Outlook, which offers a more agile and consistent experience in Windows, admins and users might encounter issues ranging from toggle visibility in classic Outlook to installation hurdles. This article provides solutions to address these challenges, ensuring a smooth integration of new Outlook into your work environment, whether it's through direct installation, by using various deployment options, or by managing policy settings.

## Toggle in classic Outlook doesn't work

When the toggle in classic Outlook is visible but unresponsive, the reason is likely installation issues that are related to security settings. To resolve this issue, see [Resolve installation issues in new Outlook](../Installation/resolve-installation-issues.md) for detailed information to address security-related installation problems.

## Toggle doesn't display in classic Outlook

One or more of the following reasons might cause the missing toggle in classic Outlook:

- Unsupported Windows version

  - Must be Windows 10, Build 1809 (17763) or higher.

- Unsupported channel

  - Current Channel, Monthly Enterprise Channel, and Semi-Annual Enterprise Channel (preview) are supported.

- Unsupported version

  - Nonsubscription versions of Outlook such as Outlook 2021, Outlook 2019, etc. aren't supported.

- Unsupported accounts in classic Outlook profile

  - POP or on-premises Exchange account: These account types could be in the classic Outlook profile.

  - Check account compatibility: If new Outlook launches successfully on a system for another user, have the user who can't access the toggle sign-in on that system to see if the toggle appears.

  - Contact support: When reaching out to Microsoft Support, include the `.etl` files from **%Temp%\Outlook Logging** (accessible via **Start** > **Run** > **%Temp%\Outlook Logging**). These files help us determine why the toggle doesn't show.

## Sovereign networks

For Windows computers that are or were part of a sovereign network, the option of switching to new Outlook isn't available. This restriction is due to the specific network configurations and security protocols inherent to sovereign networks.

## Registry settings for the toggle

The `HideNewOutlookToggle` registry key controls the visibility of the new Outlook toggle in classic Outlook. This key is located under [`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options\General`]. If `HideNewOutlookToggle` is set to `1`, the toggle remains hidden in classic Outlook. Changing this value to `0` and restarting classic Outlook makes the toggle visible.

## Cloud policy

In case a policy is set to disable the toggle in new Outlook:

Check the Global setting in the [Microsoft 365 Apps admin center](https://config.office.com/).

Search for the "Hide the 'Try the new Outlook' toggle in Outlook" policy.

If this policy is enabled, disable it to allow the toggle to appear.
