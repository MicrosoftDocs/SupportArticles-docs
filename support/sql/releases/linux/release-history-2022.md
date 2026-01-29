---
title: Release history for SQL Server 2022 on Linux
description: This article contains the release history for SQL Server 2022 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 01/29/2026
ms.update-cycle: 1095-days
appliesto:
  - SQL Server 2022
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2022 on Linux

The following table lists the release history for [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)].

| Release | Version | Release date |
| --- | --- | --- |
| [CU 23](#16-0-4236) | 16.0.4236.2 | 2026-01-29 |
| [CU 22 GDR (Jan 2026)](#16-0-4230) | 16.0.4230.2 | 2026-01-13 |
| [CU 22](#16-0-4225) | 16.0.4225.2 | 2025-11-13 |
| [CU 21 GDR (Nov 2025)](#16-0-4222) | 16.0.4222.2 | 2025-11-11 |
| [CU 21](#16-0-4215) | 16.0.4215.2 | 2025-09-11 |
| [CU 20 GDR (Sep 2025)](#16-0-4212) | 16.0.4212.1 | 2025-09-09 |
| [CU 20 GDR (Aug 2025)](#16-0-4210) | 16.0.4210.1 | 2025-08-12 |
| [CU 20](#16-0-4205) | 16.0.4205.1 | 2025-07-10 |
| [CU 19 GDR (Jul 2025)](#16-0-4200) | 16.0.4200.1 | 2025-07-08 |
| [CU 19](#16-0-4195) | 16.0.4195.2 | 2025-05-15 |
| [CU 18](#16-0-4185) | 16.0.4185.3 | 2025-03-13 |
| [CU 17](#16-0-4175) | 16.0.4175.1 | 2025-01-16 |
| [CU 16](#16-0-4165) | 16.0.4165.4 | 2024-11-14 |
| [CU 15 GDR (Nov 2024)](#16-0-4155) | 16.0.4155.4 | 2024-11-12 |
| [CU 15 GDR (Oct 2024)](#16-0-4150) | 16.0.4150.1 | 2024-10-08 |
| [CU 15](#16-0-4145) | 16.0.4145.4 | 2024-09-25 |
| [CU 14 GDR (Sep 2024)](#16-0-4140) | 16.0.4140.3 | 2024-09-10 |
| [CU 14](#16-0-4135) | 16.0.4135.4 | 2024-07-23 |
| [CU 13](#16-0-4125) | 16.0.4125.3 | 2024-05-16 |
| [CU 12 GDR (Apr 2024)](#16-0-4120) | 16.0.4120.1 | 2024-04-09 |
| [CU 12](#16-0-4115) | 16.0.4115.5 | 2024-03-14 |
| [CU 11](#16-0-4105) | 16.0.4105.2 | 2024-01-11 |
| [CU 10 GDR (Jan 2024)](#16-0-4100) | 16.0.4100.1 | 2024-01-09 |
| [CU 10](#16-0-4095) | 16.0.4095.4 | 2023-11-16 |
| [CU 9](#16-0-4085) | 16.0.4085.2 | 2023-10-12 |
| [CU 8 GDR (Oct 2023)](#16-0-4080) | 16.0.4080.1 | 2023-10-10 |
| [CU 8](#16-0-4075) | 16.0.4075.1 | 2023-09-15 |
| [CU 7](#16-0-4065) | 16.0.4065.3 | 2023-08-10 |
| [CU 6](#16-0-4055) | 16.0.4055.4 | 2023-07-13 |
| [CU 5](#16-0-4045) | 16.0.4045.3 | 2023-06-15 |
| [CU 4](#16-0-4035) | 16.0.4035.4 | 2023-05-11 |
| [CU 3](#16-0-4025) | 16.0.4025.1 | 2023-04-13 |
| [CU 2](#16-0-4015) | 16.0.4015.1 | 2023-03-15 |
| [CU 1](#16-0-4003) | 16.0.4003.1 | 2023-02-16 |
| [GDR (Feb 2023)](#16-0-1050) | 16.0.1050.5 | 2023-02-14 |
| [GA](#16-0-1000) | 16.0.1000.6 | 2022-11-16 |

For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2025 on Linux](release-history-2025.md?view=sql-server-ver17&preserve-view=true).

## Release and container tag guidance

- The **mssql-server-is** package isn't supported on SUSE Linux Enterprise Server (SLES). For more information, see [SQL Server on Linux: Known issues](/sql/linux/sql-server-linux-known-issues#sql-server-integration-services-ssis).

- Some GDR releases apply only to Windows. These Windows-only GDRs aren't published for Linux, and don't appear in this article.

- Container tags can vary by release. For a list of available tags, see [RHEL](https://mcr.microsoft.com/product/mssql/rhel/server/tags) and [Ubuntu](https://mcr.microsoft.com/product/mssql/server/tags) in the Microsoft Artifact Registry.

<a id="16-0-4236"></a>

## CU 23 (January 2026)

This is the Cumulative Update 23 (CU 23) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4236.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate23.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a0/9d7a/)) | 16.0.4236.2-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bc/0147/mssql-server-16.0.4236.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d5/10df/mssql-server-extensibility-16.0.4236.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bd/d8b2/mssql-server-fts-16.0.4236.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/08/34db/mssql-server-ha-16.0.4236.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/89/4a5b/mssql-server-polybase-16.0.4236.2-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4236.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d3/8efc/mssql-server-16.0.4236.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6b/b620/mssql-server-extensibility-16.0.4236.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/96/f623/mssql-server-fts-16.0.4236.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/5e/b02d/mssql-server-ha-16.0.4236.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/7f/2408/mssql-server-polybase-16.0.4236.2-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ce/47f6/)) | 16.0.4236.2-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/8b/356a/mssql-server_16.0.4236.2-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/08/5d7c/mssql-server-extensibility_16.0.4236.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/17/9481/mssql-server-fts_16.0.4236.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/23/28b8/mssql-server-ha_16.0.4236.2-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/88/266c/mssql-server-polybase_16.0.4236.2-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4230"></a>

## CU 22 GDR (January 2026)

This is the Cumulative Update 22-GDR (CU 22 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 22). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4230.2. For information about the fixes and improvements in this release, see [KB 5072936](https://support.microsoft.com/help/5072936).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a0/5c2d/)) | 16.0.4230.2-7 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/f3/47f7/mssql-server-16.0.4230.2-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/2e/8ab2/mssql-server-extensibility-16.0.4230.2-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/11/8f63/mssql-server-fts-16.0.4230.2-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/5e/4070/mssql-server-ha-16.0.4230.2-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/9e/ac06/mssql-server-polybase-16.0.4230.2-7.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4230.2-7 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/1f/8ca5/mssql-server-16.0.4230.2-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/0d/feb9/mssql-server-extensibility-16.0.4230.2-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/95/0854/mssql-server-fts-16.0.4230.2-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d3/7879/mssql-server-ha-16.0.4230.2-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/34/d836/mssql-server-polybase-16.0.4230.2-7.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/14/1ab1/)) | 16.0.4230.2-7 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/30/e25e/mssql-server_16.0.4230.2-7_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/86/3b09/mssql-server-extensibility_16.0.4230.2-7_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/36/d99a/mssql-server-fts_16.0.4230.2-7_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/5e/7274/mssql-server-ha_16.0.4230.2-7_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/40/e154/mssql-server-polybase_16.0.4230.2-7_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4225"></a>

## CU 22 (November 2025)

This is the Cumulative Update 22 (CU 22) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4225.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate22.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/85/2f3d/)) | 16.0.4225.2-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/b7/8d92/mssql-server-16.0.4225.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e8/5666/mssql-server-extensibility-16.0.4225.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/20/0796/mssql-server-fts-16.0.4225.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/cc/ea04/mssql-server-ha-16.0.4225.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/2f/fa32/mssql-server-polybase-16.0.4225.2-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4225.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c4/ca9a/mssql-server-16.0.4225.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6f/5fb9/mssql-server-extensibility-16.0.4225.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/0f/e810/mssql-server-fts-16.0.4225.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/86/c44a/mssql-server-ha-16.0.4225.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c4/6c1d/mssql-server-polybase-16.0.4225.2-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e4/86bd/)) | 16.0.4225.2-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/fc/c507/mssql-server_16.0.4225.2-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/ee/d9d9/mssql-server-extensibility_16.0.4225.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/f6/ff2e/mssql-server-fts_16.0.4225.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/8f/c3be/mssql-server-ha_16.0.4225.2-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/39/c8ad/mssql-server-polybase_16.0.4225.2-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4222"></a>

## CU 21 GDR (November 2025)

This is the Cumulative Update 21-GDR (CU 21 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 21). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4222.2. For information about the fixes and improvements in this release, see [KB 5068406](https://support.microsoft.com/help/5068406).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/7c/2917/)) | 16.0.4222.2-5 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/35/4097/mssql-server-16.0.4222.2-5.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/eb/3319/mssql-server-extensibility-16.0.4222.2-5.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/00/1e6e/mssql-server-fts-16.0.4222.2-5.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/dc/30cc/mssql-server-ha-16.0.4222.2-5.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e0/10b8/mssql-server-polybase-16.0.4222.2-5.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4222.2-5 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/bd/d9e4/mssql-server-16.0.4222.2-5.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/49/fcfc/mssql-server-extensibility-16.0.4222.2-5.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/21/e5af/mssql-server-fts-16.0.4222.2-5.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/4c/d60f/mssql-server-ha-16.0.4222.2-5.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e8/8845/mssql-server-polybase-16.0.4222.2-5.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/24/5fb7/)) | 16.0.4222.2-5 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/e4/5ea3/mssql-server_16.0.4222.2-5_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/d6/cc52/mssql-server-extensibility_16.0.4222.2-5_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/e3/7363/mssql-server-fts_16.0.4222.2-5_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/cc/ecec/mssql-server-ha_16.0.4222.2-5_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/81/2c2d/mssql-server-polybase_16.0.4222.2-5_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4215"></a>

## CU 21 (September 2025)

This is the Cumulative Update 21 (CU 21) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4215.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate21.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a7/5576/)) | 16.0.4215.2-2 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/10/b249/mssql-server-16.0.4215.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/41/5218/mssql-server-extensibility-16.0.4215.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ad/7546/mssql-server-fts-16.0.4215.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/c3/9635/mssql-server-ha-16.0.4215.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d2/0df1/mssql-server-polybase-16.0.4215.2-2.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/9d/b40e/mssql-server-is-16.0.4215.2-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4215.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/16/bf39/mssql-server-16.0.4215.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/68/3320/mssql-server-extensibility-16.0.4215.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a3/01ae/mssql-server-fts-16.0.4215.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/34/2af8/mssql-server-ha-16.0.4215.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/2c/3503/mssql-server-polybase-16.0.4215.2-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e9/6135/)) | 16.0.4215.2-2 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c5/9dad/mssql-server_16.0.4215.2-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/f8/efd4/mssql-server-extensibility_16.0.4215.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/1b/7620/mssql-server-fts_16.0.4215.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/ca/ea45/mssql-server-ha_16.0.4215.2-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/74/01c4/mssql-server-polybase_16.0.4215.2-2_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/43/d6f8/mssql-server-is_16.0.4215.2-3_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

<a id="16-0-4212"></a>

## CU 20 GDR (September 2025)

This is the Cumulative Update 20-GDR (CU 20 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 20). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4212.1. For information about the fixes and improvements in this release, see [KB 5065220](https://support.microsoft.com/help/5065220).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/31/b8c0/)) | 16.0.4212.1-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/51/103e/mssql-server-16.0.4212.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/56/1914/mssql-server-extensibility-16.0.4212.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/0a/eeb7/mssql-server-fts-16.0.4212.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bf/1430/mssql-server-ha-16.0.4212.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/1a/4f9a/mssql-server-polybase-16.0.4212.1-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4212.1-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/3f/1f12/mssql-server-16.0.4212.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c3/a439/mssql-server-extensibility-16.0.4212.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/29/c01a/mssql-server-fts-16.0.4212.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/4a/a1b6/mssql-server-ha-16.0.4212.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/50/b38e/mssql-server-polybase-16.0.4212.1-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/b6/9d2f/)) | 16.0.4212.1-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/78/6147/mssql-server_16.0.4212.1-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/80/9f30/mssql-server-extensibility_16.0.4212.1-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/36/1d0b/mssql-server-fts_16.0.4212.1-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/46/564d/mssql-server-ha_16.0.4212.1-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/95/4f39/mssql-server-polybase_16.0.4212.1-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4210"></a>

## CU 20 GDR (August 2025)

This is the Cumulative Update 20-GDR (CU 20 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 20). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4210.1. For information about the fixes and improvements in this release, see [KB 5063814](https://support.microsoft.com/help/5063814).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/41/76ee/)) | 16.0.4210.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ef/7b08/mssql-server-16.0.4210.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/45/0e02/mssql-server-extensibility-16.0.4210.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/0f/d212/mssql-server-fts-16.0.4210.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/77/d126/mssql-server-ha-16.0.4210.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/2f/1fd3/mssql-server-polybase-16.0.4210.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4210.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/86/1f28/mssql-server-16.0.4210.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/35/84c7/mssql-server-extensibility-16.0.4210.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/9c/9536/mssql-server-fts-16.0.4210.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/61/d9d3/mssql-server-ha-16.0.4210.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/7a/57f6/mssql-server-polybase-16.0.4210.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/a4/0d2d/)) | 16.0.4210.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/8f/462e/mssql-server_16.0.4210.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/57/ae0b/mssql-server-extensibility_16.0.4210.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/57/93f3/mssql-server-fts_16.0.4210.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/02/abc9/mssql-server-ha_16.0.4210.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/0a/a1be/mssql-server-polybase_16.0.4210.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4205"></a>

## CU 20 (July 2025)

This is the Cumulative Update 20 (CU 20) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4205.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate20.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/65/66e6/)) | 16.0.4205.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/b5/76d1/mssql-server-16.0.4205.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/6a/0c44/mssql-server-extensibility-16.0.4205.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/81/f12e/mssql-server-fts-16.0.4205.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/73/ff89/mssql-server-ha-16.0.4205.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/3e/5348/mssql-server-polybase-16.0.4205.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4205.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/40/1538/mssql-server-16.0.4205.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d9/44f4/mssql-server-extensibility-16.0.4205.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/16/e899/mssql-server-fts-16.0.4205.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/79/93d8/mssql-server-ha-16.0.4205.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/41/97f7/mssql-server-polybase-16.0.4205.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/f1/1e13/)) | 16.0.4205.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/34/bda0/mssql-server_16.0.4205.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/66/2f1e/mssql-server-extensibility_16.0.4205.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/f7/c4d0/mssql-server-fts_16.0.4205.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/33/5f81/mssql-server-ha_16.0.4205.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/20/c184/mssql-server-polybase_16.0.4205.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4200"></a>

## CU 19 GDR (July 2025)

This is the Cumulative Update 19-GDR (CU 19 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 19). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4200.1. For information about the fixes and improvements in this release, see [KB 5058721](https://support.microsoft.com/help/5058721).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/87/0ea5/)) | 16.0.4200.1-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/82/bde1/mssql-server-16.0.4200.1-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/42/b745/mssql-server-extensibility-16.0.4200.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/01/c4a1/mssql-server-fts-16.0.4200.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/21/d36f/mssql-server-ha-16.0.4200.1-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/3f/58e8/mssql-server-polybase-16.0.4200.1-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4200.1-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e4/dc22/mssql-server-16.0.4200.1-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/13/81a7/mssql-server-extensibility-16.0.4200.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/3d/e2b4/mssql-server-fts-16.0.4200.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c9/caed/mssql-server-ha-16.0.4200.1-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fe/c41f/mssql-server-polybase-16.0.4200.1-4.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/de/3110/)) | 16.0.4200.1-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/bc/1799/mssql-server_16.0.4200.1-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/9e/4a19/mssql-server-extensibility_16.0.4200.1-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/3b/af22/mssql-server-fts_16.0.4200.1-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c6/0d97/mssql-server-ha_16.0.4200.1-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/15/bc35/mssql-server-polybase_16.0.4200.1-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4195"></a>

## CU 19 (May 2025)

This is the Cumulative Update 19 (CU 19) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4195.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate19.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/89/b7d5/)) | 16.0.4195.2-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/16/7b8c/mssql-server-16.0.4195.2-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/88/542a/mssql-server-extensibility-16.0.4195.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/1f/e0a4/mssql-server-fts-16.0.4195.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/f6/a45a/mssql-server-ha-16.0.4195.2-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/f9/1195/mssql-server-polybase-16.0.4195.2-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4195.2-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/4a/459e/mssql-server-16.0.4195.2-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c7/8ac9/mssql-server-extensibility-16.0.4195.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/2e/91e4/mssql-server-fts-16.0.4195.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/21/bfb3/mssql-server-ha-16.0.4195.2-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fe/4f68/mssql-server-polybase-16.0.4195.2-4.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/1d/baf0/)) | 16.0.4195.2-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/93/6e9a/mssql-server_16.0.4195.2-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/fb/c50e/mssql-server-extensibility_16.0.4195.2-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/e0/a13c/mssql-server-fts_16.0.4195.2-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/6e/41d2/mssql-server-ha_16.0.4195.2-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/23/c353/mssql-server-polybase_16.0.4195.2-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4185"></a>

## CU 18 (March 2025)

This is the Cumulative Update 18 (CU 18) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4185.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate18.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/4a/e123/)) | 16.0.4185.3-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/33/71da/mssql-server-16.0.4185.3-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/08/3c36/mssql-server-extensibility-16.0.4185.3-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ac/1e40/mssql-server-fts-16.0.4185.3-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/8b/acb7/mssql-server-ha-16.0.4185.3-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ea/2bef/mssql-server-polybase-16.0.4185.3-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4185.3-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/74/5f33/mssql-server-16.0.4185.3-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/0d/985a/mssql-server-extensibility-16.0.4185.3-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b2/5832/mssql-server-fts-16.0.4185.3-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fa/a165/mssql-server-ha-16.0.4185.3-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/18/da87/mssql-server-polybase-16.0.4185.3-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/0b/5892/)) | 16.0.4185.3-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/b6/b8cb/mssql-server_16.0.4185.3-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/43/ca40/mssql-server-extensibility_16.0.4185.3-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/4e/bf7d/mssql-server-fts_16.0.4185.3-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/f6/99c6/mssql-server-ha_16.0.4185.3-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/5f/04c3/mssql-server-polybase_16.0.4185.3-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4175"></a>

## CU 17 (January 2025)

This is the Cumulative Update 17 (CU 17) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4175.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate17.md).

> [!IMPORTANT]  
> The Microsoft Entra managed identity feature for SQL Server on Azure VM isn't supported on Linux. For more information, see [Improvement: Microsoft Entra managed identity support for backup and restore database operations and for EKM with AKV in SQL Server on Azure VMs](../sqlserver-2022/microsoft-entra-managed-identity-support-for-backup-restore-database-ekm-akv.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/b1/b681/)) | 16.0.4175.1-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/94/3dfa/mssql-server-16.0.4175.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/41/6627/mssql-server-extensibility-16.0.4175.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/db/e24d/mssql-server-fts-16.0.4175.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/b6/9124/mssql-server-ha-16.0.4175.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bc/2144/mssql-server-polybase-16.0.4175.1-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4175.1-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a1/816b/mssql-server-16.0.4175.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fe/c09b/mssql-server-extensibility-16.0.4175.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/74/0f06/mssql-server-fts-16.0.4175.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/1c/6692/mssql-server-ha-16.0.4175.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/38/6a25/mssql-server-polybase-16.0.4175.1-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/5d/a65c/)) | 16.0.4175.1-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/db/bb86/mssql-server_16.0.4175.1-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/bc/d79b/mssql-server-extensibility_16.0.4175.1-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c4/d251/mssql-server-fts_16.0.4175.1-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/f2/0f66/mssql-server-ha_16.0.4175.1-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/e9/0a0b/mssql-server-polybase_16.0.4175.1-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4165"></a>

## CU 16 (November 2024)

This is the Cumulative Update 16 (CU 16) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4165.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate16.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/70/96d3/)) | 16.0.4165.4-7 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/99/c70a/mssql-server-16.0.4165.4-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/62/39e4/mssql-server-extensibility-16.0.4165.4-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/9d/d4d6/mssql-server-fts-16.0.4165.4-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d4/e14b/mssql-server-ha-16.0.4165.4-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d1/e923/mssql-server-polybase-16.0.4165.4-7.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4165.4-7 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fa/16b4/mssql-server-16.0.4165.4-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/1a/1645/mssql-server-extensibility-16.0.4165.4-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/7d/d7fa/mssql-server-fts-16.0.4165.4-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/91/61e6/mssql-server-ha-16.0.4165.4-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d0/e9df/mssql-server-polybase-16.0.4165.4-7.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/c4/5a56/)) | 16.0.4165.4-7 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/11/4789/mssql-server_16.0.4165.4-7_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/5f/127e/mssql-server-extensibility_16.0.4165.4-7_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/d8/8dd4/mssql-server-fts_16.0.4165.4-7_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c9/8fd7/mssql-server-ha_16.0.4165.4-7_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/22/3863/mssql-server-polybase_16.0.4165.4-7_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4155"></a>

## CU 15 GDR (November 2024)

This is the Cumulative Update 15-GDR (CU 15 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 15). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4155.4. For information about the fixes and improvements in this release, see [KB 5046862](https://support.microsoft.com/help/5046862).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/36/c76c/)) | 16.0.4155.4-6 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/49/03dd/mssql-server-16.0.4155.4-6.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/42/d081/mssql-server-extensibility-16.0.4155.4-6.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d0/2e79/mssql-server-fts-16.0.4155.4-6.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/fd/f229/mssql-server-ha-16.0.4155.4-6.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bd/d5c2/mssql-server-polybase-16.0.4155.4-6.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4155.4-6 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/bd/06f2/mssql-server-16.0.4155.4-6.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/44/d5e8/mssql-server-extensibility-16.0.4155.4-6.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f5/cdc7/mssql-server-fts-16.0.4155.4-6.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/33/4a53/mssql-server-ha-16.0.4155.4-6.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/22/454b/mssql-server-polybase-16.0.4155.4-6.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e7/8021/)) | 16.0.4155.4-6 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/8b/42b4/mssql-server_16.0.4155.4-6_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/4f/bfb5/mssql-server-extensibility_16.0.4155.4-6_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/3a/6791/mssql-server-fts_16.0.4155.4-6_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/46/5ef0/mssql-server-ha_16.0.4155.4-6_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c7/2fe3/mssql-server-polybase_16.0.4155.4-6_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4150"></a>

## CU 15 GDR (October 2024)

This is the Cumulative Update 15-GDR (CU 15 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 15). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4150.1. For information about the fixes and improvements in this release, see [KB 5046059](https://support.microsoft.com/help/5046059).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/13/eda8/)) | 16.0.4150.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/a4/156f/mssql-server-16.0.4150.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d8/0085/mssql-server-extensibility-16.0.4150.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/39/859d/mssql-server-fts-16.0.4150.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/9d/7c5c/mssql-server-ha-16.0.4150.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/eb/dd8c/mssql-server-polybase-16.0.4150.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4150.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/58/55c4/mssql-server-16.0.4150.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/43/941f/mssql-server-extensibility-16.0.4150.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d8/8062/mssql-server-fts-16.0.4150.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/76/d838/mssql-server-ha-16.0.4150.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c6/892e/mssql-server-polybase-16.0.4150.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/bb/75ea/)) | 16.0.4150.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/85/ac73/mssql-server_16.0.4150.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/cb/afa8/mssql-server-extensibility_16.0.4150.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/54/0f20/mssql-server-fts_16.0.4150.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/6c/48bb/mssql-server-ha_16.0.4150.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/d9/fb90/mssql-server-polybase_16.0.4150.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4145"></a>

## CU 15 (September 2024)

This is the Cumulative Update 15 (CU 15) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4145.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate15.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/ed/a0d2/)) | 16.0.4145.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ad/924f/mssql-server-16.0.4145.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/1a/1e75/mssql-server-extensibility-16.0.4145.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/bc/ea34/mssql-server-fts-16.0.4145.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/c2/115a/mssql-server-ha-16.0.4145.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/4f/60a8/mssql-server-polybase-16.0.4145.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4145.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ec/9168/mssql-server-16.0.4145.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/43/ea39/mssql-server-extensibility-16.0.4145.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/16/aaa5/mssql-server-fts-16.0.4145.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/0c/f2b7/mssql-server-ha-16.0.4145.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f0/549d/mssql-server-polybase-16.0.4145.4-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/07/f3d9/)) | 16.0.4145.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/46/2d47/mssql-server_16.0.4145.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/ce/d773/mssql-server-extensibility_16.0.4145.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/a7/7153/mssql-server-fts_16.0.4145.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/4f/f98d/mssql-server-ha_16.0.4145.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/55/97d7/mssql-server-polybase_16.0.4145.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4140"></a>

## CU 14 GDR (September 2024)

This is the Cumulative Update 14-GDR (CU 14 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 14). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4140.3. For information about the fixes and improvements in this release, see [KB 5042578](https://support.microsoft.com/help/5042578).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/3d/93f8/)) | 16.0.4140.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d5/2548/mssql-server-16.0.4140.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/a3/0e14/mssql-server-extensibility-16.0.4140.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/43/0edf/mssql-server-fts-16.0.4140.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/c1/4fd3/mssql-server-ha-16.0.4140.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e5/e87a/mssql-server-polybase-16.0.4140.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4140.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/07/cb68/mssql-server-16.0.4140.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c6/0289/mssql-server-extensibility-16.0.4140.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/73/a7fc/mssql-server-fts-16.0.4140.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d2/d08f/mssql-server-ha-16.0.4140.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e6/aa18/mssql-server-polybase-16.0.4140.3-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/b9/3523/)) | 16.0.4140.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/52/f66b/mssql-server_16.0.4140.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/26/5c5b/mssql-server-extensibility_16.0.4140.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/42/7c2d/mssql-server-fts_16.0.4140.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/82/8a65/mssql-server-ha_16.0.4140.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/34/c443/mssql-server-polybase_16.0.4140.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4135"></a>

## CU 14 (July 2024)

This is the Cumulative Update 14 (CU 14) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4135.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate14.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/39/1be2/)) | 16.0.4135.4-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/b0/0b89/mssql-server-16.0.4135.4-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/be/2fe0/mssql-server-extensibility-16.0.4135.4-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/13/5f52/mssql-server-fts-16.0.4135.4-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/b8/4abe/mssql-server-ha-16.0.4135.4-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/56/7625/mssql-server-polybase-16.0.4135.4-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4135.4-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b5/f160/mssql-server-16.0.4135.4-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f7/8d6e/mssql-server-extensibility-16.0.4135.4-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e5/955c/mssql-server-fts-16.0.4135.4-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d7/7a2d/mssql-server-ha-16.0.4135.4-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/db/e990/mssql-server-polybase-16.0.4135.4-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/b3/6949/)) | 16.0.4135.4-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/11/3d0c/mssql-server_16.0.4135.4-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/0c/d4b4/mssql-server-extensibility_16.0.4135.4-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/cd/a9f7/mssql-server-fts_16.0.4135.4-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/a1/a735/mssql-server-ha_16.0.4135.4-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/55/a162/mssql-server-polybase_16.0.4135.4-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4125"></a>

## CU 13 (May 2024)

This is the Cumulative Update 13 (CU 13) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4125.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate13.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/b2/063d/)) | 16.0.4125.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e4/d20c/mssql-server-16.0.4125.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e0/a6ad/mssql-server-extensibility-16.0.4125.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/7e/fb20/mssql-server-fts-16.0.4125.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/56/0b7a/mssql-server-ha-16.0.4125.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ea/ff26/mssql-server-polybase-16.0.4125.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4125.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/dc/ccaa/mssql-server-16.0.4125.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/9f/5c4c/mssql-server-extensibility-16.0.4125.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f3/1fbf/mssql-server-fts-16.0.4125.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/8d/5263/mssql-server-ha-16.0.4125.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/25/48c2/mssql-server-polybase-16.0.4125.3-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/57/3c38/)) | 16.0.4125.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/85/7d05/mssql-server_16.0.4125.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/6b/3143/mssql-server-extensibility_16.0.4125.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/bb/d890/mssql-server-fts_16.0.4125.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/eb/ed8b/mssql-server-ha_16.0.4125.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/1d/1afa/mssql-server-polybase_16.0.4125.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4120"></a>

## CU 12 GDR (April 2024)

This is the Cumulative Update 12-GDR (CU 12 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 12). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4120.1. For information about the fixes and improvements in this release, see [KB 5036343](https://support.microsoft.com/help/5036343).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/03/74f5/)) | 16.0.4120.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/25/78e8/mssql-server-16.0.4120.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/53/4155/mssql-server-extensibility-16.0.4120.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e4/27f0/mssql-server-fts-16.0.4120.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d4/35d4/mssql-server-ha-16.0.4120.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/47/4b90/mssql-server-polybase-16.0.4120.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4120.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f1/8f91/mssql-server-16.0.4120.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/99/9c9b/mssql-server-extensibility-16.0.4120.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/76/ea63/mssql-server-fts-16.0.4120.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e1/c3b1/mssql-server-ha-16.0.4120.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/9d/a217/mssql-server-polybase-16.0.4120.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/c5/3fad/)) | 16.0.4120.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/99/d377/mssql-server_16.0.4120.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/c5/1e3e/mssql-server-extensibility_16.0.4120.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/af/ca36/mssql-server-fts_16.0.4120.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/8d/65d4/mssql-server-ha_16.0.4120.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/ed/5b20/mssql-server-polybase_16.0.4120.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4115"></a>

## CU 12 (March 2024)

This is the Cumulative Update 12 (CU 12) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4115.5. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate12.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/12/b064/)) | 16.0.4115.5-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/11/7259/mssql-server-16.0.4115.5-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d6/a766/mssql-server-extensibility-16.0.4115.5-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/db/8052/mssql-server-fts-16.0.4115.5-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/8c/8170/mssql-server-ha-16.0.4115.5-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/f7/6b79/mssql-server-polybase-16.0.4115.5-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4115.5-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/dc/ca5f/mssql-server-16.0.4115.5-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/35/a5b9/mssql-server-extensibility-16.0.4115.5-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/19/7807/mssql-server-fts-16.0.4115.5-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/65/4f3a/mssql-server-ha-16.0.4115.5-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f4/e049/mssql-server-polybase-16.0.4115.5-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/fc/4656/)) | 16.0.4115.5-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/cc/52c5/mssql-server_16.0.4115.5-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/26/9620/mssql-server-extensibility_16.0.4115.5-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/68/6005/mssql-server-fts_16.0.4115.5-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/9d/530c/mssql-server-ha_16.0.4115.5-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/71/c44e/mssql-server-polybase_16.0.4115.5-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4105"></a>

