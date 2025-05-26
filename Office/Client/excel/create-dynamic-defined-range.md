---
title: Create a dynamic defined range in a worksheet
description: Provides a method to create a dynamic defined range that can automatically extend to include new information if you have a named range that must be extended.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: v-barryb
ms.custom: 
  - Editing\Formulae
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2010
  - Excel 2007
  - Excel 2003
ms.date: 05/26/2025
---

# How to create a dynamic defined range in an Excel worksheet

## Summary

In Microsoft Excel, you may have a named range that must be extended to include new information. This article describes a method to create a dynamic defined name.

> [!NOTE]
> The method in this article assumes that there are no more than 200 rows of data. You can revise the defined names so that they use the appropriate number and reflect the maximum number of rows.

### How to use the OFFSET formula with a defined name

To do this, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007,  Microsoft Excel 2010 and Microsoft Excel 2013

1. In a new worksheet, enter the following data.

    |Number|A|B|
    |---|---|---|
    |1|Month|Sales|
    |2|Jan|10|
    |3|Feb|20|
    |4|Mar|30|

2. Click the **Formulas** tab.   
3. In the **Defined Names** group, click **Name Manager**.   
4. Click **New**.   
5. In the **Name** box, type Date.   
6. In the **Refers to** box, type the following text, and then click **OK**: 

   **=OFFSET($A$2,0,0,COUNTA($A$2:$A$200),1)**
1. Click **New**.   
1. In the **Name** box, type
Sales.   
1. In the **Refers to** box, type the following text, and then click **OK**:

   **=OFFSET($B$2,0,0,COUNT($B$2:$B$200),1)**  
10. Click **Close**.   
11. Clear cell B2, and then type the following formula:
    
    =RAND()*0+10

    > [!NOTE]
    > In this formula, **COUNT** is used for a column of numbers. **COUNTA** is used for a column of text values.
    
    This formula uses the volatile RAND function. This formula automatically updates the OFFSET formula that is used in the defined name "Sales" when you enter new data in column B. The value 10 is used in this formula because 10 is the original value of cell B2.    

#### Microsoft Office Excel 2003 

1. In a new worksheet, enter the following data: 

    |Number|A|B|
    |---|---|---|
    |1|Month|Sales|
    |2|Jan|10|
    |3|Feb|20|
    |4|Mar|30|

2.  On the **Insert** menu, point to
**Name**, and then click **Define**.    
3. In the **Names in workbook** box, type
Date.    
4. In the **Refers to** box, type the following text, and then click **OK**:

   **=OFFSET($A$2,0,0,COUNTA($A$2:$A$200),1).**   
5. Click **Add**.    
6. In the **Names in workbook** box, type Sales.    
7. In the **Refers to** box, type the following text, and then click Add:

   **=OFFSET($B$2,0,0,COUNT($B$2:$B$200),1)**   
8. Click **OK**.    
9. Clear cell B2, and then type the following formula:

   =RAND()*0+10

   > [!NOTE]
   > In this formula, **COUNT** is used for a column of numbers. **COUNTA** is used for a column of text values.

   This formula uses the volatile RAND function. This formula automatically updates the OFFSET formula that is used in the defined name "Sales" when you enter new data in column B. The value 10 is used in this formula because 10 is the original value of cell B2.
