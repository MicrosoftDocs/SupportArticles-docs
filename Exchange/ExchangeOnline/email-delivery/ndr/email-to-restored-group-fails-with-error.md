---
title: Email message sent to a restored Microsoft 365 group generates an NDR 
description: The article describes an issue in which email messages sent to a restored Microsoft 365 Group are rejected.
ms.date: 07/27/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: batre
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: 033fcaaf-7916-47ae-b2cd-2a63456bb812
---

# Email message sent to a restored Microsoft 365 group generates an NDR

## Summary

This article describes an issue in which email messages that you send to a recently restored Microsoft 365 group aren't delivered. Instead you receive the `RESOLVER.ADR.RecipientNotFound` error.

## Symptoms

After you restore a deleted Microsoft 365 group, email messages that you send to the group shortly after the restore operation completes aren't delivered. Senders receive a non-delivery report (NDR) that includes information that's similar to the following message:

> Your message to TestGroup@contoso.com couldn't be delivered.
> TestGroup wasn't found at contoso.com.
> Error:	550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient TestGroup@contoso.com not found by SMTP address lookup.

## Cause

This issue occurs because either the restored Microsoft 365 group is still initializing or directory replication isn't complete.

## Resolution

Wait at least one hour after restoring the Microsoft 365 group, and then send the message again.
