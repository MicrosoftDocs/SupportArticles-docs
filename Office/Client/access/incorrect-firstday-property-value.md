---
title: FirstDay property is set incorrectly
description: Fixes an issue in which the FirstDay property is not correctly set when you use the numeric constants.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: suesch
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# Microsoft Calendar Control 10.0 and later versions use an incorrect value for the FirstDay property

_Original KB number:_ &nbsp; 826761

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file. Requires basic macro, coding, and interoperability skills.

## Symptoms

In Microsoft Access, an incorrect day is displayed for the first day of the Calendar Control. This problem occurs when you insert a Microsoft Calendar Control 10.0 or a later version into a form or into a report, and then you set the `FirstDay` property of the Calendar Control by using Microsoft Visual Basic for Applications (VBA) intrinsic constants.

For example, you set the `FirstDay` property of the Calendar Control to **vbMonday** or to **vbTuesday**. When you set the `FirstDay` property of the Calendar Control to **vbTuesday**, the calendar uses Wednesday as the first day of the week.

> [!NOTE]
> When you use the earlier versions of Calendar Control, you can set the `FirstDay` property correctly.

## Cause

This problem occurs because the intrinsic constants for the days that are defined in Microsoft Visual Basic, such as **vbSunday** and **vbMonday**, are not associated with the correct day value.

## Workaround

To work around this problem, follow these steps:

1. Determine the association between the days, the VBA intrinsic constants, and the numeric values that are associated to the correct day values and VBA intrinsic constants. To do this, follow these steps:

   1. Start Access.
   2. Open the Northwind sample database.
   3. In the Database window, click **Forms** under **Objects**.

      > [!NOTE]
      > In Access 2007, click the **Create** tab, and then click **Form Design** in the **Forms** group.

   4. In the right pane, double-click **Create form in Design view**.

      > [!NOTE]
      > In Access 2007, skip this step.

   5. On the **Insert** menu, click **ActiveX Control**.

     > [!NOTE]
     > In Access 2007, click the **Design** tab, and then click **Insert ActiveX Control** in the **Controls** group.

   6. In the **Insert ActiveX Control** dialog box, click to select **Calendar Control 10.0** or a later version from the **Select an ActiveX Control** list box, and then click **OK**.
   7. Add a command button to the form that has the properties set as follows:

      |Property|Value|
      |---|---|
      |`Name`|**testFD**|
      |`Caption`|**Change First Day**|

   8. On the **File** menu, click **Save**.

      > [!NOTE]
      > In Access 2007, click the **Microsoft Office Button**, and then click **Save**.

   9. In the **Save As** dialog box, type Form1 in the **Form Name** box, and then click **OK** to save the Form1 form.
   10. On the **View** menu, click **Code**.

       > [!NOTE]
       > In Access 2007, click the **Design** tab, and then click **View Code** in the **Tools** group.

   11. In the Visual Basic Editor, type or paste the following code:

       ```vb
       Option Compare Database

       Private Sub testFD_Click()
           Calendar0.FirstDay = vbTuesday
       End Sub
       ```

   12. Open Form1 in the Form view.
   13. Click the **Change First Day** button.

       > [!NOTE]
       > If the first column of the Calendar Control is not set to Tuesday, note the day in the first column.

   14. In the Visual Basic Editor, click **Immediate Window** on the **View** menu.
   15. In the Immediate window, type **?vbTuesday**, and then press ENTER.

       Notice the numeric value.

   16. Repeat step j through step o by replacing **vbTuesday** with other VBA intrinsic constants, such as **vbMonday**and **vbWednesday**.

       Notice that you will have the following table to show the association between the days, the VBA intrinsic constants, and the numeric values that are associated to the correct day values and VBA intrinsic constants.

       |Week Day|VBA Intrinsic Constant|Numeric Value Associated|
       |------|-----|-----|
       |Monday|**vbSunday**|1|
       |Tuesday|**vbMonday**|2|
       |Wednesday|**vbTuesday**|3|
       |Thursday|**vbWednesday**|4|
       |Friday|**vbThursday**|5|
       |Saturday|**vbFriday**|6|
       |Sunday|**vbSaturday**|7|

