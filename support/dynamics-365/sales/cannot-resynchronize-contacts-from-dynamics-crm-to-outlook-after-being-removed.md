---
title: Cannot resynchronize contacts after being deleted
description: How to restore previously deleted Microsoft Dynamics CRM contacts in Outlook when their corresponding contact record still exists in Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot resynchronize contacts from Microsoft Dynamics CRM 2011 to Outlook after being previously deleted in Outlook

This article provides a resolution for the issue that you're unable to resynchronize contacts from Microsoft Dynamics CRM 2011 to Microsoft Office Outlook after being previously deleted in Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2538795

## Symptoms

When Microsoft Dynamics CRM contacts that have been synchronized to Microsoft Office Outlook are deleted directly from Outlook, the contact from Microsoft Dynamics CRM will not resynchronize back to Outlook.

## Cause

This occurs because a modification is made to the OutlookSyncTable and IDMappingTable tables in the local OutlookSyncCache SQL database file that the record has been removed. This imploys the logic that the contact should not be resynchronized as it has been previously removed. This functionality is by design.

## Resolution

In order to have the Microsoft Dynamics CRM 2011 resynchronize the previously tracked and deleted Outlook contacts, the Outlook client needs to be reconfigured.

> [!WARNING]
> Do not perform these steps if you are in Offline mode as any changes made to the offline data will be lost upon removing the current configuration.

To reconfigure the Microsoft Dynamics CRM 2011 client for Outlook, complete these steps:

1. Close Microsoft Office Outlook if it is open.
2. Select **Start**, select **All Programs**, select **Microsoft Dynamics CRM 2011**, and then select **Configuration Wizard**.
3. Select the existing configuration profile, and then select **Delete**.
4. Select **Add**.
5. Ensure that the CRM URL is listed in the **Server URL** field, and then select **Test Connection**.
6. Enter the credentials that were initially used to configure the Outlook client previously.
7. Select the appropriate organization in the **Organization** list.
8. Enter a display name for the organization in the **Display Name** field (optional).
9. Select **OK**.

With the next synchronization process, the Outlook client will synchronize contacts from Microsoft Dynamics CRM to Outlook.

## More information

The OutlookSyncCache SQL database is located at the file path below based on the operating system:

**Windows XP:** C:/Documents and Settings/

**Windows Vista and Windows 7:** C:/Users/%userprofile%/AppData/Roaming/Microsoft/MSCRM/Client/OutlookSyncCache.sdf
