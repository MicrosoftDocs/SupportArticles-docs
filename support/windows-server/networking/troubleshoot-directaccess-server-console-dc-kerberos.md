---
title: 
description: 
ms.date: 01/14/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, MASOUDH
ms.custom: sap:remote-access, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DirectAccess Server console: DC and Kerberos

## Domain Controller
Direct Access writes all configuration on group policies. The loss of access to the domain controller would show up on the operation console if the DA cannot reach it. 
Error: 
The corporate domain for is 
Causes: 
1.	Network connectivity is disrupted. 
       2.    The firewall is blocking access. 
Resolution: 
Ensure that the domain controller can be reached for contoso.com. 
With the help of network traces, we can validate the communication happening with the domain controller(s).

## Kerberos

Kerberos errors are not so commonly seen on the console but normally guiding on the resolution addresses the issues. 
Example KDC proxy service is not running: 
KDC Proxy Server service runs on edge servers to proxy Kerberos protocol messages to domain controllers on the corporate network 
 
Kerberos: Not working properly 
Error: 
A network authentication service (kpssvc) is not available. This service helps in authenticating DirectAccess clients when they connect to the corporate network via DirectAccess. 
Causes: 
1. The kpssvc service was stopped. 
2. The service stopped responding. 
Resolution: 
The service will start automatically, or it can be restarted manually