## CU 11 (January 2024)

This is the Cumulative Update 11 (CU 11) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4105.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate11.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/9b/868e/)) | 16.0.4105.2-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/f7/ac75/mssql-server-16.0.4105.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/09/0be4/mssql-server-extensibility-16.0.4105.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/18/2e13/mssql-server-fts-16.0.4105.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/d6/33b5/mssql-server-ha-16.0.4105.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/72/57c8/mssql-server-polybase-16.0.4105.2-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4105.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/25/af13/mssql-server-16.0.4105.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/68/b360/mssql-server-extensibility-16.0.4105.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/7e/4964/mssql-server-fts-16.0.4105.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/61/30fc/mssql-server-ha-16.0.4105.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f5/be12/mssql-server-polybase-16.0.4105.2-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/04/0ff8/)) | 16.0.4105.2-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/b8/2257/mssql-server_16.0.4105.2-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/b8/7676/mssql-server-extensibility_16.0.4105.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/bd/5855/mssql-server-fts_16.0.4105.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/0a/7bb1/mssql-server-ha_16.0.4105.2-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/0d/60be/mssql-server-polybase_16.0.4105.2-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4100"></a>

## CU 10 GDR (January 2024)

This is the Cumulative Update 10-GDR (CU 10 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 10). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4100.1. For information about the fixes and improvements in this release, see [KB 5033592](https://support.microsoft.com/help/5033592).

> [!NOTE]  
> **Red Hat 9** and **Ubuntu 22.04** are now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 10.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/c2/a21d/)) | 16.0.4100.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/44/2442/mssql-server-16.0.4100.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/73/244b/mssql-server-extensibility-16.0.4100.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/45/18b8/mssql-server-fts-16.0.4100.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/0d/8534/mssql-server-ha-16.0.4100.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/ef/1717/mssql-server-polybase-16.0.4100.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4100.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/5b/4beb/mssql-server-16.0.4100.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/eb/8441/mssql-server-extensibility-16.0.4100.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c6/8f18/mssql-server-fts-16.0.4100.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a4/1edd/mssql-server-ha-16.0.4100.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d6/bd28/mssql-server-polybase-16.0.4100.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/50/70ad/)) | 16.0.4100.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/5a/ba52/mssql-server_16.0.4100.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/02/d3a7/mssql-server-extensibility_16.0.4100.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/a3/ef3d/mssql-server-fts_16.0.4100.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/e5/e52e/mssql-server-ha_16.0.4100.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/d9/1b50/mssql-server-polybase_16.0.4100.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4095"></a>

