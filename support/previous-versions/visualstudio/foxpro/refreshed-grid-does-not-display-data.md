---
title: Refreshed grid doesn't display any data
description: This article provides resolutions for the problem where a grid that has a RecordSource property set to a cursor does not refresh with data even if you use the ThisForm.Refresh or ThisForm.GridName.Refresh command.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# A refreshed grid doesn't  display any data when a cursor is updated at run time in Visual FoxPro

This article provides resolutions for the problem where a grid that has a RecordSource property set to a cursor does not refresh with data even if you use the ThisForm.Refresh or ThisForm.GridName.Refresh command.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 131836

## Symptoms

In Visual FoxPro, if the `RecordSource` property of a grid is set to a cursor and then that cursor is updated at run time by using a `SQL Select Into Cursor CursorName` command, the grid does not display any data even if you refresh it by using the `ThisForm.Refresh` command or the `ThisForm.GridName.Refresh` command.

## Cause

When you execute a SQL Select statement into the same cursor specified in the `RecordSource` property of the grid, the original cursor must be destroyed before the new cursor can be created. When this occurs, the grid columns and the `RecordSource` are also cleared and then re-created. The record source of the grid is set to the new cursor, and the grid automatically creates columns. The new grid is working from scratch. Therefore, it does not load the data from the cursor.

## Resolution

To refresh the grid in this situation, set the `RecordSource` property of the grid to itself as in this example:

```console
thisform.grid1.recordsource=thisform.grid1.recordsource
```

## Status

This behavior is by design.

## More information

For more information, see [A cursor-based grid is blank if the SELECT-SQL command resets the cursor in Visual FoxPro](https://support.microsoft.com/help/140653).

## Steps to reproduce the behavior

1. Create a form, and then add the CUSTOMER.DBF table (in the `\VFP\SAMPLES\DATA` directory) to the Data Environment.

2. Place the following code in the Load event of the form:

    ```console
    CREATE CURSOR Compdisp (company c(40),city c(15),country c(15))
    ```

3. Place the following code in the Destroy event of the form:

    ```console
    SELECT Compdisp
    USE
    ```  

4. Create a grid on the form, and give the grid the following property settings:

    ```console
    ColumnCount=3
    RecordSourceType=Alias
    RecordSource=Compdisp
    ```  

5. Add a text box to the form.

6. Add a command button with the following code in its `Click` event:

    ```console
    SELECT company,city,country;
    FROM customer;
    WHERE customer.country=thisform.text1.value;
    INTO CURSOR Compdisp
    THISFORM.GRID1.REFRESH
    ```

7. Run the Form. Type *France* in the text box, and then click the command button.
The grid should display all records where `Customer.Country="France"`, but it doesn't. The grid is blank. `THISFROM.GRID1.REFRESH` does not seem to update the grid. This happens even if the Cursor is not created in the Load event of the Form.

To have the grid display the data correctly, place the following command as the last line of code for the `Click` event of the command button:

```console
ThisForm.Grid1.RecordSource =ThisForm.Grid1.RecordSource
```
