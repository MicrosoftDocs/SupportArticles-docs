---
title: Web Automation Action Fails when Machine Runtime and MSIX versions are different
description: Solves a web automation error that occurs when the machine runtime application and Power Automate for desktop store installation (MSIX) versions are different.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.date: 02/18/2025
---
# Web Automation action fails when machine runtime and Microsoft Store (MSIX) versions are different

This article provides a workaround to the "Negotiation failed" error that occurs when a web automation action fails to run in Power Automate for desktop.

## Symptoms

Consider the following scenario:

- You installed [Power Automate for desktop from Microsoft Store (MSIX)](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).
- You installed the machine runtime using an older version of the [MSI installer](/power-automate/desktop-flows/install#install-power-automate-using-the-msi-installer).
- You created a flow in Power Automate for desktop to automate a web page with an [extension-based browser](/power-automate/desktop-flows/install-browser-extensions) and run the flow from the cloud.

In this scenario, the web automation action fails with the following error:

> Negotiation failed

This issue applies when running any web automation action under the [Browser Automation group](/power-automate/desktop-flows/automation-web) in either unattended or attended mode.

## Cause

When the Power Automate for desktop MSIX installation is a different version than the machine runtime application, the Message Host running from the browser, which is from the MSIX installation, is a different version than what the machine runtime expects. This discrepancy causes the flow to fail with a "Negotiation failed" error.

## Workaround

We don't recommend having both MSI and MSIX versions of Power Automate on the same machine. If you do, uninstall one version or ensure that the versions of the machine runtime application and the MSIX installation are the same.

For more information on Power Automate for desktop versions, see [Released versions for Power Automate for desktop](/power-platform/released-versions/power-automate-desktop).
