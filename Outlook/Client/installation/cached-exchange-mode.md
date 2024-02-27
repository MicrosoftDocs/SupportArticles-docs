---
title: Plan and configure Cached Exchange Mode in Outlook 2016 for Windows
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.collection: Ent_Office_Outlook
description: Helps IT Pros learn about planning and configuring Cached Exchange Mode in Outlook 2016 for Windows
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
ms.date: 01/30/2024
---

# Plan and configure Cached Exchange Mode in Outlook 2016 for Windows

Outlook 2016 provides two basic connectivity modes when you are connected to Exchange Server: Cached Exchange Mode and Online Mode.

> [!NOTE]
> This article is for IT Pros and admins that are deploying and configuring Outlook 2016 for Windows for users in their enterprises. If you're a user trying to configure your Outlook settings, see [Turn on Cached Exchange Mode](https://support.office.com/article/7885af08-9a60-4ec3-850a-e221c1ed0c1c).  

## Comparison of Cached Exchange Mode and Online Mode

Cached Exchange Mode gives users a seamless online and offline Outlook experience by caching the user's mailbox and the Offline Address Book (OAB) locally. With Cached Exchange Mode, which is the default setting for users, Outlook no longer depends on continuous network connectivity for access to user information. When a user is connected, Outlook continuously updates users' mailboxes so that the mailboxes are kept up to date. If a user disconnects from the network, for example, by moving to an area without Wi-Fi access, the user can continue to access the last available email data.

> [!IMPORTANT]
> We recommend always using Cached Exchange Mode with a Microsoft 365 account.
  
Online Mode works by using information directly from the server, and, as the name implies, it requires a connection. Mailbox data is only cached in memory and never written to disk.

Cached Exchange Mode is the preferred configuration in Outlook 2016 and is useful in the following situations:

- Users who frequently move in and out of connectivity.
- Users who frequently work offline or without connectivity.
- Users who have high-latency connections (greater than 500 ms) to Exchange Server.

Online mode is useful in the following situations:

- Kiosk scenarios, where a particular computer has many users who access different Outlook accounts—and the delay to download email messages to a local cache is unacceptable.
- Heavily regulated compliance or secure environments where it is a risk to store data locally. In addition, we recommend that you consider using Encrypting File System (EFS) or BitLocker as a robust solution.
- Large mailboxes on computers that don't have sufficient hard disk space for a local copy of the mailbox.

Even when it is configured in Cached Exchange Mode, Outlook 2016 must contact the server directly to do certain operations. These operations won't function when Outlook is not connected and can take longer to complete on high-latency connections. These operations include the following:

- Working with Shared Folders that were not made available offline.
- Retrieving Free/Busy information.
- Setting, changing, or canceling an Out of Office message.
- Accessing public folders that were not made available offline.
- Retrieving rights to a rights-protected message.
- Editing rules.
- Retrieving MailTips.
- Retrieving Policy Tips.

Delayed delivery options are client side in cached mode and server side in online mode. So, when you use Cached Exchange Mode, Outlook must be connected and open at the assigned delivery time for the delayed delivery message to be sent.

 Outlook 2016 supports running in Cached Exchange Mode in a Remote Desktop Services (RDS), formerly known as Terminal Services, environment that has multiple users. When you configure a computer running RDS to use Cached Exchange Mode, be sure to consider the additional storage space and disk I/O that are required for multiple client accesses. New Exchange accounts set up on computers running RDS use Online Mode by default. At setup, the user can decide to enable Cached Exchange Mode.

## Planning considerations for Cached Exchange Mode for Outlook 2016

In some cases, you can improve the performance of Cached Exchange Mode for your whole organization or for a group of users—for example, users who work remotely.
  
### Outlook data file (.ost) recommendations

When you use Cached Exchange Mode, be aware that users' local `.ost` files are 50 percent to 80 percent larger than the mailbox size reported in Exchange Server. The format that Outlook uses to store data locally for Cached Exchange Mode is less space-efficient than the server data file format.
  
The maximum size for `.ost` files are configurable. The default is 50 GB of data storage. Make sure that users' `.ost` files are located in a folder that has sufficient disk space to accommodate users' mailboxes.
  
