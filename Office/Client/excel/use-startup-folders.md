---
title: How to use startup folders in Excel
description: Provides step-by-step instructions for using startup folders in Excel.
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
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# Use startup folders in Excel

For information about Excel 2010, Excel for Mac 2011, and later versions, see the following articles:

- [Customize how Excel starts](https://support.microsoft.com/office/6509b9af-2cc8-4fb6-9ef5-cf5f1d292c19)
- [Customize how Excel starts in Excel for Mac](https://support.microsoft.com/help/259921).

## Summary

This step-by-step article describes how to use the Microsoft Excel startup folders. Excel uses startup folders in two ways:

- To load Excel workbooks at startup.
- As a reference location for templates.

The actual startup folder locations vary, depending on which version of Excel you use.

### Folders that Excel uses at startup

If you install Excel in the default location, Excel opens files from the following paths:

- `C:\Program Files\Microsoft Office\<Office1x>\Xlstart`

    > [!NOTE]
    > The \<Office1x\> boilerplate represents the version number (Microsoft Office Excel 2007 is Office12 and Microsoft Office Excel 2003 is Office11)

- `C:\Documents and Settings\<User_name>\Application Data\Microsoft\Excel\XLSTART`

    In this path, <User_name> is your logon user name.

- The folder that is specified in the **At startup, open all files in** box.

    > [!NOTE]
    >
    > - To find the **At startup, open all files in** box in Excel 2003, click **Options** on the **Tools** menu, and then click the **General** tab.
    >
    > - To find the **At startup, open all files in** box in Excel 2007, click **Microsoft Office Button**, click **Excel Options**, and then click **Advanced**. The **At startup, open all files in** box is under **General**.

### Accepted file types during Excel startup

You typically use startup folders to load Excel templates and add-ins. You can also use startup folders to load workbooks. When you load the following types of files from a startup folder, the files have the important characteristics that are described in the following list.

#### Templates

If you save a workbook named Book.xlt, and then put it in a startup folder location, that workbook is the default workbook when you start Excel or open a new workbook.

To use additional templates, you must save them in the following folder:

`C:\Program Files\Microsoft Office\Templates\1033`

To use the templates in Excel 2003, follow these steps:

1. On the **File** menu, click **New**.
2. In the **New Workbook** task pane, click **On my computer** under **Templates**.
3. In the **Templates** dialog box, double-click the template for the type of workbook that you want to create on the **Spreadsheet Solutions** tab.

To use the templates in Excel 2007, follow these steps:

1. Click the **Microsoft Office Button**, and then click **New**.
2. Under **Templates**, click **Installed Templates**.
3. Under **Installed Templates**, click the template that you want, and then click **Create**.

#### Add-ins

Add-ins (.xla files) that you put in a startup folder do not typically appear when you start Excel. The add-ins are loaded in memory. The add-ins run any auto macros.

You can use these add-ins by whatever method the add-in provides (for example, a command on a menu or a button on a toolbar).

#### Workbooks

Workbooks (.xls files) that you put in a startup folder are loaded and appear when you start Excel, unless the workbook is saved in a hidden state.

For example, the personal macro workbook Personal.xls is a global macro workbook that Excel typically loads from the XLStart folder in a hidden state.

### Incorrect use of the alternative startup file location

When you use the alternative startup file location, you must specify a file path where there are recognizable file types (such as templates, add-ins, and workbooks).

If Excel finds unrecognizable file types in a startup folder, you may receive an error message. The most common error message is:

> This file is not a recognizable format.

### Use the default file location

In addition to the alternative startup file location, the default file location can be set by using the **Default file location** box on the **General** tab in the **Options** dialog box in Excel 2003.

The default file location differs from a startup folder. It can set the folder location that you want Excel to point to when you open or save a file by using the **File** menu.

> [!NOTE]
> In Excel 2007, to see the default file location, follow these steps:
>
>   1. Click **Microsoft Office Button**, and then click **Excel Options**.
>   2. Click **Save**.
>   3. The **Default file location** box is under **Save workbooks**.
