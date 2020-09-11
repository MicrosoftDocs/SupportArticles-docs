---
title: A cursor-based grid is blank
description: This article provides resolutions for the problem where cursor-based grid is blank if the SELECT-SQL command resets the cursor in Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# A cursor-based grid is blank if the SELECT-SQL command resets the cursor in Visual FoxPro

This article helps you resolve the problem where cursor-based grid is blank if the SELECT-SQL command resets the cursor in Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 140653

## Symptoms

In Microsoft Visual FoxPro, if the `RecordSource` property of a grid is set to a cursor, and then the SELECT-SQL command resets the cursor, the grid appears blank if the
 RecordSource property is not set back to itself.

The following command will refresh the grid properly if a SELECT-SQL is run to rebuild the cursor, but if the column or header properties of the grid have been customized, these customized changes will be lost and the column and header properties of the grid will change back to their default settings:

```sql
 THISFORM.GRID1.RECORDSOURCE=THISFORM.GRID1.RECORDSOURCE
```

Such customization could be headers with different names, longer column lengths, and code placed in the events of columns or headers. For more information, please see the following article in the Microsoft Knowledge Base:
 [131836](/EN-US/help/131836) PRB: Grid Not Refreshing Displaying a Cursor from Query

## Cause

When you rebuild the cursor that the grid is based on with the SELECT-SQL command, the original cursor has to be destroyed before the new cursor can be created. When this happens, the grid columns and headers are also cleared and then recreated. Even when the `RecordSource` property of the grid is set back to itself, the custom settings of the columns and headers of the grid are lost.

## Resolution

To refresh the grid without losing the custom properties of the columns and headers, set the `RecordSource` property to a dummy cursor that already has been created with the same fields as the cursor the grid is based on. After the SELECT-SQL is run, change the `RecordSource` property back to the rebuilt cursor. This allows the properties of the columns and headers to remain intact while the cursor is being rebuilt.

## Status

This behavior is by design.

## More information about steps to reproduce behavior

1. Open the Customer.dbf table located in the \Vfp\Samples\Data directory, and create a form called GridForm.

2. Place the following code in the Load event of the form:

    ```sql
     SELECT cust_id, city, country FROM customer INTO CURSOR Temp1
     SELECT cust_id, city, country FROM customer WHERE country = "" ;
     INTO CURSOR Temp2
    ```  

3. Place the following code in the Destroy event of the form:

    ```sql
     SELECT Temp1
     USE
     SELECT Temp2
     USE
    ```  

4. Place a grid on the form, and give the grid the following property settings:

    ```sql
     ColumnCount=3
     RecordSourceType=Alias
     RecordSource=Temp1
    ```  

5. Change the caption of the grid1.Column1.header1 to Customer Id and the Column1 Width property to 100.

6. Add a text box to the form.

7. Add a command button, and place the following code in its Click event:

    ```sql
     THISFORM.GRID1.RECORDSOURCE = "Temp2"
     SELECT cust_id, city, country FROM customer ;
     WHERE country = Thisform.text1.value ;
     INTO CURSOR Temp1
     THISFORM.GRID1.RECORDSOURCE = "Temp1"
    ```  

8. Run the Form. Type Spain in the text box, and then click the command button. The grid should display all records where the country field is equal to Spain. The name of the header of column 1 stays the same and the width of the column doesn't change. By changing the RecordSource of the grid to the cursor called Temp2, the properties of the columns and headers are not reset when the Temp1 cursor is rebuilt.

9. Change the two `THISFORM.GRID1.RECORDSOURCE` lines in the Click event of the command button into comments and add the following as the last line of code:

    ```sql
     THISFORM.GRID1.RECORDSOURCE = THISFORM.GRID1.RECORDSOURCE
    ```  

After running the form, typing a country name in the text box, and clicking the command button, note that the column name changes and the width is smaller.
