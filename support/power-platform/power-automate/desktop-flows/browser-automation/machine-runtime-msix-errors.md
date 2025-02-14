---
title: Web Automation Action Fails when Machine Runtime and MSIX versions are different
description: Solves a web automation error that occurs when the machine runtime application and Power Automate for desktop store installation (MSIX) versions are different.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.date: 02/14/2025
---
# Web Automation action fails when machine runtime and MSIX versions are different

## Symptoms

When a web automation action is triggered from a cloud flow, the action fails with the following error:

> Negotiation failed

|Applies to|Modes|Actions|
|---|---|---|
|- Power Automate for desktop installed from Microsoft Store (MSIX) version 2.37 or a later. </br> - Both the MSIX and MSI versions of the application are installed on the same machine.|- Unattended </br> - Attended| Any web automation action under the [Browser Automation group](/power-automate/desktop-flows/automation-web).|

## Verifying issue

1. [Install the latest version of Power Automate for desktop from Microsoft Store (MSIX)](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).
2. Install the machine runtime application using an older version of the installer, specifically one that's not a Quick Fix Engineering (QFE) version.
3. Create a flow in Power Automate for desktop to automate a web page with an [extension-based browser](/power-automate/desktop-flows/install-browser-extensions).
4. Save the flow.
5. Run the flow from the cloud.

## Cause

If the Power Automate for desktop MSIX installation has a different version than the machine runtime application, the Message Host running from the browser is from the MSIX installation, which is a different version from what the machine runtime application expects. This discrepancy causes the flow to fail with a "Negotiation failed" error.

## Workaround

Ensure that the versions of the machine runtime application and the MSIX installation are the same.
