---
title: HCW8100, HCW8084, or HCW8083 error
description: Resolves an issue in which you receive an HCW8100, HCW8084, or HCW8083 error message when you run the Hybrid Configuration Wizard.
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
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8100, HCW8084, or HCW8083 error when you run the Hybrid Configuration Wizard

_Original KB number:_ &nbsp; 3185373

> [!NOTE]
> The Hybrid Configuration Wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration Wizard. Instead, use the Microsoft 365 Hybrid Configuration Wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

When you run the Hybrid Configuration Wizard, you receive one of the following error messages:

> HCW8100 = The connection to the Remote PowerShell server was disconnected. Please try again.

> HCW8084 = The connection to the Remote PowerShell server was disconnected. Please try again.

> HCW8083 = WinRM cannot complete the operation. Verify that the specified computer name is valid, that the computer is accessible over the network, and that a firewall exception for the WinRM service is enabled and allows access from this computer.

## Cause

This is usually a transient issue that is caused by a network connection or device.

## Resolution

Close the Hybrid Configuration Wizard, and then run it again. You can download the wizard from [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). Rerunning the wizard starts a new connection and should resolve this issue.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
