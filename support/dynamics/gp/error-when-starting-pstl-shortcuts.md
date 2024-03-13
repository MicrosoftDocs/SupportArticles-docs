---
title: Error when starting PSTL from Shortcuts
description: Provides a solution to an error that occurs when you start the Professional Services Tools Library from Shortcuts in Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "You cannot install an older version of Back Office Service Tools" Error message when you start the Professional Services Tools Library from Shortcuts in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you start the Professional Services Tools Library (PSTL) from Shortcuts in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 938108

## Symptoms

When you start the Professional Services Tools Library from the Shortcuts section of the navigation pane in Microsoft Dynamics GP, you receive the following error message:
> You cannot install an older version of Back Office Service Tools.

This problem occurs if you updated Microsoft Dynamics GP to a newer version.

## Cause

This problem occurs because the Professional Service Tools Library isn't updated when Microsoft Dynamics GP is updated to a newer version.

## Resolution

To resolve this problem, follow these steps:

1. Delete the reference to the Professional Service Tools Library from the Dynamics.set file in the Great Plains program folder.

    > [!NOTE]
    > By default, the GP program folder in Microsoft Dynamics GP is in the following location: `C:\Program Files\Microsoft Dynamics\GP`

    1. Follow the steps that are listed in [Steps to disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/help/872087).

    2. Delete the lines that are listed in the Dynamics.set file. For example, delete the following lines:
        - **1838**  
          **Technical Service Tools**  
        - **C:\Program Files\Microsoft Dynamics\GP\TAUTIL.DIC**  
        - **C:\Program Files\Microsoft Dynamics\GP\F1838.DIC**  
        - **C:\Program Files\Microsoft Dynamics\GP\R1838.DIC**  
    3. Save the changes. Then, close the Dynamics.set file.
2. Rename the TAUTIL.DIC file to *TAUTIL.DICOLD* in the GP program folder.
3. Have all users exit Microsoft Dynamics GP.
4. Drop all objects that are associated with the Professional Services Tools Library for the company that is experiencing the error. To do it, follow these steps:
    1. Start Microsoft Dynamics GP by signing in as the sa user.
    2. Select **File**, point to **Maintenance**, and then point to **SQL**.

        > [!NOTE]
        > The **SQL Maintenance** dialog box opens.
    3. In the **Database** field, select the database in which you experience the error.
    4. In the **Product** field, select **Technical Service Tools**.
    5. In the box that contains the object list, select all the objects.
    6. On the right side of the **SQL Maintenance** dialog box, select the **Drop Table** check box and the **Drop Auto Procedure** check box.
    7. Select **Process**.
    8. Select **Yes**.
    9. In the **SQL Maintenance** dialog box, select the **DYNAMICS** database. Then, repeat step 5d through step 5h for the DYNAMICS database.
5. Download the Professional Services Tools Library. For more information about the Professional Services Tools Library, use one of the following options:

    **Customers:**  
    For more information about PSTL, contact your partner of record. If you don't have a partner of record, visit [Microsoft Pinpoint](https://www.microsoft.com/solution-providers/home) to identify a partner.

6. After you download the appropriate file, extract the files to the GP program folder to reinstall the Professional Service Tools Library.
7. Start Microsoft Dynamics GP on the server. Sign in as the sa user.
8. Select **OK**.

    > [!NOTE]
    > If you receive a message, select **OK**.
9. Add the Professional Services Tools Library to the "Shortcuts" section of the navigation pane. To do it, follow these steps:
    1. Select **Add**. Then, select **Other Window**.
    2. In the **Add Window Shortcut** dialog box, type the following text in the **Name** field:  
    **Professional Services Tools Library**
    3. Under **Available Windows**, expand **Technical Service Tools**, expand **Project**, and then select **Professional Services Tools**.
    4. Select **Add**.
    5. Select **Done**.
10. Verify that **Professional Services Tools Library** is available under **Shortcuts**.
11. Repeat step 1 through step 11 for each company for which you want to use the Professional Services Tools Library.
