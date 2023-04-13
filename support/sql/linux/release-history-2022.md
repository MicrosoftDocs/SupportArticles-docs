---
title: Release history for SQL Server 2022 on Linux
description: This article contains the release history for SQL Server 2022 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 04/13/2023
ms.prod: sql
---
# <a id="release-history"></a> Release history for SQL Server 2022 on Linux

[!INCLUDE [sql-server-2022-linux](../includes/applies-to/sql-server-2022-linux.md)]

The following table lists the release history for [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).

| Release                | Version       | Release date |
| ---------------------- | ------------- | ------------ |
| [CU 3](#CU3)           | 16.0.4025.1   | 2023-04-13   |
| [CU 2](#CU2)           | 16.0.4015.1   | 2023-03-15   |
| [CU 1](#CU1)           | 16.0.4003.1   | 2023-02-16   |
| [GDR 1](#GDR1)         | 16.0.1050.5   | 2023-02-14   |
| [GA](#GA)              | 16.0.1000.6   | 2022-11-16   |

## <a id="CU3"></a> CU 3 (April 2023)

This is the Cumulative Update 3 (CU 3) release of [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. The [!INCLUDE[sql-server-database-engine](../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4025.1. For information about the fixes and improvements in this release, see the [Support article](/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate3).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4025.1-13 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4025.1-13_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4025.1-13_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4025.1-13_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4025.1-13_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4025.1-13_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU2"></a> CU 2 (March 2023)

This is the Cumulative Update 2 (CU 2) release of [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. The [!INCLUDE[sql-server-database-engine](../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4015.1. For information about the fixes and improvements in this release, see the [Support article](/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate2).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4015.1-10 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4015.1-10_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4015.1-10_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4015.1-10_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4015.1-10_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4015.1-10_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU1"></a> CU 1 (February 2023)

This is the Cumulative Update 1 (CU 1) release of [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. The [!INCLUDE[sql-server-database-engine](../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4003.1. For information about the fixes and improvements in this release, see the [Support article](/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate1).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-is-16.0.4003.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4003.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4003.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4003.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4003.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4003.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4003.1-1_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-is/mssql-server-is_16.0.4003.1-1_amd64.deb) |

<sup>1</sup> SSIS package may have a different build number.

Go back to the [release history](#release-history).

## <a id="GDR1"></a> GDR 1 (February 2023)

This is the General Distribution Release GDR1 (GDR 1) of [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE[sql-server-database-engine](../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1050.5. For information about the fixes and improvements in this release, see [KB 5021522](https://support.microsoft.com/help/5021522).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1050.5-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.1050.5-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.1050.5-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.1050.5-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.1050.5-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.1050.5-4_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="GA"></a> GA (November 2022)

This is the General Availability (GA) release of [!INCLUDE[sql-server-2022](../includes/versions/sql-server-2022.md)]. The [!INCLUDE[sql-server-database-engine](../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1000.6.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install Full-Text Search package](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent package](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services](/sql/linux/sql-server-linux-setup-ssis)

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-is-16.0.950.9-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1000.6-26 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.1000.6-26_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.1000.6-26_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.1000.6-26_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.1000.6-26_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.1000.6-26_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-is/mssql-server-is_16.0.950.9-1_amd64.deb) |

<sup>1</sup> SSIS package may have a different build number.

Go back to the [release history](#release-history).

## See also

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)

## Next steps

- [Install on Red Hat Enterprise Linux](/sql/linux/quickstart-install-connect-red-hat)
- [Install on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Install on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Run on Docker](/sql/linux/quickstart-install-connect-docker)
- [Create a SQL VM in Azure](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Run & Connect - Cloud](/sql/linux/quickstart-install-connect-clouds)

