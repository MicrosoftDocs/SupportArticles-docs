---
title: External IP addresses were not properly cleared
description: Fixes an issue in which you receive an HCW8018 error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 3/31/2022
---
# HCW8018 The external IP addresses on the Hybrid Configuration Active Directory object were not properly cleared

_Original KB number:_ &nbsp; 3087163

## Problem

When you run the Hybrid Configuration wizard, you receive the following error message:

> HCW8018 The external IP addresses on the Hybrid Configuration Active Directory object were not properly cleared during the upgrade of the hybrid configuration.

## Solution

To resolve this problem, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following command to clear the external IP addresses from the hybrid configuration:

    ```powershell
    Get-HybridConfiguration | Set-HybridConfiguration -ExternalIPAddresses $null
    ```

3. Run the Hybrid Configuration wizard again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