## CU 10 (November 2023)

This is the Cumulative Update 10 (CU 10) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4095.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate10.md).

> [!NOTE]  
> **Red Hat 9** and **Ubuntu 22.04** are now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 10.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/72/2ccf/)) | 16.0.4095.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/46/4abc/mssql-server-16.0.4095.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/86/d876/mssql-server-extensibility-16.0.4095.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/12/a5d7/mssql-server-fts-16.0.4095.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/e8/f3a9/mssql-server-ha-16.0.4095.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/a4/e71c/mssql-server-polybase-16.0.4095.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4095.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/af/c0e0/mssql-server-16.0.4095.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a7/cb2c/mssql-server-extensibility-16.0.4095.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/d0/2e0a/mssql-server-fts-16.0.4095.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/8d/2634/mssql-server-ha-16.0.4095.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/5f/f761/mssql-server-polybase-16.0.4095.4-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/4e/a478/)) | 16.0.4095.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/88/225b/mssql-server_16.0.4095.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/93/ef5a/mssql-server-extensibility_16.0.4095.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/4b/66ec/mssql-server-fts_16.0.4095.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/3b/0b52/mssql-server-ha_16.0.4095.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/99/b6f1/mssql-server-polybase_16.0.4095.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4085"></a>

## CU 9 (October 2023)

