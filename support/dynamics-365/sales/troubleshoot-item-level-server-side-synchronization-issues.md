---
title: Troubleshoot item level Server-Side Synchronization issues with Dynamics 365
description: This article introduces how to troubleshoot item level Server-Side Synchronization issues with Microsoft Dynamics 365.
ms.reviewer:  
ms.topic: article
ms.date: 
---
# Troubleshoot item level Server-Side Synchronization issues with Microsoft Dynamics 365

A new Server-Side Synchronization dashboard has been introduced that enables you to view item level failures for incoming email, outgoing email, and ACT (Appointments, Contacts, and Tasks) sync. This can help you troubleshoot issues such as why a specific email was not tracked automatically by Server-Side Synchronization.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4468755

## Enabling the feature

This feature currently requires an OrgDBOrgSetting (**EnableSssItemLevelMonitoring**) to be enabled and this setting is documented in [OrgDBOrgSettings tool for Microsoft Dynamics CRM](https://support.microsoft.com/help/2691237/orgdborgsettings-tool-for-microsoft-dynamics-crm). The EnableSssItemLevelMonitoring setting can also be enabled easily using the [OrganizationSettingsEditor](https://github.com/seanmcne/OrgDbOrgSettings/releases) tool.

This feature is available in version 8.2 and 9.x organizations of Microsoft Dynamics 365 (online).

## Usage

After following the required steps above to enable this feature, follow the steps below to locate and use the new dashboard:

1. Open the Microsoft Dynamics 365 web application and navigate to the **Dashboards** area.

    Example: **Sales** > **Dashboards or Service** > **Dashboards**

    > [!IMPORTANT]
    > To view the failures for a mailbox, you need to be accessing the dashboard as the user who owns the mailbox. This means that if you are trying to troubleshoot why email was not automatically tracked for another user, that user would need to view the dashboard to see the details for their emails that failed to sync.

2. Locate and select the **Server-Side Synchronization Failures** dashboard from the dashboard list.

   :::image type="content" source="media/troubleshoot-item-level-server-side-synchronization-issues/sever-side-synchronization-failures-option.png" alt-text="Server-Side Synchronization Failures Dashboard selection":::

3. If you locate a specific email or ACT item that did not sync as expected, you can view the reason in the **Sync Error** column. Selecting the link will direct you to a help article for that error if one exists.

   :::image type="content" source="media/troubleshoot-item-level-server-side-synchronization-issues/sever-side-synchronization-dashboard.png" alt-text="Server-Side Synchronization Dashboard":::

## More information

- This data is stored in the ExchangeSyncIdMapping table that could potentially get large if this feature is enabled. That is why the ExchangeSyncIdMappingPersistenceTimeInDays setting was also introduced and has a default of three days.
- ExchangeSyncIdMapping info is only visible to the owning user. That is why the owner of the mailbox needs to view the dashboard to see the details for their synchronization failures.
- If synchronization for a mailbox is not working at all, see [Troubleshooting Server-Side Synchronization](https://support.microsoft.com/help/4345669).

## Known issues

This dashboard does not currently work when viewed using the new Unified Client interface. You will see the following error:

> Components added to dashboard are not supported to be shown in this client
