---
title: Release history for SQL Server 2025 Preview on Linux
description: This article contains the release history for SQL Server 2025 Preview running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 06/16/2025
appliesto:
  - SQL Server 2025 Preview
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2025 Preview on Linux

The following table lists the release history for [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2022 on Linux](release-history-2022.md?view=sql-server-ver16&preserve-view=true).

> [!NOTE]  
> Any missing GDRs apply to the Windows version only.

| Release | Version | Release date |
| --- | --- | --- |
| [CTP 2.1](#CTP2.1) | 17.0.800.3 | 2025-06-16 |
| [CTP 2.0](#CTP2.0) | 17.0.700.9 | 2025-05-19 |

## <a id="CTP2.1"></a> CTP 2.1 (June 2025)

This is the CTP 2.1 of [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. This is a pre-release version of [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 17.0.800.3.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages** | 17.0.800.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-17.0.800.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-extensibility-17.0.800.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-fts-17.0.800.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-ha-17.0.800.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-polybase-17.0.800.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 17.0.800.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-17.0.800.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-extensibility-17.0.800.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-fts-17.0.800.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-ha-17.0.800.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-polybase-17.0.800.3-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages** | 17.0.800.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server/mssql-server_17.0.800.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_17.0.800.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-fts/mssql-server-fts_17.0.800.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-ha/mssql-server-ha_17.0.800.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-polybase/mssql-server-polybase_17.0.800.3-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CTP2.0"></a> CTP 2.0 (May 2025)

This is the CTP 2.0 of [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)]. This is a pre-release version of [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 17.0.700.9.

> [!IMPORTANT]  
> In [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)] on Linux, the CPU time for a query (for example, returned by set statistics time, or captured via Extended Events or SQL Server Profiler traces) can currently display inaccurately. This amount can often show significantly more than the actual execution time, even when the query isn't running in parallel. This is a known issue, and we're actively working on a resolution. This issue affects [!INCLUDE [sql-server-2025](../../includes/versions/sql-server-2025.md)] on Linux deployed on traditional VMs, physical machines, and container-based environments. This issue is resolved in CTP 2.1.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages** | 17.0.700.9-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-17.0.700.9-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-extensibility-17.0.700.9-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-fts-17.0.700.9-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-ha-17.0.700.9-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-preview/Packages/m/mssql-server-polybase-17.0.700.9-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 17.0.700.9-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-17.0.700.9-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-extensibility-17.0.700.9-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-fts-17.0.700.9-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-ha-17.0.700.9-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-preview/Packages/m/mssql-server-polybase-17.0.700.9-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages** | 17.0.700.9-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server/mssql-server_17.0.700.9-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_17.0.700.9-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-fts/mssql-server-fts_17.0.700.9-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-ha/mssql-server-ha_17.0.700.9-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-preview/pool/main/m/mssql-server-polybase/mssql-server-polybase_17.0.700.9-1_amd64.deb) |

Go back to the [release history](#release-history).

## Related content

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)
- [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat)
- [Quickstart: Install SQL Server and create a database on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Quickstart: Install SQL Server and create a database on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
- [Provision a Linux virtual machine running SQL Server in the Azure portal](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Quickstart: Run SQL Server in the cloud](/sql/linux/quickstart-install-connect-clouds)
