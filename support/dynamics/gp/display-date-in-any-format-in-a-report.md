---
title: Display a date in any format in a report
description: This article describes how to display a date in any format in a report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Display a date in any format in a report in Microsoft Dynamics GP

This article describes how to display a date in any format in a report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925970

## Introduction

This article describes how to display a date in any format in a report in Microsoft Dynamics GP. By default, when you display dates in Report Writer in Microsoft Dynamics GP, the short date format is used for the date. This format is usually MM/DD/YYYY or DD/MM/YYYY, depending on the regional settings on the computer.

## More information

If you want to display the date in a different format, you can use the RW_DateToString user-defined function to change the date into almost any format. To use this function, follow these steps.

### Step 1: Back up the report, and then open the report

1. If the existing Microsoft Dynamics GP reports have been modified, back up the Reports.dic file. To locate the Reports.dic file, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.
   2. If you are prompted to enter the system password, type your password, and then click **OK**.
   3. Use the appropriate step:

      - In Microsoft Dynamics GP 9.0 and higher, click **Microsoft Dynamics GP** in the Edit Launch File window.
      - In Microsoft Business Solutions - Great Plains 8.0 or 7.5, click **Great Plains** in the Edit Launch File window.

   4. Note the path that appears in the **Reports** box.
   5. Click **OK** to close the Edit Launch File window.

2. On the **Tools** menu, point to **Customize**, and then click **Report Writer**.
3. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0 and higher, click **Microsoft Dynamics GP** in the **Product** list, and then click **OK**.
    - In Microsoft Business Solutions - Great Plains 8.0 or 7.5, click **Great Plains** in the **Product** list, and then click **OK**.

4. Click **Reports**.
5. In the Report Writer window, click the report that you want to modify in the **Original Reports** list, and then click **Insert**.
6. In the **Modified Reports** list, click the same report, and then click **Open**.
7. Click **Layout**.

### Step 2: Modify the report

1. In the Report Writer layout window, click **Calculated Fields** in the **Toolbox** list.
2. Click **New**, and then type a name for the date field.
3. In the **Result Type** list, click **String**.
4. In the **Expression Type** area, click **Calculated**.
5. Click the **Functions** tab, and then click **User-Defined**. In the **Core** list, click **System**. In the **Function** list, click **RW_DateToString**.
6. Click **Add**.
7. Click the **Fields** tab.
8. In the **Resources** list, click the table that includes the date field that you want to modify.
9. In the **Field** list, click the date field that you want to modify.
10. Click **Add**.
11. Click the **Constants** tab, and then click **String** in the **Type** list.
12. In the **Constant** field, enter a format string.

    > [!NOTE]
    > For information about how to create a format string, see the "Options for the RW_DateToString user-defined function" section.

13. Click **Add**.
14. Click **OK**.
15. Drag the new calculated field to the report.
16. Close the report. When you are prompted to save the changes, click **Save**.
17. Use the appropriate step:

    - In Microsoft Dynamics GP 9.0 and higher, click **Microsoft Dynamics GP** on the **File** menu.

    - In Microsoft Business Solutions - Great Plains 8.0 or 7.5, click **Microsoft Business Solutions - Great Plains** on the **File** menu.

### Step 3: Assign security permissions to the modified report

To assign security permissions to the modified report, use one of the following methods.

#### Method 1: Use Advanced Security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Advanced Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box. Then, click **OK**.
3. In the Advanced Security window, click **View**, and then click **By Alternate, Modified and Custom**.
4. Use the appropriate step:

   - In Microsoft Dynamics GP 9.0 and higher, expand **Microsoft Dynamics GP**.

   - In Microsoft Business Solutions - Great Plains 8.0 or 7.5, expand **Great Plains**.

5. Expand **Reports**, expand the series for the report that you modified, and then expand the report that you modified.
6. Use the appropriate step:

   - In Microsoft Dynamics GP 9.0 and higher, click **Microsoft Dynamics GP (Modified)**.
   - In Microsoft Business Solutions - Great Plains 8.0 or 7.5, click **Great Plains (Modified)**.

7. Click **Apply**, and then click **OK**.

    > [!NOTE]
    > By default, when you start the Advanced Security tool, the current user and the current company are selected. Any changes that you make affect the current user and the current company. However, you can select additional users and companies in the **Company** area and the **Users** area of the Advanced Security window.

#### Method 2: Use standard security

1. On the **Tools** menu, point to **Setup**, point to **System**, and then click **Security**.
2. If you are prompted, type the system password in the **Please Enter Password** box. Then, click **OK**.
3. In the **User ID** list, click the ID of the user to whom you want to grant access.
4. In the **Type** list, click **Modified Reports**.
5. In the **Series** list, click the series for the report that you modified.

6. In the **Access List** box, double-click the report that you modified, and then click **OK**.

   > [!NOTE]
   > An asterisk appears next to the report name.

## Options for the RW_DateToString user-defined function

The following is a sample format string:

FUNCTION_SCRIPT(RW_DateToString Date "DD-mmm-YYYY")
The format string uses the following codes. These codes are substituted when the function is run.

|ddd|=|day of week as three letters|
|---|---|---|
|dddd|=|day of week in full|
|N|=|day of year|
|NN|=|day of year (padded)|
|D|=|day of month|
|DD|=|day of month (padded)|
|M|=|month of year|
|MM|=|month of year (padded)|
|mmm|=|month of year as three letters|
|mmmm|=|month of year in full|
|YY|=|year of date (two digits)|
|YYYY|=|year of date (four digits)|
  
  The following table contains several examples that are based on a date of April 12, 2007:

|DD-mmm-YYYY|=|12-Apr-2007|
|---|---|---|
|DD/MM/YYYY|=|12/04/2007|
|MM/DD/YY|=|04/12/07|
|M/D/YY|=|4/12/07|
|ddd, DD-mmm-YYYY|=|Thu, 12-Apr-2007|
|dddd, mmmm the DD in the year YYYY|=|Thursday, April the 12 in the year 2007|
|DD-mmm-YY is the NN day of YYYY|=|12-Apr-07 is the 102 day of 2007|
  
## References

For more information, see the Report Writer Programmer's Interface document in the Software Development Kit (SDK). The SDK can be installed from the Tools folder of CD 2 of the Microsoft Dynamics GP installation CDs.
