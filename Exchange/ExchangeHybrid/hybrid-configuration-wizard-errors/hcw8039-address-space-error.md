---
title: HCW8039 error in the Hybrid Configuration wizard
description: Fixes an issue that triggers an HCW8039 error when you run the Hybrid Configuration wizard in an Exchange Online or Exchange Server 2013 environment.
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
# HCW8039 The hybrid Send connector must only contain the single address space error when you run HCW

_Original KB number:_ &nbsp; 3087172

## Problem

When you run the Hybrid Configuration wizard (HCW), you receive the following error message:

> HCW8039 The hybrid Send connector must only contain the single address space '{0}'

## Cause

This issue occurs if the Send connector that's created by the Hybrid Configuration wizard has additional namespaces added to it.

## Solution

To resolve this issue, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following command:

    ```powershell
    Get-SendConnector -name "Outbound to Microsoft 365"
    ```

3. In the output, examine the value of the AddressSpace  parameter. You should see either "*" or "contoso.mail.onmicrosoft.com;1."
4. If you see any addresses other than "*" or "contoso.mail.onmicrosoft.com;1", remove them. To do this, run the following command:

    ```powershell
    Set-SendConnector -name "Outbound to Microsoft 365 "smtp:contoso.mail.onmicrosoft.com;1"
    ```

5. Run the Hybrid Configuration wizard again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
