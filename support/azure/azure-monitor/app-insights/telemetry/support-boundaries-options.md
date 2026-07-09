---
title: Support boundaries and support options for App Center telemetry migration to Azure Monitor (Preview)
description: Learn support boundaries and options for migrating App Center telemetry to Azure Monitor. Get help routing issues to the right support channel.
ms.date: 07/09/2026
ms.service: azure-monitor
ms.topic: troubleshooting
ms.author: kaushika
ms.custom: sap:Application Insights portal experiences
---

# Support boundaries and support options for App Center telemetry migration to Azure Monitor (Preview)

## Summary

This article provides information about support boundaries and support options for App Center telemetry migration to Azure Monitor (Preview). It's intended for users who are considering or currently using the migration feature.

Use the links to route issues to the right support channel.

### Use community support for App Center SDK removal

Microsoft doesn't provide product support for App Center SDKs. Microsoft doesn't troubleshoot App Center SDK removal, build errors, or runtime behavior related to App Center.

Use these community resources to remove App Center SDKs:

- [App Center SDK for Android (GitHub)](https://github.com/microsoft/appcenter-sdk-android)
- [App Center SDK for Apple platforms (GitHub)](https://github.com/microsoft/appcenter-sdk-apple)
- [App Center SDK for React Native (GitHub)](https://github.com/microsoft/appcenter-sdk-react-native)
- [App Center SDK for Unity (GitHub)](https://github.com/microsoft/appcenter-sdk-unity)

For general community support, use these resources:

- [GitHub Issues](https://docs.github.com/issues/tracking-your-work-with-issues/about-issues)
- [Stack Overflow App Center tag](https://stackoverflow.com/questions/tagged/appcenter)

### Use community support for OpenTelemetry instrumentation and collection

Community support covers the steps that you complete before telemetry reaches Azure Monitor, including:

- **OpenTelemetry SDK selection and instrumentation** for mobile apps
- **OpenTelemetry Collector deployment and configuration**
- **OpenTelemetry Collector exporter configuration** for Azure Monitor

Use these community resources:

- [OpenTelemetry community](https://opentelemetry.io/community/)
- [OpenTelemetry GitHub organization](https://github.com/open-telemetry)
- [OpenTelemetry Collector documentation](https://opentelemetry.io/docs/collector/)
- [OpenTelemetry Android client app guidance](https://opentelemetry.io/docs/platforms/client-apps/android/)
- [OpenTelemetry iOS client app guidance](https://opentelemetry.io/docs/platforms/client-apps/ios/)
- [OpenTelemetry ecosystem registry](https://opentelemetry.io/ecosystem/registry/)
- [Azure Monitor exporter for the OpenTelemetry Collector](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/exporter/azuremonitorexporter/README.md)
- [OpenTelemetry Collector support model](https://github.com/open-telemetry/opentelemetry-collector-contrib)

### Use Microsoft support for Azure Monitor

Microsoft support covers Azure Monitor functionality after telemetry reaches Azure Monitor, including:

- **Ingestion** into Azure Monitor when requests reach the Azure Monitor ingestion endpoint.
- **Storage and query** in Azure Monitor Logs and Application Insights.
- **Azure Monitor experiences** such as Logs, Workbooks, and Alerts.

#### How to reach out to Microsoft support

1. In the Azure portal, go to **Support + Troubleshooting**, search and select Application Insights, and then select **Next**. For more information, see [Create an Azure support request](/azure/azure-portal/supportability/how-to-create-azure-support-request#open-a-support-request-from-the-global-header).

1. Under **Which resource are you having an issue with?**, select your subscription and Application Insights resource from the drop-down menus, and then select **Next**.

1. Under **Are you having one of the following issues?**, select **None of the above**. For **Problem type**, select **Deprecated features**. For **Problem subtype**, select  **Migrating from App Center to Azure Monitor**, and then select **Next**.

    :::image type="content" source="media/support-boundaries-options/select-problem-type.png" lightbox="media/support-boundaries-options/select-problem-type.png" alt-text="A screenshot of the support pane with the problem type fields highlighted.":::

1. Scroll to the bottom of the page and select **Contact support**. In the **Help + Support** card, select **Create a support request**.

    :::image type="content" source="media/support-boundaries-options/create-support-request.png" lightbox="media/support-boundaries-options/create-support-request.png" alt-text="A screenshot showing the 'Help + Support' tile with 'Create a support request' highlighted.":::

1. In the **New support request** pane, complete the following steps:

    1. On the **Problem description** tab, enter a summary of the issue. For **Problem type**, select **Deprecated features**. For **Problem subtype**, select **Migrating from App Center to Azure Monitor**. Select **Next**.

        :::image type="content" source="media/support-boundaries-options/new-support-request.png" lightbox="media/support-boundaries-options/new-support-request.png" alt-text="A screenshot showing the 'New support request' pane.":::

    1. On the **Recommended solutions** tab, review the suggested solutions. If the suggested solutions don't resolve the issue, select **Return to support request**, and then select **Next**.
    
    1. On the **Additional details** tab, provide the date the problem started, a description, any related files, diagnostic log collection permissions, and the required support severity.

    1. On the **Review + create** tab, review your request. Make any required changes, and then select **Create**.