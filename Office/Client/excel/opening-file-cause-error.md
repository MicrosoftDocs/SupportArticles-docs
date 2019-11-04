---
title: The document caused a serious error the last time it was opened
description: Describes an error message that you receive when you try to open a file that Excel or Word could not open previously. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
---

# "The document caused a serious error the last time it was opened" when you open a file in Excel or Word

## Symptoms

When you try to open a Microsoft Excel spreadsheet or a Microsoft Word document that you could not previously open in that program, you receive the following error message: 

The document '**Filename**' caused a serious error the last time it was opened. Would you like to continue opening it? 
You receive this message every time that you try to open the file.

## Cause

This problem occurs because the file is included in the list of disabled files for the Microsoft Office program. The program adds a file to this list if the file causes a serious error, such as causing the program to close unexpectedly (crash) during two or more attempts to open it.

This error message lets you avoid potential problems that may occur if you open the file.

## Resolution

To resolve this problem, follow the appropriate steps for the version of Word or of Excel that you are running.

### Microsoft Office Excel 2007 and Microsoft Office Word 2007 or later versions

Disable add-ins. To do this, follow these steps:
 
1. In **Excel**, click **File**, click Options, and then click **Add-Ins**.    
2. In the **Manage** list, click **COM Add-Ins**, and then click **Go**.    
3. In the **COM Add-Ins** dialog box, clear the check box for any one of the add-ins in the list that's selected, and then click **OK**.    
4. Restart the application (not in safe mode).    

If the program starts successfully, the add-in for which you cleared the check box is the one that's causing the problem. If the program doesn't start after you complete these steps, repeat these steps by clearing the check box for a different add-in.

If the program doesn't start after you have tested all the listed add-ins, the problem isn't related to the add-ins. To learn about other reasons why this may problem may occur, go to the "References" section.

If the problematic add-in is a third-party product, we recommend that you go to the company website to get a newer version of the add-in. If there's no newer version available or if you don’t have to use the add-in, you can leave that check box cleared in the **COM Add-Ins** list.

> [!NOTE]
> If these steps do not work, the file may be damaged and not repairable. For more information about corrupted files, see the following articles:
>
> - [Repair a corrupted workbook](https://support.office.com/article/repair-a-corrupted-workbook-153a45f4-6cab-44b1-93ca-801ddcd4ea53)    
> - [How to troubleshoot damaged documents in Word](https://support.microsoft.com/help/918429)    
  
## References

[I get a "stopped working" error when I start Office applications on my PC](https://support.office.com/article/why-do-i-get-a-stopped-working-message-when-i-start-my-office-application-52bd7985-4e99-4a35-84c8-2d9b8301a2fa?correlationid=350c0c86-c67d-42d8-be2f-d6e0752a67bf)
