---
title: Missing or incorrect service principal names
description: Fixes authentication and authorization problems in System Center Virtual Machine Manager due to missing or incorrect service principal names.
ms.date: 04/09/2024
ms.reviewer: wenca, steveth
---
# Authentication and authorization problems in System Center Virtual Machine Manager

This article helps you fix authentication and authorization problems in System Center Virtual Machine Manager due to missing or incorrect service principal names (SPNs).

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2961630

## Symptoms

You may encounter various problems with Microsoft System Center 2012 Virtual Machine Manager (VMM 2012) that are related to authentication and authorization if the required service principal names (SPNs) are missing or incorrect.

## Cause

This can occur if the missing or incorrect service principal names (SPNs) cause delegation to fail.

## Resolution

To resolve this issue, you can use the `setspn` command to check for duplicate SPNs and to create missing SPNs if this is necessary.

> [!NOTE]
> Not all SPNs may be required. The requirements will vary based on the server roles that are installed.

For virtual console support for Hyper-V hosts (VMConnect.exe), the following SPNs are required on Hyper-V hosts:

- `setspn -s computername "Microsoft Virtual Console Service/hostname"`
- `setspn -s computername "Microsoft Virtual Console Service/hostname.fqdn.etc"`

For RDP support, the following SPNs are required:

- `setspn -s computername TERMSRV/hostname.fqdn.etc`
- `setspn -s computername TERMSRV/hostname`

For the host, the following SPNs are required:

- `setspn -s computername HOST/hostname`
- `setspn -s computername HOST/hostname.fqdn.etc`

For HTTP, the following SPNs may be needed for authentication on SSP if the VMM server is using remote SQL:

- `setspn -s computername HTTP/hostname.fqdn.etc`
- `setspn -s computername HTTP/hostname`

For SQL, requirements depend on port and instance type.

For a named instance, the following SPNs are required:

- `setspn -s computername MSSQLSvc/hostname.fqdn.etc:Port`
- `setspn -s computername MSSQLSvc/hostname.fqdn.etc:InstanceName`

For a default instance, the following SPNs are required:

- `setspn -s computername MSSQLSvc/hostname:1433`
- `setspn -s computername MSSQLSvc/hostname.fqdn.etc:1433`

For more information, see the following resources:

- [How to Implement Kerberos Constrained Delegation with SQL Server 2008](/previous-versions/sql/sql-server-2008/ee191523(v=sql.100)?redirectedfrom=MSDN)
- [How to use SPNs when you configure web applications that are hosted on Internet Information Services](https://techcommunity.microsoft.com/t5/iis-support-blog/how-to-use-spns-when-you-configure-web-applications-that-are/ba-p/324648)
