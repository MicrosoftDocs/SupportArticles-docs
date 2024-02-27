---
title: The Outlook AutoComplete list
description: Describes the Outlook AutoComplete list and provides instructions to manage the list.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 170727
ms.reviewer: aruiz; meerak
appliesto: 
  - Outlook for Microsoft 365
  - Outlook LTSC 2021    
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# The Outlook AutoComplete list

_Original KB number:_ &nbsp; 2199226

> [!IMPORTANT]
>
> Exchange Online provides some search features through Microsoft Search. Beginning in Outlook for Microsoft 365 Version 2202 (Build 14931.20604), if you’re connected to an Exchange Online mailbox, the suggestions list for the To/Cc/Bcc lines when you compose a message is powered by Microsoft Search. In this specific scenario, only two sections of this article apply: “Enable the AutoComplete feature” and “Remove AutoComplete list entries one at a time.”

Microsoft Outlook maintains the AutoComplete list. The list is used by both the automatic name-checking feature and the automatic completion feature. The AutoComplete list, also known as the *nickname cache*, is generated automatically when you send email messages from Outlook. The list contains SMTP addresses, LegacyExchangeDN entries, and display names for people to whom you have sent mail previously.

**Note**: The AutoComplete list for Outlook is specific to Outlook and is not shared with Outlook on the web. This app maintains its own AutoComplete list.

## Limited number of entries

Outlook limits the number of entries that you can save in the AutoComplete list. After you reach this limit, Outlook uses an internal algorithm to determine the best names to remove from the list. It does this based on the process of *usage weighting*. Therefore, you might find that some names are unexpectedly removed from your nickname cache. To avoid this situation, you can use the following general approaches:

1. You can proactively remove AutoComplete list entries that you no longer need. This is the preferred approach. For information about how to do this, see [Remove AutoComplete list entries one at a time](#remove-autocomplete-list-entries-one-at-a-time).
2. You can increase the limit for the nickname cache. Because this configuration is untested, we don't recommend it. If a large nickname cache becomes corrupted, it will be unusable and you could lose many cached entries. For information about how to increase the limit, see [Change the limit for the AutoComplete list](#change-the-limit-for-the-autocomplete-list).

The limits are as follows:

- Outlook 2019: 1,000 entries
- Outlook 2016: 1,000 entries
- Outlook 2013: 1,000 entries
- Outlook 2010: 1,000 entries

## Enable the AutoComplete feature

To access the AutoComplete setting, follow these steps:

1. On the **File**  menu, select **Options**.
2. Select the **Mail** tab.
3. Scroll approximately halfway down until you see **Send messages**. Make sure that the **Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines** box is checked.

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/use-auto-complete-list-to-suggest-names.png" alt-text="Screenshot of Send messages window, and the option Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines box is checked.":::

## Copy the AutoComplete list

Microsoft Office Outlook 2007 and earlier versions store the AutoComplete list in a nickname (.nk2) file on the disk. Outlook 2021, 2019, 2016, 2013, and 2010 store the AutoComplete list as a hidden message in your primary message store. They also let the older .nk2 files be imported.

For the detailed steps to copy the AutoComplete list, and copy and import an .nk2 file, see [Import or copy the AutoComplete list to another computer](https://support.microsoft.com/office/import-or-copy-the-auto-complete-list-to-another-computer-83558574-20dc-4c94-a531-25a42ec8e8f0).

## Remove AutoComplete list entries one at a time

Follow these steps:

1. Open a new email message.
2. Type the first few characters of the AutoComplete entry that you want to remove.
3. When the entry appears in the list of suggestions, move your mouse pointer over the suggestion until it becomes highlighted, but don't select it.
4. When the X icon appears next to the highlighted suggestion, select **X** to remove the entry from the list, or press the **Delete** key on the keyboard.

Selecting **X** will prevent that name entry from appearing in the AutoComplete list again but won't remove it from your account. This entry may still appear in other areas in Outlook (such as search boxes).

**Note**: If you send a person a new email after you've removed their name from the AutoComplete list, their information will be restored to the list.

## Clear the AutoComplete list

Use one of the following two methods to delete the AutoComplete list.

**Method 1**

1. Open Outlook.
2. On the **File** tab, select **Options**.
3. Select the **Mail** tab.
4. Under **Send Messages**, select **Empty Auto-Complete List**.

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/empty-auto-complete-option.png" alt-text="Screenshot of the Outlook Options window that shows the Empty Auto-Complete List button.":::

5. Select **Yes**.

**Method 2**

Start Outlook by using the /CleanAutoCompleteCache switch.

1. Select **Start**, and then select **Run**.
2. Type *Outlook.exe /CleanAutoCompleteCache*.

**Note**: If Outlook is not installed in the default location, you must point to the path of Outlook.exe.

## Known issues in the AutoComplete cache

The AutoComplete cache can become corrupted over time and might not save new entries. If this occurs, you can try to  [remove AutoComplete list entries one at a time](#remove-autocomplete-list-entries-one-at-a-time). If that doesn't resolve the issue, [clear the  AutoComplete list](#clear-the-autocomplete-list)."

## Change the limit for the AutoComplete list

Because this configuration is untested, we don’t recommend it. If a large nickname cache becomes corrupted, it will be unusable and you could lose many cached entries. Use this information with caution.

> [!IMPORTANT]
>
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry,see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Exit Outlook.
2. Start Registry Editor.
   - In Windows 8.*x*, press the Windows logo key, type *regedit* and then press **Enter**.
   - In Windows 7 and Windows Vista, select **Start**, type *regedit* in the **Start Search** box, and then press **Enter**.

3. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\AutoNameCheck`

    **Note**:
    The placeholder <x.0> in this registry subkey represents your version of Microsoft Office. Use the appropriate value from the following list.
    >
    > - Outlook 2021 = 16.0
    > - Outlook 2019 = 16.0
    > - Outlook 2016 = 16.0  
    > - Outlook 2013 = 15.0  
    > - Outlook 2010 = 14.0  
  
4. On the **Edit** menu, point to **New**, and then select **DWORD value**.
5. Type *MaxNickNames*, and then press **Enter**.
6. On the **Edit** menu, select **Modify**.
7. Type the new value for the limit, and then select **OK**.

    **Note**:
    >
    > - Make sure that you type the number in *decimal form*. That is the correct form in which to type the number.
    > - To test the new limit, try to increase the limit by only a small amount. For example, to create a 20 percent increase in the limit in Outlook 2013, you would specify *1200* for the `MaxNickNames` value.

8. Exit Registry Editor.
9. Start Outlook.

**Note**:
The `MaxNickNames` registry value specifies only the nondefault limit. Therefore, you can also use this value to lower the limit of the nickname cache.
