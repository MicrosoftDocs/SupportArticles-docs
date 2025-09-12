---
title: Only some emails are synchronized
description: Describes an issue where not all email messages are displayed in shared mailboxes and public folder favorites in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\.ost file synchronization
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Only a subset of items are synchronized in shared mailboxes or public folders in Outlook 2016

_Original KB number:_ &nbsp; 3140747

## Symptoms

In Microsoft Outlook 2016, you find fewer email messages in shared mailboxes or public folder favorites than expected. Also, older items may be missing.

At the bottom of the email message list, one of the following messages is displayed:

> Currently displaying all messages newer than 3 days.

> Currently displaying all messages newer than 1 week.

> Currently displaying all messages newer than 2 weeks.

> Currently displaying all messages newer than 1 month.

> Currently displaying all messages newer than 3 months.

> Currently displaying all messages newer than 6 months.

> Currently displaying all messages newer than 12 months.

> Currently displaying all messages newer than 24 months.

> [!NOTE]
> The number of days, weeks, or months that is displayed in the message depends on what you have configured for the **Mail to keep offline** setting in Outlook. For example, if you set this value to **1** (one) month, the message displays **Currently displaying all messages newer than 1 month**, as shown in the following screenshot.

:::image type="content" source="media/fewer-emails-in-shared-mailboxes-or-public-folders/message-example.png" alt-text="Screenshot shows the message displayed if you have the Mail to keep offline setting set to 1 month.":::

Also, when you search in a shared mailbox or public folder favorite, older items are missing from the search results.

## Cause

Starting in Outlook 2016, the **Mail to keep offline** setting applies to your own mailbox, shared mailboxes, and public folder favorites if the following conditions are true:

- Outlook is configured to use Cached Exchange mode.
- The **Download shared folders** and **Download Public Folder Favorites** settings are enabled.

Unlike the folders your own mailbox, shared mailboxes and public folder favorites that are affected by the **Mail to keep offline** setting do not provide a link to view more items from the server that is running Exchange Server. Also, when you search in shared mailboxes and public folder favorites that are affected by the **Mail to keep offline** setting, only items that are cached on your local computer are returned in the search results. Older items in shared mailboxes and public folder favorites that are stored on the server are not returned in the search results.

> [!NOTE]
> The default setting in Outlook is to have the **Download shared folders** setting enabled and the **Download Public Folder Favorites** setting disabled. In this configuration, the **Mail to keep offline** setting does not apply to public folder favorites because those folders are not cached.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To fix this problem, change the behavior of the Outlook offline mail feature. To do this, use one of the following methods.

### Method 1 - Use Outlook

You can configure Outlook to keep more of your mail offline. By doing this, more of the mail that's in shared mailboxes and public folder favorites is displayed. To change this setting, follow these steps:

1. In Outlook 2016, select **Account Settings**, on the **File** tab, and then select **Account Settings**.
2. Select your Exchange account, and then select **Change**.
3. Move the slider for the **Mail to keep offline** setting to the time that you want.

    > [!NOTE]
    > Move the slider to the All setting if you prefer to keep all of your email cached on your local computer.

    :::image type="content" source="media/fewer-emails-in-shared-mailboxes-or-public-folders/mail-to-keep-offline-setting.png" alt-text="Screenshot shows steps to change the Mail to keep offline setting.":::

4. Select **Next**.
5. In the message window that appears and states that this operation will not finish until you exit and restart Outlook, select **OK**.
6. Select **Finish**, and then select **Close**.
7. Exit and then restart Outlook.

> [!NOTE]
> The cached mode **Sync Slider** setting is maintained in the Outlook profile settings in the Windows registry. If you want to administer this setting through Group Policy, you can use the Group Policy templates. These are available from the Microsoft website. The Group Policy template files are Outlk16.admx and Outlk16.adml. If you use Group Policy to manage this setting, the following registry data is used by Outlook:
>
> Subey: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\Cached Mode`  
> DWORD: SyncWindowSetting  
> Value: integer value (Decimal)
>
> Use only the following Value settings:  
> **0** = all (whole mailbox)  
> **1** = 1 month of email items  
> **3** = 3 months of email items  
> **6** = 6 months of email items  
> **12** = 12 months of email items  
> **24** = 24 months of email items

> [!IMPORTANT]
> The Outlook 2016 user interface lets you set the **Mail to keep offline** setting to the additional values of **3 days**, **1 week**, and **2 weeks**. The May 3, 2016, update for Outlook 2016 allows you to set these additional values by using the `SyncWindowSettingDays` registry data. For more information about how to configure Outlook 2016 with these additional values, see [Update allows administrators to set additional default mail and calendar synchronization windows for new Exchange accounts in Outlook 2016](https://support.microsoft.com/help/3115009).

### Method 2 - Use the registry

Configure the registry so that the **Mail to keep offline** setting no longer applies to shared mailboxes or public folder favorites.

1. Exit Outlook.
2. Start Registry Editor. To do this, use the appropriate method for your version of Windows.

   - Windows 10, Windows 8.1, and Windows 8

     Press Windows logo key+R to open a **Run** dialog box. Type *regedit.exe*, and then press **OK**.
   - Windows 7

     Select **Start**, type *regedit.exe* in the **Start search** box, and then press Enter.

3. In Registry Editor, locate and then select the following subkey in the registry:

   `HKEY_CURRENT_USER\software\Microsoft\office\16.0\outlook\cached mode`
4. On the **Edit** menu, select **New**, and then select **DWORD (32-bit) Value**.
5. Type the following as a name for the new DWORD value:

    `DisableSyncSliderForSharedMailbox`
6. Double-click the **DisableSyncSliderForSharedMailbox** value.
7. In the **Value Data** box, type **1**, and then select **OK**.
8. Exit Registry Editor.

> [!NOTE]
> You can also add the `DisableSyncSliderForSharedMailbox` registry value in the Policies hive, as follows:
>
> Subkey: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\Cached Mode  
> DWORD: DisableSyncSliderForSharedMailbox  
> Value: Integer value (Decimal) that specifies the number of months
>
> Use only the following Value settings:  
> **0** = **Mail to keep offline** setting affects shared mailboxes and public folder favorites  
> **1** = **Mail to keep offline** setting does not affect shared mailboxes and public folder favorites

## More information

For more information about the **Mail to keep offline** setting in Outlook, see the following articles:

- [Only a subset of your Exchange mailbox items are synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized)
- [Work offline in Outlook](https://support.microsoft.com/office/work-offline-in-outlook-f3a1251c-6dd5-4208-aef9-7c8c9522d633)
