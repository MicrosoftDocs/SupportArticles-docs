---
title: Use defined names to automatically update a chart range
description: Provides two methods for using defined names to automatically update a chart range. You can use these methods to set up a chart that can be automatically updated when you add new information to an existing chart range.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# How to use defined names to automatically update a chart range in Excel

## Summary

To set up a chart that is automatically updated as you add new information to an existing chart range in Microsoft Excel, create defined names that dynamically change as you add or remove data. 

## More Information

This section includes two methods for using defined names to automatically update the chart range.

### Method 1: Use OFFSET with a defined name

To use this method, follow these steps, as appropriate for the version of Excel that you are running. 

#### Microsoft Office Excel 2007 and later versions

1. In a new worksheet, type the following data:

    ```adoc
    A1: Month B1: Sales
    A2: Jan B2: 10
    A3: Feb B3: 20
    A4: Mar B4: 30
    ```
2. On the **Formulas** tab, click **Define Name** in the **Defined Names** group.   
3. In the **Name** box, type Date.   
4. In the **Refers to** box, type "=OFFSET($A$2,0,0,COUNTA($A:$A)-1)", and then click **OK**.   
5. On the **Formulas** tab, click **Define Name** in the **Defined Names** group.   
6. In the **Name** box, type Sales.   
7. In the **Refers to** box, type "=OFFSET($B$2,0,0,COUNTA($B:$B)-1)", and then click **OK**.    
8. Clear cell B2, and then type "=RAND()*0+10"

   > [!NOTE]
   > This formula uses the volatile RAND function. The formula automatically updates the OFFSET formula that is used in the defined name "Sales" when you enter new data into column B. The value 10, which is used in this formula, is the original value of cell B2.
1. Select cells A1:B4.   
1. On the **Insert** tab, click a chart, and then click a chart type.   
1. Click the **Design** tab, click the **Select Data** in the **Data** group.  
1. Under **Legend Entries (Series)**, click **Edit**.   
1. In the **Series values** box, type **=Sheet1!Sales**, and then click **OK**.   
1. Under **Horizontal (Category) Axis Labels**, click **Edit**.   
1. In the **Axis label range** box, type **=Sheet1!Date**, and then click **OK**.   

#### Microsoft Office Excel 2003 and earlier versions

1. In a new worksheet, type the following data:
 
    ```adoc
    A1: Month B1: Sales
    A2: Jan B2: 10
    A3: Feb B3: 20
    A4: Mar B4: 30
    ```
2. On the Insert menu, point to Name, and then click Define.    
3. In the **Names in workbook** box, type
Date.    
4. In the **Refers to** box, type "=OFFSET($A$2,0,0,COUNTA($A:$A)-1)"   
5. Click Add.    
6. In the **Names in workbook** box, type Sales.    
7. In the Refers to box, type "=OFFSET($B$2,0,0,COUNT($B$2:$B$200)-1)"   
8. Click **Add**, and then click **OK**.   
9. Clear cell B2, and then type "=RAND()*0+10"

   > [!NOTE]
   > This formula uses the volatile RAND function. The formula automatically updates the OFFSET formula that is used in the defined name "Sales" when you enter new data into column B. The value 10, which is used in this formula, is the original value of cell B2.
1. Select $A$1:$B$4.    
1. Create the chart, and then add the defined names in the chart. To do this, follow these steps, as appropriate for the version of Excel that you are running. 

#### Microsoft Excel 97 through Excel 2003

1. On the Insert menu, click Chart to start the Chart Wizard.   
2. Click a chart type, and then click Next.   
3. Click the Series tab. In the Series list, click Sales.   
4. In the **Category (X) axis labels** box, replace the cell reference with the defined name Date.

   For example, the formula might be similar to the following:

   =Sheet1!Date   
5. In the Values box, replace the cell reference with the defined name Sales.

   For example, the formula might be similar to the following:
   
   =Sheet1!Sales   
6. Click Next.   
7. Make any changes you want in step 3 of the Chart Wizard and click Next.   
8. Specify the chart location and click Finish.   

#### Microsoft Excel 5.0 or Microsoft Excel 7.0

1. On the Insert menu, point to Chart, and click As New Sheet to start the Chart Wizard.   
1. Click Next.   
1. Click a chart type, and then click Next.   
1. Click a chart subtype, and then click Next.
1. Click **Columns for Data Series In** and type 1 for **Use First 1 Columns for Category (x) Axis Labels**. Click Next.
1. Click the titles that you want to display and click Finish.

    The chart appears on a new chart.   
1. Select the data series. On the Format menu, click Select Data Series.
1. Click the X Values tab. In the X Values box, replace the cell reference with the defined name Date.

   For example, the formula might be similar to the following:

   =Sheet1!Date   
1. Click the Name And Values tab. In the Y Values box, replace the cell reference with the defined name Sales.

    For example, the formula might be similar to the following:

    =Sheet1!Sales
1. Click OK.   

### Method 2: Use a database, OFFSET, and defined names in Excel 2003 and in earlier versions of Excel

You can also define your data as a database and create defined names for each chart data series. To use this method, follow these steps: 

1. In a new worksheet, type the following data:

    ```adoc
    A1: Month B1: Sales
    A2: Jan B2: 10
    A3: Feb B3: 20
    A4: Mar B4: 30
    ```
2. Select the range A1:B4, and then click Set Database on the Data menu.   
3. On the Formula menu, click Define Name.   
4. In the Name box, type Date.   
5. In the **Refers to** box, type "=OFFSET(Database,1,0,ROWS(Database)-1,1)"   
6. Click Add.   
7. In the Name box, type Sales.   
8. In the **Refers to** box, type "=OFFSET(Database,1,1,ROWS(Database)-1,1)"   
9. Click **Add**, and then click **OK**.   
10. Select $A$1:$B$4    
11. Repeat step 10 from method 1 to create the chart and add the defined names to the chart.    
 
As long as the data that you want to appear in your chart is defined as a database, the chart is updated automatically as you add new data.

> [!NOTE]
> If you are creating a series chart that plots every value in an adjacent block of cells in single column, and the block of cells starts with the first row, you can use either of the following formulas in the Refers to box for the defined name: 
>
> =INDIRECT("Sheet1!$a$1:$a"&COUNT(Sheet1!$A:$A))
>
> =Sheet1!$A$1:OFFSET(Sheet1!$A$1,COUNT(Sheet1!$A:$A),0) 

To use a block of cells that start with a cell on a row other than the first row, reference that row in the first cell reference and add the starting row number to the count to find the last row number. To plot adjacent nonnumeric entries (for example, labels), use COUNTA instead of COUNT.
