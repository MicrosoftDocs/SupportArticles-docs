---
title: Only a subset of your Exchange mailbox items is synchronized in Outlook
description: Discusses that only a subset of your Exchange mailbox items is synchronized in Outlook if you use Cached Exchange Mode. This is expected behavior. Provides a workaround.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Exchange Mailbox Accounts\Cached mode synchronization
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook for Microsoft 365
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---

# Only a subset of your Exchange mailbox items are synchronized in Outlook

## Symptoms

Consider the following scenario:

- You're using Microsoft Outlook LTSC 2021, Outlook 2019, Outlook 2016, Outlook 2013 or Outlook for Microsoft 365.
- You're connected to an Exchange Server mailbox.

   **Notes**  

  - If you're running Outlook LTSC 2021, Outlook 2019, Outlook 2016, or Outlook for Microsoft 365, this account might be your primary mailbox or another mailbox to which you have delegate access or another permission. This might be an additional, shared, or automapped mailbox, or public folders.

    For more information about this issue in Outlook 2019, Outlook 2016, or Outlook for Microsoft 365 related to shared mailboxes or public folders, see the following article in the Microsoft database:

    [3140747](https://support.microsoft.com/help/3140747) Only a subset of items is synchronized in shared mailboxes or public folders in Outlook 2016
  - If you're running Outlook 2013, the account must be your primary account.
- Your Exchange email account is configured to use Cached Exchange Mode.

In this scenario, the email folders for these mailboxes may show item counts that are lower than expected. Additionally, older items may seem to be missing, and you might receive the following message and hyperlink at the bottom of the list of items:

> There are more items in this folder on the server

> Click here to view more on Microsoft Exchange

This message is shown in the following screenshot.

:::image type="content" source="media/only-subset-items-synchronized/more-items-in-this-folder-1.png" alt-text="Screenshot shows the message There are more items in this folder on the server, and the link Click here to view more on Microsoft Exchange." border="false":::

Additionally, if you search for email items in your mailbox, the search results may display the following text at the bottom of the results:

> Showing recent results...
> More

If you click the **More** link, additional items that meet your search criteria are displayed in the search results. This occurs because Outlook retrieves the additional items from your mailbox on the server that's running Exchange Server.

> [!NOTE]
> This behavior can also occur in the RSS Feeds folder in your Exchange mailbox.  Also, only a subset of items may be synchronized in groups in Outlook 2016 or Outlook for Microsoft 365.

## Cause

This behavior occurs because the Cached Exchange mode **Mail to keep offline** setting is configured to a value other than **All**. For example, the following screenshot shows a profile that's configured to use Cached Exchange Mode and the **Mail to keep offline** setting is set to a default value of **12 months**.

:::image type="content" source="media/only-subset-items-synchronized/mail-to-keep-offline-default.png" alt-text="Screenshot shows the Mail to keep offline setting is set to 12 months in Change Account dialog box.":::

> [!NOTE]
> Outlook 2019, Outlook 2016, Outlook 2013 and Outlook for Microsoft 365 provide the options of 1, 3, 6, 12, or 24 months, or All. Outlook LTSC 2021, Outlook 2019, Outlook 2016, and Outlook for Microsoft 365 provide the additional options of 3 days, 1 week, 2 weeks, 3 years, and 5 years. Additionally, later versions of Outlook renamed the **Mail to keep offline** setting to **Download email for the past**.

In the default configuration, depending on the size of your hard disk, Outlook synchronizes only 1, 3, or 12 months of email to your Offline Outlook Data (.ost) file from the Exchange server.

If your **Mail to keep offline** setting is set to 12 months and you have email items in your Exchange mailbox that are older than 12 months, those items reside only in your mailbox on the server. Therefore, if you can't connect to the Exchange server, you may be unable to retrieve items outside the range that's specified by the Cached Exchange Mode synchronization setting until you reconnect with the server.

> [!NOTE]
> This setting does not affect the number of items that are synchronized with folders of the following types:

- Calendar
- Contacts
- Tasks
- Journal
- Notes
- Outbox
- Shared or delegated (only for Outlook 2013)

> [!NOTE]
> Groups folders only synchronize a maximum of 1 year. **Mail to keep offline** settings that are lower than 1 year are honored.
  
## More information

To reduce the effect of the Outlook offline data file (.ost), the default number of months that are configured for your profile varies by the size of your hard disk. The following table provides the different default values for different hard disk sizes.

|Hard disk size|Default value for "Mail to keep offline"|
|---|---|
|Less than or equal to 32 GB|1 month |
|Greater than 32 GB, but less than 64 GB|3 months |
|Equal to or greater than 64 GB|12 months |

If you have to change the number of selected months of email to synchronize with your cached mode ".ost" file, follow these steps:

1. Start Outlook.
2. On the **File** tab, click **Account Settings**, and then click **Account Settings**.
3. On the **E-mail** tab, double-click your Microsoft Exchange account.
4. In the **Change Account** dialog box, drag the **Mail to keep offline** slider to the desired number of months or to **All** to synchronize all email messages.

    :::image type="content" source="media/only-subset-items-synchronized/mail-to-keep-offline-all.png" alt-text="Screenshot shows the Mail to keep offline setting is set to All in Change Account dialog box.":::

5. Click **Next**.
6. Click **OK** when you're prompted to restart Outlook to complete the configuration change.
7. Click **Finish**.
8. Restart Outlook.

### Working Offline

If you don't have connectivity with the Exchange server, the following message is displayed in a folder if there are older items on the server that were not synchronized with your .ost file:

> There are more items in this folder on the server

> Connect to the server to view them

This message is shown in the following screenshot.

:::image type="content" source="media/only-subset-items-synchronized/more-items-in-this-folder-2.png" alt-text="Screenshot shows the message There are more items in this folder on the server. Connect to the server to view them." border="false":::

Under similar conditions, if you search for items in your mailbox and you don't have connectivity with the Exchange server, the following message is displayed below the search results:

**Server unavailable. \<x> months of results shown.**

In this message, **\<x>** represents the value that's configured for the cached mode **Mail to keep offline** setting.

An example of this message is shown in the following screenshot.

:::image type="content" source="media/only-subset-items-synchronized/server-unavailable.png" alt-text="Screenshot shows the message Server unavailable. 3 months of results shown." border="false":::

### Feature Administration through Group Policy

The cached mode **Mail to keep offline** setting is maintained in the Outlook profile settings in the Windows registry. If you want to administer this setting by using Group Policy, you can use the Group Policy templates. These are available from the following Microsoft websites, depending on your version of Office:

Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365: [https://www.microsoft.com/en-us/download/details.aspx?id=49030](https://www.microsoft.com/download/details.aspx?id=49030)

Office 2013: [https://www.microsoft.com/download/details.aspx?id=35554](https://www.microsoft.com/download/details.aspx?id=35554)

The Group Policy template files for Outlook 2016, Outlook 2019, Outlook LTSC 2021, and Outlook for Microsoft 365 are Outlook16.admx and Outllk16.adml. The files for Outlook 2013 are Outlk15.admx and Outlk15.adml. If you use Group Policy to manage this setting, the following registry data is used by Outlook:

**Key**: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Outlook\Cached Mode`

**DWORD**: SyncWindowSetting

**Value**: integer value (Decimal) specifying the number of months (use only the following values)
**0** = All (whole mailbox)

**1** = 1 month of email items

**3** = 3 months of email items

**6** = 6 months of email items

**12** = 12 months of email items

**24** = 24 months of email items

**36** = 3 years of email items

**60** = 5 years of email items

**Notes:**

- The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019 or Outlook for Microsoft 365, Office 2019, Outlook LTSC 2021, or Outlook for Microsoft 365, 15.0 = Office 2013).
- The Outlook 2016, Outlook 2019, Outlook LTSC 2021, or Outlook for Microsoft 365 user interface (UI) lets you set the **Mail to keep offline** setting to the additional values of three days, 1 week, 2 weeks, 3 years, and 5 years. The May 3, 2016, update for Outlook 2016 allows you to set these additional values by using the SyncWindowSettingDays registry data. For more information about how to configure Outlook 2016 with these additional values, see the following article in the Microsoft Knowledge Base:

  [3115009](https://support.microsoft.com/help/3115009) Update allows administrators to set additional default mail and calendar synchronization windows for new Exchange accounts in Outlook 2016.

- Administrators who change the existing GPO values should be aware of the potential to impact network traffic when raising the value of the **SyncWindowSetting**. When GPO changes **SyncWindowSetting** to any higher value, Outlook will do a full OST resynchronization when the new value applies. For a single client, this is not problematic. Applying a higher value to hundreds or more clients at the same time could adversely affect available network bandwidth. Decreasing the value will have no such impact because Outlook will do a local-only deletion of excess data that's cached in the OST files of all clients to receive the lower **SyncWindowSetting** value.
- Since Outlook only synchronizes a maximum of one year for groups, you are unable to search for older messages. To work around this Outlook limitation, use Outlook on the Web to view and search for older messages in groups.
