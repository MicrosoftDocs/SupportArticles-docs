---
title: Status bar has an upper limit of 3.99 GB
description: Status bar progress never shows more than 3.99 GB on initial Sync of large folders in Microsoft Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans, PhilClod
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Exchange Online
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Status bar progress never shows more than 3.99 GB remaining on initial Sync of large folders

_Original KB number:_ &nbsp; 2738323

## Symptoms

When you synchronize your Exchange mailbox to an Offline Folder file (`.ost`), the Outlook status bar never shows higher than 3.99 GB when a folder is being updated. For example, you may see the following text in the status bar when your Inbox folder is being synchronized with Exchange.

> Updating Inbox 3.99 GB

If the status bar indicates a value less than 3.99 GB and you either switch away to another folder or you exit and restart Outlook, the status bar may go back to displaying the above text when you return to the same folder.

If you then allow the synchronization process to fully synchronize the folder, the status bar may eventually indicate the following text.

> Updating Inbox (1 B).

## Cause

The value shown in the status bar has an upper limit of 3.99 GB, so this problem occurs when the size of the folder being synchronized is above 4 GB.

## Resolution

To resolve this problem you have several options.

1. Do nothing

    Since this problem only occurs during the initial synchronization of the `.ost` file, if you wait for the synchronization to fully finish, the problem should eventually go away.

    If you elect to do nothing, the time to fully synchronize a large folder may take longer than anticipated. If the time to synchronize the large folder is taking longer than desired or if it never fully synchronizes, consider using one of the following two methods.

2. Reduce the size of the folder contents

    Another option is to reduce the size of larger folders by either archiving items or moving them to other (smaller) folders in your mailbox. The best way to clean up your mailbox in this situation is to use either an Online mode profile, Outlook Web Access (OWA), or Outlook Web App (OWA) to reduce the size of a folder.

    You can use the following steps to determine the size of a folder in your Exchange mailbox.

      1. Right-click the folder in the **Navigation Pane** and then select **Properties**.
      2. On the **General** tab, select **Folder Size**.
      3. In the **Folder Size** dialog box, select the **Server Data** tab.

    The size of the folder is shown as well as the size of any subfolders.

3. Create a synchronization filter for large folders at or near 4 GB

    You can instead create a synchronization folder that limits the number of items that are synchronized from your Exchange mailbox to the `.ost` file. The criteria used for the synchronization folder should be written to ensure the amount of data to synchronize is less than 4 GB. For example, the following steps show how to create a synchronization filter that causes Outlook to only synchronize items received in the last six months.

      1. Right-click the folder in the Navigation Pane and then select **Properties**.
      2. On the **Synchronization** tab, select **Filter**.
      3. On the **Advanced** tab of the **Filter** dialog box, select **Field**, point to Date/Time fields and then select **Received**.
      4. In the **Condition** box, select **on or after**.
      5. In the **Value** box, enter *6 months ago*.

            The following figure shows the example criteria in the **Filter** dialog box.

            :::image type="content" source="media/status-bar-never-shows-more-than-3-99-gb/criteria-in-filter.png" alt-text="Screenshot for the Advanced tab of the Filter dialog box." border="false":::

            > [!NOTE]
            > You can use other descriptive text in the Value box for your criteria. For example, you can use *1 year ago* to filter on mail that was received within the past year.

      6. Select **Add to List**, and then select **OK**.
      7. Note the information provided in the prompt advising you what events will take place with the filter applied to the folder, and then select **OK** (The screenshot for this step is listed below).

         :::image type="content" source="media/status-bar-never-shows-more-than-3-99-gb/information.png" alt-text="Screenshot of the Microsoft Outlook prompt." border="false":::

      8. Select **OK** in the **Properties** dialog box for the folder.

When Outlook performs the next synchronization of the folder, the following actions will occur due to the synchronization filter:

- Any new or modified items will be synchronized with the folder.
- All items matching the filter criteria will be synchronized to the folder in the `.ost` file.
- Any items in the folder that do not meet the synchronization filter criteria will be removed from the `.ost` file (they will, however, remain in your mailbox on the Exchange server).

## More information

This problem should only occur on the initial synchronization of a folder that is larger than 4 GB. If the folder size is initially lower than 4 GB but then grows to above 4 GB over time, you will not see this problem through normal folder synchronization. The status bar indicates the amount of data being currently synchronized to the folder, so for existing folders above 4 GB, the incremental changes will be relatively small in day-to-day use.
