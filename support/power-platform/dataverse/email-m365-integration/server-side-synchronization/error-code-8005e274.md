---
title: Help with error code 8005E274
description: Provides a resolution for the error code 8005E274 in Microsoft Dataverse.
ms.date: 04/23/2024
ms.custom: 
author: rahulmital
ms.author: rahulmital
---
# Help with Error code: 8005E274

## Symptoms

 When a user tries to Test and Enable a mailbox and the mailbox is not enabled for REST.

## Cause

Test and Enable failed because the associated Exchange mailbox is not enabled for REST. The mailbox associated with the email address is not enabled for REST connectivity in the Microsoft 365 Tenant associated with Email Server Profile. This can occur if the mailbox does not have an Exchange Online license, is disabled, or exists in an Exchange On Premise Hybrid Deployment.

## Resolution

1. Verify that the mailbox has an Exchange online license:

   1. Sign in to the Microsoft 365 portal (https://portal.office.com) as an admin.
   2. Click **users and groups**, and then click **active users**.
   3. Click **Filter** (:::image type="icon" source="media/error-code-8005e274/filter-icon.png":::), and then in the drop-down box, click **Unlicensed users**.

      > [!NOTE]
      > To assign a license to a user, double-click the user. On the "Assign licenses" page, click to select the check boxes next to the items that you want to assign, and then click save.

    > [!NOTE]
    > After assigning the Microsoft Dynamics 365 license to the user, it may take a few minutes for this change to sync from Office 365 to Microsoft Dynamics 365. Exchange may also need to create a mailbox for the user which can take additional time.

2. Create a hybrid email server profile that points to the on-prem environment:

   1. In the Power Platform admin center, select an environment. On the command bar, select **Settings** > **Email** > **Server profiles**.

      :::image type="content" source="media/error-code-8005e274/server-profiles-setting.png" alt-text="Screenshot that shows the Server profiles option in Settings.":::

   2. On the command bar, select **New server profile**.

      :::image type="content" source="media/error-code-8005e274/new-server-profile.png" alt-text="Screenshot that shows the ew server profile option in Server profiles settings.":::

   3. For **Email Server Type**, select **Exchange Server (On Prem)**, and then specify a meaningful **Name** for the profile.

   4. If you want to use this server profile as the default profile for new mailboxes, turn on **Set as default profile for new mailboxes**.

      If **Authentication Type** is set to **Exchange Hybrid Modern Auth (HMA)**, enter the location and port for the email server.

   5. Expand the **Advanced** section, and then use the tooltips to choose your email processing options.

   6. When you're done, select **Save**.

### Test and Enable the mailbox again to verify

1. Open the mailbox record if it is not already open.
2. Select the **Test & Enable Mailbox** button.
3. Wait for the "Test & Enable" process to complete. If the test results are not Success, review the **Alerts** area within the mailbox record.