2. Create a global custom enumeration that is correctly mapped to the week days. To do this, follow these steps:

   1. In the Database window, click **Module** under **Objects**.

      > [!NOTE]
      > In Access 2007, click the **Create** tab, click the arrow under **Macro** in the **Other** group, and then click **Module**.
   2. On the **Insert** menu, click **Module**.

      > [!NOTE]
      > In Access 2007, skip this step.

   3. Type or paste the following code in the Visual Basic Editor:

      ```
      Option Explicit

      Public Enum nwFirstDay
         nwMonday = 1
         nwTuesday = 2
         nwWednesday = 3
         nwThursday = 4
         nwFriday = 5
         nwSaturday = 6
         nwSunday = 7
      End Enum
      ```

      > [!NOTE]
      > Create the enumeration as described in the "Week Day" column and in the corresponding "Numeric Value Associated" column of the table that is in step 1r.

   4. Name the Module **Day_Association**, and save it.
   5. Close the Visual Basic Editor.

3. Replace the VBA intrinsic constants in your application with the constants that are in the custom enumeration that is described in step 2.

   For example, if your original code is

   ```vb
   Calendar0.FirstDay = vbTuesday
   ```

   modify your code to use custom enumeration as follows:

   ```vb
   Calendar0.FirstDay = nwTuesday
   ```

4. Run the application.

## More Information

The VBA intrinsic constants do not depend on the system local information. For example, on a computer that has the localized operating system in the German language, the first day of the week is Monday. The numeric value associated with Monday on the computer is always 0.

Because Calendar Control 10.0 or a later version is a worldwide Microsoft ActiveX control, you cannot control the numeric values that are associated with the VBA intrinsic constants based on your computer specifications. Therefore, the problem that is mentioned in the "Symptoms" section of this article occurs.

### Steps to reproduce the problem

1. Start Access.
2. Open the Northwind sample database.
3. In the Database window, click **Forms** under **Objects**.

   > [!NOTE]
   > In Access 2007, click the **Create** tab, and then click **Form Design** in the **Forms** group.

4. In the right pane, double-click **Create form in Design view**.

   > [!NOTE]
   > In Access 2007, skip this step.

5. On the **Insert** menu, click **ActiveX Control**.

   > [!NOTE]
   > In Access 2007, click the **Design** tab, and then click **Insert ActiveX Control** in the **Controls** group.
6. In the **Insert ActiveX Control** dialog box, click to select **Calendar Control 10.0** or a later version from the **Select an ActiveX Control** list box, and then click **OK**.
7. Add a command button to the form that has the properties set as follows:

   |Property|Value|
   |---|---|
   |`Name`|**testFD**|
   |`Caption`|**Change First Day**|

8. On the **View** menu, click **Code**.

   > [!NOTE]
   > In Access 2007, click the **Design** tab, and then click **View Code** in the **Tools** group.

9. In the Visual Basic Editor, type or paste the following code:

   ```vb
   Option Compare Database

   Private Sub testFD_Click()
    Calendar0.FirstDay = vbTuesday
   End Sub
   ```

10. On the **File** menu, click **Save**.

    > [!NOTE]
    > In Access 2007, click the **Microsoft Office Button**, and then click **Save As**.

11. In the **Save As** dialog box, type Form1in the **Form Name** box, and then click **OK** to save the Form1 form.
12. Open Form1 in the Form view.
13. Click the **Change First Day** button.

    Although you set the `FirstDay` property of the Calendar Control to **vbTuesday**, the calendar selects Wednesday to be the first day of the week.

## References

For more information about Calendar Control and the Calendar Control properties, open Mscal.hlp and then search for the appropriate topic. Mscal.hlp is located in the following folders:

Microsoft Access 2002

**Installation Drive**: `\Program Files\Microsoft Office\Office10`

Microsoft Office Access 2003

**Installation Drive**: `\Program Files\Microsoft Office\Office11`

> [!NOTE]
> **Installation Drive** is a placeholder for the name of your installation drive.
