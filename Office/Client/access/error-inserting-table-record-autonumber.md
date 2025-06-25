---
title: Error (The changes you requested to the table were not successful) when you insert a new record in a table
description: Describes an issue in which you receive a (The changes you requested to the table were not successful) message when you insert a new record in a table that contains an Autonumber field.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: v-kirkp
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2000
search.appverid: MET150
ms.date: 05/26/2025
---
# You may receive an error message when you try to insert a new record in a table that contains an Autonumber field in Access

_Original KB number:_ &nbsp; 884185

## Symptoms

When you try to insert a new record in a table that has an **Autonumber** field, you may receive the following error message:

> The changes you requested to the table were not successful because they would create duplicate values in the index, primary key, or relationship. Change the data in the field or fields that contain duplicate data, remove the index, or redefine the index to permit duplicate entries and try again.

:::image type="content" source="./media/error-inserting-table-record-autonumber/auto-number-error.png" alt-text="Screenshot of the error message after inserting a new record in a table." border="false":::

> [!NOTE]
> The table may not have any relationships or any indexes.

## Cause

This problem occurs when the **Autonumber** field has been incorrectly seeded.

## Resolution

There are multiple methods that may resolve this problem.

### Method 1: Perform Compact and Repair

To compact the database, follow these steps:

1. Start Access.
1. Open the Access database.

   > [!NOTE]
   > If you see the Security Warning dialog box, click Open.

1. Click the Database Tools ribbon tab and then click Compact and Repair Database from within the Tools group.

   > [!NOTE]
   > Previous versions of Access may have the Compact and Repair Database option located elsewhere, see the documentation for your specific version of Access to locate this option.

To manually reset the **Autonumber** field seed, use one of the following methods.

### Method 2: Use a Data Definition query

Open the database that has the table (back-end database) in Access:

1. On the **Create** tab, click **Query Design** in the **Queries** group.
1. In the **Show Table** dialog box, click **Close**.
1. On the **Design** tab, click **SQL view** in the **Results** group.
1. Type the following in the **Query1** window:

   ```vb
   ALTER TABLE TableName ALTER COLUMN AutoNumFieldName COUNTER(iMaxID,1);
   ```

   > [!NOTE]
   > \<TableName> is a placeholder for the name of the \<table.AutoNumFieldName> is a placeholder for the name of the **Autonumber** field. *iMaxID* is a placeholder for the current maximum value in the field plus 1.

1. On the **Design** tab, click **Run** in the **Results** group.

### Method 3: Run Visual Basic for Applications code

1. On the **Create** tab, click the down arrow under **Macro**, and then click **Module**.
1. Paste the following code in the Visual Basic Editor.

    ```vb
    Sub ResetAuto()
      Dim iMaxID As Long
      Dim sqlFixID As String
      iMaxID = DMax("<AutonumberFieldName>", "<TableName>") + 1
      sqlFixID = "ALTER TABLE <TableName> ALTER COLUMN <AutonumberFieldName> COUNTER(" & <iMaxID> & ",1)"
      DoCmd.RunSQL sqlFixID
    End Sub
    ```

   > [!NOTE]
   > The placeholder \<AutonumberFieldName> represents the name of the Autonumber field. The placeholder \<TableName> represents the name of the table.

1. On the Run menu, click Run Sub/UserForm.

   > [!NOTE]
   > You must close the table before you use either method. You do not have to save the query or the module after you successfully use either method

## Steps to reproduce the behavior

1. Create a new blank database
1. Create a new table that is named **Table1** that contains the following two fields:

    **Field1**: Autonumber (Primary Key)
    **Field2**: Text

1. Add the following six records to Table1.

    |Field1|Field2|
    |-|-|
    |1|A|
    |2|B|
    |3|C|
    |4|D|
    |5|E|
    |6|F|

1. Delete the record where Field1 has the value 3.
1. On the **Create** tab, click **Query Design** in the **Queries** group.
1. In the **Show Table** dialog box, click **Close**.
1. On the **Design** tab, click **SQL view** in the **Results** group.
1. Type the following in the **Query1** window:

    ```vb
    INSERT INTO Table1 (Field1, Field2) SELECT 3 AS Field1, "C" AS Field2;
    ```

1. On the **Design** tab, click **Run** in the **Results** group.
1. Open **Table1**, and then try to add a new record. You receive the error message that is mentioned in the "Symptoms" section.
