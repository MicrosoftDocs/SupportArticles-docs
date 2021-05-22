---
title: Information about the Outlook AutoComplete list
description: Describes the Outlook AutoComplete list and step-by-step instructions for users to manage the list.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer:
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Outlook 2010
- Microsoft Office Outlook 2007
- Microsoft Office Outlook 2003
search.appverid: MET150
---
# Information about the Outlook AutoComplete list

_Original KB number:_ &nbsp; 2199226

## Summary

This article contains an overview of the Microsoft Outlook AutoComplete list (also known as the Outlook Auto-Complete list). In addition to describing the feature, this article contains more information and step-by-step instructions for advanced users to manage the list.

## More information

Outlook maintains the AutoComplete list. The list is used by both the automatic name-checking feature and the automatic completion feature. The AutoComplete list, also known as the nickname cache, is generated automatically when you send email messages from Outlook. The list contains SMTP addresses, LegacyExchangeDN entries, and display names for people to whom you have sent mail previously.

> [!NOTE]
> The AutoComplete list for Outlook is specific to Outlook and is not shared by Outlook Web App (OWA). OWA maintains its own AutoComplete list.

The following sections provide information about the AutoComplete feature.

### Limit to the number of entries

Outlook limits the number of entries that you can save in the AutoComplete list. After you reach this limit, Outlook uses an internal algorithm to determine the best names to remove from the list. It does this based on a usage weighting. So, you may find some names unexpectedly removed from your nickname cache. There are two general approaches that you can use to avoid this situation:

