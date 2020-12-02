---
title: 200 OK message not received by SBC
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: 11/5/2020
audience: Admin
ms.topic: article
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 124780
- CSSTroubleshoot 
ms.reviewer: mikebis
description: Resolution to an issue where the SBC didn't receive the 200 OK message from SIP proxy. 
---

# SBC didn't receive "200 OK" message

## Summary

SBC didn't receive the expected "200 OK" from MS Teams SIP proxy.

## Cause

Assuming that there are no issues that affect the TLS connection, the FQDN that's provided by SBC either in the **Record-Route** header (if it exists) or the **Contact** header may not be recognized as belonging to the tenant. 


## Resolution

This situation can occur for one of several reasons. To resolve this issue, you have to narrow it down. The most common situations to investigate include the following:

- The FQDN that’s provided by SBC differs from what was configured in Microsoft system.
- The domain was not yet [fully validated](https://docs.microsoft.com/microsoft-365/admin/setup/add-domain).
- A user with a valid license (E3 or E5) was not [assigned to the SBC domain](https://docs.microsoft.com/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
- The Contact header contains an IP address instead of the expected FQDN.


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).