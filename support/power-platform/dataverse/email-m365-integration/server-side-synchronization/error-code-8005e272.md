---
title: Error code 8005E272 when you test and enable a mailbox
description: Provides a resolution for error code 8005E272 that occurs when you test and enable a mailbox for server-side synchronization.
ms.date: 05/07/2024
ms.custom: sap:E-mail and Microsoft 365 Integration\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Error code 8005E272 when you test and enable mailbox

This article provides a resolution for error code 8005E272 that occurs when you test and enable a mailbox for server-side synchronization in Microsoft Dataverse.

## Symptoms

When a user tries to Test and Enable a mailbox and error is “401 Unauthorized”. 

## Cause

When a user tries to Test and Enable a mailbox and the user account specified in the Email Server Profile receives a 401 Unauthorized error when contacting the Exchange Server. 

## Resolution

1. Verify that the account specified in the Email Server Profile is authorized to contact Exchange.

   1. Select an environment in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

      In the legacy web client in the upper-right corner, select gear icon., and then select **Advanced settings**.

   2. Select **Settings** > **Email** > **Mailboxes**.
   3. Select **Active Mailboxes**.

   4. Select all the mailboxes that you want to associate with the Microsoft Exchange Online profile, select **Apply Default Email Settings**, verify the settings, and then select **OK**.

      :::image type="content" source="media/error-code-8005e272/apply-default-email-settings.png" alt-text="Screenshot that shows the Apply Default Email Settings page.":::

      By default, the mailbox configuration will be tested and the mailboxes enabled when you select **OK**.

2. Edit mailboxes to set the profile and delivery methods.

   1. Do one of the following:

      - Select an environment in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
      - In the legacy web client in the upper-right corner, select gear icon., and then select **Advanced settings**.

   2. Select **Settings** > **Email** > **Mailboxes**.
   3. Select **Active Mailboxes**.
   4. Select the mailboxes that you want to configure, and then select **Edit**.
   5. In the **Change Multiple Records** form, under **Synchronization Method**, set **Server Profile** to **Microsoft Exchange Online**.
   6. Set **Incoming** and **Outgoing Email** to **Server-Side Synchronization or Email Router**.
   7. Set **Appointments**, **Contacts**, and **Tasks** to **Server-Side Synchronization**.

   8. Select **Change**.

3. Test and enable the mailbox again.

    1. Open the mailbox record if it isn't already open.
    2. Select the **Test & Enable Mailbox** button.
    3. Wait for the "Test & Enable" process to complete. If the test results aren't **Success**, review the **Alerts** area within the mailbox record.
