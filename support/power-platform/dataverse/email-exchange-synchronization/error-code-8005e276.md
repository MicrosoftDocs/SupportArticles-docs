---
title: Error code 8005E276 when you test and enable a mailbox
description: Provides a resolution for error code 8005E276 that occurs when you test and enable a mailbox for server-side synchronization.
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Error code 8005E276 when you test and enable mailbox

This article provides a resolution for error code 8005E276 that occurs when you test and enable a mailbox for server-side synchronization in Microsoft Dataverse.

## Symptoms

When a user tries to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Microsoft Dataverse, the test fails with error code 800046.

## Cause

This issue occurs because the Microsoft Graph user associated with the email address doesn't have a valid Exchange license or the user isn't in administrative access mode.

## Resolution

As an administrator, follow these steps to make sure the user has a valid Exchange license .

1. [Assign a license to the user by using the "Licenses" page](/microsoft-365/admin/manage/assign-licenses-to-users#assign-licenses-by-using-the-licenses-page) in the Microsoft 365 admin center.

   > [!IMPORTANT]
   > Licensed users must be assigned [at least one security role to access customer engagement apps](/power-platform/admin/plan-for-deployment-and-administration). [Security roles can be assigned either directly or indirectly as a group team member](/microsoft-365/admin/add-users/assign-admin-roles#assign-admin-roles-to-users-using-roles).

   > [!NOTE]
   > After assigning the Microsoft Dynamics 365 license to the user, this change may take a few minutes to sync between Microsoft 365 and Microsoft Dynamics 365. Exchange might also need additional time to create a mailbox for the user.

2. Make sure the user is in administrative access mode.

   1. Sign in to your Microsoft Dynamics 365 organization as a user with the "System Administrator" role.
   2. Navigate to **Settings** > **Email Configuration** > **Mailboxes**.
   3. Change the selected view from **My Active Mailboxes** to **Active Mailboxes**.
   4. Open the user's mailbox record.
   5. Select the user selected in the **Owner** field to open the user record.
   6. Expand the **Administration** tab.
   7. Set the **Access Mode** to **Read-Write**.

3. Test and enable the mailbox again.

   1. Open the mailbox record if it isn't already open.
   2. Select the **Test & Enable Mailbox** button.
   3. Wait for the "Test & Enable" process to complete. If the test results aren't **Success**, review the **Alerts** area within the mailbox record.
