---
title: Ethernet connection interrupted after installation of Power Automate for desktop
description: Some third party software may interrupted internet connectivity due to certificates installed by Power Automate desktop
ms.subservice: power-automate-desktop-flows
---

# Ethernet connection interrupted after installation of Power Automate for desktop

This article provides a resolution for when third party software interrupts internet connectivity due to certificates installed by Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

After installing Power Automate on your local machine, you no longer have internet access.

## Description

By default, Power Automate installs local machine public key certificates in the Personal > Certificates. These certificates allow the runtime to ensure the authenticity of requests coming from the cloud through the on-premises data gateway (note: the use of on-premises data gateways has been deprecated for desktop flows). The existence of these certificates without private keys can cause some third party software to block internet access through ethernet on the machine.

## Resolution

Resolution (Power Automate installer version 2.32 or greater required)

To install Power Automate without on-premises gateway certificates, you can run the installer from the command line with the `/SkipGatewaySupport` parameter. Using this option you will only be able to run flows using direct machine connectivity.

1. Go to the start menu, type cmd, and open a command prompt
2. Navigate to the location of the installer
3. Type `Setup.Microsoft.PowerAutomate.exe /SkipGatewaySupport`
4. Follow the prompts and install Power Automate
