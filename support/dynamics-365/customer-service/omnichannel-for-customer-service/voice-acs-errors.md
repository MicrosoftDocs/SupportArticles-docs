---
title: Troubleshoot connectivity errors caused by firewalls or VPNs 
description: Resolves an issue where VPN or firewall blocks Azure Communication Services registration.
ms.reviewer: mgandham
ms.author: gandhamm
ms.date: 06/16/2025
ms.custom: sap:Voice channel
ms.collection: CEnSKM-ai-copilot
---

# Troubleshoot connectivity errors caused by firewalls or VPNs

This article provides a solution to an issue where customer service representatives encounter Azure Communication Services or telephony errors caused by firewalls or VPNs.

## Symptoms
 
As a service representative or supervisor, you notice the following error:
"The connection to the telephony system was lost. We're working on re-establishing the connection."

## Cause

Firewall or VPN issues.
 
## Resolution

Copy and paste the following URLs in your browser to confirm that the firewall or VPN is causing the issue. If the URLs load in your browser, your network is fine. If they fail/timeout, your firewallor VPN is likely blocking the registration service.
  - `https://prod.registrar.skype.com/v2/ping`
  - `https://teams.microsoft.com/registrar/prod/v2/ping`

Disable the firewall or VPN to resolve this issue.
