---
title: Error code 8005E272 when you test and enable a mailbox
description: Provides a resolution for error code 8005E272 that occurs when you test and enable a mailbox for server-side synchronization.
ms.date: 05/13/2024
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Error code 8005E272 when you test and enable a mailbox

This article provides a resolution for error code 8005E272 that occurs when you test and enable a mailbox for server-side synchronization in Microsoft Dataverse.

## Symptoms

When a user tries to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Microsoft Dataverse, the user account specified in the email server profile receives a "401 Unauthorized" error when contacting the Microsoft Exchange Server.

## Resolution

1. Verify that the account specified in the email server profile is authorized to contact Exchange.

   1. Select an environment in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

       Or, in the legacy web client, select the gear (:::image type="icon" source="media/error-code-8005e272/gear-icon.svg":::) icon in the upper-right corner, and then select **Advanced settings**.

   2. Select **Settings** > **Email** > **Mailboxes**.
   3. Select **Active Mailboxes**.
   4. Select all the mailboxes that you want to associate with the Microsoft Exchange Online profile, select **Apply Default Email Settings**, verify the settings, and then select **OK**.

        :::image type="content" source="media/error-code-8005e272/apply-default-email-settings.png" alt-text="Screenshot that shows the Apply Default Email Settings page.":::

        By default, the mailbox configuration will be tested and the mailboxes will be enabled when you select **OK**.

2. Edit mailboxes to set the profile and delivery methods.

   1. Select an environment in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

        Or, in the legacy web client, select the gear (:::image type="icon" source="media/error-code-8005e272/gear-icon.svg":::) icon in the upper-right corner, and then select **Advanced settings**.

   2. Select **Settings** > **Email** > **Mailboxes**.
   3. Select **Active Mailboxes**.
   4. Select the mailboxes that you want to configure, and then select **Edit**.
   5. In the **Change Multiple Records** form, under **Synchronization Method**, set **Server Profile** to **Microsoft Exchange Online**.
   6. Set **Incoming Email** and **Outgoing Email** to **Server-Side Synchronization or Email Router**.
   7. Set **Appointments, Contacts, and Tasks** to **Server-Side Synchronization**.
   8. Select **Change**.

3. Test and enable the mailbox again.

    1. Open the mailbox record if it isn't already open.
    2. Select the **Test & Enable Mailbox** button.
    3. Wait for the "Test & Enable" process to complete. If the test results aren't **Success**, review the **Alerts** area within the mailbox record.
