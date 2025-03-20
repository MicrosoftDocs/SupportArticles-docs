---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot data export option not available in Application Insights
description: Troubleshoot data export option not available in Application Insights
---
# Troubleshoot data export option not available in Application Insights

This article addresses the issue of the data export option not being available in Application Insights, specifically for log analytics and observability in a new environment. It provides steps to identify and resolve the issue, including prerequisites and advanced troubleshooting information.

## Prerequisites

Before proceeding, ensure the following:

- The Power Platform environment is set to managed.
- The user has one of the required admin roles: Power Platform admin, Dynamics 365 admin, or Microsoft 365 Global admin.
- Premium licenses are assigned to enable the data export feature.

## Potential quick workarounds

### Workaround: Convert the environment to managed

1. Check whether the environment is currently unmanaged.
2. Follow the steps to convert the environment to managed using the Power Platform admin center.

### Workaround: Enable premium features and capabilities

1. Verify the availability of premium licenses within your tenant.
2. Assign the required premium licenses to enable the data export feature.

## Troubleshooting checklist

### Troubleshooting step

1. Confirm the environment type:
    - Open the Power Platform admin center.
    - Navigate to the environment settings and verify if it is set to “managed.”
2. Check admin roles:
    - Ensure the user performing the setup has one of the required admin roles (Power Platform admin, Dynamics 365 admin, or Microsoft 365 Global admin).
3. Verify licenses:
    - Confirm that premium licenses are assigned and active for the environment.

## Cause: Data export feature requires managed environments and premium licenses

The data export feature is only supported in managed environments. If the environment is unmanaged, the feature will not be available. Additionally, premium licenses are required to enable the capabilities associated with data export.

### Solution: Convert the environment to managed and ensure license compliance

1. Convert the environment:
    - Access the Power Platform admin center.
    - Select the environment and follow the steps to convert it to managed.
2. Assign premium licenses:
    - Review the licensing requirements and assign the necessary licenses to users as per your organization’s needs.
3. Manually schedule data exports:
    - Note that there is no automated process for scheduling data exports; users must manually configure the data export schedule.

## Advanced troubleshooting and data collection

If the issue persists after following the above steps, you may need additional troubleshooting or support. Collect the following information before contacting Microsoft Support:

1. Environment details:
    - Confirm whether the environment is managed or unmanaged.
2. Licensing information:
    - Provide details of the premium licenses assigned to users in your environment.
3. Admin role verification:
    - Confirm the admin role assigned to the user performing the setup.

For further information, refer to the following resources:

- [Conversation diagnostics in Azure Application Insights (preview) - Power Platform | Microsoft Learn](/power-platform/admin/conversation-diagnostics-application-insights)
- [Managed Environments overview - Power Platform | Microsoft Learn](/power-platform/admin/managed-environment-overview)
- [Licensing overview for Microsoft Power Platform - Power Platform | Microsoft Learn](/power-platform/admin/pricing-billing-skus)