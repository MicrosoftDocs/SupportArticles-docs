---
title: Dynamics CRM for Outlook records do not synchronize or are missing Track and Set Regarding buttons
description: Microsoft Dynamics CRM for Outlook records do not synchronize or are missing Track and Set Regarding buttons with User Filters disabled. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Microsoft Dynamics CRM for Outlook records do not synchronize or are missing Track and Set Regarding buttons with User Filters disabled

This article provides a resolution for the issue that Microsoft Dynamics CRM for Microsoft Outlook records do not synchronize or are missing Track and Set Regarding buttons with User Synchronization Filters disabled.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3006088

## Symptoms

Microsoft Dynamics CRM for Outlook records do not synchronize or are missing Track and Set Regarding buttons with User Synchronization Filters disabled even though System Synchronization Filters exist and are enabled.

## Cause

Although System Synchronization Filters are enabled for a specific type of record, they will not track without User Synchronization Filters enabled. The System Synchronization Filters currently depend on User Synchronization Filters being enabled before the synchronization criteria is applied.

## Resolution

User Synchronization Filters for the particular record type in question must exist and be enabled.
