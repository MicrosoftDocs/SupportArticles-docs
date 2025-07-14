---
title: SIP 420 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 420 error, and provides actions to resolve the errors.
ms.date: 11/22/2024
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI2387
  - CSSTroubleshoot
ms.reviewer: mikebis
---

# SIP response code 420

This article provides troubleshooting information for the combination of the SIP 420 error and Microsoft response code 560420.

## 560420 420 Bad Extension

- Microsoft response code: **560420**
- SIP response code: **420**
- Suggested actions:  
  - Check the SBC configuration to make sure that it's configured to support the required headers, such as the **Replaces** header. If necessary, work with your SBC vendor to verify that the SBC is configured correctly to support the required SIP protocol extension.
