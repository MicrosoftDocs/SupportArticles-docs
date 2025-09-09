---
title: Security settings for Dynamic Data Exchange in Excel Trust Center
description: Describes two new security options under Security Settings for Dynamic Data Exchange (DDE) in Excel Trust Center.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Security\Trust
  - CSSTroubleshoot
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
ms.date: 05/26/2025
---

# Security settings for Dynamic Data Exchange in Excel Trust Center in Microsoft 365

## Summary

Two new security options are now included in the Excel Trust Center in Microsoft 365 under the **Security Settings for Dynamic Data Exchange** heading:

- Enable Dynamic Data Exchange Server Lookup
- Enable Dynamic Data Exchange Server Launch (not recommended)

These new options are intended to help protect users from attackers who use Dynamic Data Exchange (DDE) to spread malware.

 :::image type="content" source="media/security-settings/options-to-protect-users.png" alt-text="Screenshot shows two options under the Security Settings for Dynamic Data Exchange heading.":::

## More Information

These new options are located in the Excel Trust Center (**File** > **Options** > **Trust Center** > **Trust Center Settings** > **External Content**). They're listed as follows.

- **Enable Dynamic Data Exchange Server Lookup**

   Select this option if you want to enable DDE server lookup. If this option is selected, DDE servers that are already running will be visible and usable. By default, this option is selected.
- **Enable Dynamic Data Exchange Server Launch (not recommended)**

   Select this option if you want to enable DDE server startup. If this option is selected, Excel starts DDE servers that are not already running, and enables data to be sent out of Excel. For security, we recommend that you leave this check box cleared. By default, this option isn't selected.

   For more information about DDE, see [About Dynamic Data Exchange](/windows/desktop/dataxchg/about-dynamic-data-exchange).
