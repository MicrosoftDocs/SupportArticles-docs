---
title: Fail to enumerate subscription properties
description: This article provides a workaround for the error that occurs when you try to enumerate the properties of the subscription on a subscriber instance in SQL Server Management Studio.
ms.date: 08/05/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: lzhang, tzakir, akbarf, maarumug, ramakoni
---
# Error when you enumerate the subscription properties in SQL Server 2016 or 2017

This article helps you work around the problem that occurs when you try to enumerate the properties of the subscription on a subscriber instance in SQL Server Management Studio.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016  
_Original KB number:_ &nbsp; 4046801

## Symptoms

Consider the following scenario:

- You have configured an instance of Microsoft SQL Server 2016 or 2017 as a publisher and distributor.

- You have configured either a push or pull subscription to a remote subscriber that's not configured as a publisher or distributor.

In this situation, if you try to enumerate the properties of the subscription on a subscriber instance in SQL Server Management Studio, you receive an error message that resembles the following:

> Cannot apply value 'null' to property ServerInstance: Value cannot be null.

## Workaround

To work around this issue, use replication monitor for the subscription status and progress.

## Applies to

- SQL Server 2017 on Linux (all editions)
- SQL Server 2017 on Windows (all editions)
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Web
- SQL Server 2016 Express
