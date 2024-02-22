---
title: Junk email settings aren't synchronized
description: Describes an issue in which junk email message settings are not synchronized between Outlook 2013 and Outlook.com. This issue occurs when you use Outlook 2013 to connect to an Outlook.com account.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz, v-matham
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
ms.date: 10/30/2023
---
# Junk email message settings aren't synchronized when you use Outlook 2013 to connect to an Outlook.com account

_Original KB number:_ &nbsp; 2861826

## Symptoms

When you use Outlook 2013 to connect to an `Outlook.com` account, the junk email message settings aren't synchronized between Outlook 2013 and `Outlook.com`.

> [!NOTE]
>
> - The junk email message settings include the **Safe Senders** and **Blocked Senders** lists.
> - `Outlook.com` accounts include `Hotmail.c`om, `Msn.com`, and `Live.com` accounts.

## Cause

This issue occurs because Outlook 2013 uses Exchange ActiveSync (EAS) to connect to the `Outlook.com` account. However, the EAS protocol does not support the synchronization of the **Safe Senders** and **Blocked Senders** lists in the Junk E-mail Options dialog box.

There are several options that you can use to manage the junk email message settings on `Outlook.com`. To work around the issue that's described in the [Symptoms](#symptoms) section, use one of the following workarounds.

## Workaround 1: Block or enable senders on Outlook.com

Instead of configuring the **Safe Senders** and **Blocked Senders** lists on each Outlook 2013 client that you use, you can configure the **Safe senders** and **Blocked senders** lists on `Outlook.com`.

If you block or enable senders on `Outlook.com`, the **Safe Senders** and **Blocked Senders** lists in the Outlook 2013 clients are not updated. However, email messages are processed by the `Outlook.com` service. Therefore, if an email message is blocked by the `Outlook.com` service, the email message is not delivered to the Outlook 2013 clients.

To use this workaround, add the information from the **Safe Senders** and **Blocked Senders** lists in each Outlook 2013 client that you use to the **Safe senders** and **Blocked senders**  lists on the **Options**  webpage on `Outlook.com`. To access the **Options** webpage, click **More mail settings** on `Outlook.com`. Then, remove the lists from each Outlook 2013 client. If you want to back up the lists before you remove them, click the **Export to File** button in the **Junk E-mail Options** dialog box in Outlook 2013.

## Workaround 2: Manually add or remove email messages

If you manually move an email message to, or remove an email message from, the **Junk E-Mail** folder in an Outlook 2013 client, the email message is also moved on `Outlook.com`. Similarly, if you move an email message to or remove an email message from the **Junk** folder on `Outlook.com`, the email message is also moved in Outlook 2013. When you manually move an email message to or remove an email message from the junk email message folders, the `Outlook.com` service uses this information to improve its junk email message criteria.

## Workaround 3: Block or enable senders in Outlook 2013

If you use the **Safe Senders** and **Blocked Senders** lists on an Outlook 2013 client, the lists are maintained only on that client. If the Outlook 2013 client blocks an email message according to the **Blocked Senders** list, the email message is moved to the **Junk E-Mail** folder on the Outlook 2013 client. When the Outlook 2013 client is synchronized with `Outlook.com`, the email message is also moved to the **Junk** folder on `Outlook.com`. However, the **Blocked senders** list on `Outlook.com` is not updated to include the sender of the blocked email message.

## More information

Because Outlook 2007 and Outlook 2010 use Outlook Hotmail Connector to connect to `Outlook.com` accounts, this issue only occurs in Outlook 2013.
