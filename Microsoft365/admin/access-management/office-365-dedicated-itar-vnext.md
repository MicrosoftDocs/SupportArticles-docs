---
title: Full Access permissions don't work
description: Describes an issue in which Full Access permissions don't work after a migration to Office 365 dedicated/ITAR (vNext). Provides a resolution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
ms.date: 03/31/2022
---

# Full Access permissions aren't working after a migration to Office 365 dedicated/ITAR (vNext)

## Symptoms

After a migration to Microsoft Office 365 dedicated/ITAR (vNext), the Full Access permissions aren't working.

## Cause

Full Access permissions should be successfully migrated. However, if a provisioning readiness step isn't completed, the permissions no longer work. 

## Resolution

To make sure that the migration doesn't have any negative effects, see the following information:

*The Dedicated service, via Active Directory Trusts, has allowed customers to set permissions on cloud objects using on-premises security identifiers (SIDs). This is a practice that does not work for vNext as there will no longer be AD trusts to the on-premises directory. To ensure that permissions to shared mailboxes are not lost during migration, you must ensure that all permissions are set using cloud objects.*

- *To facilitate this, the Microsoft team will provide a report of all on-premises SIDs being used to permission cloud mailboxes.*
- *Make sure that all these objects are in scope of MMSSPP synchronization.*
- *Once all the objects have been synchronized to the Dedicated directory, the Microsoft team will translate the permissions to the cloud objects so that permissions persist during migration to vNext.*
