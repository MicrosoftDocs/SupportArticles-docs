---
title: Power Automate machine registration failure
description: Provides a set of troubleshooting steps for a failing machine registration
ms.subservice: power-automate-desktop-flows
---
# Machine registration failure

This article provides a set of troubleshooting steps for when you are unable to register your machine using the Power Automate runtime application.

## Symptoms

When registering your machine, you get an error such as "There was an error connecting to the Power Automate cloud services", or "Error during machine registration. Check your internet connection and try again. If the issue persists, contact your administrator".

## Resolution

To register your computer to run flows through a Power Automate cloud flow, the Power Automate service on your computer needs to connect to the Power Automate cloud services. Here is a list of what to verify:

1. Verify that your on-premises network allows connectivity to all required endpoints through its proxy or firewall. The full list of IP addresses can be found at the [IP address configuration page](https://learn.microsoft.com/en-us/power-automate/ip-address-configuration). In particular, *.dynamics.com, *.servicebus.windows.net and *.gateway.prod.island.powerapps.com are needed for machine connectivity.
1. If your network uses a proxy, you must configure Power Automate to use it. Please read the following documentation for how to [configure the Power Automate runtime application for use with a proxy](https://support.microsoft.com/topic/power-automate-for-desktop-proxy-setup-8a79d690-1c02-416f-8af1-f057df5fe9b7).
1. Verify that the Power Automate service itself can connect to the Azure Relay service. This may require you to change the account that the Power Automate service on your computer runs as. Please read the documentation on the [runtime application troubleshooting tool](https://learn.microsoft.com/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) which allows you to change the account.
