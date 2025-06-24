---
title: Multiple Send Connectors found for AddressSpace
description: Fixes the HCW8011 error that occurs when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
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
# "HCW8011 multiple Send Connectors found for AddressSpace" when you run the HCW

_Original KB number:_ &nbsp; 3087161

## Problem

When you run the Hybrid Configuration wizard (HCW), you receive the following error message:

> HCW8011 Ambiguous configuration: multiple Send Connectors found for AddressSpace 'Consoto.com'

## Cause

This issue occurs if the Hybrid Configuration wizard detected conflicting or duplicate Send connectors for a particular namespace and couldn't continue.

## Solution

Remove the duplicate Send connectors from the on-premises organization. Follow these steps:

1. Open the Exchange Management Shell.
2. Run the following command:

    ```powershell
    Get-SendConnector |fl
    ```

3. Examine the output to determine whether there are multiple Send connectors that exist for AddressSpace that's mentioned in the error message.
4. If multiple Send connectors exist, remove the duplicate Send connectors. To do so, run the following command for each duplicate connector:

    ```powershell
    Remove-SendConnector <NameOfSendConnector>
    ```

    For more information about how to remove a connector, see [Remove-SendConnector](/powershell/module/exchange/remove-sendconnector).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
