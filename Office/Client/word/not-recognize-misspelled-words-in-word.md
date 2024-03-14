---
title: Spell Check not working in Word 2010
description: Provides steps to resolve an issue where the spell checker does not catch spelling mistakes in Word 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Word 2010
ms.date: 03/31/2022
---

# Spell Check does not work in Word 2010

## Symptoms

You experience one of the following symptoms in Microsoft Word 2010.

### Symptom 1

Spell Check does not recognize misspelled words.

### Symptom 2

When you select the **Spelling & Grammar** button in the **Proofing** group on the **Review** tab, you receive one of the following messages:

- The spelling and grammar check is complete.
- Proofing Tools are not installed for \<default language\>, try re-installing proofing tools.

## Cause

This issue might occur for any of the following reasons:

- Proofing tools are not installed.
- The speller EN-US (or the equivalent for your language, for example: ES-ES, FR-FR, JA-JP, CH-ZN, etc.) add-in is disabled.
- The **Do not check spelling or grammar** check box is selected.
- Another language is set as default.
- The following subkey exists in the registry:**HKEY_CURRENT_USER\Software\Microsoft\Shared Tools\ProofingTools\1.0\Override\**

## Resolution

To resolve this problem, use the following methods in the given order. If you have previously tried one of these methods, and it did not help to resolve the problem, you can skip that method and proceed to the next one.

### Method 1: Install proofing tools  

To install the proofing tools, follow these steps:

1. Exit all programs.
2. Select **Start**.
3. Follow the appropriate step for your operating system:  
   - In Windows 10, type **uninstall** and then select **Add or remove programs**.
   - In Windows 8.1, type **programs and features** and select **Programs and Features** from the search results.
   - In Windows 7, Select **Control Panel** and then click **Uninstall a program** under **Programs**.


4. Select **Microsoft Office <*Edition*>**, and then select **Change** or **Modify**, depending on your Windows version.

    > [!NOTE]
    > In this step and in the following step, <*Edition*> is a placeholder for the edition of Office that's installed on the computer.
5. In the **Microsoft Office <*Edition*>** dialog box, select **Add or Remove Features**, and then select **Continue**.

    :::image type="content" source="media/not-recognize-mispespelled-words-in-word/add-remove-features.png" alt-text="Screenshot of selecting Add or Remove Features in the Microsoft Office \<Edition> dialog box." border="false":::

6. Expand **Office Shared Features**, select the icon to the left of **Proofing Tools**, and then select **Run all from My Computer**.

    :::image type="content" source="media/not-recognize-mispespelled-words-in-word/run-all-from-my-computer.png" alt-text="Screenshot of Installation Options, expanding Office Shared Features, selecting the icon to the left of Proofing Tools, and then selecting Run all from My Computer." border="false":::

### Method 2: Enable the speller EN-US add-in

To enable the add-in, follow these steps:

1. Select the **File** tab, and then select **Options**.
2. On the left, select **Add-Ins**.
3. At the bottom of the **Word Options** dialog box, select the down arrow under **Manage**, change the selection from **COM Add-ins** to **Disabled items**, and then select **Go**.

   :::image type="content" source="media/not-recognize-mispespelled-words-in-word/disabled-items.png" alt-text="Screenshot of selecting Disabled items in the Manage field.":::

4. In the **Disabled Items** dialog box, check whether **Speller EN-US (nlsdata0009.dll)** is available in the **Select the ones you wish to re-enable** box.
5. If **Speller EN-US (nlsdata0009.dll)** is listed, select it, and then select **Enable**.
6. Select **Close**, and then select **OK**.

### Method 3: Enable "Check spelling as you type"

To enable Spell Check as you type, follow these steps:

1. Select the **File** tab, and then select **Options**.
2. In the **Word Options** dialog box, select **Proofing**.
3. Make sure that the **Check spelling as you type** check box is selected in the **When correcting spelling and grammar in Word** section.

   :::image type="content" source="media/not-recognize-mispespelled-words-in-word/check-spelling.png" alt-text="Screenshot of selecting Check spelling as you type .":::

4. Make sure that all check boxes are cleared in the **Exception for** section.

   :::image type="content" source="media/not-recognize-mispespelled-words-in-word/cleared-boxes.png" alt-text="Screenshot of all check boxes cleared in the Exception for section.":::

5. Select **OK**.

### Method 4: Select language and clear "Do not check spelling or grammar"  

To clear the "Do not check spelling or grammar check box, follow these steps:

1. Select the entire contents of the document.
2. On the **Review** tab, select **Language** in the **Language** group, and then select **Set Proofing Language**.
3. In the **Language** dialog box, select the language that you want.
4. If the **Do not check spelling or grammar** check box is selected, select to clear the check box.

    :::image type="content" source="media/not-recognize-mispespelled-words-in-word/language-window.png" alt-text="Screenshot of the Language dialog box, selecting the language and clearing the Do not check spelling or grammar check box." border="false":::
5. Select **OK**.

    > [!NOTE]
    > If this method fixes the problem, repeat steps 1 through 3 to reopen to the **Language** dialog box, and then select **Set As Default**

### Method 5: Modify the registry  

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs.

To fix this problem yourself, follow these steps:

1. Select **Start** > **Run**.
2. In the **Run** box, enter **regedit**, and then press Enter.
3. Locate and then right-click the following registry subkey:

    **`HKEY_CURRENT_USER\Software\Microsoft\Shared Tools\Proofing Tools\1.0\Override`**
4. Select Registry Editor.
5. Exit and then restart Word.

## More information

If none of the methods in this article resolve the problem, try the following additional method:

Remove and then restore the battery at the bottom of the laptop. If the problem persists, replace the battery.

This problem is reported to occur on only the following Dell laptops:

- Inspiron 1501
- Vostro 1000
