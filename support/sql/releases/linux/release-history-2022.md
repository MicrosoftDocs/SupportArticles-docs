---
title: Release history for SQL Server 2022 on Linux
description: This article contains the release history for SQL Server 2022 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 07/08/2025
appliesto:
  - SQL Server 2022
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2022 on Linux

The following table lists the release history for [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. For release history on other editions, see the following articles:

- [Release history for SQL Server 2017 on Linux](release-history-2017.md?view=sql-server-ver14&preserve-view=true).
- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2025 Preview on Linux](release-history-2025.md?view=sql-server-ver17&preserve-view=true).

> [!NOTE]  
> Any missing GDRs apply to the Windows version only.

| Release | Version | Release date |
| --- | --- | --- |
| [CU 19 GDR](#CU19-GDR) | 16.0.4200.1 | 2025-07-08 |
| [CU 19](#CU19) | 16.0.4195.2 | 2025-05-15 |
| [CU 18](#CU18) | 16.0.4185.3 | 2025-03-13 |
| [CU 17](#CU17) | 16.0.4175.1 | 2025-01-16 |
| [CU 16](#CU16) | 16.0.4165.4 | 2024-11-14 |
| [CU 15 GDR 2](#CU15-GDR2) | 16.0.4155.4 | 2024-11-12 |
| [CU 15 GDR 1](#CU15-GDR1) | 16.0.4150.1 | 2024-10-08 |
| [CU 15](#CU15) | 16.0.4145.4 | 2024-09-25 |
| [CU 14 GDR](#CU14-GDR) | 16.0.4140.3 | 2024-09-10 |
| [CU 14](#CU14) | 16.0.4135.4 | 2024-07-23 |
| [CU 13](#CU13) | 16.0.4125.3 | 2024-05-16 |
| [CU 12 GDR](#CU12-GDR) | 16.0.4120.1 | 2024-04-09 |
| [CU 12](#CU12) | 16.0.4115.5 | 2024-03-14 |
| [CU 11](#CU11) | 16.0.4105.2 | 2024-01-11 |
| [CU 10 GDR](#CU10-GDR) | 16.0.4100.1 | 2024-01-09 |
| [CU 10](#CU10) | 16.0.4095.4 | 2023-11-16 |
| [CU 9](#CU9) | 16.0.4085.2 | 2023-10-12 |
| [CU 8 GDR](#CU8-GDR) | 16.0.4080.1 | 2023-10-10 |
| [CU 8](#CU8) | 16.0.4075.1 | 2023-09-15 |
| [CU 7](#CU7) | 16.0.4065.3 | 2023-08-10 |
| [CU 6](#CU6) | 16.0.4055.4 | 2023-07-13 |
| [CU 5](#CU5) | 16.0.4045.3 | 2023-06-15 |
| [CU 4](#CU4) | 16.0.4035.4 | 2023-05-11 |
| [CU 3](#CU3) | 16.0.4025.1 | 2023-04-13 |
| [CU 2](#CU2) | 16.0.4015.1 | 2023-03-15 |
| [CU 1](#CU1) | 16.0.4003.1 | 2023-02-16 |
| [GDR 1](#GDR1) | 16.0.1050.5 | 2023-02-14 |
| [GA](#GA) | 16.0.1000.6 | 2022-11-16 |

<a id="CU19-GDR"></a>

## CU 19 GDR (July 2025)

This is the Cumulative Update 19-GDR (CU 19 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 19). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4200.1. For information about the fixes and improvements in this release, see [KB 5058721](https://support.microsoft.com/help/5058721).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4200.1-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4200.1-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4200.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4200.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4200.1-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4200.1-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4200.1-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4200.1-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4200.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4200.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4200.1-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4200.1-4.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4200.1-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4200.1-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4200.1-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4200.1-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4200.1-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4200.1-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU19"></a>

## CU 19 (May 2025)

This is the Cumulative Update 19 (CU 19) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4195.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate19.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4195.2-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4195.2-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4195.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4195.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4195.2-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4195.2-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4195.2-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4195.2-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4195.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4195.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4195.2-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4195.2-4.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4195.2-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4195.2-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4195.2-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4195.2-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4195.2-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4195.2-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU18"></a>

## CU 18 (March 2025)

This is the Cumulative Update 18 (CU 18) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4185.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate18.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4185.3-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4185.3-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4185.3-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4185.3-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4185.3-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4185.3-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4185.3-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4185.3-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4185.3-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4185.3-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4185.3-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4185.3-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4185.3-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4185.3-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4185.3-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4185.3-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4185.3-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4185.3-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU17"></a>

## CU 17 (January 2025)

This is the Cumulative Update 17 (CU 17) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4175.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate17.md).

> [!IMPORTANT]  
> The Microsoft Entra managed identity feature for SQL Server on Azure VM isn't supported on Linux. For more information, see [Improvement: Microsoft Entra managed identity support for backup and restore database operations and for EKM with AKV in SQL Server on Azure VMs](../sqlserver-2022/microsoft-entra-managed-identity-support-for-backup-restore-database-ekm-akv.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4175.1-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4175.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4175.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4175.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4175.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4175.1-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4175.1-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4175.1-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4175.1-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4175.1-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4175.1-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4175.1-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4175.1-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4175.1-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4175.1-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4175.1-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4175.1-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4175.1-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU16"></a>

## CU 16 (November 2024)

This is the Cumulative Update 16 (CU 16) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4165.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate16.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4165.4-7 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4165.4-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4165.4-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4165.4-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4165.4-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4165.4-7.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4165.4-7 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4165.4-7.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4165.4-7.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4165.4-7.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4165.4-7.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4165.4-7.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4165.4-7 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4165.4-7_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4165.4-7_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4165.4-7_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4165.4-7_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4165.4-7_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU15-GDR2"></a>

## CU 15 GDR 2 (November 2024)

This is the Cumulative Update 15-GDR2 (CU 15 GDR 2) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 15). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4155.4. For information about the fixes and improvements in this release, see [KB 5046862](https://support.microsoft.com/help/5046862).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4155.4-6 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4155.4-6.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4155.4-6.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4155.4-6.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4155.4-6.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4155.4-6.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4155.4-6 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4155.4-6.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4155.4-6.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4155.4-6.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4155.4-6.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4155.4-6.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4155.4-6 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4155.4-6_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4155.4-6_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4155.4-6_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4155.4-6_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4155.4-6_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU15-GDR1"></a>

## CU 15 GDR 1 (October 2024)

This is the Cumulative Update 15-GDR1 (CU 15 GDR 1) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 15). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4150.1. For information about the fixes and improvements in this release, see [KB 5046059](https://support.microsoft.com/help/5046059).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4150.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4150.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4150.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4150.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4150.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4150.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4150.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4150.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4150.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4150.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4150.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4150.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4150.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4150.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4150.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4150.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4150.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4150.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU15"></a>

## CU 15 (September 2024)

This is the Cumulative Update 15 (CU 15) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4145.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate15.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4145.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4145.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4145.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4145.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4145.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4145.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4145.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4145.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4145.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4145.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4145.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4145.4-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4145.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4145.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4145.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4145.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4145.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4145.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU14-GDR"></a>

## CU 14 GDR (September 2024)

This is the Cumulative Update 14-GDR (CU 14 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 14). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4140.3. For information about the fixes and improvements in this release, see [KB 5042578](https://support.microsoft.com/help/5042578).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4140.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4140.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4140.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4140.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4140.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4140.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4140.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4140.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4140.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4140.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4140.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4140.3-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4140.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4140.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4140.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4140.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4140.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4140.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU14"></a>

## CU 14 (July 2024)

This is the Cumulative Update 14 (CU 14) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4135.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate14.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4135.4-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4135.4-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4135.4-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4135.4-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4135.4-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4135.4-3.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4135.4-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4135.4-3.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4135.4-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4135.4-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4135.4-3.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4135.4-3.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4135.4-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4135.4-3_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4135.4-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4135.4-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4135.4-3_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4135.4-3_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU13"></a>

## CU 13 (May 2024)

This is the Cumulative Update 13 (CU 13) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4125.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate13.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4125.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4125.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4125.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4125.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4125.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4125.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4125.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4125.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4125.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4125.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4125.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4125.3-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4125.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4125.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4125.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4125.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4125.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4125.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU12-GDR"></a>

## CU 12 GDR (April 2024)

This is the Cumulative Update 12-GDR (CU 12 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 12). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4120.1. For information about the fixes and improvements in this release, see [KB 5036343](https://support.microsoft.com/help/5036343).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4120.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4120.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4120.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4120.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4120.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4120.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4120.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4120.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4120.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4120.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4120.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4120.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4120.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4120.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4120.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4120.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4120.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4120.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU12"></a>

## CU 12 (March 2024)

This is the Cumulative Update 12 (CU 12) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4115.5. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate12.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4115.5-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4115.5-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4115.5-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4115.5-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4115.5-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4115.5-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4115.5-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4115.5-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4115.5-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4115.5-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4115.5-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4115.5-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4115.5-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4115.5-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4115.5-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4115.5-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4115.5-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4115.5-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU11"></a>

## CU 11 (January 2024)

This is the Cumulative Update 11 (CU 11) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4105.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate11.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4105.2-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4105.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4105.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4105.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4105.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4105.2-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4105.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4105.2-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4105.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4105.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4105.2-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4105.2-2.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4105.2-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4105.2-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4105.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4105.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4105.2-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4105.2-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU10-GDR"></a>

## CU 10 GDR (January 2024)

This is the Cumulative Update 10-GDR (CU 10 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 10). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4100.1. For information about the fixes and improvements in this release, see [KB 5033592](https://support.microsoft.com/help/5033592).

> [!NOTE]  
> **Red Hat 9** and **Ubuntu 22.04** are now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 10.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4100.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4100.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4100.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4100.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4100.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4100.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4100.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4100.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4100.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4100.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4100.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4100.1-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4100.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4100.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4100.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4100.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4100.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4100.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU10"></a>

## CU 10 (November 2023)

This is the Cumulative Update 10 (CU 10) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4095.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate10.md).

> [!NOTE]  
> **Red Hat 9** and **Ubuntu 22.04** are now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 10.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 9.x RPM packages**<br /><br />(Get RPM packages for [RHEL 8.x](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/)) | 16.0.4095.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-16.0.4095.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4095.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4095.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4095.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/9/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4095.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4095.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4095.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4095.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4095.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4095.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4095.4-1.x86_64.rpm) |
| **Ubuntu 22.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 20.04](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/)) | 16.0.4095.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4095.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4095.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4095.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4095.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/22.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4095.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU9"></a>

## CU 9 (October 2023)

This is the Cumulative Update 9 (CU 9) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4085.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate9.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4085.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4085.2-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4085.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4085.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4085.2-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4085.2-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4085.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4085.2-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4085.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4085.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4085.2-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4085.2-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4085.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4085.2-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4085.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4085.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4085.2-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4085.2-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU8-GDR"></a>

## CU 8 GDR (October 2023)

This is the Cumulative Update 8-GDR (CU 8 GDR) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that also includes the previously released CU (CU 8). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4080.1. For information about the fixes and improvements in this release, see [KB 5029503](https://support.microsoft.com/help/5029503).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4080.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4080.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4080.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4080.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4080.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4080.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4080.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4080.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4080.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4080.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4080.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4080.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4080.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4080.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4080.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4080.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4080.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4080.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU8"></a>

## CU 8 (September 2023)

This is the Cumulative Update 8 (CU 8) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4075.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate8.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4075.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4075.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4075.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4075.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4075.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4075.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4075.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4075.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4075.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4075.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4075.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4075.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4075.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4075.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4075.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4075.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4075.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4075.1-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU7"></a>

## CU 7 (August 2023)

This is the Cumulative Update 7 (CU 7) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4065.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate7.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4065.3-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4065.3-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4065.3-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4065.3-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4065.3-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4065.3-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4065.3-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4065.3-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4065.3-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4065.3-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4065.3-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4065.3-4.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4065.3-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4065.3-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4065.3-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4065.3-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4065.3-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4065.3-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU6"></a>

## CU 6 (July 2023)

This is the Cumulative Update 6 (CU 6) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4055.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate6.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4055.4-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4055.4-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4055.4-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4055.4-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4055.4-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4055.4-2.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4055.4-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4055.4-2.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4055.4-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4055.4-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4055.4-2.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4055.4-2.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4055.4-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4055.4-2_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4055.4-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4055.4-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4055.4-2_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4055.4-2_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU5"></a>

## CU 5 (June 2023)

This is the Cumulative Update 5 (CU 5) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4045.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate5.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4045.3-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4045.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4045.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4045.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4045.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4045.3-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4045.3-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4045.3-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4045.3-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4045.3-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4045.3-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4045.3-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4045.3-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4045.3-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4045.3-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4045.3-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4045.3-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4045.3-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU4"></a>

## CU 4 (May 2023)

This is the Cumulative Update 4 (CU 4) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4035.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate4.md).

> [!NOTE]  
> **SLES v15 SP4** is now supported on [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)] starting with CU 4.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4035.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4035.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4035.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4035.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4035.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4035.4-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4035.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4035.4-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4035.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4035.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4035.4-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4035.4-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4035.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4035.4-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4035.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4035.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4035.4-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4035.4-1_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU3"></a>

## CU 3 (April 2023)

This is the Cumulative Update 3 (CU 3) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4025.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate3.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4025.1-13 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4025.1-13.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4025.1-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4025.1-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4025.1-13.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4025.1-13.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4025.1-13 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4025.1-13_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4025.1-13_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4025.1-13_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4025.1-13_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4025.1-13_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU2"></a>

## CU 2 (March 2023)

This is the Cumulative Update 2 (CU 2) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4015.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate2.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4015.1-10 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4015.1-10.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4015.1-10.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4015.1-10.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4015.1-10.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4015.1-10.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4015.1-10 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4015.1-10_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4015.1-10_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4015.1-10_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4015.1-10_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4015.1-10_amd64.deb) |

Go back to the [release history](#release-history).

<a id="CU1"></a>

## CU 1 (February 2023)

This is the Cumulative Update 1 (CU 1) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.4003.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2022/cumulativeupdate1.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-is-16.0.4003.1-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.4003.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.4003.1-1.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.4003.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.4003.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.4003.1-1.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.4003.1-1.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.4003.1-1 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.4003.1-1_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.4003.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.4003.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.4003.1-1_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.4003.1-1_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-is/mssql-server-is_16.0.4003.1-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

<a id="GDR1"></a>

## GDR 1 (February 2023)

This is the General Distribution Release GDR1 (GDR 1) of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1050.5. For information about the fixes and improvements in this release, see [KB 5021522](https://support.microsoft.com/help/5021522).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1050.5-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.1050.5-4.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1050.5-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1050.5-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1050.5-4.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1050.5-4.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1050.5-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.1050.5-4_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.1050.5-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.1050.5-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.1050.5-4_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.1050.5-4_amd64.deb) |

Go back to the [release history](#release-history).

<a id="GA"></a>

## GA (November 2022)

This is the General Availability (GA) release of [!INCLUDE [sql-server-2022](../../includes/versions/sql-server-2022.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 16.0.1000.6.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install SQL Server Full-Text Search on Linux](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent package](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services (SSIS) on Linux](/sql/linux/sql-server-linux-setup-ssis)

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2022/Packages/m/mssql-server-is-16.0.950.9-1.x86_64.rpm) |
| **SLES 15 RPM packages** | 16.0.1000.6-26 | [Database Engine RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-16.0.1000.6-26.x86_64.rpm)<br />[Extensibility RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-extensibility-16.0.1000.6-26.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-fts-16.0.1000.6-26.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-ha-16.0.1000.6-26.x86_64.rpm)<br />[PolyBase RPM package](https://packages.microsoft.com/sles/15/mssql-server-2022/Packages/m/mssql-server-polybase-16.0.1000.6-26.x86_64.rpm) |
| **Ubuntu 20.04 Debian packages** | 16.0.1000.6-26 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server/mssql-server_16.0.1000.6-26_amd64.deb)<br />[Extensibility Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-extensibility/mssql-server-extensibility_16.0.1000.6-26_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-fts/mssql-server-fts_16.0.1000.6-26_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-ha/mssql-server-ha_16.0.1000.6-26_amd64.deb)<br />[PolyBase Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-polybase/mssql-server-polybase_16.0.1000.6-26_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/20.04/mssql-server-2022/pool/main/m/mssql-server-is/mssql-server-is_16.0.950.9-1_amd64.deb) |

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
