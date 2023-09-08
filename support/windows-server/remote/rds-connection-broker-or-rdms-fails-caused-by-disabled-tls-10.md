---
title: Remote Desktop service (RDS) Connection Broker or Remote Desktop Management service (RDMS) fails
description: Addresses an issue in which RDS Connection Broker or RDMS fails after you disable Transport Layer Security (TLS) 1.0 in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, jerrycif
ms.custom: sap:certificate-management, csstroubleshoot
ms.technology: windows-server-rds
---
# RDS Connection Broker or RDMS fails after you disable TLS 1.0 in Windows Server

This article provides methods to make sure Remote Desktop service (RDS) Connection Broker and Remote Desktop Management service (RDMS) can work as expected.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4036954

## Symptoms

Assume that you use the inbox Windows Internal Database (WID) in Windows Server. If you disable Transport Layer Security (TLS) 1.0 when you configure security settings, you experience the following issues:

- The Remote Desktop service (RDS) may fail.
- An existing RDS deployment that uses Remote Desktop Connection Broker and WID may fail.
- The Remote Desktop Management service (RDMS) doesn't start.
- You receive the following error message when you try to start the RDMS:

  > The Remote Desktop Management service on Local Computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.

- The Remote Desktop Connection Broker role can't be installed.

## Cause

This behavior is expected because of the current dependencies between RDS and Windows Internal Database (WID). RDMS and Connection Broker depend on TLS 1.0 to authenticate with the database. WID doesn't currently support TLS 1.2. So, disabling TLS 1.0 breaks this communication.

> [!NOTE]
> RDS deployments that use Connection Broker have to establish an encrypted channel to WID by using one of the following methods:
>
> - TLS
> - SSL 3.0
> - FIPS

## Resolution

To fix this issue, use one of the following methods:

- Set up RDS without Connection Broker for a single-server installation.
- Don't disable TLS 1.0 on a single Connection Broker deployment.
- Configure a high availability Connection Broker deployment that uses dedicated SQL Server.
- Upgrade the computers that run the RDS services to Windows Server 2019.

> [!NOTE]
> Microsoft has released [TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/help/3135244) to enable SQL Server communication to use TLS 1.2.
