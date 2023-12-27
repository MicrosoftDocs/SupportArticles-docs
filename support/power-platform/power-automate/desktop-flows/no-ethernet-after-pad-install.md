---
title: Internet connection is interrupted after installing Power Automate for desktop
description: Provides a resolution for an issue where some third-party software may interrupt the internet connectivity due to the certificates installed by Power Automate for desktop.
ms.subservice: power-automate-desktop-flows
ms.reviewer: johndund, guco
ms.date: 07/17/2023
---
# Internet connection is interrupted after you install Power Automate for desktop

This article provides a resolution for an issue where third-party software interrupts the internet connectivity due to the certificates installed by Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

After you install Power Automate on your local machine, you no longer have internet access.

## Cause

By default, Power Automate installs local machine public key certificates in the **Machine**/**Local Computer** > **Personal** > **Certificates** store. These certificates allow Power Automate machine runtime to ensure the authenticity of requests coming from the cloud through the on-premises data gateway. Note that the use of on-premises data gateways has been deprecated for desktop flows. These certificates without private keys can cause some third-party software to block internet access on the machine. This may be in the form of Ethernet, Wi-Fi, or VPN access.

## Resolution

To install Power Automate without on-premises gateway certificates, you can run the Power Automate installer (version 2.32 or later) by using the command line together with the `/SkipGatewaySupport` parameter. With this option, you can only run flows using direct machine connectivity.

1. Go to the **Start** menu, type *cmd*, and open a command prompt.
2. Navigate to the location of the installer.
3. Type `Setup.Microsoft.PowerAutomate.exe /SkipGatewaySupport`.
4. Follow the prompts and install Power Automate.

After installing Power Automate using this command, subsequent upgrades will remember this setting, so there is no need to add the flag again. To add the gateway certificates back, you can run the installer in the same way using the `/AddGatewaySupport` parameter.

This parameter is also supported by the [silent installer](/power-automate/desktop-flows/install-silently).
