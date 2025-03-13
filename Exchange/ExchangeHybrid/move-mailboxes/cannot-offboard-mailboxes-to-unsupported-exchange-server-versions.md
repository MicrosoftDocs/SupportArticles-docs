---
title: Can't Offboard Cloud Mailboxes to Unsupported Versions of Exchange Server
description: Resolves an issue in which you receive an error when you try to migrate Exchange Online mailboxes to an out of support version of Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
  - CI 4504
ms.reviewer: aleeming, ninob, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Unsupported versions of Exchange Server
search.appverid: MET150
ms.date: 03/13/2025
---

# Can't offboard cloud mailboxes to unsupported versions of Exchange Server

## Symptoms

In a Microsoft Exchange hybrid deployment, when you try to migrate (offboard) Exchange Online mailboxes to a version of Exchange Server that's out of support, you receive the following error message:

> MigrationPermanentException: Moving mailbox to Exchange version \<version number\> is not supported. Mailboxes can be moved to Exchange version \<minimum version number\> and later versions only.

## Cause

The error occurs because Exchange Online can't offboard mailboxes to unsupported versions of Exchange Server.

## Resolution

Upgrade your on-premises environment to a [supported version](/exchange/plan-and-deploy/supportability-matrix#supported-versions-and-builds) of Exchange Server, and then retry the mailbox migration.