This is the Cumulative Update 9 (CU 9) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4085.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate9.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4085.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8a/4ca7/mssql-server-16.0.4085.2-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/db/0465/mssql-server-extensibility-16.0.4085.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/58/785f/mssql-server-fts-16.0.4085.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/e7/df15/mssql-server-ha-16.0.4085.2-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8e/a495/mssql-server-polybase-16.0.4085.2-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4085.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/4e/9fd6/mssql-server-16.0.4085.2-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/70/acb9/mssql-server-extensibility-16.0.4085.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/58/9993/mssql-server-fts-16.0.4085.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/1d/6c2d/mssql-server-ha-16.0.4085.2-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f7/9bdc/mssql-server-polybase-16.0.4085.2-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4085.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/73/53e0/mssql-server_16.0.4085.2-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/a6/04c8/mssql-server-extensibility_16.0.4085.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ba/7786/mssql-server-fts_16.0.4085.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/a0/d3a2/mssql-server-ha_16.0.4085.2-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/f9/2ae3/mssql-server-polybase_16.0.4085.2-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4080"></a>

## CU 8 GDR (October 2023)

This is the Cumulative Update 8-GDR (CU 8 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 8). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4080.1. For information about the fixes and improvements in this release, see [KB 5029503](https://support.microsoft.com/help/5029503).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4080.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/c8/28a8/mssql-server-16.0.4080.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/d7/a1ca/mssql-server-extensibility-16.0.4080.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8e/9a55/mssql-server-fts-16.0.4080.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/36/f191/mssql-server-ha-16.0.4080.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/82/92a3/mssql-server-polybase-16.0.4080.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4080.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/31/5647/mssql-server-16.0.4080.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/89/eea4/mssql-server-extensibility-16.0.4080.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b3/eccb/mssql-server-fts-16.0.4080.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/1e/017c/mssql-server-ha-16.0.4080.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/8e/67aa/mssql-server-polybase-16.0.4080.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4080.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/21/b7c1/mssql-server_16.0.4080.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/0e/1615/mssql-server-extensibility_16.0.4080.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/35/b4e9/mssql-server-fts_16.0.4080.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/5d/ec45/mssql-server-ha_16.0.4080.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/eb/83d7/mssql-server-polybase_16.0.4080.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4075"></a>

## CU 8 (September 2023)

This is the Cumulative Update 8 (CU 8) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4075.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate8.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4075.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/5a/ea9e/mssql-server-16.0.4075.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/18/c296/mssql-server-extensibility-16.0.4075.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a5/4053/mssql-server-fts-16.0.4075.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/6e/efd1/mssql-server-ha-16.0.4075.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/60/24dc/mssql-server-polybase-16.0.4075.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4075.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ca/6c16/mssql-server-16.0.4075.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/43/f1db/mssql-server-extensibility-16.0.4075.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a4/00cc/mssql-server-fts-16.0.4075.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/80/c89a/mssql-server-ha-16.0.4075.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/44/55fb/mssql-server-polybase-16.0.4075.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4075.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/c8/f5e6/mssql-server_16.0.4075.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/53/7f3e/mssql-server-extensibility_16.0.4075.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/9c/35e9/mssql-server-fts_16.0.4075.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ab/1c95/mssql-server-ha_16.0.4075.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/65/15c5/mssql-server-polybase_16.0.4075.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4065"></a>

## CU 7 (August 2023)

This is the Cumulative Update 7 (CU 7) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4065.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate7.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4065.3-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8d/230d/mssql-server-16.0.4065.3-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/20/c996/mssql-server-extensibility-16.0.4065.3-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a1/8d71/mssql-server-fts-16.0.4065.3-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/6f/5958/mssql-server-ha-16.0.4065.3-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/5c/f353/mssql-server-polybase-16.0.4065.3-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4065.3-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6e/290a/mssql-server-16.0.4065.3-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/5c/75f5/mssql-server-extensibility-16.0.4065.3-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ab/e05e/mssql-server-fts-16.0.4065.3-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/60/bfcc/mssql-server-ha-16.0.4065.3-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/79/aecd/mssql-server-polybase-16.0.4065.3-4.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4065.3-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/16/9d7a/mssql-server_16.0.4065.3-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/d0/8e6b/mssql-server-extensibility_16.0.4065.3-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/93/48c0/mssql-server-fts_16.0.4065.3-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/02/b11f/mssql-server-ha_16.0.4065.3-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/8a/448d/mssql-server-polybase_16.0.4065.3-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4055"></a>

## CU 6 (July 2023)

This is the Cumulative Update 6 (CU 6) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4055.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate6.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4055.4-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/3a/916e/mssql-server-16.0.4055.4-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/a0/906e/mssql-server-extensibility-16.0.4055.4-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/b2/b751/mssql-server-fts-16.0.4055.4-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/0d/2c3e/mssql-server-ha-16.0.4055.4-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/f9/f7f6/mssql-server-polybase-16.0.4055.4-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4055.4-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/5d/2c9c/mssql-server-16.0.4055.4-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/04/6689/mssql-server-extensibility-16.0.4055.4-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ec/87bd/mssql-server-fts-16.0.4055.4-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c7/2cf3/mssql-server-ha-16.0.4055.4-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a5/664a/mssql-server-polybase-16.0.4055.4-2.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4055.4-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/9b/927e/mssql-server_16.0.4055.4-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/30/e2ee/mssql-server-extensibility_16.0.4055.4-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/94/f2d3/mssql-server-fts_16.0.4055.4-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ac/89b2/mssql-server-ha_16.0.4055.4-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/f8/ac97/mssql-server-polybase_16.0.4055.4-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4045"></a>

## CU 5 (June 2023)

This is the Cumulative Update 5 (CU 5) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4045.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate5.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4045.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/0d/9415/mssql-server-16.0.4045.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/57/83ff/mssql-server-extensibility-16.0.4045.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/1f/4b45/mssql-server-fts-16.0.4045.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/29/5841/mssql-server-ha-16.0.4045.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/9a/8281/mssql-server-polybase-16.0.4045.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4045.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ea/7e9b/mssql-server-16.0.4045.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/eb/6e20/mssql-server-extensibility-16.0.4045.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/01/85fc/mssql-server-fts-16.0.4045.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b5/4cd1/mssql-server-ha-16.0.4045.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/76/b1f2/mssql-server-polybase-16.0.4045.3-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4045.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/23/6729/mssql-server_16.0.4045.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/82/cba6/mssql-server-extensibility_16.0.4045.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/b7/8af4/mssql-server-fts_16.0.4045.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/09/68ff/mssql-server-ha_16.0.4045.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/31/6395/mssql-server-polybase_16.0.4045.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4035"></a>

## CU 4 (May 2023)

This is the Cumulative Update 4 (CU 4) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4035.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate4.md).

