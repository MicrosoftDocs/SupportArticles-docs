---
title: Troubleshoot DC and Kerberos for DirectAccess troubleshooting
description: This article discusses how to troubleshoot DC and Kerberos for DirectAccess server troubleshooting.
ms.date: 01/19/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# Troubleshoot DirectAccess Server console: domain controller and Kerberos

DirectAccess writes all configuration on Group Policy policies. The loss of access to the domain controller is indicated on the operation console.

## Domain controller error

Error:  
> The corporate domain controller for contoso.local is not available.

### Cause

- Network connectivity is disrupted.
- The firewall is blocking access.

### Resolution

To resolve this issue, make sure that the domain controller can be accessed.

You can use network trace tools to verify that communication with the domain controllers is occurring.

## Kerberos error

Kerberos errors don't appear on the console as often as domain controller errors do.

Here's an example that occurs when the KDC proxy service is not running. The KDC Proxy Server service runs on edge servers. It proxies Kerberos protocol messages to domain controllers on the corporate network.

> Kerberos: Not working properly  
> Error:  
> A network authentication service (kpssvc) is not available. This service helps in authenticating DirectAccess clients when they connect to the corporate network via DirectAccess.

This issue might occur is the kpssvc service was stopped or the service stopped responding.

The service will restart automatically, or you can restart it manually.
