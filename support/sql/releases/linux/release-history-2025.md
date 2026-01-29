---
title: Release history for SQL Server 2025 on Linux
description: This article contains the release history for SQL Server 2025 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 01/29/2026
ms.update-cycle: 1095-days
appliesto:
  - SQL Server 2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2025 on Linux

The following table lists the release history for [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)].

| Release | Version | Release date |
| --- | --- | --- |
| [CU 1](#17-0-4006) | 17.0.4006.2 | 2026-01-29 |
| [GA](#17-0-1000) | 17.0.1000.7 | 2025-11-18 |

For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2022 on Linux](release-history-2022.md?view=sql-server-ver16&preserve-view=true).

## Release and container tag guidance

- Starting with [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], **SUSE Linux Enterprise Server** (SLES) isn't supported.

  Customers using earlier versions of [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] on SLES aren't affected, and there are no changes to your support for existing deployments. For more information about version lifecycle policies, see [SQL Server 2022](/lifecycle/products/sql-server-2022), [SQL Server 2019](/lifecycle/products/sql-server-2019), and [SQL Server 2017](/lifecycle/products/sql-server-2017). To upgrade to [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], [back up your databases and restore them](/sql/linux/sql-server-linux-backup-and-restore-database) to a [supported distribution](/sql/linux/sql-server-linux-release-notes-2025#supported-platforms).

- Some GDR releases apply only to Windows. These Windows-only GDRs aren't published for Linux, and don't appear in this article.

- Container tags can vary by release. For a list of available tags, see [RHEL](https://mcr.microsoft.com/product/mssql/rhel/server/tags) and [Ubuntu](https://mcr.microsoft.com/product/mssql/server/tags) in the Microsoft Artifact Registry.

<a id="17-0-4006"></a>

## CU 1 (January 2026)

This is the Cumulative Update 1 (CU 1) release of [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 17.0.4006.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2025/cumulativeupdate1.md).

> [!NOTE]  
> **Red Hat 10** and **Ubuntu 24.04** are fully supported on [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], starting with CU 1.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 10.x RPM packages**<br /><br />(Get RPM packages for [RHEL 9.x](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/ce/b11d/)) | 17.0.4006.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/10/mssql-server-2025/Packages/29/5f5c/mssql-server-17.0.4006.2-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/10/mssql-server-2025/Packages/da/2fb6/mssql-server-extensibility-17.0.4006.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/10/mssql-server-2025/Packages/3c/d5c5/mssql-server-fts-17.0.4006.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/10/mssql-server-2025/Packages/99/d17d/mssql-server-ha-17.0.4006.2-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/10/mssql-server-2025/Packages/5c/afba/mssql-server-polybase-17.0.4006.2-1.x86_64.rpm) |
| **Ubuntu 24.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 22.04](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/47/5a7a/)) | 17.0.4006.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/24.04/mssql-server-2025/pool/main/04/fe0b/mssql-server_17.0.4006.2-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/24.04/mssql-server-2025/pool/main/72/2407/mssql-server-extensibility_17.0.4006.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/24.04/mssql-server-2025/pool/main/6e/0549/mssql-server-fts_17.0.4006.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/24.04/mssql-server-2025/pool/main/17/c130/mssql-server-ha_17.0.4006.2-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/24.04/mssql-server-2025/pool/main/0f/ca21/mssql-server-polybase_17.0.4006.2-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="17-0-1000"></a>

## GA (November 2025)

This is the General Availability (GA) release of [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 17.0.1000.7.

> [!NOTE]  
> **Red Hat 10** and **Ubuntu 24.04** are supported (in preview) on [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)], starting with GA.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install SQL Server Full-Text Search on Linux](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent on Linux](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services (SSIS) on Linux](/sql/linux/sql-server-linux-setup-ssis)

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages** | 17.0.1000.7-7 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/f2/c293/mssql-server-17.0.1000.7-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/73/5579/mssql-server-extensibility-17.0.1000.7-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/6a/b338/mssql-server-fts-17.0.1000.7-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/e5/94a2/mssql-server-ha-17.0.1000.7-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9.0/mssql-server-2025/Packages/77/ab98/mssql-server-polybase-17.0.1000.7-7.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages** | 17.0.1000.7-7 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/be/1f46/mssql-server_17.0.1000.7-7_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/a9/54a3/mssql-server-extensibility_17.0.1000.7-7_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/53/13f0/mssql-server-fts_17.0.1000.7-7_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/f1/5df7/mssql-server-ha_17.0.1000.7-7_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2025/pool/main/f1/3837/mssql-server-polybase_17.0.1000.7-7_amd64.deb) |

Go back to the [release history](#release-history).

## Related content

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)
- [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat)
- [Quickstart: Install SQL Server and create a database on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Quickstart: Install SQL Server and create a database on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
- [Provision a Linux virtual machine running SQL Server in the Azure portal](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Quickstart: Run SQL Server in the cloud](/sql/linux/quickstart-install-connect-clouds)
