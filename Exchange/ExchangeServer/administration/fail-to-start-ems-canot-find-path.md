---
title: Exchange Management Shell fails to start with error Cannot find path because it does not exist
description: This article describes an issue that Exchange Management Shell fails to start with error Cannot find path because it does not exist
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013
  - Exchange Server 2016
ms.date: 01/24/2024
ms.reviewer: v-six
---

# Exchange Management Shell fails to start with error "Cannot find path '' because it does not exist"

## Symptoms

Assume that you deploy Microsoft Exchange Server 2013 or Exchange Server 2016 on Windows Server 2012 R2. The Exchange Management Shell fails to start, and you receive an error message that resembles the following:

```powershell
VERBOSE: Connecting to Exch1.contoso.com.
New-PSSession : Cannot find path '' because it does not exist.
At line:1 char:1
+ New-PSSession -ConnectionURI "$connectionUri" -ConfigurationName Micr ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [New-PSSession], RemoteException
+ FullyQualifiedErrorId : PSSessionOpenFailed
```

## Cause

The issue happens if Windows Management Framework (WMF) 5.0 is installed on the server. You can use the following steps to confirm the WMF version:

1. Start PowerShell in administrative mode and run the following command:

    ```powershell
    $PSVersionTable
    ```

2. If the Version displays 5.0, you have WMF 5.0 installed on the server.

## Resolution

To fix this issue, you have to uninstall the Windows update KB3134758. To do this, follow these steps:

1. Go to **Control Panel**, open **Programs and Features** (press Windows + R key, run appwiz.cpl)
2. Click **View installed updates** and search for KB3134758
3. Uninstall the update KB3134758
4. Restart the server
