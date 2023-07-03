---
title: Best practices for changing the service account
description: This article describes the best practices for changing the service account for the report server in Microsoft SQL Server Reporting Services and Power BI Report Server.
ms.date: 09/21/2020
ms.custom: sap:Reporting Services
ms.reviewer: tinadeo
---
# Best practices for changing the service account for the report server in SQL Server Reporting Services

This article introduces the best practices for changing the service account for the report server in Microsoft SQL Server Reporting Services and Power BI Report Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 958999

## Introduction

In Microsoft SQL Server Reporting Services, you can configure the report server to use the Service Credentials type for the database connection. When you try to change the service account by using the Services.msc management console, the operation may corrupt the encryption key that is used to protect sensitive information that is stored in the report server database. We recommend that you change the service account for the report server by using one of the following methods

## Method 1

Use Reporting Services Configuration Manager to change the service account for the report server. To do this follow these steps:

1. Open Reporting Services Configuration Manager, and then connect to the instance of SQL Server Reporting Services.
2. Click **Microsoft service Identity** on the left pane.
3. Change the account and the password in the **Account** text box and the **Password** text box, and then click **Apply**.

## Method 2

Use the `Rsconfig.exe` utility to change the service account for the report server. To do this, run the following command:

```console
Rsconfig -c -s <Server Name> -d <Database Name> -u <User Name> -p <Password> -a <Authentication Method>  
```

> [!NOTE]
> If the instance of SQL Server that hosts the report server database is a named instance, add the **-i** switch to specify the instance name.

## Method 3

If method 1 and method 2 do not work, use the `rskeymgmt` utility. When you use this utility, you must back up the encrypted keys before you change the user account that is used to run the Report Server Microsoft service or the Report Server Web service, and then you must apply the keys that were backed up. To do this, follow these steps on the computer that is running the service:

1. Start the Report Server Microsoft service and the Report Server Web service by using the user account that the service was running successfully for.
2. Use the `rskeymgmt` command-line utility to back up the encryption keys. To do this, run the command at the command prompt: `RSKeyMgmt -e -f <FileName> -p <StrongPassword>`  

    > [!NOTE]
    > By default, the `rskeymgmt` command-line utility is located in the `<InstallationDrive>:\Program Files\Microsoft SQL Server\80\Tools\Binn folder`.

    For more information about the `rskeymgmt` command-line utility, run the following command at the command prompt: `rskeymgmt /?`

3. Use the `rskeymgmt` command-line utility to remove the reference to the existing keys. To do this, run the command at the command prompt: `rskeymgmt -r <InstallationID>`  

    > [!NOTE]
    > Replace the `InstallationID` placeholder by using the installation ID that is provided in the InstallationID setting of the *RSReportServer.config* file. By default, the *RSReportServer.config* file is stored in the `<InstallationDrive>:\Program Files\Microsoft SQL Server\MSSQL\Reporting Services\ReportServer folder`.
4. Stop Internet Information Services (IIS).
5. Stop the Report Server Microsoft service.

6. Change the user account that is used to run the Report Server Microsoft service or the Report Server Web service to the user account that you want.
7. Start IIS.

8. Start the Report Server Microsoft service.

9. Use the rskeymgmt command-line utility to apply the encryption keys that were backed up in step 2. To do this, run the following command at the command prompt: `rskeymgmt -a -f <FileName> -p <StrongPassword>`

    > [!NOTE]
    > Replace the `<FileName>` placeholder and the `<StrongPassword>` placeholder with the file name and the password that you used to back up the symmetric encryption keys in step 1.
