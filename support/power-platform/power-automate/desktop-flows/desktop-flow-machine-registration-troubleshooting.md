---
title: Power Automate machine registration failure
description: Provides a set of troubleshooting steps for a failing machine registration in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Power Automate for desktop errors
ms.date: 09/22/2023
ms.reviewer: madiazor, alarnaud, fredg, guco
ms.author: johndund 
author: johndund
---
# Machine registration failure in Power Automate

This article provides a set of troubleshooting steps for an issue where you can't register your machine using the Power Automate runtime application.

## Symptoms

When you register your machine, you receive one of the following error messages:

> There was an error connecting to the Power Automate cloud services.

> Error during machine registration. Check your internet connection and try again. If the issue persists, contact your administrator.

> We didn't get a response when trying to register your machine. Please click learn more for more details.

## Resolution

To register your computer to run desktop flows through a Power Automate cloud flow, the Power Automate service on your computer needs to connect to the Power Automate cloud services. Here's a list of what to verify:

1. Verify that your on-premises network allows connectivity to all required endpoints through its proxy or firewall. The full list of IP addresses can be found on the [IP address configuration page](/power-automate/ip-address-configuration). In particular, `*.dynamics.com`, `*.servicebus.windows.net`, and `*.gateway.prod.island.powerapps.com` are needed for machine connectivity.

1. If your network uses a proxy, you must [configure the Power Automate runtime application for use with a proxy](https://support.microsoft.com/topic/power-automate-for-desktop-proxy-setup-8a79d690-1c02-416f-8af1-f057df5fe9b7).

1. Verify that the Power Automate service itself can connect to the required services. This may require you to change the account that's running the Power Automate service on your computer. For more information, see the [runtime application troubleshooting tool](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) that allows you to change the account.

If you've verified all of these and still occasionally receive the "We didn't get a response when trying to register your machine" error, you might have connectivity issues with your Dataverse organization. This might be due to temporary network instability or latency reaching your Dataverse organization. You can check the latency of your Dataverse organization by navigating to `https://[myorg].crm.dynamics.com/tools/diagnostics/diag.aspx` (replace `[myorg].crm.dynamics.com` with your organization's URL) and selecting **Run**. If you see extremely high latencies on the order of tens of seconds, you can try again when the situation improves or consult your network administrator.
