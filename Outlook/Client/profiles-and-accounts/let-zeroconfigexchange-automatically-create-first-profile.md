---
title: Let ZeroConfigExchange automatically create first profile
description: Make ZeroConfigExchange automate the creation of the first Outlook profile only in case you want to manually create the second and more profiles.
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
search.appverid: MET150
ms.date: 01/30/2024
---
# How to manually create additional Outlook 2016 profiles with ZeroConfigExchange in place

_Original KB number:_ &nbsp; 4046818

## Background information of ZeroConfigExchange

The concept of Reliable Profiles was introduced in Microsoft Outlook 2016. As a result, we don't recommend using Outlook profile (.prf) files to create profiles in Outlook 2016. Instead, we recommend enabling automatic profile creation by using the `ZeroConfigExchange` registry key or the **Automatically configure profile based on Active Directory Primary SMTP address** policy.

## ZeroConfigExchange controls profile creation

`ZeroConfigExchange` works well for the first profile to be automatically created, with no user action. But you may want to create an additional profile that connects to a different Exchange account. You are unable to do that because you can't bypass `ZeroConfigExchange` to manually configure the profile.

This is by-design behavior, as `ZeroConfigExchange` controls the creation of any Outlook profile.

## How to create additional profiles

This method currently only applies to Outlook 2016 Click-to-Run Version 1708 (Build 8431.2079) and later versions. For Outlook 2016 MSI-based versions, the method will apply to the November PU for Outlook 2016 and later versions.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To create additional profiles without the intervention of `ZeroConfigExchange`, add the ZeroConfigExchangeOnce registry subkey. To do this, follow these steps:

1. In Registry Editor, browse to the following registry subkey:

   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\AutoDiscover`

2. Create a DWORD value that has the following name and value:

   **Name**: ZeroConfigExchangeOnce  
   **Value**: 1

## More information

After you add `ZeroConfigExchangeOnce`, `ZeroConfigExchange` still controls the automatic creation of the first profile. After the first profile is automatically created, you can manually create additional profiles that connect to different Exchange accounts.

If `ZeroConfigExchange` and `ZeroConfigExchangeOnce` are both set with a value of "**1**" at the above registry path, note that `ZeroConfigExchange` always takes precedence.
