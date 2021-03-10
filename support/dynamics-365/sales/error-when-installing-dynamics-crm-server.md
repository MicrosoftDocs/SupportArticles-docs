---
title: Error when installing Dynamics CRM Server
description: Provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM Server 2016.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# SECDoClientHandshake() SSL Security error connecting SQL Server when you try to install Microsoft Dynamics CRM Server 2016

This article provides a solution to an error that occurs when you try to install Microsoft Dynamics CRM Server 2016.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Server 2016  
_Original KB number:_ &nbsp; 4077486

## Symptoms

When you try to install Dynamics CRM Server 2016, the Environment Diagnostics wizard fails with this error message:

> Error| Check SqlServerValidator : Failure: Could not connect to the following SQL Server: 'Server Name'. Verify that the server is up and running and that you have SQL Server administrative credentials. [DBNETLIB][ConnectionOpen (SECDoClientHandshake()).]SSL Security error.

## Cause

The Dynamics CRM Server 2016 wizard requires connectivity check through [Microsoft OLE DB Provider for SQL Server](/sql/ado/guide/appendixes/microsoft-ole-db-provider-for-sql-server) to start database creation. The installation documentation lists [software installed](https://technet.microsoft.com/library/hh699706.aspx) during the setup. It includes the [Install or upgrade Microsoft Dynamics CRM Server](/previous-versions/dynamicscrm-2016/deployment-administrators-guide/hh699706(v=crm.8)). The setup uses this native client and during the phase of the configuration database creation, OLE DB connection is required.

This connectivity failure reproduces when a test connection is created for the given SQL Server through a Universal Data Link (UDL) file.

1. Open Notepad.
2. Save the file as *Connectivity Test.udl* and file type as **All Files**.
3. Open the saved file.
4. Select Microsoft OLE DB Provider for SQL Server as the provider.
5. Provide server connection and authentication details.
6. Test the connection or open list of databases.
7. The connection fails with same error message.

It fails because the secured connection between the Dynamics CRM Server 2016 and the SQL Server needs TLS 1.0 to be enabled for the OLE DB Provider for SQL Server. And the SQL Server may not have TLS 1.0 enabled for secure channel communication.

The connectivity may fail even if TLS 1.1 or 1.2 is enabled on the SQL Server as the OLE DB Provider for SQL Server supports only TLS 1.0. Support for TLS 1.2 is provided for the providers listed in this article.

## Resolution

Enable TLS 1.0 for Microsoft OLE DB Provider for SQL Server on SQL Server. TLS 1.0 can be enabled with the following registry changes:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server] "Enabled"=dword:00000001`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server] "DisabledByDefault"=dword:00000000`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client] "Enabled"=dword:00000001`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client] "DisabledByDefault"=dword:00000000`

If the organization policy requires TLS 1.0 to be disabled, it can be done after the installation completes:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server] "Enabled"=dword:00000000`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server] "DisabledByDefault"=dword:00000001`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client] "Enabled"=dword:00000000`
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client] "DisabledByDefault"=dword:00000001`

TLS 1.0 may also need to be enabled on Dynamics CRM Server 2016 as client.

## More information

TLS 1.0 can be disabled on SQL Server and Dynamics CRM Server 2016 after the installation completes if the organization policy needs TLS 1.0 disabled.

References

- [SQL Server Native Client](/sql/relational-databases/native-client/sql-server-native-client)
- [Install or upgrade Microsoft Dynamics CRM Server](/previous-versions/dynamicscrm-2016/deployment-administrators-guide/hh699706(v=crm.8))
- [KB3135244 - TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/help/3135244)
- [Enable and Disable TLS 1.0](/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs#enable-and-disable-tls-10)
- [Microsoft OLE DB Provider for SQL Server Overview](/sql/ado/guide/appendixes/microsoft-ole-db-provider-for-sql-server)
