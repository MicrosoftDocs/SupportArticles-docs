---
title: Error when connecting to a Terminal server
description: Provides a solution to various certificate-related error messages when you connect to a Terminal server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificate-management, csstroubleshoot
ms.technology: windows-server-rds
---
# You receive various certificate-related error messages when connecting to a Terminal server that is running Windows Server 2008 or Windows Server 2008 R2

This article provides a solution to various certificate-related error messages when you connect to a Terminal server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2000960

## Symptoms

You receive one of the following error messages when you connect to a Terminal server that is running Windows Server 2008 or a Remote Desktop Server that is running Windows Server 2008 R2:

> Your Remote desktop connection failed because the remote computer cannot be authenticated  

> The remote computer could not be authenticated due to problems with its security certificate. It may be unsafe to proceed.  

> Name mismatch  
Requested remote computer is \<computer name 1>  
Name in the certificate is \<computer name 2>  

> Certificate errors  
The following errors were encountered while validating the remote computer's certificate: The server name on the certificate is incorrect.

> You cannot proceed because authentication is required.

-or-

> The identity of the remote computer cannot be verified.Do you want to connect anyway?

> The remote computer could not be authenticated due to problems with its security certificate. It may be unsafe to proceed.

> Name mismatch  
Requested remote computer is \<computer name 1>  
Name in the certificate is \<computer name 2>

> Certificate errors  
The server name on the certificate is incorrect  
the certificate is not from a trusted certifying authority.

> Do you want to connect despite these certificate errors?

## Cause

The issue occurs because an incorrect certificate is used to make the Terminal server session or remote desktop session.

## Resolution

Here are the steps to verify the selected certificate:

1. Open the **Terminal Services Configuration** windows in Windows Server 2008 or the **RD Session Host Configuration** in Windows Server 2008 R2.
2. Open the **properties** dialog of the RDP-Tcp connection.
3. On the **General** tab, check the selected certificate. Ensure that you select a correct certificate to make Terminal Server sessions or Remote Desktop sessions.
