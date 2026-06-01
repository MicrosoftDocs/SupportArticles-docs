---
title: Cluster validation account causes events or messages
description: Describes the temporary user account that the cluster validation process creates, uses, and deletes.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:clustering and high availability\setup and configuration of clustered services and applications
- pcy:WinComm Storage High Avail
keywords: cluster validation, user account
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Cluster validation account causes events or messages

## Symptoms

In a failover clustering environment, when you run the cluster validation process, Windows creates a new user account. After this occurs, you might notice security events or messages that describe this account. The account is temporary. Windows removes the account when the cluster validation process ends.

## More information

During the cluster validation process, Windows creates a user account that has the following properties:

- User name: **CliTest2**
- Password: 12 characters
- Group memberships: None

The cluster validation process uses this account to connect to clustered shares across cluster nodes. When the cluster validation process ends, Windows deletes the account.
