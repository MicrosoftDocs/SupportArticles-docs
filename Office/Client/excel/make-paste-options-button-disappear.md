---
title: Make Paste Options button disappear after you paste
description: Describes how to make Paste Options button disappear after you paste in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# Make Paste Options button disappear after you paste in Excel

## Summary

After you perform a copy-and-paste operation in Microsoft Excel, the Paste Options button is displayed near the paste destination. This step-by-step article explains how to make the Paste Options button disappear and how to prevent options from appearing.

### How to make the Paste Options button disappear

The Paste Options button is displayed until one of the following actions occurs:

- You perform an action that can be undone. This action differs from those that are listed in the Paste Options list.

    > [!NOTE]
    > An action that can be undone is an action that is added to the undo stack. When you click the Undo button, you see the list of actions that can be undone.   
- The Clipboard contents change because you copy information in another Microsoft Office program.   
- You use the Undo command.   
- You type something in the worksheet or document.   

In some situations, you can also press ESC to make the Paste Options button disappear.

> [!NOTE]
> These conditions also apply to the Auto Fill Options and the Insert Options that appear in Excel.

### How to prevent options from appearing

To prevent the paste options, the auto fill options, and the  insert options from appearing, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007

1. Click the **Microsoft Office Button**, and then click **Excel Options**.
2. Click **Advanced**.
3. Under **Cut, copy, and paste**, use one or both of the following procedures:
      - To turn off Paste Options and Auto Fill Options, click to clear the **Show Paste Options buttons** check box.
      - To turn off Insert Options, click to clear the **Show Insert Options buttons** check box.
4. Click **OK**.

#### Microsoft Office Excel 2003 and earlier versions of Excel

1. On the Tools menu, click Options.
2. Click the Edit tab.
3. Use one or both of the following procedures: 
      - To turn off Paste Options and Auto Fill Options, click to clear the **Show Paste Options buttons** check box.   
      - To turn off Insert Options, click to clear the **Show Insert Options buttons** check box.

## References

For more information on Paste Options, see [How to use the Paste Options button in Excel](https://support.microsoft.com/help/291358).
