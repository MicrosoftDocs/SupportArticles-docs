---
title: The first sheet name is in a language different from the Office display language
description: The name of the first sheet in an Excel workbook that you create through right-clicking in a folder may be in a language that's different from the Office display language.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Languages
  - CI 106750
  - CSSTroubleshoot
ms.reviewer: iuliam
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
search.appverid: MET150
ms.date: 05/26/2025
---

# The first worksheet name in a new Excel workbook displays in a language other than the Office display language

## Symptoms

Consider the following scenario:

- You create a new Microsoft Excel workbook by right-clicking in a folder and then selecting **New** > **Microsoft Excel Worksheet**.
- You have more than one language packs installed with Microsoft 365.

In this scenario, the name of the first sheet in the Excel workbook may appear in a language that's different than the **Display Language** set in Microsoft Office. For example, if you have Microsoft 365 installed with German, English, and Polish, the name of the worksheet created is displayed in German, despite having English (or Polish) set as the **Display Language**.

:::image type="content" source="media/first-sheet-name-displays-different-language/display-language.png" alt-text="Screenshot to set English as the Display Language in the Excel Options window.":::

:::image type="content" source="media/first-sheet-name-displays-different-language/name-example.png" alt-text="Screenshot shows the first sheet name displayed in a different language.":::

## Cause

When you create a workbook through by right-clicking in a folder and then selecting > **New** > **Microsoft Excel Worksheet**, Windows Explorer creates a copy of a workbook named Excel12.xlsx from thea system folder called *SHELLNEW* in the active folder. The original Excel12.xlsx is created in the *SHELLNEW* folder at the Office installation, with the name of its default sheet in a language that may differ from the **Display Language**.

## Workaround

To correct this behavior, replace the original Excel12.xlsx in the *SHELLNEW* folder with a workbook that you create in the language of your choice and with the same name (Excel12.xlsx).

The *SHELLNEW* folder is located in the following folder (depending on the version and architecture of Excel and the OS):

- For Microsoft 365 32-bit on 64-bit Windows

  C:\Program Files (x86)\Microsoft Office\root\vfs\Windows\SHELLNEW

- For 64-bit Microsoft 365 installations on 64-bit Windows

  C:\Program Files\Microsoft Office\root\vfs\Windows\SHELLNEW

- For Office MSI

  C:\Windows\SHELLNEW

The next time you create a workbook by right-clicking in a folder, a copy of your new Excel12.xlsx with the chosen language will be created in the active folder.

> [!NOTE]
> If you add a sheet by clicking "+" in the Excel Worksheet, the sheet name appears according to the **Display Language**. The behavior that's described in the Symptoms section only applies to the first sheet.
> :::image type="content" source="media/first-sheet-name-displays-different-language/second-sheet.png" alt-text="Screenshot shows the second sheet name displayed in the correct language." border="false":::

Also, if you create a blank workbook in Excel by using the Start screen or through **File** > **New**, the first worksheet is displayed according to the display language.

Microsoft is researching this problem and will post more information in this article when the information becomes available.
