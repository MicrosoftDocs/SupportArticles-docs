---
title: Support policies for manual database changes
description: Describes the support policies for manual database changes that are made to the site database in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, jchornbe, brianhun
---
# Support policies for manual database changes in a Configuration Manager environment

This article describes Microsoft support policies for changes that are made to the site database (SQL Server database) in Configuration Manager (all versions).

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager, Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 3106512

## Support policies for manual database changes

Additions or changes that are made to the schema, structure, views, or objects in the site database are not supported if they are made outside the Software Development Kit (SDK) or the Configuration Manager product.

This includes changes that are made under the guidance of Microsoft Customer Support, Microsoft Consulting Services, or other partner organizations to help troubleshoot problems or performance issues.

In this context, **not supported** is defined as follows:

- Changes are made at your own risk. The Configuration Manager product team doesn't offer testing of database changes.
- Updates or upgrades to the product may revert your changes.
- Servicing support is not available for issues that are caused by custom changes to the database. Servicing support is defined as requests for out-of-band (hotfix or cumulative update) changes that are made to resolve problems or alter the product design.

This definition doesn't prevent you from contacting Microsoft Customer Support, and it doesn't automatically exempt the whole environment from support. Changes that are made by using the guidance of official documentation are supported. However, such changes are not guaranteed to persist after updates or upgrades are applied.

> [!NOTE]
> Microsoft Customer Support cannot build, rebuild, troubleshoot, or maintain custom changes to the database. When you contact Support, you may be asked to revert the changes to resolve a problem. Additionally, you may be asked to reproduce the same problem independent of those changes to help Support agents escalate your case and work toward a resolution.

Because of the diverse nature of Configuration Manager installations, some unsupported changes (such as adding a new index) are still desirable to optimize performance for a given environment. We recommend that you test such changes thoroughly in your environment to make sure that they meet your business needs and do not introduce unintended side effects. Remember that these changes may be reverted during an update or upgrade of the product.

If you believe that product changes that you have made in your environment would be appropriate to include in a future version of the product, we encourage you to [send feedback directly to the Microsoft product group](/mem/configmgr/core/understand/product-feedback).
