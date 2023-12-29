---
title: TLS 1.2 upgrade workflow
description: This article describes the upgrade steps and some important points to be done before upgrading the TLS protocol.
ms.date: 12/29/2023
ms.custom: sap:Connection issues
author: Malcolm-Stewart 
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
---

# Introduction

TLS 1.2 is a cryptographic protocol that provides secure communication and is a more secure protocol than TLS 1.0, which SQL Server has used historically. This article describes the workflow which is an ideal order of upgrade steps and discusses some things to keep in mind while performing the upgrade.

For more information about which SQL servers and drivers and other components can and need to be upgraded, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).

For more information about SharePoint-specific TLS 1.2 upgrade, see [Enable TLS and SSL support in SharePoint 2013](/SharePoint/security-for-sharepoint-server/enable-tls-and-ssl-support-in-sharepoint-2013?redirectedfrom=MSDN).

