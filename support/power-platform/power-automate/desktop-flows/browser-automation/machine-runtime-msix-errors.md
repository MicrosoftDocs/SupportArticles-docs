---
title: Web Automation Fails When Machine Runtime and MSIX Versions Are Different
description: Solves a web automation error that occurs when the machine runtime application and the Power Automate for desktop store installation (MSIX) versions are different.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.date: 03/03/2025
---
# Web automation action fails when the machine runtime and Microsoft Store (MSIX) versions are different

This article provides a workaround for the "Negotiation failed" error that occurs when a web automation action fails to run in Power Automate for desktop.

## Symptoms

Consider the following scenario:

- You installed [Power Automate for desktop from Microsoft Store (MSIX)](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).
- You installed the machine runtime using an older version of the [MSI installer](/power-automate/desktop-flows/install#install-power-automate-using-the-msi-installer).
- You created a flow in Power Automate for desktop to automate a web page with an [extension-based browser](/power-automate/desktop-flows/install-browser-extensions) and ran the flow from the cloud.

In this scenario, the web automation action fails with the following error:

> Negotiation failed

This issue applies when running any web automation action under the [Browser Automation group](/power-automate/desktop-flows/automation-web) in unattended or attended mode.

## Cause

When the Power Automate for desktop MSIX installation is a different version than the machine runtime application, the Message Host (from the MSIX installation) running from the browser is a different version than the machine runtime expects. This discrepancy causes the flow to fail with a "Negotiation failed" error.

## Workaround

We don't recommend having both the MSI and MSIX versions of Power Automate on the same machine. If you do this, uninstall one version or ensure that the machine runtime application and the MSIX installation versions are the same.

For more information on Power Automate for desktop versions, see [Released versions for Power Automate for desktop](/power-platform/released-versions/power-automate-desktop).
