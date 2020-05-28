---
title: Long numbers are displayed incorrectly in Excel
description: Describes how to show long numbers in Excel cells.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# Long numbers are displayed incorrectly in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

After you enter a long number (such as a credit card number) in an Excel cell, the number is not displayed correctly in Excel. For example,

![An example](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057455_en_1) 

> [!NOTE]
> Default number format in Excel is General therefore you can display up to 11 digits in a cell. 

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Format the cell as text
 
To do this, follow these steps: 
 
1. Right-click target cell, and then click **Format Cells**.

    ![Format Cells](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057456_en_1)

2. On the **Number** tab, select **Text**, and then click **OK**.

    ![Number](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057457_en_1)

3. Then type a long number. (Be sure to set the cell format before you type the number)

    ![Type a long number](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057458_en_1)    
4. If you do not want to see the warning arrows, click the small arrow, and then click **Ignore Error**.

    ![Warning arrows](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057459_en_1)

    ![Ignore Error](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057460_en_1)

 
### Method 2: Use a single quotation mark
 
When you enter a long number, type a single quotation mark (**'**) first in the cell, and then type the long number.

For example, type **'1234567890123456789** and the quotation mark will not be displayed after you press ENTER.

![Example](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4057461_en_1) 

Your opinion is important to us!Do not hesitate to tell us what you think of this article using the comment field located at the bottom of the document. This will allow us to improve the content. Thank you in advance!