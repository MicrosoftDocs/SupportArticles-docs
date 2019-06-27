---
title: Use the registry to override the default behavior When Excel recover data
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Use the registry to override the default behavior when Excel tries to recover data

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Description of the Microsoft Windows Registry](https://support.microsoft.com/help/256986).

## Summary

Excel 2003 contains a feature that allows you to recover data from corrupted workbooks. This article describes how to use the registry to override the default behavior when Excel tries to recover data.

## More information

When you open a workbook in Excel, Excel checks for problems in the workbook. If Excel detects a problem in a workbook, the data recovery process begins automatically.

> [!NOTE]
> You can also manually start the data recovery process. To do so, on the **File** menu, click **Open**, click the arrow on the **Open** button, and then click **Open and Repair**. 

All the registry values that affect data recovery are in the following registry subkey:

HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Excel\Options

This subkey contains three DWORD registry values that you can modify as follows. (0 is always the default value, and 1 is the only other valid value.)

### ExtractDataMode

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk. 

If ExtractDataMode equals 0 (or a value that is not valid), Excel assumes that the structure of the workbook is not corrupted. Therefore, Excel tries to recover the whole workbook, including formulas, formatting, and Microsoft Visual Basic for Applications (VBA) projects.

If ExtractDataMode equals 1, Excel assumes that the structure of the workbook is corrupted. Therefore, Excel does not try to recover anything other than the data in the workbook. 

To change the value from 0 to 1, follow these steps:

1. Start Registry Editor.   
2. Expand **HKEY_CURRENT_USER**, expand **Software**, expand **Microsoft**, expand **Office**, expand **11.0**, expand **Excel**, and then click **Options**.    
3. Double-click **ExtractDataMode**.   
4. Type 1 in the **Value data** field, and then click **OK**.

### ExtractDataFormulas

 If ExtractDataFormulas equals 0 (or a value that is not valid), Excel tries to recover formulas and converts a formula to a value if recovery does not succeed. 

If ExtractDataFormulas equals 1, Excel recovers as much of the formula as possible, and substitutes #REF if recovery does not succeed. This value also affects the default option when you are prompted to recover formulas during the Open and Repair process.

To change the value from 0 to 1, follow these steps:

1. Start Registry Editor.   
2. Expand **HKEY_CURRENT_USER**, expand
**Software**, expand **Microsoft**, expand
**Office**, expand **11.0**, expand
**Excel**, and then click **Options**.    
3. Double-click
**ExtractDataFormulas**.   
4. Type 1 in the **Value data** field, and then click **OK**.

### ExtractDataDisableUI

 If ExtractDataDisableUI equals 0 (or a value that is not valid), Excel prompts you with two messages during the Open and Repair process. The first message prompts you to select either to repair or to extract data. The second message prompts you to select either to convert to values or to recover formulas.

If ExtractDataDisableUI equals 1, Excel does not offer you any options during the Open and Repair process. Excel opens the file by using the Safe Load process. Data extraction is still enabled through the object model and through automatic data recovery.

To change the value from 0 to 1, follow these steps:

1. Start Registry Editor.   
2. Expand **HKEY_CURRENT_USER**, expand **Software**, expand **Microsoft**, expand **Office**, expand **11.0**, expand **Excel**, and then click **Options**.    
3. Double-click
**ExtractDataDisableUI**.   
4. Type 1 in the **Value data** field, and then click **OK**.
