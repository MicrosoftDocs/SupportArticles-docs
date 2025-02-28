---
title: Frequently asked questions, used terms and acronyms
description: This article describes the frequently asked questions, used terms and acronyms of SQL Server.
ms.date: 10/15/2022
ms.topic: faq
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: v-six
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Frequently asked questions, used terms and acronyms

This article describes the frequently asked questions, used terms and acronyms of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321185

## Frequently asked questions

**Q1: How do you determine the version of SQL Server when SQL Server is not running?**

**A1:** You can determine the version of SQL Server by using either Method 2 or Method 5 (for SQL Server 2008 and later versions) in the [Determine which version and edition of SQL Server Database Engine is running](find-my-sql-version.md)] section of this article.

**Q2: How do I map the product versions to product names?**

**A2:** You can use the following table as a reference.

|Version pattern|SQL Product|
|---|---|
|16.0.x.x|SQL Server 2022|
|15.0.x.x|SQL Server 2019|
|14.0.x.x|SQL Server 2017|
|13.0.x.x|SQL Server 2016|
|12.0.x.x|SQL Server 2014|
|11.0.x.x|SQL Server 2012|
|10.50.x.x|SQL Server 2008 R2|
|10.00.x.x|SQL Server 2008|
|9.00.x.x|SQL Server 2005|
|8.00.x.x|SQL Server 2000|

## Frequently used terms and acronyms

**Cumulative update (CU):** A roll-up update that contains all previous critical on-demand hotfixes to date. Additionally, a CU contains fixes for issues that meet the hotfix acceptance criteria. These criteria may include the availability of a workaround, the effect on the customer, the reproducibility of the problem, the complexity of the code that must be changed, and other topics.

**Hotfix:** A single, cumulative package that includes one or more files that are used to address a problem in a product and are cumulative at the binary and file level. A hotfix addresses a specific customer situation and may not be distributed outside the customer's organization.

**RTM:** Usually means "release to manufacturing". In the context of a product such as SQL Server, it indicates that no service packs or hotfixes were applied to the product.

**RTW:** Usually means "release to web". It indicates a package that was released to the web and made available to customers for downloading.

**Service pack:** A tested, cumulative set of all hotfixes, security updates, critical updates, and updates. Service packs may also contain additional fixes for problems that are found internally since the release of the product and a limited number of customer-requested design changes or features.

For more information, go to the following websites:

- [Announcing the Modern Servicing Model for SQL Server](https://techcommunity.microsoft.com/t5/sql-server/announcing-the-modern-servicing-model-for-sql-server/ba-p/385594)

- [Naming schema and Fix area descriptions for SQL Server software update packages](https://support.microsoft.com/help/822499)

- [Description of the standard terminology that is used to describe Microsoft software updates](https://support.microsoft.com/help/824684)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../windows-client/deployment/standard-terminology-software-updates.md)

- [An Incremental Servicing Model is available from the SQL Server team to deliver hotfixes for reported problems](https://support.microsoft.com/help/935897)

- [Software release life cycle](http://wikipedia.org/wiki/software_release_life_cycle)

- [SQL Server documentation](/sql/sql-server/?view=sql-server-ver15&preserve-view=true)

- [SQL Server product information center](https://www.microsoft.com/sqlserver/default.aspx)

- [SQL Server release blogs](https://aka.ms/sqlreleases)
