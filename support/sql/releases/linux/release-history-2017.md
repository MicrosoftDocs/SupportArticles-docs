---
title: Release history for SQL Server 2017 on Linux
description: This article contains the release history for SQL Server 2017 running on Linux. Information includes all Cumulative Updates and GDRs.
author: rwestMSFT
ms.author: randolphwest
ms.reviewer: amitkh, vanto
ms.date: 03/06/2025
appliesto:
  - SQL Server 2017
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, linux-related-content
---
# <a id="release-history"></a> Release history for SQL Server 2017 on Linux

The following table lists the release history for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. For release history on other editions, see the following articles:

- [Release history for SQL Server 2019 on Linux](release-history-2019.md?view=sql-server-ver15&preserve-view=true).
- [Release history for SQL Server 2022 on Linux](release-history-2022.md?view=sql-server-ver16&preserve-view=true).

> [!NOTE]  
> Any missing GDRs apply to the Windows version only.

| Release                    | Version       | Release date |
| -------------------------- | ------------- | ------------ |
| [AzureConnectFeaturePack](#AzureConnectFeaturePack) | 14.0.3490.10  | 2025-03-06   |
| [CU 31 GDR 6](#CU31-GDR6)  | 14.0.3485.1   | 2024-11-12   |
| [CU 31 GDR 5](#CU31-GDR5)  | 14.0.3480.1   | 2024-10-08   |
| [CU 31 GDR 4](#CU31-GDR4)  | 14.0.3475.1   | 2024-09-10   |
| [CU 31 GDR 2](#CU31-GDR2)  | 14.0.3465.1   | 2023-10-10   |
| [CU 31 GDR 1](#CU31-GDR1)  | 14.0.3460.9   | 2023-02-14   |
| [CU 31](#CU31)             | 14.0.3456.2   | 2022-09-20   |
| [CU 30](#CU30)             | 14.0.3451.2   | 2022-07-13   |
| [CU 29 GDR](#CU29-GDR)     | 14.0.3445.2   | 2022-06-14   |
| [CU 29](#CU29)             | 14.0.3436.1   | 2022-03-30   |
| [CU 28](#CU28)             | 14.0.3430.2   | 2022-01-13   |
| [CU 27](#CU27)             | 14.0.3421.10  | 2021-10-27   |
| [CU 26](#CU26)             | 14.0.3411.3   | 2021-09-14   |
| [CU 25](#CU25)             | 14.0.3401.7   | 2021-07-12   |
| [CU 24](#CU24)             | 14.0.3391.2   | 2021-05-10   |
| [CU 23](#CU23)             | 14.0.3381.3   | 2021-02-24   |
| [CU 22 GDR](#CU22)         | 14.0.3370.1   | 2021-01-12   |
| [GDR 5](#GDR5)             | 14.0.2037.2   | 2021-01-12   |
| [CU 22](#CU22)             | 14.0.3356.20  | 2020-09-10   |
| [CU 21](#CU21)             | 14.0.3335.7   | 2020-07-01   |
| [CU 20](#CU20)             | 14.0.3294.2   | 2020-04-10   |
| [CU 19](#CU19)             | 14.0.3281.6   | 2020-02-05   |
| [CU 18](#CU18)             | 14.0.3257.3   | 2019-12-09   |
| [CU 17](#CU17)             | 14.0.3238.1   | 2019-10-08   |
| [CU 16](#CU16)             | 14.0.3223.3   | 2019-08-01   |
| [CU 15 GDR](#CU15-GDR)     | 14.0.3192.2   | 2019-07-09   |
| [GDR 4](#GDR4)             | 14.0.2027.2   | 2019-07-09   |
| [CU 15](#CU15)             | 14.0.3162.1   | 2019-05-23   |
| [CU 14](#CU14)             | 14.0.3076.1   | 2019-03-25   |
| [CU 13](#CU13)             | 14.0.3048.4   | 2018-12-18   |
| [CU 12](#CU12)             | 14.0.3045.24  | 2018-10-24   |
| [CU 11](#CU11)             | 14.0.3038.14  | 2018-09-20   |
| [CU 10](#CU10)             | 14.0.3037.1   | 2018-08-27   |
| [CU 9 GDR](#CU9-GDR)       | 14.0.3035.2   | 2018-08-18   |
| [GDR 2](#GDR2)             | 14.0.2002.14  | 2018-08-18   |
| [CU 9](#CU9)               | 14.0.3030.27  | 2018-07-18   |
| [CU 8](#CU8)               | 14.0.3029.16  | 2018-06-21   |
| [CU 7](#CU7)               | 14.0.3026.27  | 2018-05-24   |
| [CU 6](#CU6)               | 14.0.3025.34  | 2018-04-19   |
| [CU 5](#CU5)               | 14.0.3023.8   | 2018-03-20   |
| [CU 4](#CU4)               | 14.0.3022.28  | 2018-02-20   |
| [CU 3](#CU3)               | 14.0.3015.40  | 2018-01-03   |
| [CU 3 GDR](#CU3-GDR)       | 14.0.3015.40  | 2018-01-03   |
| [GDR 1](#GDR1)             | 14.0.2000.63  | 2018-01-03   |
| [CU 2](#CU2)               | 14.0.3008.27  | 2017-11-28   |
| [CU 1](#CU1)               | 14.0.3006.16  | 2017-10-24   |
| [GA](#GA)                  | 14.0.1000.169 | 2017-10-02   |

## <a id="AzureConnectFeaturePack"></a> Azure Connect Pack (March 2025)

This is the Azure Connect Pack for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3490.10. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/azureconnect.md).

> [!IMPORTANT]  
> This is the Azure Connect Pack, which includes CU 31 for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 14.0.3490.10-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3490.10-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3490.10-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3490.10-4.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3490.10-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3490.10-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3490.10-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3490.10-4.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages** | 14.0.3490.10-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3490.10-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3490.10-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3490.10-4_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31-GDR6"></a> CU 31 GDR 6 (November 2024)

This is the Cumulative Update 31-GDR6 (CU 31 GDR 6) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 31). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3485.1. For information about the fixes and improvements in this release, see [KB 5046858](https://support.microsoft.com/help/5046858).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 14.0.3485.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3485.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3485.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3485.1-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3485.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3485.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3485.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3485.1-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages** | 14.0.3485.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3485.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3485.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3485.1-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31-GDR5"></a> CU 31 GDR 5 (October 2024)

This is the Cumulative Update 31-GDR5 (CU 31 GDR 5) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 31). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3480.1. For information about the fixes and improvements in this release, see [KB 5046061](https://support.microsoft.com/help/5046061).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 14.0.3480.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3480.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3480.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3480.1-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3480.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3480.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3480.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3480.1-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages** | 14.0.3480.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3480.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3480.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3480.1-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31-GDR4"></a> CU 31 GDR 4 (September 2024)

This is the Cumulative Update 31-GDR4 (CU 31 GDR 4) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 31). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3475.1. For information about the fixes and improvements in this release, see [KB 5042215](https://support.microsoft.com/help/5042215).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages** | 14.0.3475.1-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3475.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3475.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3475.1-4.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3475.1-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3475.1-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3475.1-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3475.1-4.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages** | 14.0.3475.1-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3475.1-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3475.1-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3475.1-4_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31-GDR2"></a> CU 31 GDR 2 (October 2023)

This is the Cumulative Update 31-GDR2 (CU 31 GDR 2) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 31). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3465.1. For information about the fixes and improvements in this release, see [KB 5029376](https://support.microsoft.com/help/5029376).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3465.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3465.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3465.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3465.1-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3465.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3465.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3465.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3465.1-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3465.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3465.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3465.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3465.1-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31-GDR1"></a> CU 31 GDR 1 (February 2023)

This is the Cumulative Update 31-GDR1 (CU 31 GDR 1) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 31). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3460.9. For information about the fixes and improvements in this release, see [KB 5021126](https://support.microsoft.com/help/5021126).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3460.9-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3460.9-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3460.9-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3460.9-3.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3460.9-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3460.9-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3460.9-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3460.9-3.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3460.9-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3460.9-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3460.9-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3460.9-3_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU31"></a> CU 31 (September 2022)

This is the Cumulative Update 31 (CU 31) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3456.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate31.md).

> [!IMPORTANT]  
> This is the final cumulative update for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)].

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3456.2-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3456.2-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3456.2-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3456.2-3.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3456.2-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3456.2-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3456.2-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3456.2-3.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3456.2-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3456.2-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3456.2-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3456.2-3_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU30"></a> CU 30 (July 2022)

This is the Cumulative Update 30 (CU 30) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3451.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate30.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3451.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3451.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3451.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3451.2-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3451.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3451.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3451.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3451.2-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3451.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3451.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3451.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3451.2-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU29-GDR"></a> CU 29 GDR (June 2022)

This is the Cumulative Update 29-GDR (CU 29 GDR) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 29). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3445.2. For information about the fixes and improvements in this release, see [KB 5014553](https://support.microsoft.com/help/5014553).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3445.2-4 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3445.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3445.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3445.2-4.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3445.2-4 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3445.2-4.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3445.2-4.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3445.2-4.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3445.2-4 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3445.2-4_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3445.2-4_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3445.2-4_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU29"></a> CU 29 (March 2022)

This is the Cumulative Update 29 (CU 29) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3436.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate29.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3436.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3436.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3436.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3436.1-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3436.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3436.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3436.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3436.1-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3436.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3436.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3436.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3436.1-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU28"></a> CU 28 (January 2022)

This is the Cumulative Update 28 (CU 28) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3430.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate28.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3430.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3430.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3430.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3430.2-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3430.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3430.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3430.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3430.2-1.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3430.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3430.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3430.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3430.2-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU27"></a> CU 27 (October 2021)

This is the Cumulative Update 27 (CU 27) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3421.10. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate27.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3421.10-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3421.10-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3421.10-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3421.10-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3421.10-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3421.10-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3421.10-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3421.10-2.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3421.10-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3421.10-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3421.10-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3421.10-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU26"></a> CU 26 (September 2021)

This is the Cumulative Update 26 (CU 26) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3411.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate26.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3411.3-16 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3411.3-16.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3411.3-16.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3411.3-16.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3411.3-16 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3411.3-16.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3411.3-16.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3411.3-16.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3411.3-16 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3411.3-16_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3411.3-16_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3411.3-16_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU25"></a> CU 25 (July 2021)

This is the Cumulative Update 25 (CU 25) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3401.7. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate25.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3401.7-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3401.7-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3401.7-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3401.7-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3401.7-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3401.7-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3401.7-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3401.7-2.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3401.7-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3401.7-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3401.7-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3401.7-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU24"></a> CU 24 (May 2021)

This is the Cumulative Update 24 (CU 24) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3391.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate24.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3391.2-12 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3391.2-12.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3391.2-12.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3391.2-12.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3391.2-12 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3391.2-12.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3391.2-12.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3391.2-12.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3391.2-12 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3391.2-12_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3391.2-12_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3391.2-12_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU23"></a> CU 23 (February 2021)

This is the Cumulative Update 23 (CU 23) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3381.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate23.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3381.3-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3381.3-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3381.3-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3381.3-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3381.3-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3381.3-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3381.3-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3381.3-2.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3381.3-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3381.3-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3381.3-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3381.3-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU22"></a> CU 22 GDR (January 2021)

This is the Cumulative Update 22-GDR (CU 22 GDR) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 22). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3370.1. For information about the fixes and improvements in this release, see [KB 4583457](https://support.microsoft.com/help/4583457).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3370.1-18 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3370.1-18.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3370.1-18.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3370.1-18.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3370.1-18 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3370.1-18.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3370.1-18.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3370.1-18.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3370.1-18 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3370.1-18_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3370.1-18_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3370.1-18_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="GDR5"></a> GDR 5 (January 2021)

This is the General Distribution Release GDR5 (GDR 5) of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.2037.2. For information about the fixes and improvements in this release, see [KB 4583456](https://support.microsoft.com/help/4583456).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.2037.2-23 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2037.2-23.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2037.2-23.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2037.2-23.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.2037.2-23 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2037.2-23.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2037.2-23.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2037.2-23.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.2037.2-23 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server/mssql-server_14.0.2037.2-23_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.2037.2-23_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.2037.2-23_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU22"></a> CU 22 (September 2020)

This is the Cumulative Update 22 (CU 22) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3356.20. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate22.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3356.20-23 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3356.20-23.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3356.20-23.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3356.20-23.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3356.20-23 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3356.20-23.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3356.20-23.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3356.20-23.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3356.20-23 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3356.20-23_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3356.20-23_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3356.20-23_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU21"></a> CU 21 (July 2020)

This is the Cumulative Update 21 (CU 21) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3335.7. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate21.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3335.7-17 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3335.7-17.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3335.7-17.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3335.7-17.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3335.7-17 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3335.7-17.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3335.7-17.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3335.7-17.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3335.7-17 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3335.7-17_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3335.7-17_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3335.7-17_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU20"></a> CU 20 (April 2020)

This is the Cumulative Update 20 (CU 20) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3294.2. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate20.md).

> [!NOTE]  
> **Ubuntu 18.04** and **RHEL 8** are now supported on [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] starting with CU 20.
>
> The offline package installation links for Ubuntu are pointing to Ubuntu 18.04 packages, except for the SSIS package (which isn't available for Ubuntu 18.04). If you're looking for Ubuntu 16.04 packages, refer to the download path <https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/>.
>
> The offline package installation links for Red Hat are pointing to RHEL 8 packages, except for the SSIS package (which isn't available for RHEL 8). If you're looking for RHEL 7 packages, refer to the download path <https://packages.microsoft.com/rhel/7/mssql-server-2017/>.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 8.x RPM packages**<br /><br />(Get RPM packages for [RHEL 7.x](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/)) | 14.0.3294.2-27 | [Database Engine RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-14.0.3294.2-27.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3294.2-27.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/8/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3294.2-27.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3294.2-27 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3294.2-27.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3294.2-27.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3294.2-27.x86_64.rpm) |
| **Ubuntu 18.04 Debian packages**<br /><br />(Get Debian packages for [Ubuntu 16.04](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/)) | 14.0.3294.2-27 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3294.2-27_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3294.2-27_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/18.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3294.2-27_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU19"></a> CU 19 (February 2020)

This is the Cumulative Update 19 (CU 19) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3281.6. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate19.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3281.6-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3281.6-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3281.6-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3281.6-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3281.6-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3281.6-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3281.6-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3281.6-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3281.6-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3281.6-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3281.6-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3281.6-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU18"></a> CU 18 (December 2019)

This is the Cumulative Update 18 (CU 18) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3257.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate18.md).

### Added support

- Change Data Capture (CDC) is supported with [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] on Linux starting with CU 18.
- Transactional Replication is supported with [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] on Linux starting with CU 18.

### Remarks

[!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] containers now have a new tagging pattern as described in the following examples.

- `mcr.microsoft.com/mssql/server:<SQL Server Version>-<update>-<Linux Distribution>-<Linux Distribution Version>`

  This command pulls the container image with the combination described in the tag.

- `mcr.microsoft.com/mssql/server:<SQL Server Version>-latest`

  This command pulls the latest [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] version on the latest supported Ubuntu version.

#### Examples

- `mcr.microsoft.com/mssql/server:2017-CU18-ubuntu-16.04`

  This command pulls [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] CU 18 based on the Ubuntu 16.04 container.

- `mcr.microsoft.com/mssql/server:2017-latest`

  This command pulls the latest [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] version (CU 18 as the time of this writing) based on the %%LATESTUBUNTU%% container.

> [!NOTE]
>  
> We no longer publish containers with other tagging patterns for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)] containers.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3257.3-13 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3257.3-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3257.3-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3257.3-13.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3257.3-13 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3257.3-13.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3257.3-13.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3257.3-13.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3257.3-13 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3257.3-13_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3257.3-13_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3257.3-13_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU17"></a> CU 17 (October 2019)

This is the Cumulative Update 17 (CU 17) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3238.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate17.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3238.1-19 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3238.1-19.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3238.1-19.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3238.1-19.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3238.1-19 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3238.1-19.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3238.1-19.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3238.1-19.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3238.1-19 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3238.1-19_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3238.1-19_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3238.1-19_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU16"></a> CU 16 (August 2019)

This is the Cumulative Update 16 (CU 16) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3223.3. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate16.md).

### What's new

| New feature or update | Details |
| --- | --- |
| MSDTC support | Support for the Microsoft Distributed Transaction Coordinator (MSDTC) for [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. For more information, see [How to configure the Microsoft Distributed Transaction Coordinator (MSDTC) on Linux](/sql/linux/sql-server-linux-configure-msdtc). |

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3223.3-15 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3223.3-15.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3223.3-15.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3223.3-15.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3223.3-15 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3223.3-15.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3223.3-15.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3223.3-15.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3223.3-15 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3223.3-15_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3223.3-15_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3223.3-15_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU15-GDR"></a> CU 15 GDR (July 2019)

This is the Cumulative Update 15-GDR (CU 15 GDR) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 15). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3192.2. For information about the fixes and improvements in this release, see [KB 4505225](https://support.microsoft.com/help/4505225).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3192.2-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3192.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3192.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3192.2-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3192.2-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3192.2-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3192.2-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3192.2-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3192.2-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3192.2-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3192.2-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3192.2-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="GDR4"></a> GDR 4 (July 2019)

This is the General Distribution Release GDR4 (GDR 4) of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.2027.2. For information about the fixes and improvements in this release, see [KB 4505224](https://support.microsoft.com/help/4505224).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.2027.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2027.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2027.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2027.2-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.2027.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2027.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2027.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2027.2-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.2027.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server/mssql-server_14.0.2027.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.2027.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.2027.2-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU15"></a> CU 15 (May 2019)

This is the Cumulative Update 15 (CU 15) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3162.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate15.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3162.1-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3162.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3162.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3162.1-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3162.1-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3162.1-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3162.1-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3162.1-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3162.1-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3162.1-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3162.1-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3162.1-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU14"></a> CU 14 (March 2019)

This is the Cumulative Update 14 (CU 14) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3076.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate14.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3076.1-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3076.1-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3076.1-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3076.1-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3076.1-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3076.1-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3076.1-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3076.1-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3076.1-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3076.1-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3076.1-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3076.1-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU13"></a> CU 13 (December 2018)

This is the Cumulative Update 13 (CU 13) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3048.4. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate13.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3048.4-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3048.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3048.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3048.4-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3048.4-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3048.4-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3048.4-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3048.4-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3048.4-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3048.4-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3048.4-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3048.4-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU12"></a> CU 12 (October 2018)

This is the Cumulative Update 12 (CU 12) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3045.24. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate12.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3045.24-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3045.24-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3045.24-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3045.24-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3045.24-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3045.24-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3045.24-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3045.24-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3045.24-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3045.24-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3045.24-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3045.24-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU11"></a> CU 11 (September 2018)

This is the Cumulative Update 11 (CU 11) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3038.14. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate11.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3038.14-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3038.14-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3038.14-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3038.14-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3038.14-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3038.14-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3038.14-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3038.14-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3038.14-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3038.14-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3038.14-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3038.14-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU10"></a> CU 10 (August 2018)

This is the Cumulative Update 10 (CU 10) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3037.1. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate10.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3037.1-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3037.1-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3037.1-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3037.1-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3037.1-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3037.1-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3037.1-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3037.1-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3037.1-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3037.1-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3037.1-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3037.1-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU9-GDR"></a> CU 9 GDR (August 2018)

This is the Cumulative Update 9-GDR (CU 9 GDR) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 9). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3035.2. For information about the fixes and improvements in this release, see [KB 4293805](https://support.microsoft.com/help/4293805).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3035.2-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3035.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3035.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3035.2-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3035.2-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3035.2-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3035.2-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3035.2-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3035.2-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3035.2-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3035.2-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3035.2-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="GDR2"></a> GDR 2 (August 2018)

This is the General Distribution Release GDR2 (GDR 2) of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.2002.14. For information about the fixes and improvements in this release, see [KB 4293803](https://support.microsoft.com/help/4293803).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.2002.14-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2002.14-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2002.14-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2002.14-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.2002.14-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2002.14-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2002.14-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2002.14-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.2002.14-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server/mssql-server_14.0.2002.14-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.2002.14-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.2002.14-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU9"></a> CU 9 (July 2018)

This is the Cumulative Update 9 (CU 9) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3030.27. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate9.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3030.27-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3030.27-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3030.27-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3030.27-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3030.27-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3030.27-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3030.27-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3030.27-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3030.27-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3030.27-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3030.27-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3030.27-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU8"></a> CU 8 (June 2018)

This is the Cumulative Update 8 (CU 8) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3029.16. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate8.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3029.16-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3029.16-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3029.16-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3029.16-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3029.16-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3029.16-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3029.16-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3029.16-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3029.16-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3029.16-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3029.16-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3029.16-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU7"></a> CU 7 (May 2018)

This is the Cumulative Update 7 (CU 7) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3026.27. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate7.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3026.27-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3026.27-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3026.27-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3026.27-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3026.27-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3026.27-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3026.27-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3026.27-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3026.27-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3026.27-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3026.27-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3026.27-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU6"></a> CU 6 (April 2018)

This is the Cumulative Update 6 (CU 6) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3025.34. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate6.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3025.34-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3025.34-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3025.34-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3025.34-3.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3025.34-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3025.34-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3025.34-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3025.34-3.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3025.34-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3025.34-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3025.34-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3025.34-3_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU5"></a> CU 5 (March 2018)

This is the Cumulative Update 5 (CU 5) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3023.8. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate5.md).

### Known upgrade issue

When you upgrade from a previous release to CU 5, [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] might fail to start with the following error:

```output
Error: 4860, Severity: 16, State: 1.
Cannot bulk load. The file "C:\Install\SqlTraceCollect.dtsx" does not exist or you don't have file access rights.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 200, state
```

To resolve this error, enable [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] Agent and restart [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] with the following commands:

```bash
sudo /opt/mssql/bin/mssql-conf set sqlagent.enabled true
sudo systemctl start mssql-server
```

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3023.8-5 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3023.8-5.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3023.8-5.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3023.8-5.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3023.8-5 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3023.8-5.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3023.8-5.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3023.8-5.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3023.8-5 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3023.8-5_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3023.8-5_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3023.8-5_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU4"></a> CU 4 (February 2018)

This is the Cumulative Update 4 (CU 4) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3022.28. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate4.md).

> [!NOTE]  
> As of CU 4, [!INCLUDE [sql-server-no-version](../../includes/versions/sql-server-no-version.md)] Agent is no longer installed as a separate package. It's installed with the Database Engine package and must be enabled to use.

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3022.28-2 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3022.28-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3022.28-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3022.28-2.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3022.28-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3022.28-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3022.28-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3022.28-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3022.28-2 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3022.28-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3022.28-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3022.28-2_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU3"></a> CU 3 (January 2018)

This is the Cumulative Update 3 (CU 3) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3015.40. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate3.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3015.40-1 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3015.40-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3015.40-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3015.40-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3015.40-1.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-is-14.0.3015.40-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3015.40-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3015.40-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3015.40-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3015.40-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3015.40-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3015.40-1 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3015.40-1_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.3015.40-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3015.40-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3015.40-1_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-is/mssql-server-is_14.0.3015.40-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

## <a id="CU3-GDR"></a> CU 3 GDR (January 2018)

This is the Cumulative Update 3-GDR (CU 3 GDR) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that also includes the previously released CU (CU 3). The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3015.40. For information about the fixes and improvements in this release, see [KB 4058562](https://support.microsoft.com/help/4058562).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3015.40-1 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3015.40-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3015.40-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3015.40-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3015.40-1.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-is-14.0.3015.40-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3015.40-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3015.40-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3015.40-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3015.40-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3015.40-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3015.40-1 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3015.40-1_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.3015.40-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3015.40-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3015.40-1_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-is/mssql-server-is_14.0.3015.40-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

## <a id="GDR1"></a> GDR 1 (January 2018)

This is the General Distribution Release GDR1 (GDR 1) of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. This is a security update that only includes fixes for GDR releases. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.2000.63. For information about the fixes and improvements in this release, see [KB 4057122](https://support.microsoft.com/help/4057122).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.2000.63-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2000.63-3.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-agent-14.0.2000.63-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2000.63-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2000.63-3.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.2000.63-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-14.0.2000.63-3.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-agent-14.0.2000.63-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-fts-14.0.2000.63-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017-gdr/Packages/m/mssql-server-ha-14.0.2000.63-3.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.2000.63-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server/mssql-server_14.0.2000.63-3_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.2000.63-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.2000.63-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017-gdr/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.2000.63-3_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU2"></a> CU 2 (November 2017)

This is the Cumulative Update 2 (CU 2) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3008.27. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate2.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3008.27-1 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3008.27-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3008.27-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3008.27-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3008.27-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3008.27-1 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3008.27-1.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3008.27-1.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3008.27-1.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3008.27-1.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3008.27-1 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3008.27-1_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.3008.27-1_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3008.27-1_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3008.27-1_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="CU1"></a> CU 1 (October 2017)

This is the Cumulative Update 1 (CU 1) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.3006.16. For information about the fixes and improvements in this release, see the [Support article](../sqlserver-2017/cumulativeupdate1.md).

### Package details

For manual or offline package installations, you can download the RPM and Debian packages with the information in the following table:

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.3006.16-3 | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.3006.16-3.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3006.16-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3006.16-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3006.16-3.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.3006.16-3 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.3006.16-3.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-agent-14.0.3006.16-3.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.3006.16-3.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.3006.16-3.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.3006.16-3 | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.3006.16-3_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.3006.16-3_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.3006.16-3_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.3006.16-3_amd64.deb) |

Go back to the [release history](#release-history).

## <a id="GA"></a> GA (October 2017)

This is the General Availability (GA) release of [!INCLUDE [sql-server-2017](../../includes/versions/sql-server-2017.md)]. The [!INCLUDE [sql-server-database-engine](../../includes/versions/sql-server-database-engine.md)] version for this release is 14.0.1000.169.

### Package details

Package details and download locations for the RPM and Debian packages are listed in the following table. You don't need to download these packages directly if you use the steps in the following installation guides:

- [Install SQL Server package](/sql/linux/sql-server-linux-setup)
- [Install SQL Server Full-Text Search on Linux](/sql/linux/sql-server-linux-setup-full-text-search)
- [Install SQL Server Agent package](/sql/linux/sql-server-linux-setup-sql-agent)
- [Install SQL Server Integration Services (SSIS) on Linux](/sql/linux/sql-server-linux-setup-ssis)

| Distribution | Package version | Downloads |
| --- | --- | --- |
| **RHEL 7.x RPM packages** | 14.0.1000.169-2 <sup>1</sup> | [Database Engine RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-14.0.1000.169-2.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-agent-14.0.1000.169-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-fts-14.0.1000.169-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-ha-14.0.1000.169-2.x86_64.rpm)<br />[SSIS RPM package](https://packages.microsoft.com/rhel/7/mssql-server-2017/Packages/m/mssql-server-is-14.0.1000.169-1.x86_64.rpm) |
| **SLES 12 RPM packages** | 14.0.1000.169-2 | [Database Engine RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-14.0.1000.169-2.x86_64.rpm)<br />[SQL Server Agent RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-agent-14.0.1000.169-2.x86_64.rpm)<br />[Full-Text Search RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-fts-14.0.1000.169-2.x86_64.rpm)<br />[High Availability RPM package](https://packages.microsoft.com/sles/12/mssql-server-2017/Packages/m/mssql-server-ha-14.0.1000.169-2.x86_64.rpm) |
| **Ubuntu 16.04 Debian packages** | 14.0.1000.169-2 <sup>1</sup> | [Database Engine Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_14.0.1000.169-2_amd64.deb)<br />[SQL Server Agent Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-agent/mssql-server-agent_14.0.1000.169-2_amd64.deb)<br />[Full-Text Search Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-fts/mssql-server-fts_14.0.1000.169-2_amd64.deb)<br />[High Availability Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-ha/mssql-server-ha_14.0.1000.169-2_amd64.deb)<br />[SSIS Debian package](https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server-is/mssql-server-is_14.0.1000.169-1_amd64.deb) |

<sup>1</sup> SSIS package can have a different build number.

Go back to the [release history](#release-history).

## Related content

- [SQL Server on Linux FAQ](/sql/linux/sql-server-linux-faq)
- [Quickstart: Install SQL Server and create a database on Red Hat](/sql/linux/quickstart-install-connect-red-hat)
- [Quickstart: Install SQL Server and create a database on SUSE Linux Enterprise Server](/sql/linux/quickstart-install-connect-suse)
- [Quickstart: Install SQL Server and create a database on Ubuntu](/sql/linux/quickstart-install-connect-ubuntu)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
- [Create a SQL VM in Azure](/azure/azure-sql/virtual-machines/linux/sql-vm-create-portal-quickstart)
- [Quickstart: Run SQL Server in the cloud](/sql/linux/quickstart-install-connect-clouds)
