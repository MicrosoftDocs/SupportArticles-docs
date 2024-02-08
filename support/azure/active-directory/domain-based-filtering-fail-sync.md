---
title: Changes to domain-based filtering in Synchronization Service Manager fail to sync
description: Describes an issue in which changes to domain-based filtering in the Active Directory management agent or the Active Directory Connector fail to sync. Provides a resolution.
ms.date: 05/22/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Changes to domain-based filtering in Synchronization Service Manager fail to sync

This article describes an issue in which changes to domain-based filtering in the Active Directory management agent or the Active Directory Connector fail to sync.

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2998261

## Symptoms

After you make a change to domain-based filtering in the Active Directory management agent or the Active Directory Connector, the run profile action fails to sync. In this situation, you receive the following error message:

> missing-partition-for-run-step

Additionally, an instance of event ID 6020 is logged in Event Viewer:

> Source: FIMSynchronization  
 Event ID: 6020  
 Description:  
 The management agent "Active Directory Connector" failed on run profile "Delta Sync" because a partition specified in the configuration could not be located.  
 User Action  
 Refresh and verify the partition configuration for the management agent and the target partition.

## Cause

This issue may occur if the run profile isn't updated.

## Resolution

### If you're removing a domain from the sync process

1. In Synchronization Service Manager, select the **Management Agents** tab or the **Connectors** tab.
2. Right-click the management agent or the Connector type for **Active Directory Domain Services,** and then select **Configure Run Profiles**.
3. Look for the step that has a **Partition** value that contains a string of alphanumeric characters (for example, {B3C9A66A-4C9C-457A-97B9-A0107037A416}), and then select **Delete Step**.
4. Select **Apply**, and then select **OK**.
5. Repeat steps 3-4 for each run profile.
6. Right-click the same management agent or Connector again, and then select **Run**.
7. Select **Full Sync**, and then select **OK**.

### If you're adding a domain to be synced

1. In Synchronization Service Manager, select the **Management Agents** tab or the **Connectors** tab.
2. Right-click the management agent or the Connector type for **Active Directory Domain Services,** and then select **Configure Run Profiles**.
3. In the navigation pane (on the left), select a Management Agent run profile.
4. Select **New Step**.
5. Under **Type**, select the option that resembles the run profile that you selected in step 3, and then select **Next**.
6. Under **Partition**, select the domain that you want to add, and then select **Finish**.
7. Repeat steps 3-6 for each run profile.
8. Right-click the same management agent or Connector again, and then select **Run**.
9. Select **Full Sync**, and then select **OK**.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
