---
title: Selecting distinct users in identity fields
description: This article describes the new identity control for work items and queries in Visual Studio 2015 and the web portal. This feature is available through Team Foundation Server 2015.
ms.date: 08/14/2020
ms.custom: sap:Server Administration
ms.service: azure-devops-server
---
# Client support for selecting distinct users in identity fields in Team Foundation Server 2015

This article introduces the support for selecting distinct users in identity fields in Team Foundation Server 2015.

_Original product version:_ &nbsp; Team Foundation Server 2015, Visual Studio 2015  
_Original KB number:_ &nbsp; 3080404

## Summary

Before Team Foundation Server 2015, you could not distinguish between users who had the same display name when you assigned and queried work items. Team Foundation Server 2015 provides a new identity control for work items and queries in Visual Studio 2015 and the web portal. With this new identity control, you can easily distinguish between users who have the same display name, because the control displays the user's avatar and account name.

## More information

**What does this mean for queries?**

When you query in Visual Studio 2013 or earlier versions, a query clause that contains an ambiguous display name returns the work items of everyone who shares that display name. With newer clients, however, query results return only the work items for the distinct user who you selected through the Identity selector.

Additionally, querying on the display name in Visual Studio 2013 or earlier versions returns results for both active and inactive users who have matching display names. But when you use the web portal or Visual Studio 2015 to query against Team Foundation Server 2015 or Visual Studio Codespace, the user must use the `Contains` operator and query against the display name to return results for both active and inactive users.

|Query way| Query behavior |
|---|---|
| Visual Studio 2013 and earlier versions|New identity control is not available. Query results contain work items of all users who have the same display name, including active and inactive users.|
| Visual Studio 2015|Identity control is available, and query results contain work items that are assigned to the distinct active user. Inactive users can be found only by using the `Contains` operator.|
| Web portal|Identity control is available, and query results contain work items that are assigned to the distinct user. Inactive users can be found only by using the `Contains` operator.|
  
## Applies to

- Team Foundation Server 2015
- Team Foundation Server 2015 Express
- Visual Studio Enterprise 2015
- Visual Studio Express 2015 for Windows Desktop
- Visual Studio Express 2015 for Web
- Visual Studio Express 2015 for Windows 10
- Visual Studio Professional 2015

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
