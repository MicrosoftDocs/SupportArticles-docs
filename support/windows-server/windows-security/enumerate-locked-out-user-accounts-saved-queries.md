---
title: Enumerate locked out user accounts using Saved Queries
description: provides some step-by-step instructions to enumerate locked out user accounts using Saved Queries
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows security technologies\account lockouts
- pcy:WinComm Directory Services
---
# Enumerate locked out user accounts using Saved Queries

This article provides some step-by-step instructions to enumerate locked out user accounts using Saved Queries.

_Original KB number:_ &nbsp; 555131

This article was written by [Simon Geary](https://social.msdn.microsoft.com/profile/simon%20geary/), Microsoft MVP.

## More Information

Follow these step-by-step instructions to list all currently locked out accounts in a domain:

1. Sign in to a Domain Controller with administrative privileges in the domain, and open Active Directory Users & Computers.
2. Right-click **Saved Queries** and select **New** > **Query**.
3. Give the query a name and optionally a description. Select **Define Query**.
4. Select **Custom Search** from the drop-down dialogue box.
5. Select **Advanced** and enter this LDAP filter in the query box:

    *(&(objectCategory=Person)(objectClass=User)(lockoutTime>=1))*

6. Select **OK** twice and the new query appears under the **Saved Queries** folder in Active Directory Users & Computers.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
