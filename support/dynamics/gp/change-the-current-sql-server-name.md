---
title: Change the current SQL Server name
description: This article lists steps on how to change the Web Services files to the new Microsoft SQL Server name.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to change the current SQL Server name that is set up with Web Services for Microsoft Dynamics GP

This article describes how to change the current SQL Server name that is set up with Web Services for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927321

## Introduction

The following steps assume the computer on which the Web Services for Microsoft Dynamics GP were installed wasn't moved, and that only the Microsoft SQL Server databases were moved to a different Microsoft SQL Server.

1. Use Notepad or other text editor program to enter the new SQL Server name in the web.config file for the DynamicsGPWebServices application. The following is the default location for the web.config file:  

    `C:\Program Files\Microsoft Dynamics\GPWebServices\WebServices\web.config`

2. Locate the following code in the web.config file.

    ```sql
    <add key ="server" value="server_name" />
    ```

    > [!NOTE]
    > The "**server_name**" string represents the SQL Server name and instance. If the following conditions are true, change the value to **SQLServer\SQL2005**:
    >
    > - The SQL Server databases are on a named instance called SQL2005.
    > - The SQL Server computer name is SQLServer.

3. In the DynamicsSecurityServiceAppPool and GPWebServicesAppPool application pools in Internet Information Services (IIS) Manager, you must enter a domain account on the **Identity** tab. Additionally, this domain account must have the DYNGRP role membership in the DYNAMICS and company databases. The domain account that you specify must be a member of the IIS_WPG group on the computer. To do it, follow these steps:

    1. Select **Start**, point to **Administrative Tools**, and then double-click **Internet Information Services (IIS) Manager**.
    2. Expand **Application Pools**.
    3. Right-click **GPWebServicesAppPool**, and then select **Properties**.
    4. On the **Identity** tab, enter the domain account information in the **username** and **password** fields.

        > [!NOTE]
        > The format for the **username** field is `Domain\User`.

    5. Select **OK**.
    6. Repeat steps c and d for the DynamicsSecurityServiceAppPool application pool.

    > [!NOTE]
    > The domain account that you entered for the DynamicsSecurityServiceAppPool and GPWebServicesAppPool application pools must be a domain account. It's because Microsoft SQL Server and IIS are on separate computers. For the application pool to function correctly, the domain account must have access to the IIS_WPG group on the local computer.

4. Give eConnect 9 for Great Plains COM+ domain account DYNGRP role access to the DYNAMICS and company databases. To do it, follow these steps:
    1. Select **Start**, select **Administrative Tools**, and then double-click **Component Services**.
    2. Expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **COM+ Applications**.
    3. Right-click **eConnect 9 for Great Plains**, and then select **Properties**.
    4. On the **Identity** tab, enter the domain account information in the **username** and **password** fields.

5. Restart IIS. To do it, select **Start**, select **Run**, type **IISRESET** in the **Open** Box, and then select **OK**.

6. Test this configuration changes by using the Policy data in the Dynamics Security Console. In the Dynamics Security Console, confirm that all aspects of the Web Services for Microsoft Dynamics GP are working as expected. To do it, follow these steps:
    1. Select **Start**, point to **Administrative Tools**, and then double-click **Dynamics Security Console**.
    2. Select **Select Applications**, and then wait for the Dynamics GP Web Services application to appear in the Select Applications window.
    3. Select **OK**.
    4. Expand **Microsoft Dynamics Security**, and then expand **DynamicsGPWeb Services**.
    5. When you select the **Policy** node, the list of Policies appears in the right-hand pane.

## References

For more information, see [How to transfer an existing Microsoft Dynamics GP, Microsoft Small Business Financials, or Microsoft Small Business Manager installation to a new server that is running Microsoft SQL Server](https://support.microsoft.com/help/878449).
