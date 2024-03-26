---
title: SharePoint customizations revert to the original settings
description: SharePoint customizations to the Microsoft 365 top navigation revert to the default settings.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:App Bar and Navigation\Other
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
  - Microsoft 365
ms.date: 12/17/2023
---

# Customizations to the Microsoft 365 top navigation bar in SharePoint Online revert to the original settings

## Problem

Consider the following scenario.

- You make customizations to the Microsoft 365 top navigation bar in SharePoint Online by changing any .css class that begins with the following:
  
  **.0365cs-**

- You discover that these changes have reverted to the default settings.

## Solution

To work around this issue, use SharePoint themes or Microsoft 365 themes.

For more information about themes in SharePoint Online, go to [SharePoint Site Theme](/sharepoint/dev/declarative-customization/site-theming/sharepoint-site-theming-overview).

For more information about Microsoft 365 themes, go to [Personalize your Microsoft 365 experience by selecting themes](https://support.office.com/article/customizations-to-the-office-365-top-navigation-bar-in-sharepoint-online-revert-to-the-original-settings-ed6b3aca-d2f7-4350-b152-023000945f9d?ui=en-US&rs=en-US&ad=US).

## More information

This issue occurs because overriding .css classes that begin with ".0365cs-" isn't supported. These classes are frequently updated across the Microsoft 365 service as new functionality is deployed. When this kind of updating occurs, changes may be overwritten.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
