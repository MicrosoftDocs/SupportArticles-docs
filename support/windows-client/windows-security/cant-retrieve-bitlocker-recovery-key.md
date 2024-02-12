---
title: Can't retrieve BitLocker Recovery key using MBAM 2.0 Self Service Portal
description: Provides a solution to an error that occurs when you try to open MBAM 2.0 Self Service Portal web page to retrieve BitLocker Recovery Key.
ms.date: 09/17/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, lacranda, manojse
ms.custom: sap:bitlocker, csstroubleshoot
---
# Users cannot retrieve BitLocker Recovery key using MBAM 2.0 Self Service Portal

This article provides a solution to an error that occurs when you try to open MBAM 2.0 Self Service Portal web page to retrieve BitLocker Recovery Key.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2870849

## Symptoms

If a user attempts to open MBAM 2.0 Self Service Portal web page to retrieve BitLocker Recovery Key, the web page may fail to open. Additionally, you may receive the following error message:

> There was error contacting the MBAM database. Please try again later.

## Cause

This problem can occur for two possible reasons:

1. Windows Firewall is blocking the traffic from machine to SQL Server.

    You will also see the below error message in the application logs where SSP feature is installed.

    > Exception message: A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)

2. User Support Service web.config file does not have connection string information.

## Resolution

To resolve this problem, do the following:

For Windows Firewall issue:

Open firewall ports for SQL Server. By default SQL uses port 1433 if you have configured SQL with a default instance.

[Configuring the Windows Firewall to Allow SQL Server Access](/previous-versions/sql/sql-server-2008-r2/cc646023(v=sql.105))

For User Support Service web.config file issue, follow the steps:

1. Connect to Server where MBAM 2.0 Self Service Portal feature is installed.
2. Open Windows Explorer and browse to c:\\inetpub\\MicrosoftBitLockerManagementSolution\\UserSupportService directory.
3. Make a copy of web.config file.
4. Edit the web.config file and make sure the connection string information is correct as shown below.
5. In the \<connectionStrings> block:

    ```xml
    <add name="ComplianceStatusConnectionString" providerName="System.Data.SqlClient" connectionString=""/>
    ```

    should be:

    ```xml
    <add name="ComplianceStatusConnectionString" providerName="System.Data.SqlClient" connectionString=" Data Source=[SQL server name];Initial Catalog=&quot;MBAM Compliance Status&quot;;Integrated Security=SSPI;"/>
    ```

    > [!NOTE]
    >
    > - Replace *[SQL server name]* with your SQL Server Name.
    > - Replace *MBAM Compliance Status* with name of MBAM Compliance Status DB.

    For example, if the name of your SQL Server is MBAMSQL and the name of MBAM Compliance DB is MBAM_Comp_DB, then the query should be:

    ```xml
    <add name="ComplianceStatusConnectionString" providerName="System.Data.SqlClient" connectionString="*Data Source=[MBAMSQL];Initial Catalog=&quot;MBAM_ Comp_DB &quot;;Integrated Security=SSPI;*"/>
    ```

6. Save the web.config file.
7. Restart IIS Services on Server.
8. Now user should be to retrieve BitLocker Recovery key successfully from MBAM SSP webpage.

## References

[How to Use the Self-Service Portal to Regain Access to a Computer](/microsoft-desktop-optimization-pack/mbam-v2/how-to-use-the-self-service-portal-to-regain-access-to-a-computer)
