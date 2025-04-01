---
title: The Outlook AutoComplete list
description: Describes the Outlook AutoComplete list and provides instructions to manage it.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:People or Contacts\Nickname cache
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 170727
ms.reviewer: aruiz; meerak
appliesto: 
  - Outlook for Microsoft 365
  - Outlook LTSC 2021    
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 04/01/2025
---
# The Outlook AutoComplete list

_Original KB number:_ &nbsp; 2199226

> [!IMPORTANT]
>
> Exchange Online provides some search features through Microsoft Search. Beginning in Outlook for Microsoft 365 Version 2202 (Build 14931.20604), if you’re connected to an Exchange Online mailbox, the suggestions list for the To/Cc/Bcc lines when you compose a message is powered by Microsoft Search. In this specific scenario, only two sections of the article apply: "Enable the AutoComplete feature" and "Remove AutoComplete list entries one at a time."

Microsoft Outlook maintains the AutoComplete list. The list is used by both the automatic name-checking feature and the automatic completion feature. The AutoComplete list, also known as the *nickname cache*, is generated automatically when you send email messages from Outlook. The list contains SMTP addresses, LegacyExchangeDN entries, and display names for people you sent mail to previously.

**Note**: The AutoComplete list for Outlook is specific to Outlook. It isn't shared with Outlook on the web, which maintains its own AutoComplete list.

## Limited number of entries

Outlook limits the number of entries that you can save in the AutoComplete list. After you reach the limit, Outlook uses an internal algorithm based on *usage weighting* to determine the best names to remove from the list. Therefore, you might find that some names are unexpectedly removed from your nickname cache. To avoid such a situation, you can use the following general approaches:

1. You can proactively [remove AutoComplete list entries](#remove-autocomplete-list-entries-one-at-a-time) that you no longer need. This method is the preferred approach.
2. You can [increase the limit for the nickname cache](#change-the-limit-for-the-autocomplete-list). Because this type of configuration is untested, we don't recommend it. When a large nickname cache becomes corrupted, it's unusable and you could lose many cached entries.

The limits are as follows:

- Outlook 2019: 1,000 entries
- Outlook 2016: 1,000 entries

## Enable the AutoComplete feature

To access the AutoComplete setting, follow these steps:

1. On the **File**  menu, select **Options**.
2. Select the **Mail** tab.
3. Scroll down until you see **Send messages**. Make sure that the **Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines** box is checked.

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/use-auto-complete-list-to-suggest-names.png" alt-text="Screenshot of Send messages window, with the Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines option checked.":::

## Copy the AutoComplete list

Microsoft Office Outlook 2007 and earlier versions store the AutoComplete list in a nickname (.nk2) file on the disk. Outlook 2021, Outlook 2019, Outlook 2016, Outlook 2013, and Outlook 2010 store the AutoComplete list as a hidden message in your primary message store. They also allow the older .nk2 files be imported.

For the detailed steps to copy the AutoComplete list, and copy and import an .nk2 file, see [Import or copy the AutoComplete list to another computer](https://support.microsoft.com/office/import-or-copy-the-auto-complete-list-to-another-computer-83558574-20dc-4c94-a531-25a42ec8e8f0).

## Remove AutoComplete list entries one at a time

Follow these steps:

1. Open a new email message.
2. Type the first few characters of the AutoComplete entry that you want to remove.
3. When the entry appears in the list of suggestions, move your mouse pointer over the suggestion until it becomes highlighted, but don't select it.
4. When the X icon appears next to the highlighted suggestion, select **X** to remove the entry from the list, or press the DELETE key on the keyboard.

Selecting **X** prevents the name entry from appearing in the AutoComplete list again but doesn't remove it from your account. The entry might still appear in other areas in Outlook, such as search boxes.

**Note**: If you send a contact a new email after you remove their name from the AutoComplete list, their information will be restored to the list.

## Clear the AutoComplete list

To delete the AutoComplete list, use one of the following methods.

**Method 1**

1. Open Outlook.
2. On the **File** tab, select **Options**.
3. Select the **Mail** tab.
4. Under **Send Messages**, select **Empty Auto-Complete List**.
5. When you're prompted, select **Yes**.

**Method 2**

Start Outlook by using the /CleanAutoCompleteCache switch.

1. Select **Start**, and then select **Run**.
2. Type *Outlook.exe /CleanAutoCompleteCache*.

**Note**: If Outlook isn't installed in the default location, you must point to the path of Outlook.exe.

## Known issue in the AutoComplete cache

The AutoComplete cache can become corrupted over time and might not save new entries. To resolve the issue, you can try to [remove AutoComplete list entries one at a time](#remove-autocomplete-list-entries-one-at-a-time). If that doesn't resolve the issue, [clear the  AutoComplete list](#clear-the-autocomplete-list)."

## Change the limit for the AutoComplete list

Because this configuration is untested, we don’t recommend it. When a large nickname cache becomes corrupted, it's unusable and you can lose many cached entries. Use this information with caution.

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

1. Exit Outlook.
2. Start Registry Editor.
3. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\<16.0>\Outlook\AutoNameCheck`
4. On the **Edit** menu, point to **New**, and then select **DWORD value**.
5. Type *MaxNickNames*, and then press **Enter**.
6. On the **Edit** menu, select **Modify**.
7. Type the new value for the limit, and then select **OK**.

    **Note**:
    >
    > - Specify the new value in *decimal form*. That is the correct form for the value.
    > - Increase the limit by only a small amount. For example, to create a 20 percent increase in the limit for Outlook 2016, specify *1200* as the value for the `MaxNickNames`entry.

8. Exit Registry Editor.
9. Start Outlook.

**Note**:
The value of the `MaxNickNames` registry entry specifies only the nondefault limit. Therefore, you can also use this value to lower the limit of the nickname cache.
