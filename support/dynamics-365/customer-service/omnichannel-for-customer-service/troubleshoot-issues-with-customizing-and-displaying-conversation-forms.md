---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot issues with customizing and displaying conversation forms
description: Troubleshoot issues with customizing and displaying conversation forms
---
# Troubleshoot issues with customizing and displaying conversation forms

This article provides guidance on resolving issues related to customizing and displaying the Active Conversation form in Microsoft Dynamics 365. Users may encounter problems such as repeated sections, incorrect content, missing custom fields, or missing SLA timers when the form is not properly configured.

## Prerequisites

Ensure you have access to the Customer Service Admin app to modify form settings.

## Potential quick workarounds

### Workaround: Refresh browser cache

1. Perform a hard refresh twice by pressing **CTRL + F5**.
2. Test the scenario again to check if the issue is resolved.

## Troubleshooting checklist

### Troubleshooting step

1. Verify if the **Customize Active Conversation form** setting is enabled under Active Conversation form settings.

## Cause: The Customize Active Conversation form setting is disabled.

When this setting is turned off, the Active Conversation form fails to display as configured, resulting in repeated sections, incorrect content, and missing custom fields or SLA timers.

### Solution: Enable Customize Active Conversation form

1. Open the **Customer Service Admin app**.
2. Navigate to **Workspaces > Active conversation form settings**.
3. Locate the **Customize Active Conversation form** toggle.
4. Turn the toggle **on**.
5. Save the changes.
6. Perform a hard refresh twice by pressing **CTRL + F5**.
7. Test the scenario again to confirm the resolution.

## Advanced troubleshooting and data collection

If the issue persists after following the steps above, consider collecting the following data before contacting support:

- Screenshots of the issue (e.g., repeated sections, missing fields).
- Steps performed to reproduce the problem.
- Browser version and any relevant extensions that may affect functionality.
- Details of any recent changes to the Active Conversation form or workspace settings.

Providing this information will help expedite the resolution process when reaching out to Microsoft Support.