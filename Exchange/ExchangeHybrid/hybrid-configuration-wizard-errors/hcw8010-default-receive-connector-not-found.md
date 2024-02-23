---
title: Default Receive Connector cannot be found on server
description: Fixes an issue that returns HCW8010 error when you run the Hybrid Configuration wizard in an Exchange Online or Exchange Server 2013 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8010 Default Receive Connector cannot be found on server when you run the HCW

_Original KB number:_ &nbsp; 3087159

## Problem

When you run the Hybrid Configuration wizard (HCW), you receive the following error message:

> HCW8010 Default Receive Connector cannot be found on server <*ServerName*>.

## Cause

If you have a Receive connector set up in your environment, this issue typically occurs if IP version 6 (IPv6) is disabled on a server.

## Solution

To resolve this issue, follow these steps:

1. Enable IPv6 on the Exchange servers in your environment. For more information about how to do this, see [Guidance for configuring IPv6 in Windows for advanced users](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

2. Add the IPv6 binding to the Receive connector. To do this, follow these steps:
  
   1. Open the Exchange Management Shell.
   2. Run the following command to identify the default Receive connector that's using port 25:

        ```powershell
        Get-ReceiveConnector -Server <ServerName> | Where {$_.Bindings -match '25'}
        ```

3. Run the following commands to update the Receive connector:

    ```powershell
    $rc = Get-ReceiveConnector "<ServerName>\Default Frontend <ServerName>"

    $rc.Bindings += "[::]:25"

    Set-ReceiveConnector $rc -Bindings $rc.Bindings
    ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
