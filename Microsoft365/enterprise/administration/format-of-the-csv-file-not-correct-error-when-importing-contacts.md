---
title: Format of the CSV file isn't correct error
description: Describes an issue that triggers an error when a Microsoft 365 user tries to import contacts in a CSV file. Provides a solution.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 3/31/2022
---
# Format of the CSV file isn't correct error when a Microsoft 365 user tries to import contacts

_Original KB number:_ &nbsp; 3145388

## Symptoms

A Microsoft 365 user wants to import contacts in a CSV file that was exported from another email application such as Outlook.com. However, when the user tries to import the CSV file through the Microsoft 365 portal (**People** > **Manage** > **Import contacts**), they receive the following error message:

> The format of the CSV file isn't correct. Be sure that the file was exported in the Outlook CSV Format

This issue may occur if the exported CSV file includes quotation marks ("").

## Resolution

To resolve this issue, follow these steps:

1. Open the CSV in Notepad. (Don't use Excel to open the CSV file because the quotation marks may not be visible in Excel).
2. On the **Edit** menu, select **Replace**. In the **Find what** box, type ", leave the **Replace with** box blank, and then select **Replace All**.

    > [!NOTE]
    > Make sure that the **Replace with** box is blank and doesn't contain a space or any other character.

3. Save the file, and then import it to Microsoft 365.

You receive a **<#> contacts imported successfully** message when the contacts are successfully imported.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
