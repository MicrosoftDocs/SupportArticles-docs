---
title: Emails sent to wrong account if profile has many accounts
description: Describes an issue in which email messages aren't sent to the correct account when a profile has multiple accounts associated with it in Outlook. This issue occurs in a Microsoft 365 environment. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Email messages are sent to the wrong account when multiple accounts are associated with an Outlook profile

_Original KB number:_ &nbsp; 2391896

## Symptoms

When you set up one or more email accounts for a profile in Microsoft Outlook, email messages that are intended for a particular account are sent to the Inbox of a different account.

This issue occurs if the `.ost` file that's created by Outlook Cached Exchange Mode contains a folder mapping error. Specifically, if the `.ost` file contains more than one MAPI mailbox, mail may be redirected to an incorrect MAPI mailbox.

## Resolution

To fix this issue, follow these steps:

1. In Outlook, drag all the incorrectly sent messages to the correct folders.

2. Remove the secondary account to which the messages were incorrectly redirected by Outlook. To do this, follow these steps:
      1. Select **Start**, and then select **Control Panel**.
      2. On the search bar, type *mail*.
      3. Double-click **Mail**.
      4. In the **Mail Setup** dialog box, select **E-mail Accounts**.
      5. In the **Account Settings** dialog box, select the account that you want to remove, and then select **Remove**.
      6. Select **Close**.

3. Exit Outlook.
4. If you're running Outlook 2007, you can run the ScanOST.exe process against the updated `.ost` file to help repair any errors. For more information, see [Repair Outlook Data Files (.pst and .ost)](https://support.microsoft.com/office/repair-outlook-data-files-pst-and-ost-25663bc3-11ec-4412-86c4-60458afc5253).

5. If you're running Outlook 2010, redownload the `.ost` file from the server.
6. Readd the secondary MAPI account to the profile. To do this, follow these steps:
      1. Select **Start**, and then select **Control Panel**.
      2. On the search bar, type *mail*.
      3. Double-click **Mail**.
      4. In the **Mail Setup** dialog box, select **E-mail Accounts**.
      5. In the **Account Settings** dialog box, select **New**, and then follow the steps to readd the secondary account.
7. Send a test message to confirm that the account is set up correctly.
8. Monitor the account to confirm that the `.ost` file is successfully repaired.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
