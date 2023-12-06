---
title: Azure Connect feature pack for SQL Server 2016 Service Pack 3 (KB5014242)
description: This article contains the summary, improvements, and other information for the Azure Connect feature pack for Microsoft SQL Server 2016 Service Pack 3 (KB5014242).
ms.date: 10/26/2023
ms.custom: KB5014242
appliesto:
- SQL Server 2016 Service Pack 3
---

# KB5014242 - Azure Connect feature pack for SQL Server 2016 Service Pack 3

_Release Date:_ &nbsp; May 19, 2022  
_Version:_ &nbsp; 13.0.7000.253

This article describes the Azure Connect feature pack for Microsoft SQL Server 2016 Service Pack 3.

## Improvements included in this feature pack

- Adds support for the [link feature](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview) for Azure SQL Managed Instance, which enables database replication from SQL Server to [Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview).

- Adds improvement to enable distributed availability groups and service broker connections with Azure SQL Managed Instance.

- Adds improvement to certificate-based authentication between endpoints for database mirroring (Always On) and service broker connections, which facilitates rotation and management of certificates that are issued by a certificate authority.

- Adds improvement to use signed certificates that have multiple Domain Name System (DNS) names, which allows a selection of a single DNS name for securing database mirroring endpoints in SQL Server.

- Enables distributed availability groups in SQL Server Standard editions to establish database replication with Azure resources.

## How to obtain or download this feature pack

### Method 1: Microsoft Update

This update is available through Windows Update. When you turn on automatic updating, this update will be downloaded and installed automatically. For more information about how to turn on automatic updating, see [Windows Update: FAQ](https://support.microsoft.com/windows/windows-update-faq-8a903416-6f45-0718-f5c7-375e92dddeb2).

### Method 2: Microsoft Update Catalog

To get the standalone package for this update, go to the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5014242) website.

### Method 3: Microsoft Download Center

The following file is available for download from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the Azure Connect feature pack for SQL Server 2016 Service Pack 3 now](https://download.microsoft.com/download/1/9/7/197fcbdb-bf21-42e9-99a4-02048b000099/SQLServer2016-KB5014242-x64.exe)

## References

For more information about how to determine the current SQL Server version and edition, select the following article number to go to the article in the Microsoft Knowledge Base:

[321185](../../releases/download-and-install-latest-updates.md) How to identify your SQL Server version and edition
