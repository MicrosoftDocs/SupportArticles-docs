---
title: HCW8019, HCW8021, HCW8022, or HCW8023 error
description: Fixes an issue in which you receive an HCW8019, HCW8021, HCW8022, or HCW8023 error message when you run the Hybrid Configuration wizard.
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
# HCW8019, HCW8021, HCW8022, or HCW8023 error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3087168

## Problem

When you run the Hybrid Configuration wizard, you receive one of the following error messages:

> HCW8019 The HybridConfiguration Active Directory object must be upgraded before the cmdlet can proceed.

> HCW8021 An OnPremisesOrganization with the upgraded inbound and outbound connectors wasn't properly created during upgrade of the hybrid configuration.

> HCW8022 The on-premises remote domain {0} wasn't properly removed during the upgrade of the hybrid configuration.

> HCW8023 The tenant remote domain {0} wasn't properly removed during the upgrade of the hybrid configuration.

## Cause

This problem occurs if the hybrid configuration object contains an incorrect setting.

## Solution

To resolve this problem, follow these steps:

1. Open the Exchange Management Shell.
2. Run the following command:

    ```powershell
    Remove-HybridConfiguration
    ```

    When you're prompted, click **Yes** to remove the hybrid configuration object. Notice that when you do this, existing hybrid deployment configuration settings aren't disabled or removed.
3. Run the Hybrid Configuration wizard again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
