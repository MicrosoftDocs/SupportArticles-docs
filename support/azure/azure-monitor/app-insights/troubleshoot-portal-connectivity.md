---
title: Application Insights portal connectivity issues
description: Learn how to resolve portal connectivity issues in Azure Application Insights, such as data retrieval problems, network failures, and back-end failures.
ms.date: 02/22/2024
author: toddfoust
ms.author: toddfous
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: vitalyg, v-leedennis
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure user, I want to learn how to resolve connectivity errors in the Application Insights portal so that I can use Application Insights successfully.
---
# Application Insights portal connectivity issues

This article discusses how to resolve connectivity issues (such as the "Error retrieving data" message, time-outs, and loading failures) that occur within the Microsoft Azure Application Insights portal.

## Symptoms

On an Application Insights portal page (such as the **Failures** page or the **Performance** page), you see error messages such as "Error retrieving data" or "Missing localization resource" for charts that don't load.

:::image type="content" source="media/troubleshoot-portal-connectivity/error-in-portal.png" alt-text="Azure portal screenshot that shows the portal connectivity error in Application Insights." border="true" lightbox="media/troubleshoot-portal-connectivity/error-in-portal.png":::

## Cause

The web browser couldn't call into a required API, or the API returned a failure response. These problems can occur because of a network failure, a back-end failure, or interference from a browser extension.

## Solution

To fix the issue, follow these steps:

1. [Open an InPrivate window in the Microsoft Edge web browser](https://support.microsoft.com/microsoft-edge/browse-inprivate-in-microsoft-edge-cd2c9a48-0bc4-b98e-5e46-ac40c84e27e2) (or open an Incognito window in Google Chrome).

1. Temporarily [disable any browser extensions that are running](https://support.microsoft.com/microsoft-edge/add-turn-off-or-remove-extensions-in-microsoft-edge-9c0ec68c-2fbc-2f2c-9ff0-bdc76f46b026).

1. Check whether you can reproduce the portal connectivity error in the browser. (One or more browser extensions might be preventing the expected behavior.)

1. Try to reproduce the portal connectivity error in other browsers, on other computers or virtual machines (VMs), or in other user sessions.

1. Investigate whether any DNS or other network-related issues exist on the client device on which the portal page doesn't load within the browser.

1. If the portal error persists and requires further investigations, [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace) while you reproduce the unexpected portal behavior. Then, you can report the incident to Microsoft Support.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
