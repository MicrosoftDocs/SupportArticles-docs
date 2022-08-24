---
title: Checks cannot be calculated 
description: Provides a solution to an error that occurs when you try to calculate checks in Payroll in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Checks cannot be calculated while the year-end closing is in process" Error message displays when you try to calculate checks in Payroll in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to calculate checks in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855929

## Symptoms

When you try to calculate checks in Payroll in Microsoft Dynamics GP, you receive the following error message:
> Checks cannot be calculated while the year-end closing is in process.

This problem occurs even though you've removed the Year-End Wage file.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. Enter a date that is in the upcoming new year in the User Date window.

    > [!NOTE]
    > After you change the date in the User Date window, you must remove the build in the Build Payroll Checks window, and then build the payroll checks again in the Build Payroll Check window.
2. Change the value in the **YENDCRTD** field in the UPR10100 table. To do it, follow these steps:

    1. Start SQL Server Management Studio. To do it,  select **Start**, point to **All Programs**, point to **Microsoft SQL Server 20XX** **(XX=your version)**, and then select **SQL Server Management Studio**.
    1. Run the following statement against the company database.

        ```sql
        select YENDCRTD, * from UPR10100
        ```

    1. > [!NOTE]
       > The value in the **YENDCRTD** field. If the value in the field is **1**, change the value in the **YENDCRTD** field to **0**.

        For more information about how to change the value to **0** in the **YENDCRTD** field, contact your partner or technical support.
        > [!NOTE]
        > If you must create the W-2 Electronic File or print W-2s, you must change the value in the **YENDCRTD** field back to 1 after you complete the pay run.

3. If you've a Wennsoft product, verify that the **Rate Class** setting is unmarked in the Posting Options window.

    The information and the solution in this document represents the current view of Microsoft Corporation on these issues as of the date of publication. This solution is available through Microsoft or through a third-party provider. Microsoft doesn't specifically recommend any third-party provider or third-party solution that this article might describe. There might also be other third-party providers or third-party solutions that this article doesn't describe. Because Microsoft must respond to changing market conditions, this information shouldn't be interpreted to be a commitment by Microsoft. Microsoft can't guarantee or support the accuracy of any information or of any solution that is presented by Microsoft or by any mentioned third-party provider.

    Microsoft makes no warranties and excludes all representations, warranties, and conditions whether express, implied, or statutory. These include but aren't limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition, merchantability, and fitness for a particular purpose, regarding any service, solution, product, or any other materials or information. In no event will Microsoft be liable for any third-party solution that this article mentions.
