---
title: Teams doesn't start with Dell Encryption
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Security and Compliance (Retention, etc)\
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Describes a workaround for starting Teams when using Dell Encryption.
---

# Dell Encryption prevents Teams from starting correctly 

## Problem

Dell Encryption (formerly Dell Data Protection Encryption) is known to corrupt Teams installations during the update process, leading to a permanent failure to start the application. 

## Solution

Exclude the Teams folder %LocalAppData%\Microsoft\Teams from the encryption policy.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
