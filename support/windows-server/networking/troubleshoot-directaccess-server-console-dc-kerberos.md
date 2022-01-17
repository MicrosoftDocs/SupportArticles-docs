---
title: Troubleshoot DC and Kerberos for DirectAccess troubleshooting
description: This article introduces how to troubleshoot DC and Kerberos for DirectAccess server troubleshooting.
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: asvaidya, anupamk
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: domain controller and Kerberos

## Domain Controller

DirectAccess writes all configuration on group policies. The loss of access to the domain controller would show up on the operation console if the DA cannot reach it.

Error:  
> The corporate domain for is <!-- missing words -->

### Causes

1. Network connectivity is disrupted.
2. The firewall is blocking access.

### Resolution

To resolve this issue, ensure that the domain controller can be reached.

You can use network traces tools to validate the communication happening with the domain controllers.

## Kerberos

Kerberos errors are not so commonly seen on the console but normally guiding on the resolution addresses the issues.

Here is an example when KDC proxy service is not running. KDC Proxy Server service runs on edge servers to proxy Kerberos protocol messages to domain controllers on the corporate network.

> Kerberos: Not working properly  
> Error:  
> A network authentication service (kpssvc) is not available. This service helps in authenticating DirectAccess clients when they connect to the corporate network via DirectAccess.

This issue can be caused when the kpssvc service was stopped or the service stopped responding.

The service will start automatically, or it can be restarted manually.
