---
title: Errors when you access documents in Microsoft Offices Online 2013 or Office Online Server from SharePoint web applications where Forms-Based Authentication is enabled
description: Fixes an issue that occurs when you preview, view, or edit documents in Microsoft Offices Online 2013 or Office Online Server from SharePoint web applications where Forms-Based Authentication (FBA) is enabled.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: thempel
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 06/06/2024
---

# Errors when you access documents in Office Online Server

This article was written by [Taylor Hempel](https://social.technet.microsoft.com/profile/Taylor+H+-+MSFT), Premier Field Engineer.

## Symptoms

When you preview, view, or edit documents in Microsoft Offices Online 2013 or Office Online Server from SharePoint web applications where **Forms-Based Authentication (FBA)** is enabled, you receive various error messages.

## Cause

By default, Microsoft Offices Online 2013 and Office Online Server connect back to the default zone of any given web application.

If you have **Forms-Based Authentication** configured for the extended zone, but not for the default zone, the **Security Token Service(STS)** in SharePoint won't validate the Access Token that's presented by Microsoft Offices Online or Office Online Server to access document contents.

## Resolution

To fix these errors, configure **Forms-Based Authentication** for the default zone of any web application where Microsoft Offices Online 2013 or Office Online Server is being used in the farm.
