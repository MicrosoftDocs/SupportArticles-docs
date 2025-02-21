---
title: ADAM general Event ID 1161 is logged on an AD LDS server
description: Describes an issue in which ADAM General Event ID 1161 is logged on an AD LDS server
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\ldap configuration and interoperability
- pcy:WinComm Directory Services
---
# ADAM general Event ID 1161 is logged on an AD LDS server

This article describes an issue in which ADAM general Event ID 1161 is logged on an AD LDS server.

_Original KB number:_ &nbsp; 3080830

## Symptoms

The following event is logged in the ADAM log every time an instance is restarted on an AD LDS server that's running Windows Server 2012 R2.

## Cause

The address book hierarchy table does not exist in the Active Directory Lightweight Directory Services (AD LDS) database. Therefore, the event is triggered during service startup.

This event can be safely ignored on an AD LDS instance.
