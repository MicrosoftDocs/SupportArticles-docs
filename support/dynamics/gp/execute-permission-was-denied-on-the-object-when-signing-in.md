---
title: The EXECUTE permission was denied on the object error when signing in
description: Provides a resolution for the error that occurs when you try to sign in to Microsoft Dynamics PDK 2013.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 04/22/2021
---
# "The EXECUTE permission was denied on the object..." error when signing in to Microsoft Dynamics PDK 2013

This article provides steps on how to solve the **EXECUTE permission was denied on the object** error that occurs when you try to sign in to Microsoft Dynamics PDK 2013.

_Applies to:_ &nbsp; Microsoft Dynamics GP 2013  
_Original KB number:_ &nbsp; 2870546

## Symptoms

You may get the one or more of following errors after the password is changed on MS Dynamics PDK 2013 when the user tries to log in:

> [Microsoft][SQL Server Native Client 10.0][SQL Server] The EXECUTE permission was denied on the object 'zDP_SY02100SS_1', database 'master', schema 'dbo'.
>
> A get/change on operation table 'SY_Pathnames' failed accessing SQL data.
>
> You're attempting to log in from a data source using a trusted connection. Update the SQL Server settings for this data source to disable trusted connections and try logging in again.

## Cause

The PDK ODBC gets set to a default database name of *Master*, instead of *Dynamics*, since Microsoft Dynamics GP 2013 allows you to name this (Dynamics)database whatever you want. This happens when the ODBC is created by PDK.

## Resolution

To resolve this issue, you will need to set the Default Database for the PDK ODBC to *Dynamics* (or whatever you named this database). Follow these steps:

1. Exit PDK.
2. Navigate to **Start**, select **Control Panel**, select **Administrative Tools**, select **Data Sources (ODBC)**, and select the **System DSN** tab.
3. Select the ODBC for PDK, and select **Configure**. (If you don't know the name of the ODBC, sign in to PDK and see what you selected for the Data Server name.)
4. Select **Next** to get to the Microsoft SQL Server DSN Configuration window.
5. Change the name of the database from *Master* to *DYNAMICS* in the field for Change the default database to:

    > [!NOTE]
    > Both of the checkboxes for the **Use ANSI...** settings should not be marked.

6. Select **Next** and **Finish**.
7. Sign in to PDK and the error should now be gone.

## More information

Another reason may also be that the user in not in the role of DYNGRP. In SQL Server Management Studio, under the SQL instance, expand **Databases**, expand the company database, expand Security and expand **Users**. Right-click the user having issues and select **Properties**. Under **General**, verify the user is in the DYNGRP role. Relaunch PDK and verify the error no longer happens.
