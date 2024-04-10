---
title: Migrating BizTalk Servers to another domain isn't supported
description: Describes migrating BizTalk Servers from one domain to another domain isn't supported.
ms.date: 05/17/2022
ms.custom: sap:BizTalk Server Setup and Configuration
ms.reviewer: v-sidong
ms.author: niklase
author: NiklasEMS
---

# Migrating BizTalk Servers from one domain to another domain isn't supported

_Original product version:_&nbsp;BizTalk Server  
_Original KB number:_&nbsp;904356

The Microsoft BizTalk Server installation and the BizTalk Server databases in Microsoft SQL Server contain domain-specific information. In this scenario, the following actions aren't supported:

- Moving an existing BizTalk Server installation from one domain to another domain.

- Moving the databases associated with an existing BizTalk Server installation from one domain to another domain.

## Workaround

If you want to move an existing server, you must use the `ConfigFramework /u` command to completely unconfigure the server before you migrate it to the new domain.

This command removes the current configuration and the existing BizTalk Server databases. Once the server is in the new domain, you must run the Configuration Wizard to reconfigure the server to create a new group that has a new set of databases.

## Applies to

- Microsoft BizTalk Server 2004 Enterprise Edition
- Microsoft BizTalk Server 2006 R2 Enterprise Edition
- Microsoft BizTalk Server 2006 Enterprise Edition
- Microsoft BizTalk Server 2009 Enterprise Edition
- Microsoft BizTalk Server 2010 Enterprise Edition
- Microsoft BizTalk Server 2013 Enterprise Edition
- Microsoft BizTalk Server 2013 R2 Enterprise Edition
- Microsoft BizTalk Server 2016 Enterprise Edition
- Microsoft BizTalk Server 2020 Enterprise Edition
