---
title: Organization database updates fail during import
description: Organization database updates fail during the import process of the organization in Microsoft Dynamics CRM 2011. Provides a resolution.
ms.reviewer: bhshastr
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-server
---
# Organization database updates fail during the import process of the organization in Microsoft Dynamics CRM 2011

This article provides a resolution for the issue that organization database updates fail during the import process of the organization in Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2714807

## Symptoms

Updates to the Microsoft Dynamics CRM 2011 organization database are applied as part of import organization process and/or update rollup installation process. Applying such database updates on the organization database may fail.

Error message reported in Dmsnap-in log for the database update failures:

> Info| Applying slipstream dbUpdates to organization. Id=\<GUID>, UniqueName=CRMtest.  
Error| Applying database updates to organization with name = CRMtest Id=\<GUID> failed with Exception:  
System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. --->  
System.AggregateException: One or more errors occurred. ---> Microsoft.Crm.BusinessEntities.CrmObjectNotFoundException: No rows could be found for Entity with id \<ID> if Entity were published

Error reported in update rollup installation log:

> Info| Database update install failed for orgId = \<GUID>. Continuing with other orgs.  
Exception: System.Reflection. TargetInvocationException: Exception has been thrown by the target of an invocation . ---> System.AggregateException: One or more errors occurred. ---> Microsoft.Crm.BusinessEntities.CrmObjectNotFoundException: No rows could be found for Entity with id \<GUID> if Entity were published

> [!NOTE]
> GUIDs in the error messages above may differ from those shown, as the entities involved may vary.

## Cause

This issue occurs when the `NumThreadsForIndexCreation` registry value has been added to the registry.

## Resolution

To modify the registry, follow the steps below:

1. Point to the **Start** menu, select **Run**, and type *regedit*.
2. Navigate to the following location in the registry: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM`.
3. Remove the `NumThreadsForIndexCreation` key.
4. Reapply the update rollup or reimport the organization database depending on which process incurred failure.