> [!NOTE]  
> **SLES v15 SP4** is now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 4.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4035.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/33/2dc8/mssql-server-16.0.4035.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/48/6e76/mssql-server-extensibility-16.0.4035.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/1f/7ee5/mssql-server-fts-16.0.4035.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8d/94eb/mssql-server-ha-16.0.4035.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/f2/e67a/mssql-server-polybase-16.0.4035.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4035.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/e2/b18a/mssql-server-16.0.4035.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6b/c0c0/mssql-server-extensibility-16.0.4035.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f3/9021/mssql-server-fts-16.0.4035.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/35/ec04/mssql-server-ha-16.0.4035.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a4/8b1d/mssql-server-polybase-16.0.4035.4-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4035.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/66/c7af/mssql-server_16.0.4035.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/0c/af88/mssql-server-extensibility_16.0.4035.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ea/2d53/mssql-server-fts_16.0.4035.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/d1/6d5a/mssql-server-ha_16.0.4035.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e0/834f/mssql-server-polybase_16.0.4035.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4025"></a>

## CU 3 (April 2023)

This is the Cumulative Update 3 (CU 3) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4025.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate3.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/4c/436f/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/ea/57ff/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/8c/6e12/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/7c/c185/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/96/c140/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/16/6c99/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b4/ebc3/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/b6/a111/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/30/669f/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6e/3bc0/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4025.1-13 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/a0/a377/mssql-server_16.0.4025.1-13_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/b4/e789/mssql-server-extensibility_16.0.4025.1-13_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/a6/6454/mssql-server-fts_16.0.4025.1-13_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/81/281a/mssql-server-ha_16.0.4025.1-13_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e9/8a1b/mssql-server-polybase_16.0.4025.1-13_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4015"></a>

