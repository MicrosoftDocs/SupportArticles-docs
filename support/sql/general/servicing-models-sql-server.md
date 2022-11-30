---
title: Servicing models for SQL Server
description: This article describes the information regarding servicing channels for currently supported versions of SQL Server.
ms.date: 08/19/2020
ms.reviewer: ramakoni
ms.author: v-sidong
author: sevend2
ms.prod: sql
---

# Servicing models for SQL Server

_Original product version:_ &nbsp; SQL Server (all supported versions)  
_Original KB number:_ &nbsp; 935897

This article provides more information regarding servicing channels for currently supported versions of SQL Server. The criteria for fixes includes workaround availability, customer effect, reproducibility, the complexity of the code that must be changed, and so on.  

For determining the version, edition, and the latest updates of your SQL Server instance, review [Determine the version, edition, and update level of SQL Server and its components](determine-version-edition-update-level.md). For details on the support cycle for each product, check [mainstream lifecycle](/lifecycle/products/?products=sql-server). To understand various options that are available for SQL Server products that have reached the end of support, review [SQL Server end of support options](/sql/sql-server/end-of-support/sql-server-end-of-support-overview).

## Delivery mechanisms for SQL Server updates

The SQL Server team uses a scheduled delivery model for releasing fixes and product updates. In the scheduled delivery model, a customer can receive a fix to address their most critical situations in a reasonable time. Additionally, a customer can receive a fix that has undergone rigorous testing and that is released on a scheduled basis. Therefore, the SQL Server team has created the following delivery mechanisms:

### Cumulative Update (CU)

|Description|SQL Server 2017 and later versions (both Windows and Linux platforms) |SQL Server 2016 and earlier versions|
|-|-|-|
|**Contains**|All the fixes, improvements, and feature enhancements since the release version of the product.|All the fixes, improvements, and feature enhancements since the release version (RTM) or a baseline Service Pack. |
|**Release frequency** |Every month for the first year after a SQL Server release and every two months for the remaining four years of the full 5-year [mainstream lifecycle](/lifecycle/products/?products=sql-server). |Every two months for a given baseline. |
|**Localized content** |Will accommodate localized content, allowing new feature completeness and supportability enhancements to be delivered faster. ||
|**Example** |[KB5016394 - Cumulative Update 17 for SQL Server 2019 (microsoft.com)](https://support.microsoft.com/topic/kb5016394-cumulative-update-17-for-sql-server-2019-3033f654-b09d-41aa-8e49-e9d0c353c5f7)|[B5001092 - Cumulative Update 17 for SQL Server 2016 SP2 (microsoft.com)](https://support.microsoft.com/topic/kb5001092-cumulative-update-17-for-sql-server-2016-sp2-5876a4d6-59ac-484a-93dc-4be456cd87d1)|
|**Notes** |CU31 for 2017 is the last CU for SQL Server 2017. We'll only ship on-demand fixes and security updates for SQL Server 2017.|We no longer ship CUs for SQL Server 2016 and earlier versions. Only on-demand fixes and security updates will be shipped.|

> [!NOTE]
> The update can be requested by any customer, regardless of their support offering.

### On-demand fixes(OD)

- Contains critical fix requests that satisfy all these conditions:

   - Can't wait for the scheduled Cumulative Update release.
   - There is no reasonable mitigation or workaround.
   - The problem causes significant impact to product or application functionality.

- The hotfix can be requested by any customer, regardless of their support offering.

- The hotfix is released on or before a mutually agreed-upon date based on the customer's need. The hotfix is targeted for a specific baseline like a Cumulative Update or a Service Pack.

- This hotfix build can contain one or more fixes.

- They don't have a defined frequency.

- Example: [KB4510083 - On-demand hotfix update package 2 for SQL Server 2017 CU15](https://support.microsoft.com/topic/kb4510083-on-demand-hotfix-update-package-2-for-sql-server-2017-cu15-5a04ceb8-b93d-43d7-c767-e96e307744e4)

### General distribution release (GDR)

- A GDR addresses an issue that has a broad customer impact, security implications, or both. A GDR is determined and issued by Microsoft as appropriate and when appropriate. The number of GDRs is kept to a minimum.

- A GDR can't be requested by a customer. Microsoft internally determines whether a reported hotfix is classified as and delivered as a GDR.

- A GDR is released through the download center. A GDR is also released through Microsoft Update, Windows Update, or both.

- For fixes to SQL Server versions that are out of extended support, review [What are Extended Security Updates for SQL Server?](/sql/sql-server/end-of-support/sql-server-extended-security-updates)

- Example: [KB5014356 – Description of the security update for SQL Server 2019 GDR: June 14, 2022](https://support.microsoft.com/topic/kb5014356-description-of-the-security-update-for-sql-server-2019-gdr-june-14-2022-568fdeaa-f05a-4f2e-8be5-b0a15d99fd8a)

> [!NOTE]
> By default, hotfixes are serviced through GDR, CU, and OD releases. When a product's hotfix request volume gets low, the SQL Server team stops CU releases and delivers hotfixes through GDR and OD releases. The SQL Server team makes the decision based on support trends and customer demand.

### Service Pack (SP)

- Service packs are no longer released for SQL Server 2017 and later versions.  

- Service packs include hotfixes and fixes to issues that are reported through the Microsoft SQL Server community. Service packs can also include product and feature improvements.

- They're typically released on a yearly schedule.

- Service packs may also include issues that our support organization feels must be addressed. The most common items included impact customer support cases and customer satisfaction. These updates and components are conveniently bundled for easy downloading.

- Service packs are cumulative. Each new service pack contains all the fixes that are in previous service packs, together with any new fixes. You don't have to install a previous service pack before you install the latest service pack. To find the list of fixes and cumulative updates that a service pack includes, review its release documentation.

- Example: [KB5003279 - SQL Server 2016 Service Pack 3 release information](https://support.microsoft.com/topic/kb5003279-sql-server-2016-service-pack-3-release-information-46ab9543-5cf9-464d-bd63-796279591c31)

## Support phase and release vehicle matrix

|Support phase |Mainstream support |Extended Support |Extended Security Updates |
|-|-|-|-|
|**Available release vehicles** |CU, OD, GDR, SP (SQL Server 2016 and earlier versions only) |GDR/Security updates |GDR/Security updates with agreement |

### SQL Server 2017 and later versions

The following figure shows an overview of the support cycle for a typical product. This kind of timeline also applies to all future releases of a product.

:::image type="content" source="media/servicing-models-sql-server/overview-support-cycle-2017.png" alt-text="Screenshot shows an overview of the support cycle for a typical product of SQL Server 2017 and later versions.":::

### SQL Server 2016 and earlier versions

The following figure shows an overview of the support cycle for a typical product. Both the original release version support cycle and the first service pack support cycle are shown.

:::image type="content" source="media/servicing-models-sql-server/overview-support-cycle-2016.png" alt-text="Screenshot shows an overview of the support cycle for a typical product of SQL Server 2016 and later versions.":::