- For more information about how to deploy `.ost` files to a location other than the default location, see [To configure a default .ost location by using Group Policy](#to-configure-a-default-ost-location-by-using-group-policy)
- For more information about how to configure `.ost` file size, see [How to configure the size limit for both (.pst) and (.ost) files in Outlook](https://support.microsoft.com/help/832925).

### Upgrading existing Cached Exchange Mode users to Outlook 2016

When upgrading, if you do not change Cached Exchange Mode settings, the same settings are kept for Outlook 2016.
  
However, by default, when Outlook 2016 is installed and Cached Exchange Mode is enabled, a new compressed version of the Outlook data file (`.ost`) is created. The earlier version of the `.ost` file is kept and, if it is necessary, can be opened by Outlook 2016. If you must keep Outlook 2016 from creating a new compressed Outlook data file (`.ost`), use the Group Policy template for Outlook (Outlk16.admx) to enable the **Do not create new OST file on upgrade** policy setting.

For more information about how to configure this and other settings, see [Using Group Policy and the Office Customization Tool (OCT)](#using-group-policy-and-the-office-customization-tool-oct).

> [!NOTE]
> The Exchange Fast Access feature that was added to Outlook 2013 Exchange Cached Mode has been deprecated in Outlook 2016.

### Managing performance issues in Outlook

Most users find that Cached Exchange Mode performs faster than online mode. However, several factors can influence a user's perception of Cached Exchange Mode performance, like hard disk size and speed, CPU speed, `.ost` file size, and the expected level of performance.
  
For troubleshooting tips about diagnosing and addressing performance issues in Outlook, see [How to troubleshoot performance issues in Outlook](https://support.microsoft.com/help/2695805).
  
### Managing Outlook folder sharing

By default, when Cached Exchange Mode is enabled, shared mail and non-mail folders that users access in other mailboxes are downloaded and cached in the user's local `.ost` file. Similarly, if a manager delegates access to the Inbox to a team member, when the team member accesses the folder, Outlook 2016 also starts caching the Inbox folder locally.
  
You can disable caching of all shared folders for profiles that have Cached Exchange Mode enabled. To do this, configure the **Download shared non-mail folders** option in the Office Customization Tool (OCT) when you customize your Cached Exchange Mode deployment. This setting applies to both mail and non-mail folders in Outlook 2016.
  
If you want to disable caching of shared mail folders (like a delegated Inbox) but not shared non-mail folders (like Calendar), see [By default, shared mail folders are downloaded in Cached mode in Outlook 2010 and later versions](https://support.microsoft.com/help/982697/).

For more information about how to configure these settings, see [Using Group Policy and the Office Customization Tool (OCT)](#using-group-policy-and-the-office-customization-tool-oct).
  
### Site mailboxes

As an alternative to Public Folders, consider Site Mailboxes. Site mailboxes improve collaboration and user productivity by allowing access to both SharePoint Server documents and Exchange email that is in the same client interface. A site mailbox consists of SharePoint Server site membership (owners and members), shared storage through an Exchange Server mailbox for email messages and a SharePoint Server site for documents, and a management interface that addresses provisioning and life-cycle needs. SharePoint Server  documents that are viewed in the site mailbox are stored only on SharePoint Server. For more information, see [Configure site mailboxes in SharePoint Server](/sharepoint/administration/configure-site-mailboxes-in-sharepoint).

### Managing Outlook behavior for slow connections

Outlook is configured to determine a user's connection speed by checking the network adapter speed on the user's computer (supplied by the operating system). If the reported network adapter speed is 128 KB or lower, the connection is defined as a slow connection.
  
When a slow connection to an Exchange Server computer is detected, Outlook helps users have a better experience if they reduce the less important information that is synchronized with the Exchange Server computer. Outlook makes the following changes to synchronization behavior for slow connections:
  
- Switches to downloading only headers.
- Does not download the Offline Address Book or OAB updates.
- Downloads the body of an item and associated attachments only when it is requested by the user.

Outlook continues to synchronize the Outlook data with mobile devices, and some client-side rules might run.
  
> [!NOTE]
> We recommend that you do not synchronize mobile devices when the **Cached Exchange Download only headers** setting is enabled. When you synchronize a mobile device by using ActiveSync, for example, full items are downloaded in Outlook, and the synchronization process is less efficient than it is during regular Outlook synchronization to users' computers.
  
The **Download only headers** setting for synchronization is designed for Outlook users who have dial-up connections or cellular wireless connections, to minimize network traffic when there is a slow or expensive connection.
  
For a scenario where users' actual data throughput is slow, even though their network adapters report a fast connection, you can disable automatic switching to downloading only headers by using the Group Policy option, **Disallow On Slow Connections Only Download Headers**. Similarly, there might be connections that Outlook has determined are slow but which provide high data throughput to users. In this case, you can also disable automatic switching to downloading only headers.
  
You can configure the **On slow connections, download only headers** option in the Office Customization Tool (OCT), or configure the option by using Group Policy to set **Disallow On Slow Connections Only Download Headers**.

For more information about how to configure these settings, see [Using Group Policy and the Office Customization Tool (OCT)](#using-group-policy-and-the-office-customization-tool-oct).
  
## Configure Cached Exchange Mode for Outlook 2016

### Offline data file (.ost file) and Offline Address Book (OAB)

When an Outlook 2016 account is configured to use Cached Exchange Mode, there's always a local copy of a user's Exchange mailbox ready in an offline data file (`.ost` file) on the user's computer. By default, the `.ost` file is in the C:\Users\\<username\>\AppData\Local\Microsoft\Outlook folder.)

Whenever the user is offline and using Outlook 2016, the program works from this local copy and with the Offline Address Book (OAB). When the user is online, the cached mailbox and OAB are periodically updated from Exchange Server in the background. Any email messages the user drafted while offline are automatically sent when that user is back online.

If a user upgrades from an earlier version of Outlook to Outlook 2016 and you previously configured Outlook for Cached Exchange Mode, those old Cached Exchange Mode settings are automatically applied, including a new synchronization control for shared mailboxes. The default location for new `.ost` or OAB files is: %userprofile%\AppData\Local\Microsoft\Outlook\Offline Address Books. As an administrator, you can configure a different `.ost` file location for users in your organization who do not already have `.ost` files. If you do not specify a different `.ost` file location, Outlook creates an `.ost` file in the default location when users start Outlook in Cached Exchange Mode.

### "Mail to keep offline" setting

The **Mail to keep offline** slider in the Server Settings dialog box in Outlook 2016 has been updated to apply to shared folders and lets you set a smaller synchronization window, available by default with Cached Exchange Mode in Outlook 2016.

The slider allows an Outlook 2016 user to limit the email messages that are locally synchronized in a Microsoft Outlook data file (.ost). By default, if Cached Exchange Mode is enabled, Outlook 2016 caches email messages only from the last 12 months and removes anything older from the *local* cache for the PC. These default settings depend on the device, with mobile devices having smaller default settings. The email messages that are removed from the local cache are still available for users to view, but they'll need to be connected to Exchange Server to view them. Users can view messages that were removed from the local cache by scrolling to the end of a message list in a folder and clicking the message **Click here to view more on Microsoft Exchange**. Users can also change how much email to keep offline. You, the administrator, can change the default age or enforce the age of email messages that are removed from the local cache.

### Using Group Policy and the Office Customization Tool (OCT)

Use the following procedures to configure Cached Exchange Mode settings by using the OCT or Group Policy. Remember that customizing Cached Exchange Mode settings is optional.

> [!NOTE]
>
> - To get the Group Policy and Office Customization Tool (OCT) files, download the [Office 2016 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=49030) from the Microsoft Download Center.
> - The Office Customization Tool can only be used to configure volume licensed versions of Outlook, such as the version of Outlook that comes with Office Standard 2016.
  
### To configure Cached Exchange Mode settings by using the OCT

1. In the OCT tree view, find **Outlook**, and click **Add Accounts**. In the **Account Name** column, click the account you want to configure, and click **Modify** to display the **Exchange Settings** dialog box.
2. Click **More settings**.
3. Click the **Cached Mode** tab.
4. Click **Configure Cached Exchange Mode**, and select the **Use Cached Exchange Mode** check box to enable Cached Exchange Mode for users. (By default, Cached Exchange Mode is disabled.)
5. Choose a default download option on the **Cached Mode** tab:

   - **Download only headers**: Users see header information and the beginning of the message. They can download the full message in several ways—for example, by double-clicking to open the message or by clicking **Download the rest of this message now** in the reading pane.
   - **Download headers followed by the full item**: All headers are downloaded first, and then full items are downloaded. The download order might not be chronological, but that shouldn't be noticeable to the user. Microsoft Outlook downloads headers followed by full items in the folder that the user is currently accessing, and then it downloads headers followed by full items in folders that the user has recently viewed.
   - **Download full items**: Full items are downloaded. We recommend this option unless you have a slow network connection. The download order might not be chronological, but that shouldn't be noticeable to the user. Microsoft Outlook downloads full items in the folder that the user is currently accessing, and then it downloads full items in folders that the user has recently viewed. You might want to pair this with the **On slow connections, download only headers** option.

### To configure Cached Exchange Mode settings using Group Policy

1. In Group Policy, load the Outlook 2016 template.
2. Open the Group Policy Management Console (GPMC), and in the tree view, expand **Domains**, and expand **Group Policy Objects**.
3. Right-click the policy object that you want, and click **Edit**. The Group Policy Management Editor window opens.
4. In the tree view, go to  **User Configuration** > **Policies** > **Administrative Templates** > **Microsoft Outlook 2016** > **Account Settings** > **Exchange** > **Cached Exchange Mode**.
5. In the reading pane, in the **Setting** column, open the policy that you want to set by double-clicking it. For example, in the **Exchange** reading pane, open **Use Cached Exchange Mode for new and existing Outlook profiles**.
6. Select **Enabled**, and select an option (if appropriate).
7. Click **OK**.

### To configure a default .ost location by using Group Policy

1. In Group Policy, load the Outlook 2016 template.
2. Open the Group Policy Management Console (GPMC), and in the tree view, expand **Domains**, and then expand **Group Policy Objects**.
3. Right-click the policy object that you want, and click **Edit**. The Group Policy Management Editor window opens.
4. In the tree view, go to **User Configuration** > **Policies** > **Administrative Templates** > **Microsoft Outlook 2016** > **Miscellaneous** > **PST Settings**.
5. Double-click **Default location for OST files** to open it.
6. Click **Enabled** to enable the policy setting.
7. In the **Default location for OST files** text box, enter the default location for `.ost` files. For example:

    %userprofile%\Local Settings\Application Data\Microsoft\ _newfolder_.
8. Click **OK**.

    You can define a new default location for both Personal Microsoft Outlook data files (.pst) and `.ost` files. After you click **PST Settings** in the tree view, double-click to open the **Default location for PST files** setting in the reading pane.

### To prevent a new .ost file from being created

1. In Group Policy, load the Outlook 2016 template.
2. Open the Group Policy Management Console (GPMC), and in the tree view, expand **Domains**, and expand **Group Policy Objects**.
3. Right-click the policy object that you want, and click **Edit**. The Group Policy Management Editor window opens.
4. In the tree view, go to  **User Configuration** > **Policies** > **Administrative Templates** > **Microsoft Outlook 2016** > **Account Settings** > **Exchange**.
5. Double-click **Do not create new OST file on upgrade** to open it.
6. Click **Enabled** to enable the policy setting, and then click **OK**.

### Additional Group Policy and OCT settings

The following table shows some settings that you can configure for Cached Exchange Mode. In Group Policy, you can find the settings under **User Configuration\Policies\Administrative Templates\Microsoft Outlook 2016\Account Settings\Exchange\Cached Exchange Mode**. The OCT settings are in corresponding locations on the **Modify user settings** page of the OCT.
  
#### Cached Exchange Mode settings

|**Setting name**|**Description**|
|:-----|:-----|:-----|
|Cached Exchange Mode Sync Settings|Enable it to configure how much user email that Outlook synchronizes locally by date of message. To allow all email messages regardless of date to synchronize to users' local mailbox cache, enable and select **All** from the list. By default, if you don't configure this setting, Outlook synchronizes email messages sent or received in the last 12 months to users' local mailbox cache (`.ost`). |
|Disallow Download Full Items  |Enable it to turn off the **Download Full Items** option in Outlook. To find this option, choose the **Send/Receive** tab, and then choose **Download Preferences**.   |
|Disallow Download Headers  |Enable it to turn off the **Download Headers** option in Outlook. To find this option, choose the **Send/Receive** tab.   |
|Disallow Download Headers then Full Items  |Enable it to turn off the **Download Headers then Full Items** option in Outlook. To find this option, choose the **Send/Receive** tab, and then choose **Download Preferences**.  |
|Disallow On Slow Connections Only Download Headers   |Enable it to turn off the **On Slow Connections Download Only Headers** option in Outlook. To find this option, choose the **Send/Receive** tab, and then choose **Download Preferences**.   |
|Download Public Folder Favorites  |Enable it to synchronize Public Folder Favorites in Cached Exchange Mode.   |
|Download shared non-mail folders   |Enable it to synchronize shared nonmail folders in Cached Exchange Mode.   |
|Use Cached Exchange Mode for new and existing Outlook profile   |Enable it to configure new and existing Outlook profiles to use Cached Exchange Mode. Disable to configure new and existing Outlook profiles to use Online Mode. |

The following table shows some additional settings that you can configure for Exchange connectivity. In Group Policy, you can find the settings under **User Configuration\Policies\Administrative Templates\Microsoft Outlook 2016\Account Settings\Exchange**. The OCT settings are in corresponding locations on the **Modify user settings** page of the OCT.
  
#### Exchange connectivity settings

|**Setting name**|**Description**|
|:-----|:-----|:-----|
|Configure Outlook Anywhere (RPC over HTTP) user interface options  |Enable it to let users view and change user interface (UI) options for Outlook Anywhere (RPC over HTTP).  |
|Do not allow an OST file to be created  |Enable it to prevent offline folder use.   |
|Do not create new OST file on upgrade  |Enable it to force Outlook 2016 to use the existing `.ost` file that was created by an earlier version of Outlook. If you disable or do not configure this setting (recommended), a new `.ost` file is created when you upgrade to Outlook 2016.  |
|Synchronizing data in shared folders  |Enable it to control the number of days that elapses without a user accessing an Outlook folder before Outlook stops synchronizing the folder with Exchange.  |

## Related topics

[Planning considerations for deploying Outlook 2016 for Windows](plan-outlook-2016-deployment.md)
