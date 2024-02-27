---
title: Issues that can occur when you add multiple Exchange accounts to the same Outlook profile
description: This article describes scenarios in which adding multiple accounts can cause unexpected behavior.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, gregmans, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool, sercast
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Issues that can occur when you add multiple Exchange accounts to the same Outlook profile

In Microsoft Outlook 2010, Outlook 2013, Outlook 2016, Outlook 2019 and Outlook for Microsoft 365, you can add multiple Microsoft Exchange accounts to the same profile if one of the following conditions is true:

- You have Full Access permission to the additional Exchange mailboxes.
- You have the credentials to access the additional Exchange mailboxes if you don't have Full Access permission to them.

This article describes the following two scenarios in which this feature can cause unexpected behavior, and provides alternate steps that you can use to set up the scenario.

1. [You add both the manager and delegate mailbox accounts to the same Outlook profile](#scenario-1-the-manager-and-delegate-mailboxes-are-added-to-the-same-profile).
1. [You manually add another mailbox account, and the Exchange Auto Mapping feature adds it at the same time](#scenario-2-the-mailbox-that-you-add-manually-is-also-added-by-exchange-auto-mapping).

## Scenario 1: The manager and delegate mailboxes are added to the same profile

In Outlook 2010, Outlook 2013, and Outlook 2016, Outlook 2019, and Outlook for Microsoft 365 a manager can add a delegate's account to their profile and the delegate can add the manager's account to their profile. This type of profile configuration isn't supported, however there is no warning or error message displayed when this scenario is set up.

In the following example, an Outlook 2010 profile displays two Exchange accounts that have been added to it.

:::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/example-of-email-account-settings.png" alt-text="Screenshot shows the two accounts under Email tab.":::

In this example, the manager is Corey Gray. The delegate has added Corey Gray's account to their own Outlook profile. This configuration is not supported.

To set up a configuration in which a manager and their delegate's mailboxes can be accessed from the same Outlook profile, follow these steps instead.

1. Remove the second Exchange account from your profile. For example, if you're a delegate, remove your manager's account from your profile.
   1. On the **File** menu, select **Info**.
   2. Select **Account Settings**, and then select **Account Settings**.
   3. Select the account that you want to remove, and then select **Remove**.

      :::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/remove-email-account.png" alt-text="Screenshot highlights the Remove button after selecting an Exchange account.":::

   4. Select **Yes** when you're prompted to confirm that you want to remove the account.
   5. In the **Account Settings** dialog box, select **Close**.

2. Add the other user's mailbox as an additional mailbox. (This is not the same as adding a second account).
   1. On the **File** menu, select **Info**.
   2. Select **Account Settings,** and then select **Account Settings**.
   3. Select your primary account, and then select **Change**.
   4. In the **Change Account** dialog box, select **More Settings**.
   5. On the **Advanced** tab, select **Add**.
   6. Enter the name of the mailbox, and then select **OK**.

      After you make this change, you'll see the additional mailbox listed on the **Advanced** tab in the **Microsoft Exchange** dialog box.

      :::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/advanced-tab.png" alt-text="Screenshot shows the Advanced tab in Microsoft Exchange dialog." border="false":::

   7. In the **Microsoft Exchange** dialog box, select **OK**.
   8. In the **Change Account** dialog box, select **Next**.
   9. Select **Finish**, and then select **Close**.

In this configuration, you can access any folders in the second mailbox for which you have permissions.

The following steps demonstrate two problems that may occur if manager and delegate accounts are added to the same profile. There might be other situations too in which this unsupported configuration can cause problems.

**Note**: The Calendar sharing improvements introduced in Outlook for Microsoft 365 that are based on the REST protocol don't prevent such problems.

1. In Outlook 2010, Outlook 2013, Outlook 2016, Outlook 2019 or Outlook for Microsoft 365, use a profile for a manager's mailbox to configure a delegate for the manager's mailbox with default settings.

   **Note**: The default delegate settings don't provide the delegate access to items that are owned by the manager and marked as private.
1. Add an appointment to the manager's calendar, and then enable the **Private** option on the **Tags** section of the Ribbon.
1. Exit Outlook.
1. Start Outlook by using a profile for the delegate.
1. On the **File** tab, select **Add Account** on the **Info** tab.
1. In the **Add New Account** dialog box, enter the manager's account information, and then select **Next**.
1. Select **Finish** after the account is added successfully.
1. Select **OK** at the prompt that instructs you to restart Outlook.
1. Exit Outlook, and then restart it by using the delegate's profile.
1. Enter the delegate's credentials if prompted.
1. In the navigation pane, select the **Calendar** module.
1. Under **My Calendars**, cancel the selection of the manager's calendar.
1. Select **Open Calendar** on the Ribbon, and then select **Open Shared Calendar**.
1. Enter the name of the manager's mailbox, and then select **OK**.
1. In the manager's calendar, open the appointment created in step 2. The appointment opens and the delegate is able to view the private item. However, this should not have been possible because of the default delegate settings used to configure the delegate for the manager's mailbox.
1. Right-click anywhere on the manager's calendar and select **New Meeting Request**.
1. Examine the account in the **From** field. The account that is listed is the manager's account. However, this should have been the delegate's account, because the delegate is creating the meeting on behalf of the manager.

## Scenario 2: The mailbox that you add manually is also added by Exchange Auto-Mapping

In Exchange Server 2010 Service Pack 1 (SP1) or later versions, the Auto-Mapping feature automatically adds mailboxes to the Outlook Navigation Pane if you have Full Access permission to the mailboxes. Outlook manages these additional mailboxes by using a specific permission set. If you previously configured these mailboxes as multiple Exchange accounts in the same Outlook profile, you may experience unexpected behavior when you send mail by using these mailboxes. This is because the mailboxes that are accessed by using the multiple Exchange accounts functionality in Outlook use a different permissions set from the mailboxes that are added by Exchange Auto-Mapping. Outlook tries to use both permission sets at the same time which is not a supported functionality.

To prevent this issue, disable Auto-Mapping for shared Exchange mailboxes. The administrator must use Exchange Management Shell to disable Auto-Mapping. For more information about how to disable Auto-Mapping for Exchange mailboxes, see [How to remove automapping for a shared mailbox in Outlook for Microsoft 365](./remove-automapping-for-shared-mailbox.md).
