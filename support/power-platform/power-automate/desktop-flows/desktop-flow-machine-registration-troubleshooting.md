---
title: Power Automate machine registration failure
description: Provides a set of troubleshooting steps for a failing machine registration in Microsoft Power Automate.
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 04/03/2026
ms.reviewer: kdeepika, sbemag, v-shaywood
ms.author: johndund 
author: johndund
---
# Machine registration failure in Power Automate

## Summary

When you register your machine using the Power Automate runtime application, the registration might fail with an error like "There was an error connecting to the Power Automate cloud services" or "Error during machine registration." These errors typically occur because the machine can't connect to required endpoints through the network, a proxy isn't configured correctly, the Power Automate service account lacks network access, or a required Dataverse process is deactivated. This article provides steps to verify connectivity, configure proxy settings, and resolve service account issues.

## Symptoms

When you register your machine, you receive one of the following error messages:

> There was an error connecting to the Power Automate cloud services.

> Error during machine registration. Check your internet connection and try again. If the issue persists, contact your administrator.

> We didn't get a response when trying to register your machine. Please click learn more for more details.

> The registration failed because the machine could not communicate with the cloud services due to a TLS error.

> A cloud process needed for machine registration has been deactivated in Dataverse.

## Troubleshooting steps

To register your computer to run desktop flows through a Power Automate cloud flow, the Power Automate service on your computer needs to connect to the Power Automate cloud services. Here's a list of what to verify:

1. Verify that your on-premises network allows connectivity to all required endpoints through its proxy or firewall. The full list of IP addresses can be found on the [IP address configuration page](/power-automate/ip-address-configuration). In particular, `*.dynamics.com`, `*.servicebus.windows.net`, and `*.gateway.prod.island.powerapps.com` are needed for machine connectivity.

1. If your network uses a proxy, you must [configure the Power Automate runtime application for use with a proxy](/power-automate/desktop-flows/how-to/proxy-settings).

1. Verify that the Power Automate service itself can connect to the required services. This may require you to change the account that's running the Power Automate service on your computer. For more information, see the [runtime application troubleshooting tool](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) that allows you to change the account.

1. If you get an error indicating that the registration failed because a cloud process needed for machine registration has been deactivated, follow the instructions in ["The registration failed because Dataverse solution has the process 'RegisterFlowMachine' deactivated" error](verify-dataverse-process-registerflowmachine.md) to reactivate the process.

If you've verified all of these and still occasionally receive the "We didn't get a response when trying to register your machine" error, you might have connectivity issues with your Dataverse organization. This might be due to temporary network instability or latency reaching your Dataverse organization. You can check the latency of your Dataverse organization by navigating to `https://[myorg].crm.dynamics.com/tools/diagnostics/diag.aspx` (replace `[myorg].crm.dynamics.com` with your organization's URL) and selecting **Run**. If you see extremely high latencies on the order of tens of seconds, you can try again when the situation improves or consult your network administrator.

## Related content

- [Tenant restrictions for Power Automate desktop machine registration](tenant-restictions-machine-registration.md)
- [Manage machines in Power Automate](/power-automate/desktop-flows/manage-machines)
- [Power Automate for desktop logs](how-to-get-power-automate-desktop-installer-logs.md)
