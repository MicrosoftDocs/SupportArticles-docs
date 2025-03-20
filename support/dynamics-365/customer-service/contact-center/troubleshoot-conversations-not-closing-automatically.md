---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot conversations not closing automatically
description: Troubleshoot conversations not closing automatically
---
# Troubleshoot conversations not closing automatically

This article provides guidance on resolving issues where conversations in Dynamics 365 Customer Service are not closing automatically after the configured wrap-up time.

## Prerequisites

Ensure you have access to Dynamics 365 Customer Service and administrative privileges to make changes to the environment configuration.

## Potential quick workarounds

### Workaround: Verify and adjust wrap-up settings

1. Confirm that the "Persistent Chat - Wrap Up" configuration is correctly set in the Channel State Configuration entity (msdyn_occhannelstateconfiguration).
2. Adjust the wrap-up time to the desired value (e.g., 1 minute).

## Troubleshooting checklist

### Step 1: Verify configuration settings

- Check the configuration for "Persistent Chat - Wrap Up" in the Channel State Configuration entity (msdyn_occhannelstateconfiguration).

### Step 2: Use the web API for automatic closure

- Automatic closure of conversations can be managed through the web API if the configuration settings are correct but the issue persists.

## Cause: Misconfiguration of the environment

The issue occurs due to incorrect settings in the Channel State Configuration entity, which affects the automatic closure of conversations after the configured wrap-up time.

### Solution: Adjust configuration settings

1. Navigate to the Channel State Configuration entity (msdyn_occhannelstateconfiguration) in Dynamics 365 Customer Service.
2. Confirm that "Persistent Chat - Wrap Up" is set to 1 minute or the desired wrap-up duration.
3. Save changes to the configuration and test the automatic conversation closure functionality.

## Advanced troubleshooting and data collection

If the issue persists after confirming the configuration settings, consider the following steps:

- Use the Dynamics 365 web API to manually trigger automatic conversation closure.
- Collect diagnostic logs and other relevant data to identify potential issues in the environment.
- Refer to [Close conversations automatically | Microsoft Learn](/dynamics365/customer-service/administer/auto-close-conversation-powerapps) for additional guidance and advanced troubleshooting steps.