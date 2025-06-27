---
title: OneDrive for Business can't sync after tenant migration
description: Provides fix for issues syncing after tenant migration
author: helenclu
ms.author: luche
ms.reviewer: ericspli
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 163353
search.appverid: 
  - MET150
appliesto: 
  - OneDrive for Business
ms.date: 12/17/2023
---

# OneDrive for Business can't sync after tenant migration

After a tenant-to-tenant migration, a User Principal Name (UPN) change, or a password update, OneDrive for Business might be unable to sync.

To resolve this issue, clear the cached credentials for OneDrive for Business using the following steps:

1. Sign out of OneDrive for Business.
1. Remove the following folders:
    - `%localappdata%/Microsoft/OneAuth`
    - `%localappdata%/Microsoft/IdentityCache`

1. Sign in to OneDrive for Business.
