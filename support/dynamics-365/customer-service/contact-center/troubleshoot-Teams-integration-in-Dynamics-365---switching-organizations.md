---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot Teams integration in Dynamics 365 - switching organizations
description: Troubleshoot Teams integration in Dynamics 365 
---
# Troubleshoot Teams integration in Dynamics 365 - switching organizations

This article addresses an issue where customers are unable to switch between different Teams organizations within the Dynamics 365 app, a functionality that is available in the standalone Teams mobile and desktop applications.

## Prerequisites

- Ensure Dynamics 365 app with Teams integration is enabled.
- Verify that you have valid credentials for all Teams organizations you intend to access.

## Potential quick workarounds

Currently, there are no direct workarounds for switching organizations within the Dynamics 365 app.

## Troubleshooting checklist

### Troubleshooting step

- Confirm that you are signed in to the correct Teams organization within Dynamics 365 to access its respective chat functionalities.

## Cause: Teams organization switching not supported in Dynamics 365

This behavior is by design; Dynamics 365 does not currently support the ability to switch between Teams organizations as is possible in the standalone Teams applications.

### Solution: Access the desired organization separately

1. Sign out of the current Teams organization in Dynamics 365.
2. Sign in to the desired Teams organization separately.
3. Ensure the Dynamics 365 app with Teams integration is enabled in the newly accessed organization to interact with its chat functionalities.

By following these steps, you can access the specific Teams organization you need within Dynamics 365.

## Advanced troubleshooting and data collection

If signing into the desired Teams organization does not resolve the issue, or if you encounter additional problems, consider collecting the following information before contacting Microsoft Support:

- The version of Dynamics 365 and Teams app being used.
- Steps taken to reproduce the issue.
- Screenshots or error messages encountered during the process.

This information will assist Microsoft Support in diagnosing and resolving your issue effectively.