## CU 2 (March 2023)

This is the Cumulative Update 2 (CU 2) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4015.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate2.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/13/9794/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/0d/9055/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/bb/0bb7/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/0d/78b2/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/4f/d9f7/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/53/13f0/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f3/7bfc/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/52/a3a1/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/8b/aa5a/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/88/88be/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4015.1-10 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/0a/3959/mssql-server_16.0.4015.1-10_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/d6/7c87/mssql-server-extensibility_16.0.4015.1-10_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/ed/aa0f/mssql-server-fts_16.0.4015.1-10_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/45/e811/mssql-server-ha_16.0.4015.1-10_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/69/4580/mssql-server-polybase_16.0.4015.1-10_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-4003"></a>

## CU 1 (February 2023)

This is the Cumulative Update 1 (CU 1) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4003.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate1.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/fe/511a/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/27/8f92/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/d0/2712/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/6b/82b1/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/59/74c6/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/7e/7f9c/mssql-server-is-16.0.4003.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4003.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/6c/f642/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ef/b7ec/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fe/ddcb/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ce/e6da/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/69/a917/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/11/3d66/mssql-server_16.0.4003.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/41/433a/mssql-server-extensibility_16.0.4003.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/4f/1e77/mssql-server-fts_16.0.4003.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/c3/9582/mssql-server-ha_16.0.4003.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/19/3bbe/mssql-server-polybase_16.0.4003.1-1_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/90/f7b2/mssql-server-is_16.0.4003.1-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

