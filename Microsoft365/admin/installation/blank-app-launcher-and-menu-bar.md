---
title: Microsoft 365 app launcher and menu bar icons are blank
description: Describes a scenario in which icons are missing from the tiles in the Microsoft 365 app launcher and from the menu bar in Outlook on the web.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 app launcher and menu bar icons are blank

## Problem

In Microsoft 365, a user experiences the following symptoms:

- Icons are missing from the tiles in the Microsoft 365 app launcher.    
- In Outlook on the web, the icons in the upper-right area of the page are missing. For example, the **Help** and **Settings** icon are missing.    

## Cause

This issue occurs if the Untrusted Font Blocking feature is enabled on the computer as part of either a domain Group Policy setting or a local policy. Microsoft 365 icons are glyphs that are saved in a Microsoft 365-designated font. When the policy setting is enabled, glyphs from the font aren't visible.

## Solution

Turn off the Untrusted Font Blocking feature. For more information about how to do this, see [Windows 10 Technical Preview adds a feature that blocks untrusted fonts](https://support.microsoft.com/help/3053676).

## More information

For more information, see [Block untrusted fonts in an enterprise](/windows/security/threat-protection/block-untrusted-fonts-in-enterprise).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).