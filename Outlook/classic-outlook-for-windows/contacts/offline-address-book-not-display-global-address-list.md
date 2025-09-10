---
title: Offline Address Book Does Not Display The Global Address List By Default
description: Fixes an issue in which Offline Address Book does not display the Global Address List by default in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 07/14/2025
---
# The Offline Address Book (OAB) does not display the Global Address List by default

_Original KB number:_ &nbsp; 2665915

## Symptoms

When Microsoft Outlook is configured in Cached Exchange mode and you open the Address Book, the global address list (GAL) isn't displayed by default. Instead, another address list such as **\All Users** is displayed, and the GAL must be manually selected from the **When opening the address book, show this address list first** Address Book option. This is demonstrated in the following figure:

:::image type="content" source="media/offline-address-book-not-display-global-address-list/address-book-option.jpg" alt-text="Screenshot that shows Address Book option.":::

You may also receive an error message that resembles the following error in a synchronization log message when you try to download the Offline Address Book (OAB):

> Microsoft Exchange offline address book  
Not downloading Offline address book files. A server (URL) could not be located  
0X80004005

In the situation where you can't download the OAB, you'll find the following event in the Application event log.

> Source: Outlook  
Event ID: 27  
Description: The operation failed.

## Cause

This behavior may occur if multiple address lists are included as part of the Offline Address Book (OAB) generation on the server that is running Microsoft Exchange Server.

This can also occur in Outlook when the **When opening the address book, show this address list first** option is set to **Choose automatically**.

When multiple address lists are included in the OAB, each address list is built as an OAB and is available for download to the Outlook clients. In this scenario, when Outlook receives the list of available OABs, it doesn't necessarily download the one for the GAL by default.

## Resolution

To resolve this issue, set the GAL as the only address list for which an OAB is generated on the Exchange server. To do this, follow these steps:

1. Open the Exchange Management Console.

1. Expand **Organization Configuration**.

1. Select **Mailbox**.

1. Select **Offline Address Book**.

1. Right-click the default OAB, and then select **Properties**.

1. Select **Address Lists**.

1. Select to clear the **Include the following address lists** check box.

    :::image type="content" source="media/offline-address-book-not-display-global-address-list/include-the-following-address-lists.jpg" alt-text="Screenshot that shows the Include the following address lists check box.":::

1. Select **OK** to save the changes.

After you make this change on the Exchange server, any new Outlook profiles that you create will use the OAB with the GAL by default.

> [!NOTE]
> The Microsoft Exchange server generates updated offline address book files at a 24-hour interval. Therefore, at worst it can take 24 hours for a new Outlook profile not to exhibit the problems described in the "Symptoms" section.

## Workaround

For existing Outlook profiles, you can manually change the OAB that is downloaded to the one that is built from the GAL by following these steps for your version of Outlook.

- Outlook 2010 and later versions

    1. On the **Send/Receive** tab, select **Send/Receive Groups** and then select **Download Address Book**.

    1. In the **Choose address book** drop-down, select **\Global Address List**.

    1. Select **OK**.

- Outlook 2007

    1. On the Tools menu, point to Send/Receive, and then select Download Address Book.

    1. In the **Choose address book** drop-down, select **\Global Address List**.

    1. Select **OK**.

> [!NOTE]
> The Microsoft Exchange server generates updated offline address book files at a 24-hour interval. Additionally, Outlook clients automatically download offline address book updates every 24 hours. Therefore, if Outlook is left running until the automatic OAB download occurs, it can potentially take up to 48 hours before the problems described in the "Symptoms" section are resolved. You can circumvent the Outlook interval by manually downloading the OAB. However, you must still account for the Exchange OAB generation that can be delayed by up to 24 hours.

## More Information

In Outlook 2010 and later versions, the **Choose automatically** option is the default option for compatibility with the multiple Exchange accounts feature. In configurations in which multiple Exchange accounts are configured, the **Choose automatically** option lets the correct GAL be displayed for the selected Exchange account.

1. To set the default address list when you open the Address Book in Outlook 2010, follow these steps:

1. Open the Address Book by clicking the ribbon icon.

1. On the **Tools** menu, select **Options**.

In the **When opening the address book, show this address list first** drop-down list, select the default address book.