1. You can proactively remove AutoComplete list entries that you no longer need. This is the preferred approach. For more information about how to do this, see the [How to remove AutoComplete list entries one at a time](#how-to-remove-autocomplete-list-entries-one-at-a-time) section.
2. You can increase the limit for the nickname cache. Because this configuration is untested, we don't recommend it. If you have a larger nickname cache, you could also lose a larger number of cached entries if your nickname cache becomes unusable because of corruption. For more information about how to increase the limit, see the [How to change the limit for the AutoComplete list](#how-to-change-the-limit-for-the-autocomplete-list) section.

The limits are as follows:

- Outlook 2019: 1,000 entries
- Outlook 2016: 1,000 entries
- Outlook 2013: 1,000 entries
- Outlook 2010: 1,000 entries
- Outlook 2007: 2,000 entries
- Outlook 2003: 1,000 entries

### How to enable the AutoComplete feature

This section details how to enable or disable the AutoComplete feature.

#### Outlook 2010, Outlook 2013, Outlook 2016, and Outlook 2019

To access the AutoComplete setting, follow these steps:

1. On the **File**  menu, select **Options**.
2. Select the **Mail** tab.
3. Scroll approximately halfway down until you see **Send messages**. Make sure that the **Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines** box is checked.

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/enable-the-autocomplete-feature.jpg" alt-text="Send messages window, Use Auto-Complete List to suggest names when typing in the To, Cc, and Bcc lines box checked":::

#### Outlook 2003 and Outlook 2007

To access the AutoComplete settings, follow the steps:

1. Select **Tools**, and then select **Options**.
2. Select the **E-mail options** button.
3. Select the **Advanced E-mail Options** button.
4. Make sure that the **Suggest names while completing To, Cc, and Bcc fields**  box is checked. (The screenshot for this step follows.)

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/enable-the-autocomplete-feature-for-outlook-2003-and-2007.jpg" alt-text="Advanced E-mail Options window, Suggest names while completing To, Cc, and Bcc fields checked" border="false":::

### How to import .nk2 files into Outlook 2010, Outlook 2013, Outlook 2016 and Outlook 2019

Microsoft Office Outlook 2007 and earlier versions store the AutoComplete list in a nickname (.nk2) file on the disk. Outlook 2010, Outlook 2013, and Outlook 2016 store the AutoComplete list as a hidden message in your primary message store. Outlook 2010, Outlook 2013, Outlook 2016  and outlook 2019 let you import the older .nk2 files.

For more information about how to import .nk2 files in Outlook 2010, see [Import Auto-Complete List from another computer](https://support.microsoft.com/office/import-or-copy-the-auto-complete-list-to-another-computer-83558574-20dc-4c94-a531-25a42ec8e8f0).

#### How to copy the AutoComplete list

The steps to export and import the AutoComplete list are different, depending on the version of Outlook that you're using.

##### Outlook 2010, Outlook 2013, Outlook 2016 and Outlook 2019

To copy the AutoComplete list in Outlook 2010, Outlook 2013, Outlook 2016 and Outlook 2019 follow these steps:

**Step 1**

To export the AutoComplete mailbox message, follow these steps:

1. Exit Outlook, and then close Outlook Web Access or Outlook Web App (OWA) on all workstations that are connected to your mailbox.
2. Download and install [MFCMAPI](https://github.com/stephenegriffin/mfcmapi).
3. Run mfcmapi.exe.
4. On the **Session** menu, select **Logon**.
5. If you're prompted for a profile, select the desired profile name, and then select **OK**.
6. In the top pane, locate the line that corresponds to your mailbox, and then double-click it.
7. In the left-side navigation pane, expand **Root Container**, and then expand **Top of Information Store** or **IPM_SUBTREE**.
8. Right-click the **Inbox** folder, and then select **Open Associated Content Table**. This action opens a new MFCMAPI window that contains various properties.
9. Under the **Subject** column, right-click the item that has the subject **IPM.Configuration.Autocomplete**, and then select **Export Message**. This action opens the **Save Message To File** window.
10. In the drop-down list, select **MSG file (UNICODE)**, and then select **OK**.
11. Select a folder location to which you want to save the message, and then select **Save**. Note this location.

**Step 2**

To import the AutoComplete mailbox message, follow these steps.

1. Exit Outlook, and then close Outlook Web Access or Outlook Web App (OWA) on all workstations that are connected to your mailbox.
2. Download and install [MFCMAPI](https://github.com/stephenegriffin/mfcmapi).
3. Run mfcmapi.exe.
4. On the **Session** menu, select **Logon**.
5. If you're prompted for a profile, select the desired profile name, and then select **OK**.
6. In the top pane, locate the line that corresponds to your mailbox, and then double-click it.
7. In the left-side navigation pane, expand **Root - Mailbox**, and then expand **Top of Information Store** or **IPM_SUBTREE**.
8. Right-click the **Inbox** folder, and then select **Open Associated Content Table**. This action opens a new MFCMAPI window that contains various properties.
9. To avoid duplicate entries, you must delete the existing AutoComplete message.

    > [!NOTE]
    > Before you delete the **IPM.Configuration.Autocomplete** message, you must export the message by using the steps in the [How to copy the AutoComplete list](#how-to-copy-the-autocomplete-list) section.

    To delete the existing AutoComplete message, follow these steps:

    1. In the **Subject** column, locate the item that has the subject **IPM.Configuration.Autocomplete**.
    2. Right-click the item, and then select **Delete message**. This opens the **Delete Item** window.
    3. In the drop-down list, select **Permanent deletion (deletes to deleted item retention if supported)**, and then select **OK**.

10. On the **Folder** menu, select **Import**, and then select **From MSG**.
11. Locate the .msg file that you created in step 11 of the [How to copy the AutoComplete list](#how-to-copy-the-autocomplete-list) section, and then select **OK**.
12. In the **Load MSG** window that appears, select **Load message into current folder** in the **Load style** list, and then select **OK**.

The AutoComplete information is imported from the IPM.Configuration.Autocomplete_\<hexadecimal code>.msg, where the placeholder \<hexadecimal code> represents a long string of numbers and letters.

##### Outlook 2007 and Outlook 2003

The steps to copy the AutoComplete list in Outlook 2003 and Outlook 2007 are different. This is because Outlook 2003 and Outlook 2007 store the AutoComplete list in the .nk2 file.

To copy the AutoComplete list in Outlook 2007, see [Import or copy the Auto-Complete List to another computer](https://support.microsoft.com/office/import-or-copy-the-auto-complete-list-to-another-computer-83558574-20dc-4c94-a531-25a42ec8e8f0).

#### How to remove AutoComplete list entries one at a time

To remove entries from the AutoComplete cache one entry at a time, follow these steps:

1. Open a new email message.
2. Type the first few characters of the AutoComplete entry that you want to remove.
3. When the entry appears in the list of suggestions, move your mouse pointer over the suggestion until it becomes highlighted, but don't select it.
4. When the X icon appears next to the highlighted suggestion, select **X** to remove the entry from the list, or press the **Delete** key on the keyboard.

Selecting **X** will prevent that entry (name) from appearing in the AutoComplete list again but won't remove it from your account. This entry may still appear in other areas in Outlook (such as search boxes).

> [!NOTE]
> If you send a person a new email after you've removed their name from the AutoComplete list, their information will be added back to the list.

#### How to clear the whole AutoComplete list

This section explains how to delete the AutoComplete list.

##### Outlook 2010, Outlook 2013, Outlook 2016 and Outlook 2019

Use one of the following two methods to delete the AutoComplete list in Outlook 2010, Outlook 2013, and Outlook 2016.

**Method 1**

1. Open Outlook.
2. On the **File** tab, select **Options**.
3. Select the **Mail** tab.
4. Under **Send Messages**, select **Empty Auto-Complete List**.

    :::image type="content" source="media/information-about-the-outlook-autocomplete-list/empty-auto-complete-option.jpg" alt-text="Outlook Options window":::

5. Select **Yes**.

**Method 2**

Start Outlook by using the /CleanAutoCompleteCache switch. To do this, follow these steps:

1. Select **Start**, and then select **Run**.
2. Type *Outlook.exe /CleanAutoCompleteCache*.

> [!NOTE]
> If Outlook is not installed in the default location, you must point to the path of Outlook.exe.

##### Outlook 2007 and Outlook 2003

To delete the AutoComplete list in Outlook 2003 and Outlook 2007, you must manually delete the .nk2 file. To delete the .nk2 file, follow these steps:

1. Exit Outlook.
2. Select **Start**, and then select **Computer**.
3. Select **Organize**, and then select **Folder and search options**.
4. On the **View** tab, select **Show hidden files, folders, and drives**.
5. Select **OK**.
6. Select **Start**, select **All Programs**, select **Accessories,** and then select **Run**.
7. In the **Run** dialog box, type the following command (including the quotation marks), and then select **OK**:

    C:\ Users\\*UserName*\AppData\Roaming\Microsoft\Outlook

    > [!NOTE]
    > *Username* in this path is the name of the currently logged on Windows user.

8. Right-click the .NK2 file that has name of the profile that you want to reset, and then select **Rename**.
9. Rename the file as *profilename*.bak, and then press Enter.
10. Start Outlook.

#### Issues with the AutoComplete cache

This section describes known issues that can occur with the AutoComplete cache. The AutoComplete cache can become corrupted over time and may not save new entries. If this happens, you can try to remove individual entries from the list. To do this, see the [How to remove AutoComplete list entries one at a time](#how-to-remove-autocomplete-list-entries-one-at-a-time) section. If that doesn't resolve the issue, the whole AutoComplete list can be reset. To do this, see the section titled "How to clear the whole AutoComplete list."

### How to change the limit for the AutoComplete list

Because this configuration is untested, we don't recommend it. If you have a larger AutoComplete list, you could also lose a larger number of cached entries if your AutoComplete cache becomes unusable because of corruption. Given this disclaimer, you can use the following registry data to increase the AutoComplete list limit in Outlook.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry,see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Exit Outlook.
2. Start Registry Editor.
   - In Windows 8.x, press the Windows key, type *regedit* and then press **Enter**.
   - In Windows 7 and Windows Vista, select **Start**, type *regedit* in the **Start Search** box, and then press **Enter**.

3. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Outlook\AutoNameCheck`

    > [!NOTE]
    > The placeholder <x.0> in this registry subkey represents your version of Microsoft Office. Use the appropriate value from the following list.
    
    Outlook 2019 = 16.0
    Outlook 2016 = 16.0  
    Outlook 2013 = 15.0  
    Outlook 2010 = 14.0  
    Outlook 2007 = 12.0  
    Outlook 2003 = 11.0

4. On the **Edit** menu, point to **New**, and then select **DWORD value**.
5. Type *MaxNickNames*, and then press **Enter**.
6. On the **Edit** menu, select **Modify**.
7. Type the new value for the limit, and then select **OK**.

    > [!NOTE]
    >
    > - Make sure that you type the number in *decimal form*. That is the correct form in which to type the number.
    > - Try increasing the limit by only a marginal amount to test the new limit. For example, to create a 20 percent increase in the limit in Outlook 2013, you would specify 1200 for the `MaxNickNames` value.

8. Exit Registry Editor.
9. Start Outlook.

> [!NOTE]
> The `MaxNickNames` registry value merely specifies the nondefault limit. Therefore, you can also use this value to lower the limit of the nickname cache.
