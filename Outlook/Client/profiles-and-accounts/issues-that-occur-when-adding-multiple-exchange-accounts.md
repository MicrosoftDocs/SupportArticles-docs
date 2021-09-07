---
title: Issues when adding multiple accounts in a profile
description: Outlook 2010 introduced a new feature that lets you add multiple Exchange accounts to the same messaging profile. This article describes three distinct scenarios in which this can cause unexpected behavior.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
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
- Outlook for Office 365 
search.appverid: MET150
---
# Issues that can occur when you add multiple Exchange accounts in the same Outlook profile

_Original KB number:_ &nbsp; 981245

## Introduction

Microsoft Outlook 2010, Outlook 2013, Outlook 2016, Outlook 2019 and Outlook for Office 365 let you add multiple Microsoft Exchange accounts to the same profile. You can add an additional Exchange account if one of the following conditions is true:

- You have Full Access permission to the additional Exchange mailbox.
- You do not have Full Access permission to the Exchange mailbox. However, you know the credentials to access the additional Exchange mailbox.

This article describes two distinct scenarios in which this feature can cause unexpected behavior:

1. You add both the manager and delegate mailbox accounts in the same Outlook profile.
2. You manually add another mailbox account, and the Exchange Server 2010 Service Pack 1 (SP1) Auto Mapping feature adds it at the same time.

## More information

This section describes the two scenarios in which unexpected behavior can occur when you use the Outlook feature that lets you add multiple Exchange accounts to the same profile. Additionally, this section provides the steps that you can follow to resolve or to work around these issues.

### Scenario 1 - The manager and delegate mailboxes are added to the same profile

Outlook 2010, Outlook 2013, and Outlook 2016, Outlook 2019, and Outlook for Office 365 let you add your delegate's account to your own profile and lets your delegate add your account to their profile. However, although there is no warning message or error, this profile configuration is not supported. For example, the following screenshot shows an Outlook 2010 profile that has two Exchange accounts.

:::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/example-of-email-account-settings.png" alt-text="example":::

In this example, the manager is Marcelo Santos. The delegate has added the mailbox account of Marcelo Santos to his own Outlook profile.

If the manager and delegate mailboxes have to be accessed in the same Outlook profile, follow these steps:

1. Remove the second Exchange account from your profile. For example, if you are a delegate, remove your manager's account from your profile. To do this, follow these steps:
   1. On the **File** menu, select **Info**.
   2. Select **Account Settings**, and then select **Account Settings**.
   3. Select the account that you want to remove, and then select **Remove**.

      :::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/remove-email-account.png" alt-text="Remove":::

   4. Select **Yes** when you are prompted to confirm that you want to remove the account.
   5. In the **Account Settings** dialog box, select **Close**.

2. Add the second mailbox as an additional mailbox. (This differs from a second account). To do this, follow these steps:
   1. On the **File** menu, select **Info**.
   2. Select **Account Settings,** and then select **Account Settings**.
   3. Select your primary account, and then select **Change**.
   4. In the **Change Account** dialog box, select **More Settings**.
   5. On the **Advanced** tab, select **Add**.
   6. Enter the name of the mailbox, and then select **OK**.

      After you make this change, the additional mailbox is listed on the **Advanced** tab in the **Microsoft Exchange** dialog box.

      :::image type="content" source="media/issues-that-occur-when-adding-multiple-exchange-accounts/the-advanced-tab-in-the-microsoft-exchange.png" alt-text="Microsoft Exchange" border="false":::

   7. In the **Microsoft Exchange** dialog box, select **OK**.
   8. In the **Change Account** dialog box, select **Next**.
   9. Select **Finish**, and then select **Close**.

In this configuration, you can access any folders in the second mailbox for which you have permissions.

The following steps demonstrate two problems that may occur if manager and delegate accounts are added to the same profile by using the Outlook multiple Exchange accounts functionality. There may be other situations in which this unsupported configuration may cause problems, and this article may be updated in the future to include additional problems.

> [!NOTE]
> In this scenario, you are considered the manager account.

1. Using an Outlook 2010, Outlook 2013, Outlook 2016, Outlook 2019 or Outlook for Office 365 profile for your mailbox, configure a delegate for your mailbox, and use default delegate settings.

    > [!NOTE]
    > Default delegate settings do not let the delegate see items that are owned by the manager and that are marked as private.

2. Add an appointment to your calendar, and then enable the **Private** option on the **Tags** section of the Ribbon.
3. Exit Outlook.
4. Start Outlook by using a profile for the delegate.
5. On the **File** tab, select **Add Account** on the **Info** tab.
6. In the **Add New Account** dialog box, enter your account information, and then select **Next**.
7. Select **Finish** after your account is successfully added.
8. Select **OK** to the prompt that instructs you to restart Outlook.
9. Exit Outlook, and then restart Outlook by using the delegate's profile.
10. Enter any credentials if you are prompted.
11. In the navigation pane, select the **Calendar** module.
12. Under **My Calendars**, cancel the selection of the manager's calendar.
13. Select **Open Calendar** on the Ribbon, and then select **Open Shared Calendar**.
14. Enter the name of the manager's mailbox, and then select **OK**.
15. In the manager's calendar, double-select the appointment that you created in step 2.

    The appointment opens and the delegate can view the item. In the default delegate configuration, the delegate should be unable to open a private item.
16. Right-select any space on the manager's calendar, and then select **New Meeting Request**.
17. Examine the account in the **From** field.

    The account that is listed is the manager's account. The account that is shown should be the delegate's account, because the delegate is creating the meeting on behalf of the manager.

### Scenario 2 - The mailbox that you add is also added by Exchange Server 2010 SP1 Auto Mapping

In Exchange Server 2010 Service Pack 1 (SP1), the new Auto Mapping feature automatically adds mailboxes to the Outlook Navigation Pane if you have Full Access permission to the mailboxes. Outlook manages these additional mailboxes by using a specific permission set. If you previously configured these same mailboxes as multiple Exchange accounts in one Outlook profile, you may experience unexpected behavior when you send mail by using those other mailboxes. This is because mailboxes that are accessed by using the Outlook multiple Exchange accounts functionality use a different permissions set from those mailboxes that are added by Exchange Auto Mapping. Outlook tries to use both permission sets at the same time. This profile configuration is not supported.

To prevent this issue, use one of the following methods:

#### Disable Auto Mapping for the shared Exchange mailboxes

Exchange Server 2010 Service Pack 2 (SP2) extended the Auto Mapping feature to also let an administrator disable Auto Mapping for specific mailboxes. To disable the Auto Mapping feature for specific Exchange mailboxes, the Exchange administrator must use the Exchange Management Shell. For more information about how to disable Auto Mapping for Exchange mailboxes, see [Disable Outlook Auto-Mapping with Full Access Mailboxes](/previous-versions/office/exchange-server-2010/hh529943(v=exchg.141)).

#### Remove the auto-mapped mailboxes from your profile

To remove the auto-mapped mailboxes from your profile, use the **Account Settings** dialog box. Because these mailboxes are automatically added through Auto Mapping, you do not have to also add them as additional Exchange accounts.
