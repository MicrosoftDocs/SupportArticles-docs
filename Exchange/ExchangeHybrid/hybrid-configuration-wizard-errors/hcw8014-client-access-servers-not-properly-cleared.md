---
title: Client Access servers were not properly cleared
description: Fixes an issue in which you get the HCW8014 Client Access servers specified by the Hybrid Configuration Active Directory object were not properly cleared error message when you run the Hybrid Configuration wizard.
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
# HCW8014 Client Access servers specified by the Hybrid Configuration Active Directory object were not properly cleared

_Original KB number:_ &nbsp; 3087162

## Problem

When you run the Hybrid Configuration wizard, you receive the following error message:

> HCW8014 The Client Access servers specified by the Hybrid Configuration Active Directory object were not properly cleared during the upgrade of the hybrid configuration.

## Cause

This issue occurs if the Hybrid Configuration wizard has one of the following kinds of servers:

- Incorrect servers
- Removed servers that are listed in the configuration object

## Solution

To resolve this issue, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following command to clear the Client Access servers from the hybrid configuration:

    ```powershell
    Set-HybridConfiguration -ClientAccessServers $Null
    ```

3. Run the Hybrid Configuration wizard again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
