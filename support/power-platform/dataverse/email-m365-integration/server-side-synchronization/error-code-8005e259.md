---
title: Help with error code 8005E259
description: Provides a resolution for the error code 8005E259 in Microsoft Dataverse.
ms.date: 04/23/2024
ms.custom: 
author: rahulmital
ms.author: rahulmital
---
# Help with Error code: 8005E259

## Symptoms

When a user tries to Test and Enable a mailbox and missing privilege.

## Cause

When a user tries to Test and Enable a mailbox, the user or team associated with the Dataverse mailbox is missing the privilege.

## Resolution

Please assign a security role to the user or team that has the missing privilege.

1. Sign in to the Power Platform admin center, select **Environments** in the navigation pane, and then select an environment.
2. Select **Settings** > **Users + permissions** > **Security roles**.
3. Select **New**.
4. Enter the name of the new security role.
5. Select the **Member's privilege inheritance** list, and then select **Direct User/Basic access level and Team privileges**.
6. Go to each tab and set the appropriate privileges on each table.

> [!NOTE] 
> To change the access level for a privilege, keep selecting the access level symbol until you see the one you want. The access levels available depend on whether the record type is organization-owned or user-owned.

### Test and Enable the mailbox again to verify

1. Open the mailbox record if it is not already open.
2. Select the **Test & Enable Mailbox** button.
3. Wait for the "Test & Enable" process to complete. If the test results are not Success, review the **Alerts** area within the mailbox record.
