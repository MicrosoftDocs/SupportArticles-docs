---
title: Clients become inactive and don't send inventory
description: Describes an issue in which Configuration Manager clients that report to a particular server or subset of servers repeatedly become inactive.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Operations\Hardware Inventory
---
# Configuration Manager clients become inactive and don't send inventory

This article provides a solution for the issue that the Configuration Manager clients become inactive and don't send inventory information.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3067633

## Symptoms

Configuration Manager clients that report to a particular server or subset of servers may repeatedly become inactive. You may also notice that the clients do not send inventory information for 30 days or more and that the data in the Inventoryagent.log file is static. Additionally, the ClientIDManagerStartup.log displays repeated occurrences of this error:

> [RegTask] - Client is not registered. Sending registration request for GUID:4874BD6C-CB98-4EEB-9F4F-721CC65B25C3 ...
>
> [RegTask] - Client is registered. Server assigned ClientID is GUID:4874BD6C-CB98-4EEB-9F4F-721CC65B25C3. Approval status 1
>
> SetRegistrationState failed (0x80071770)
>
> [RegTask] - Sleeping for 15360 seconds ...

> [!NOTE]
> Error code 0x80071770 indicates that the specified file could not be encrypted.

## Cause

This is a known issue in cng.sys and is related to the update that is mentioned in [Microsoft security advisory: Update to improve Windows command-line auditing: February 10, 2015](https://support.microsoft.com/help/3004375).

## Resolution

To solve this issue, apply either [update 3023562](https://support.microsoft.com/help/3023562) or [update 3046049](https://support.microsoft.com/help/3046049) to update your version of cng.sys. After you apply either of these updates and restart the computer, the affected client will successfully send up a heartbeat and update inventory data. This action will also enable the client to remain active.
