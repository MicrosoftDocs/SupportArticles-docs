---
title: Application Insights portal connectivity troubleshooting 
description: Provides a troubleshooting guide for Application Insights portal connectivity issues.
ms.date: 03/10/2023
ms.service: azure-monitor
ms.subservice: application-insights
ms.reviewer: vgorbenko
---
# "Error retrieving data" message on Application Insights portal

This troubleshooting guide is for the Application Insights portal when you encounter connectivity errors similar to "Error retrieving data" or "Missing localization resource".

:::image type="content" source="media/troubleshoot-portal-connectivity/error-in-portal.png" alt-text="Screenshot that shows the portal connectivity error." border="true":::

The source of the issue is likely third-party browser plug-ins that interfere with the portal's connectivity.

To confirm that plug-ins are the source of the issue and to identify which plug-in is interfering:

- Open the portal in an **InPrivate** or **Incognito** window and verify that the site functions correctly.
- Attempt to disable plug-ins to identify the one that's causing the connectivity issue.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
