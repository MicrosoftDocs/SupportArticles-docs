---
title: Error when you log on to Dynamics GP
description: Describes a problem that occurs when you try to log on to Microsoft Dynamics GP. A resolution is provided.
ms.topic: troubleshooting
ms.reviewer: theley, Kyouells
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error message when you try to log on to Microsoft Dynamics GP: "FP:Bad component offset.Form:80 Wind:1 Fld:14"

This article provides a solution to an error that occurs when you log on to Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861608

## Symptoms

When you try to log on to Microsoft Dynamics GP, you receive the following error message:

> FP:Bad component offset.Form:80 Wind:1 Fld:14

This problem occurs if one of the following conditions is true:

- You reinstall Microsoft Dynamics GP.
- You import a new database to Microsoft Dynamics GP.

## Cause

This problem occurs because the account framework of the Microsoft Dynamics GP dictionary or of the Microsoft Business Solutions - Great Plains dictionary differs from the account structure that is defined for the data in the Microsoft Dynamics GP database or in the Microsoft Business Solutions - Great Plains database.

## Resolution

To resolve this problem, synchronize the Microsoft Dynamics GP dictionary or the Microsoft Business Solutions - Great Plains dictionary by using the current account framework. To do this, follow these steps:

1. In Notepad, open the Dex.ini file.

    > [!NOTE]
    >
    > - By default, in Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0, the Dex.ini file is located in the folder: C:\\Program Files\\Microsoft Dynamics\\GP\\Data.
    > - By default, in Microsoft Dynamics GP 9.0, the Dex.ini file is located in the folder: C:\\Program Files\\Microsoft Dynamics\\GP.
    > - By default, in Microsoft Business Solutions - Great Plains 8.0, the Dex.ini file is located in the folder: C:\\Program Files\\Microsoft Business Solutions\\Great Plains.

2. In the open file, change the Synchronize value to TRUE as follows.

    `Synchronize=TRUE`

3. On the **File** menu, click **Save**.
4. On the **File** menu, click **Exit**.
5. Use the appropriate method:
   - In Microsoft Dynamics GP 2010, click **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 2010**, and then click **GP Utilities**.
   - In Microsoft Dynamics GP 10.0, click **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 10.0**, and then click **GP Utilities**.
   - In Microsoft Dynamics GP 9.0, click **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 9.0**, and then click **GP Utilities**.
   - In Microsoft Business Solutions - Great Plains 8.0, click **Start**, point to **All Programs**, point to **Microsoft Business Solutions**, point to **Great Plains**, and then click **Great Plains Utilities**.

6. Log on to Microsoft Dynamics GP or to Microsoft Business Solutions - Great Plains as the sa user.

    Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains starts the process to synchronize the account framework.

7. After the synchronization process is complete, click **Launch Microsoft Dynamics GP**.

## More information

After the synchronization process is complete, the Dex.ini file is automatically updated. The Synchronize value is reset to FALSE.
