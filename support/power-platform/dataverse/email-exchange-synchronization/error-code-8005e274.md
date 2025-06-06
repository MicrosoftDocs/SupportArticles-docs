---
title: Error code 8005E274 when you test and enable a mailbox
description: Provides a resolution for error code 8005E274 that occurs when you test and enable a mailbox for server-side synchronization.
ms.date: 06/06/2025
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Error code 8005E274 when you test and enable mailbox

This article provides a resolution for error code 8005E274 that occurs when you test and enable a mailbox for server-side synchronization in Microsoft Dataverse.

## Symptoms

When a user tries to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Microsoft Dataverse, the test fails with error code 8005E274.

You might also see the following error message in the [Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) section of the mailbox record:

> **Email Server Error Code:** MailboxNotEnabledForRESTAPI

## Cause

This issue occurs because the Exchange mailbox associated with the email address isn't enabled for REST API connectivity in the Microsoft 365 tenant relative to the configured email server profile. This issue can occur if the mailbox doesn't have an Exchange Online license, is disabled, or exists in an Exchange on-premises hybrid deployment.

## Resolution

1. Verify that the mailbox has an Exchange online license:

   1. Sign in to the [Microsoft 365 portal](https://portal.office.com) as an administrator.
   2. Select **Users and groups** > **Active users**.
   3. Select **Filter** (:::image type="icon" source="media/error-code-8005e274/filter-icon.svg":::), and then select **Unlicensed users** in the drop-down list.

       > [!NOTE]
       >
       > - To assign a license to a user, double-click the user. On the **Assign licenses** page, select the check boxes next to the items that you want to assign, and then select **Save**.
       > - After assigning the Microsoft Dynamics 365 license to the user, this change may take a few minutes to sync between Microsoft 365 and Microsoft Dynamics 365. Exchange might also need additional time to create a mailbox for the user.

2. Create a hybrid email server profile that points to the on-premises environment:

    1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select an environment. On the command bar, select **Settings** > **Email** > **Server profiles**.

        :::image type="content" source="media/error-code-8005e274/server-profiles-setting.png" alt-text="Screenshot that shows the Server profiles option in Settings.":::

    2. On the command bar, select **New server profile**.

        :::image type="content" source="media/error-code-8005e274/new-server-profile.png" alt-text="Screenshot that shows the New server profile option in Server profiles settings.":::

    3. For **Email Server Type**, select **Exchange Server (On Prem)**, and then specify a meaningful name for the profile.

    4. If you want to use this server profile as the default profile for new mailboxes, turn on **Set as default profile for new mailboxes**.

        If **Authentication Type** is set to **Exchange Hybrid Modern Auth (HMA)**, enter the location and port for the email server.

    5. Expand the **Advanced** section, and then use the tooltips to choose your email processing options.
    6. When you're done, select **Save**.

3. Test and enable the mailbox again.

    1. Open the mailbox record if it isn't already open.
    2. Select the **Test & Enable Mailbox** button.
    3. Wait for the "Test & Enable" process to complete. If the test results aren't **Success**, review the **Alerts** area within the mailbox record.
