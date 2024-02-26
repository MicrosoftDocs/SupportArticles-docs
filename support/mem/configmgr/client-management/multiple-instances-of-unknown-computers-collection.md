---
title: Multiple instances of the Unknown computers collection
description: Describes a problem in which System Center 2012 Configuration Manager may show multiple instances of the Unknown computers collection when you reinstall a primary site.
ms.date: 12/05/2023
ms.reviewer: kaushika, ErinWi, prakask, keiththo, frankroj
---
# Multiple instances of the Unknown computers collection occur when you reinstall a primary site

This article provides a workaround for the issue that multiple instances of the **Unknown computers** collection are shown in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2688121

## Symptoms

Consider this scenario in Microsoft System Center 2012 Configuration Manager:

- You install a central administration site.
- You install a primary site and then uninstall the primary site.
- You reinstall the primary site by using the same server name and site name.

In this scenario, you may notice multiple instances of the **Unknown computers** collection.

## Workaround

To work around this problem, create a collection that includes all Unknown Computer objects. This method creates a collection that contains both active and inactive objects. Then, advertise a task sequence to this collection to make sure that it becomes associated with the inactive GUID that is being used by the Pre-Boot Execution Environment (PXE) image.

To do this, run the following query for the collection, and then retarget advertisements to the new collection:

```sql
Select SMS_R_UNKNOWNSYSTEM.ResourceID,SMS_R_UNKNOWNSYSTEM.ResourceType,SMS_R_UNKNOWNSYSTEM.Name,SMS_R_UNKNOWNSYSTEM.Name,SMS_R_UNKNOWNSYSTEM.Name from SMS_R_UnknownSystem where Decommissioned = "0"
```
