---
title: Azure Connect feature pack for SQL Server 2017 (KB5050533)
description: This article contains the summary, improvements, and other information for the Azure Connect feature pack for Microsoft SQL Server 2017 (KB5050533).
ms.date: 03/06/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5050533
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5050533 - Azure Connect feature pack for SQL Server 2017

_Release Date:_ &nbsp; March 06, 2025  
_Version:_ &nbsp; 14.0.3490.10

This article describes the Azure Connect feature pack for Microsoft SQL Server 2017.

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

To get the standalone package for this update, go to the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5050533) website.

### Method 3: Microsoft Download Center

The following file is available for download from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the Azure Connect feature pack for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

## References

For more information about how to determine the current SQL Server version and edition, select the following article number to go to the article in the Microsoft Knowledge Base:

[321185](../../releases/download-and-install-latest-updates.md) How to identify your SQL Server version and edition