<a id="16-0-1050"></a>

## GDR (February 2023)

This is the General Distribution Release (GDR) of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1050.5. For information about the fixes and improvements in this release, see [KB 5021522](https://support.microsoft.com/help/5021522).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/00/4312/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/76/7cc6/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/37/4a19/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/2d/26c0/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/ed/5836/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/fb/8bc8/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/f6/8c2d/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/ea/89e6/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/7f/8123/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/0e/0fd3/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1050.5-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/72/6e59/mssql-server_16.0.1050.5-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/2c/bc81/mssql-server-extensibility_16.0.1050.5-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/4a/89a1/mssql-server-fts_16.0.1050.5-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/29/472b/mssql-server-ha_16.0.1050.5-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/62/9020/mssql-server-polybase_16.0.1050.5-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="16-0-1000"></a>

## GA (November 2022)

This is the General Availability (GA) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1000.6.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install SQL Server Full-Text Search on Linux](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent on Linux](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services (SSIS) on Linux](/sql/linux/sql-server-linux-setup-ssis)

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/26/11a4/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/c4/b268/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/36/fd0a/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/4b/39a7/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/4c/ffba/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/5f/da5e/mssql-server-is-16.0.950.9-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1000.6-26 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/a2/cf56/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/92/5797/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/4d/b321/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/c1/640f/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/67/60be/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e9/6811/mssql-server_16.0.1000.6-26_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/47/dea4/mssql-server-extensibility_16.0.1000.6-26_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/e0/80b9/mssql-server-fts_16.0.1000.6-26_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/53/d1c1/mssql-server-ha_16.0.1000.6-26_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/4d/bb9f/mssql-server-polybase_16.0.1000.6-26_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/08/174a/mssql-server-is_16.0.950.9-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

## Related content

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)
- [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat)
- [Quickstart: Install SQL Server and create a database on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Quickstart: Install SQL Server and create a database on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
- [Provision a Linux virtual machine running SQL Server in the Azure portal](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Quickstart: Run SQL Server in the cloud](/sql/linux/quickstart-install-connect-clouds)
