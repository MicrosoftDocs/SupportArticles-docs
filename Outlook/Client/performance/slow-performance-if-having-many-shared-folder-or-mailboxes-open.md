---
title: Slow performance if many shared folders or mailboxes open
description: Describes an issue in Outlook where performance is slow or an error appears when making changes in the calendar when you have many shared folders or mailboxes open.  Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook performance issues when you have many shared folders or mailboxes open

_Original KB number:_ &nbsp; 3136059

## Symptoms

When you start Microsoft Outlook, switch folders, or synchronize email, you may experience slow performance. Additionally, when you make changes or additions to a calendar, you may receive the following error message:

> You don't have permission to create an entry in this folder. Right-click the folder, then click Properties to check your permissions for the folder. See the folder owner or your administrator to change your permissions.

## Cause

You have many shared folders or mailboxes, or both, open in Outlook. In the case with a shared calendar, modifications or additions cannot be made until the program is finished syncing updates.

The number of shared folders and mailboxes that you can have open without issues depends on several factors, including hardware, mailbox size, size of the shared folders or mailboxes, number of folders in a shared mailbox, item count in folders, and network speed. A computer that has slower hardware, a large mailbox, and slow network connection may not be able to open more than five shared folders or mailboxes. However, a faster computer that has a smaller mailbox and a fast network connection may be able to open 10 or more shared folders or mailboxes.

## Resolution

Reduce the number of shared folders or mailboxes that you have open in Outlook. To do this, you must first determine whether you have shared folders or shared mailboxes open. If you have shared mailboxes open, you must also determine how they are opened, such as being opened manually as an additional mailbox or being opened because of AutoMapping.

A shared mailbox appears below your own mailbox in the Folder Pane, as shown in the following screenshot.

:::image type="content" source="media/slow-performance-if-having-many-shared-folder-or-mailboxes-open/example-of-shared-mailbox.png" alt-text="Screenshot showing a shared mailbox in the Folder Pane." border="false":::

A shared folder appears below Shared *\<Folder type>*, such as Shared Calendar or Shared Contacts, as shown in the following screenshot.

:::image type="content" source="media/slow-performance-if-having-many-shared-folder-or-mailboxes-open/different-types-of-shared-folders.png" alt-text="Screenshot showing shared folders of different types.":::

### Remove a shared mailbox

If you have a shared mailbox open in Outlook, it was either manually added under Open these additional mailboxes or it was opened automatically because of automapping. You can determine how the shared mailbox was opened and remove the shared mailbox by following the steps in the following sections.

### Remove a shared mailbox that was opened as an additional mailbox manually

1. Select **File**, **Account Settings**, and then select **Account Settings**.
2. Select the Microsoft Exchange account, and then select **Change**.
3. Select **More Settings**.
4. On the **Advanced** tab, you can view any manually added shared mailboxes below **Open these additional mailboxes**.
5. Select the shared mailbox, and then select **Remove**.
6. Select **Yes** to confirm that you want to remove the mailbox, and then select **OK**.
7. Select **Next**, and then select **Finish**.
8. Select **Close** on the Account Settings window.

> [!NOTE]
> If the shared mailbox does not appear below **Open these additional mailboxes**, it is likely Automapped. To determine whether this is the case, and to remove the automapped mailbox from Outlook, follow these steps.

Run the Test E-mail AutoConfiguration tool to determine whether any automapped mailboxes exist:

1. Hold the Ctrl key, and then right-click the Outlook icon in the notification area.
2. Select **Test E-mail AutoConfiguration**.
3. Enter your email address and password.
4. Clear the **Use Guessmart** and **Secure Guessmart Authentication** options.
5. Select **Test**.
6. When the test is complete, select the **XML** tab.
7. Scroll down until you see the \<AlternativeMailbox> section, and then look for \<Type>Delegate\</Type> in the script, as shown in the following screenshot.

   :::image type="content" source="media/slow-performance-if-having-many-shared-folder-or-mailboxes-open/test-e-mail-autoconfiguration-dialog.png" alt-text="Screenshot showing the Test E-mail AutoConfiguration dialog with an automapped mailbox." border="false":::

To remove an automapped mailbox from Outlook, use one of the following options:

1. Remove your Full Access permissions from the mailbox. This is a good option if you no longer require access to the shared mailbox.

   [Manage Full Access Permissions](/previous-versions/office/exchange-server-2010/bb676551(v=exchg.141))
2. Remove AutoMapping for the shared mailbox. This is a good option if you must have access to the shared mailbox, but do not want it AutoMapped in Outlook automatically.

   - [Disable Outlook Auto-Mapping with Full Access Mailboxes](/previous-versions/office/exchange-server-2010/hh529943(v=exchg.141))
   - [How to remove automapping for a shared mailbox in Outlook for Microsoft 365](/outlook/troubleshoot/profiles-and-accounts/remove-automapping-for-shared-mailbox)

### Remove shared Calendar, Contacts, Tasks, or Notes folders

1. Open Outlook.
2. Select the **Calendar, Contacts, Tasks or Notes** folder in the **Navigation** pane in which you have a shared folder open.
3. Look under Shared \<Folder name> for any shared folders, as shown in the following screenshot.

   :::image type="content" source="media/slow-performance-if-having-many-shared-folder-or-mailboxes-open/different-types-of-shared-folders.png" alt-text="Screenshot showing shared folders of different types.":::

4. Right-click the shared folder, and then select **Delete Folder** or **Delete Calendar**, depending on the folder type. The following screenshot shows a shared Calendar being removed.

   :::image type="content" source="media/slow-performance-if-having-many-shared-folder-or-mailboxes-open/remove-shared-calendar-folder.png" alt-text="Screenshot showing how to remove a shared calendar folder." border="false":::

    > [!NOTE]
    > Selecting **Delete Calendar** or **Delete Folder** on a Shared Calendar or Shared Folder does not delete the folder from the mailbox where it resides. This action removes the folder from your Outlook view Delete Folder only.

Follow steps 2 through 4 for any remaining shared folders that you want to remove from Outlook.

### Close a Shared Inbox Folder

When you open a shared Inbox folder, it appears in Outlook only until you select a different folder. It does not remain in the Folder list. To remove a shared Inbox folder, close it by selecting a different folder in your Mailbox.

## More information

Many of the items that are discussed in this article can be automatically checked by the Microsoft Support and Recovery Assistant (SaRA). Start the automated checks by running the [Outlook Advanced Diagnostics](https://aka.ms/SaRA-OutlookAdvDiagnostics) scenario. Select **Run** when you are prompted by your browser. In the report that's generated, review the items on the **Issues found** tab. For details about the Outlook, Windows, and computer configuration, review the settings on the **Detailed View** tab.
