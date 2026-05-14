---
ms.date: 05/14/2026
ms.custom: sap:Linked Server and distributed queries, evergreen
ms.reviewer: randolphwest, hugoqueiroz, jamesferebee, aartigoyle, v-shaywood
---

Linked server queries that use the `MSDASQL` (OLE DB Provider for ODBC Drivers) provider and specify a provider string (`@provstr`) might fail and return the following error:

> Msg 7416, Level 16  
> Access to the remote server is denied because no login-mapping exists.

A stricter connection validation check in the Database Engine can reject connections for certain linked server configurations that use the `MSDASQL` provider, even when earlier builds allowed those connections.

For more information and workarounds, see [Linked server queries that use MSDASQL fail with error 7416](../../database-engine/linked-servers/msdasql-query-error-7416.md).
