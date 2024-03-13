---
title: Change the sort order to Last Name
description: Describes how to change the sort order for employees in Microsoft Dynamics GP 10.0, in Microsoft Dynamics GP 9.0, and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: shannona, dbader
ms.topic: how-to
ms.date: 03/13/2024
---
# How to change the sort order for employees to "Last Name" in the Employee Maintenance window in Microsoft Dynamics GP

This article describes how to change the sort order for employees to **Last Name**.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 946278

## Introduction

In Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, you can change the sort order for employees in the Employee Maintenance window.

## More information

To change the sort order for employees to **Last Name** in the Employee Maintenance window, follow these steps:

1. Have all users exit Microsoft Dynamics GP.

2. Locate the Dex.ini file.

    > [!NOTE]
    >
    > - By default, the Dex.ini file is in the following location in Microsoft Dynamics GP 10.0:  
    > `C:\Program Files\Microsoft Dynamics\GP\Data`
    > - By default, the Dex.ini file is in the following location in Microsoft Dynamics GP 9.0:  
        `C:\Program Files\Microsoft Dynamics\GP`
    > - By default, the Dex.ini file is in the following location in Microsoft Business Solutions - Great Plains 8.0:  
        `C:\Program Files\Microsoft Business Solutions\Great Plains`

3. Right-click the **Dex.ini** file, and then select **Open**.

4. Insert the following line above the **Workstation=** line.

    > EmpLookup=2

    > [!NOTE]
    > To change the sort order for employees to **First Name** or to **Social Security Number**, replace **2** with one of the following numbers:
    >
    > - 3 : **First Name**  
    > - 4 : **Social Security Number**

5. On the **File** menu, select **Save**, and then close the Dex.ini file.
