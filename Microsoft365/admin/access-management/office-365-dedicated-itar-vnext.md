---
title: Full Access permissions don't work
description: Describes an issue in which Full Access permissions are not working after a migration to Office 365 dedicated/ITAR (vNext). Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: Office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Business Productivity Online Dedicated
- Microsoft Business Productivity Online Suite Federal
---

# Full Access permissions are not working after a migration to Office 365 dedicated/ITAR (vNext)

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

After a migration to Microsoft Office 365 dedicated/ITAR (vNext), the Full Access permissions are not working. 

## Cause

Full Access permissions should be successfully migrated. However, if a provisioning readiness step isn't completed, the permissions no longer work. 

## Resolution

To make sure that the migration does not have any negative effects, section **3.3.8.1 Translate On-Premises SIDs** of the [Exchange vNext Topology and General Guidelines](https://sharepoint.partners.extranet.microsoft.com/sites/MMS%20Knowledge%20Base/Release%20Docs/Convergence/Content/EXO/EXO-D%20vNext%20Topology%20Upgrade%20Customer%20Environment%20Configuration%20Sample.docx) document should be completed. This section states as follows: 

*The Dedicated service, via Active Directory Trusts, has allowed customers to set permissions on cloud objects using on-premises security identifiers (SIDs). This is a practice that does not work for vNext as there will no longer be AD trusts to the on-premises directory. To ensure that permissions to shared mailboxes are not lost during migration, you must ensure that all permissions are set using cloud objects.*

- *To facilitate this, the Microsoft team will provide a report of all on-premises SIDs being used to permission cloud mailboxes.*    
- *Make sure that all these objects are in scope of MMSSPP synchronization.*    
- *Once all the objects have been synchronized to the Dedicated directory, the Microsoft team will translate the permissions to the cloud objects so that permissions persist during migration to vNext.*
