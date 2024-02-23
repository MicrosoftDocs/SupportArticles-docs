---
title: Inconsistent search results when email body contains both English and non-English characters in Exchange Server 2013
description: Describes an issue that affects search functionality in OWA in an Exchange Server 2013 environment. Occurs when the email message contains both English and Chinese-Japanese-Korean (CJK) languages.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
- Exchange Server 2013 Enterprise 
- Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.reviewer: dennym, erlendp, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# Inconsistent search results when email body contains both English and non-English characters in Exchange Server 2013

## Symptoms

In a Microsoft Exchange Server 2013 environment, search functionality in Outlook Web App fails when you search non-English words in an email message whose body contains both non-English characters (such as Chinese or Japanese) and English characters.

## Cause

When both Chinese-Japanese-Korean (CJK) and non-CJK languages are detected by Outlook Web App search, the first one is used instead of the CJK language. This may cause incorrect search results.

## Resolution

To fix this issue, install [Cumulative Update 15](https://support.microsoft.com/en-us/topic/cumulative-update-15-for-exchange-server-2013-eda84bd3-c207-d9fe-25dd-5cf0d406c699) for Exchange Server 2013 or a later [cumulative update for Exchange Server 2013](/exchange/updates-for-exchange-2013-exchange-2013-help).

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](/troubleshoot/windows-client/deployment/standard-terminology-software-updates) that Microsoft uses to describe software updates.
