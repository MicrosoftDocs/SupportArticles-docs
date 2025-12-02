---
title: Release history for SQL Server 2025 on Linux
description: This article contains the release history for SQL Server 2025 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 11/18/2025
ms.update-cycle: 1095-days
appliesto:
  - SQL Server 2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2025 on Linux

The following table lists the release history for [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2022 on Linux](release-history-2022.md?view=sql-server-ver16&preserve-view=true).

> [!NOTE]  
> Any missing GDRs apply to the Windows version only.

| Release | Version | Release date |
| --- | --- | --- |
| [GA](#17-0-1000) | 17.0.1000.7 | 2025-11-18 |

<a id="17-0-1000"></a>

## GA (November 2025)

This is the General Availability (GA) release of [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 17.0.1000.7.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install SQL Server Full-Text Search on Linux](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent on Linux](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services (SSIS) on Linux](/sql/linux/sql-server-linux-setup-ssis)

> [!NOTE]  
> **Red Hat 10** and **Ubuntu 24.04** are supported (in preview) on [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], starting with GA.

Starting with [!INCLUDE [sql-server-no-version.md](../../includes/versions/sql-server-no-version.md)], **SUSE Linux Enterprise Server** (SLES) isn't supported.

Customers using earlier versions of [!INCLUDE [sql-server-no-version.md](../../includes/versions/sql-server-no-version.md)] on SLES aren't affected, and there are no changes to your support for existing deployments. For more information about version lifecycle policies, see [SQL Server 2022](/lifecycle/products/sql-server-2022), [SQL Server 2019](/lifecycle/products/sql-server-2019), and [SQL Server 2017](/lifecycle/products/sql-server-2017). To upgrade to [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], [back up your databases and restore them](/sql/linux/sql-server-linux-backup-and-restore-database) to a [supported distribution](/sql/linux/sql-server-linux-release-notes-2025#supported-platforms).

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages** | 17.0.1000.7-7 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2025/Packages/m/mssql-server-17.0.1000.7-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2025/Packages/m/mssql-server-extensibility-17.0.1000.7-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2025/Packages/m/mssql-server-fts-17.0.1000.7-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2025/Packages/m/mssql-server-ha-17.0.1000.7-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2025/Packages/m/mssql-server-polybase-17.0.1000.7-7.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages** | 17.0.1000.7-7 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/m/mssql-server/mssql-server_17.0.1000.7-7_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_17.0.1000.7-7_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/m/mssql-server-fts/mssql-server-fts_17.0.1000.7-7_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/m/mssql-server-ha/mssql-server-ha_17.0.1000.7-7_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/m/mssql-server-polybase/mssql-server-polybase_17.0.1000.7-7_amd64.deb) |

Go back to the [release history](#release-history).

## Related content

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)
- [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat)
- [Quickstart: Install SQL Server and create a database on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Quickstart: Install SQL Server and create a database on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
- [Provision a Linux virtual machine running SQL Server in the Azure portal](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Quickstart: Run SQL Server in the cloud](/sql/linux/quickstart-install-connect-clouds)
