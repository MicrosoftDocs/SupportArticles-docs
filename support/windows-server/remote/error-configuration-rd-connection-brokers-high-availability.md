---
title: Error after completing configuration of the RD Connection Broker server for high availability
description: Provides resolutions for the error that occur after completing configuration of the RD Connection Broker server for high availability.
ms.date: 11/06/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jenya, v-lianna
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# Error after completing configuration of the RD Connection Broker server for high availability

_Applies to:_ &nbsp; Windows Server 2016

You receive the following error message after completing [the configuration of the Remote Desktop Connection Broker (RD Connection Broker) server for high availability](/windows-server/remote/remote-desktop-services/rds-connection-broker-cluster#step-3-configure-the-connection-brokers-for-high-availability).

> Could not create the database \<DatabaseName>. Please check that the broker server has access to the SQL server, the path for -DatabaseFilePath parameter exists and contains the SQL Server database file, the connection to SQL database is correct and SQL database is online. See the SQL Server and broker event log for more details.

## Configure RD Connection Broker for High Availability wizard

When [configuring the RD Connection Broker server for high availability](/windows-server/remote/remote-desktop-services/rds-connection-broker-cluster#step-3-configure-the-connection-brokers-for-high-availability), the **Database connection string** field should be as follows:

DRIVER=SQL Server Native Client \<VersionNumber>;SERVER=\<SQL Server Name>;Trusted_Connection=Yes;APP=Remote Desktop Services Connection Broker;Database=\<New database file name>

:::image type="content" source="./media/error-configuration-rd-connection-brokers-high-availability/configure-rd-connection-broker-for-high-availability.png" alt-text="Wizard of Configure RD Connection Broker for High Availability.":::

> [!NOTE]
>
> - The string value is case-sensitive. Make sure the value for "Trusted_Connection" is "Yes" and not "YES".
> - The SQL Server Native Client version should be compatible with the SQL server.
> - Don't include the file extension when you input the file name into the string.

## Verify permission for the RD Connection Broker server on SQL Server 

Verify that correct permission is assigned to the RD Connection Broker Server on the SQL Server. To do that, follow these steps:

1. Sign in to the SQL server.
2. Open **Microsoft SQL Management Studio**.
3. Go to **Security** > **Logins** in **Object Explorer**, right-click the RD Connection Broker server, and select **Properties**.
4. Make sure the **dbcreator** and **public** checkboxes are selected under the **Server roles** pane.

:::image type="content" source="./media/error-configuration-rd-connection-brokers-high-availability/grant-permission-for-rdcb.png" alt-text="Select the dbcreator and public options under the Server roles page in Login Properties of the RD Connection Broker server in SQL Server Management Studio.":::

> [!NOTE]
> The RD Connection Broker server is now allowed to create databases in the SQL server. The RD Connection Broker service will attempt to migrate Windows Internal Database (WID) to a SQL Server instance when converting the RD Connection Broker server to a high available cluster.

## Check case-sensitivity of SQL Server collation

The database creation script for Remote Desktop Services (RDS) supports only case-insensitive collations. Make sure that the instance collation of the SQL Server database is set to be case-insensitive. 

## References

- [Add the RD Connection Broker server to the deployment and configure high availability](/windows-server/remote/remote-desktop-services/rds-connection-broker-cluster)
- [Useful log files for troubleshooting RDS issues](log-files-to-troubleshoot-rds-issues.md)
