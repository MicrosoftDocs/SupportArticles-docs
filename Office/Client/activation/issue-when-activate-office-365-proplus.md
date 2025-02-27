---
title: We are unable to connect right now when try to activate Microsoft 365 Apps for enterprise
description: Describes an issue that triggers an error message when users try to activate Microsoft 365 Apps for enterprise. Provides a workaround.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Unable to connect
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 02/11/2025
---

# "We are unable to connect right now" error when users try to activate Microsoft 365 Apps for enterprise

## Symptoms

When you set up your network to block Internet Explorer 6, users discover that they cannot activate Microsoft 365 Apps for enterprise. When users try to activate Microsoft 365 Apps for enterprise, they receive the following error message:

**We are unable to connect right now. Please check your network and try again later.**

## Cause

This issue occurs under one of the following situations:

- The client computer can't connect to `*.microsoftonline-p.net`.
- Network Connectivity Status Indicator (NCSI) active probe is disabled.

## Workaround

To work around this issue, first check your firewall or proxy setting. Add an explicit "allow" rule that contains "MSOIDCRL"in your firewall or proxy for agents. For example, set up the rules to first allow MSOIDCRL and to then deny Internet Explorer 6. For more information about how to configure firewall rules, see your firewall documentation. 

If the issue persists, check if NCSI active probe is disabled. In this case, enable NCSI active probe by using the registry or Group Policy Objects (GPOs).

To use the registry to enable NCSI active probe, configure one of the following registry keys:

> [!IMPORTANT]
> Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\EnableActiveProbing`
  - Type: DWORD
  - Value: Decimal 1 
- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\NoActiveProbe`
  - Type: DWORD
  - Value: Decimal 0

To use Group Policy to enable NCSI active probe, configure the following GPO:

**Computer Configuration**\\**Administrative Templates**\\**System**\\**Internet Communication Management**\\**Internet Communication settings**\\**Turn off Windows Network Connectivity Status Indicator active tests**  
Value: Disabled 

## More information

For more information about Microsoft 365 activation issues, see [Unlicensed Product and activation errors in Office](https://support.office.com/article/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380).

Still need assistance? Ask for help in the [Microsoft Community](https://answers.microsoft.com/).
