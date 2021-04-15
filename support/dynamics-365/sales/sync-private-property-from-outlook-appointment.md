---
title: Sync the private property from Outlook appointments
description: This article describes Microsoft Dynamics CRM 2011 with Update Rollup 12 adds the functionality to synchronize the private property from Office Outlook appointments into Microsoft Dynamics CRM 2011.
ms.reviewer: 
ms.topic: article
ms.date: 3/31/2021
---
# Sync the private property from Outlook appointments to Microsoft Dynamics CRM 2011 with Update Rollup 12

This article describes Microsoft Dynamics CRM 2011 with Update Rollup 12 adds the functionality to synchronize the private property from Office Outlook appointments into Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2820835

Microsoft Dynamics CRM 2011 with Update Rollup 12 adds the functionality to synchronize the private property from Office Outlook appointments into Microsoft Dynamics CRM 2011.

In the Microsoft Dynamics CRM database, an ismapiprivate column to the activitypointer table to support the ismapiprivate functionality.

On the Microsoft Dynamics CRM for Outlook client side, a registry key must be used to determine if the private flag of an appointment (appointment, recurring appointment, service appointment) should be synced up to the corresponding Microsoft Dynamics CRM activity.

To enable this functionality:

1. Go to **Start**, click **Run**, and type *regedit*.
1. Navigate to the `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient` registry location.
1. Add a DWORD IsMapiPrivatePropertySupported with a value of 00000001.
