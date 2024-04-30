---
title: Error code 8005E259 when you test and enable a mailbox
description: Provides a resolution for error code 8005E259 that occurs when you test and enable a mailbox during server-side synchronization.
ms.date: 04/29/2024
ms.custom: sap:E-mail and Microsoft 365 Integration\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Error code 8005E259 when you test and enable mailbox

This article provides a resolution for error code 8005E259 that occurs when you test and enable a mailbox for server-side synchronization in Microsoft Dataverse.

## Symptoms

When a user tries to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Microsoft Dataverse, the test fails with error code 8005E259.

## Cause

This issue occurs because the user or team associated with the Dataverse mailbox lacks privileges.

## Resolution

As an administrator, assign a security role that has the missing privileges to the user or team.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select **Environments** in the navigation pane, and then select an environment.
2. Select **Settings** > **Users + permissions** > **Security roles**.
3. Select **New** to [create a security role](/power-platform/admin/create-edit-security-role#create-a-security-role).
5. Select the **Member's privilege inheritance** option list, and then select **Direct User (Basic) access level and Team privileges**.
6. Go to each tab and set the appropriate privileges on each table.

   > [!NOTE] 
   > To change the access level for a privilege, keep selecting the access level symbol until you see the one you want. The access levels available depend on whether the record type is organization-owned or user-owned.

7. Test and enable the mailbox again to verify that the issue is resolved.
   
   1. Open the mailbox record if it isn't already open.
   2. Select the **Test & Enable Mailbox** button.
   3. Wait for the "Test & Enable" process to complete. If the test results aren't **Success**, review the **Alerts** area within the mailbox record.

## More information

[Security roles and privileges](/power-platform/admin/security-roles-privileges)
