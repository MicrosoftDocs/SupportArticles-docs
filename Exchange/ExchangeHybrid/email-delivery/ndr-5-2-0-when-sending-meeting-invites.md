---
title: NDR 5.2.0 when sending meeting invites
description: How to fix non-delivery report users get when sending meeting invites after a delegate or manager's mailbox is moved to a new forest.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Users receive NDR 5.2.0 when they send meeting invites in Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 4038474

## Symptoms

After a delegate's or manager's mailbox is moved to a new forest in Microsoft 365, users receive the following non-delivery report (NDR) when they send meeting invites to the manager:

> Remote Server returned '554 5.2.0 STOREDRV.Deliver.Exception:DelegateUserValidationException; Failed to process message due to a permanent exception with message Delegate user validation failed for user:DelegateName. DelegateUserValidationException: Delegate user validation failed for user:DelegateName. [Stage: OnCreatedEvent[Agent: Meeting Message Processing Agent]'

## Cause

The delegate's old value for the `legacyExchangeDN` attribute is stored on the local free/busy object in the manager's mailbox.

## Resolution

The manager should readd the delegate after making sure that there are no cached references to the delegate's original object. To do this, follow these steps:

1. Remove all delegates from the **Delegates** dialog box in Outlook.

    :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/remove-delegates.png" alt-text="A screenshot of the dialog to remove delegates.":::

    > [!NOTE]
    > Before you move on to the next steps, confirm whether the issue is now resolved. If users continue to receive an NDR when they send meeting invites to the manager, continue through the remaining steps to make sure that all cached delegate information is removed from the mailbox.

2. Sign in to the mailbox through Outlook Web App (OWA), and then confirm  that all delegates are removed. Follow these steps to check delegates in OWA:

   1. Sign in to the mailbox through OWA.
   2. Open the calendar.
   3. Select **Share** from the menu at the top.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/share-button.png" alt-text="A screenshot of the Share button on the Outlook page.":::

   4. Select the trash can icon to remove any delegates.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/dumpster-icon.png" alt-text="A screenshot of the dumpster icon on the Share this calendar page.":::

3. Remove any auto-complete entries for the delegates. To do this, follow these steps:

   1. Start a new mail message.
   2. Type the delegate's name.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/type-delegate-name.png" alt-text="A screenshot of removing any auto-complete entries page.":::

   3. Highlight the entry in the pop-up window, and then select the **X** to delete the entry.

4. Force the Offline Address Book (OAB) to download. This should happen automatically every 24 hours, but it's important to have the most recent version to make sure that the correct delegate information is stored in the manager's mailbox.

   1. On the **Send/Receive** menu, select **Send/Receive Groups**, and then select **Download Address Book**.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/send-receive-groups-page.png" alt-text="A screenshot of the Send/Receive menu page.":::

   2. Select **OK**.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/offline-address-book.png" alt-text="A screenshot of the OK page.":::

      A progress bar is displayed when the OAB is downloading. Depending on the size of the file and the network connection, this process might take several minutes to complete.

      :::image type="content" source="media/ndr-5-2-0-when-sending-meeting-invites/process-bar.png" alt-text="A screenshot of the progress bar" border="false":::

After these steps are complete, add a new delegate, and then confirm that new meeting invites are delivered to the manager successfully.
