---
title: Portal Entity Permission Enhancement
description: Portal Entity Permission Enhancement requires record modifications.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Portal Entity Permission Enhancement requires record modifications

This article provides a solution to an error that occurs when the necessary changes aren't granted on the respective Entity Permission records.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4020181

## Update Summary

To create and update records by using an entity form or web form, a portal user requires a web role with the associated entity permissions that have the **Append** and **Append To** privileges granted (in addition to the **Create** and **Write** privileges). Any Entity Permission records that have the **Write** and **Create** privileges enabled should also have the **Append** and **Append To** privileges.

If the necessary permissions are not granted on the Entity Permission records, portal users who try to create or update records by using an entity form or web form will receive the following error:

> You don't have the appropriate permissions.

This issue applies to both default and custom entity forms and web forms that are present in the Dynamics 365 organization associated to a portal, depending on the current Entity Permission configuration.

## Action required

To prevent users from encountering this error, the **Append** and **Append To** privileges should be enabled on any Entity Permission records where the **Write** or **Create** privileges are enabled. The steps to add the privileges are as follows:

1. Sign into Dynamics 365 with a licensed user with sufficient permissions to modify Entity Permission records.
2. In Dynamics 365, using the navigation menu at the top of the page, navigate to **Portals** -> **Entity Permissions**.
3. Using the view dropdown menu, select the **Active Entity Permissions** view if it isn't selected already.
4. Open any Entity Permission record(s) with **Write** or **Create** set to a value of **Yes** and **Append** or **Append To** set to a value of **No**.
5. On the Entity Permission record form, ensure that both **Append** and **Append To** are enabled in the **Privileges** section.

As a specific example, the **Customer Service - Contact of the User** Entity Permission record was deployed to all Customer Self-Service portals with the **Append** privilege disabled. As this record has the **Write** privilege enabled and is set to a Scope of **Self**, this record should be modified so that the **Append** privilege is enabled.
