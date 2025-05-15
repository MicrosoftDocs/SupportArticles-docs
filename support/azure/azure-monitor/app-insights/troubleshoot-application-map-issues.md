---
title: Troubleshoot Application Map Issues
description: Provides general recommendations and specific suggestions for Application map issues.
ms.date: 05/14/2025
ms.service: azure-monitor
ms.custom: sap:Application Map doesn't show performance of my app's components (Retired)
ms.reviewer: aaronmax, v-weizhu
---
# Troubleshoot Application map issues

The **Application map** feature in Azure Monitor Application Insights might not work as expected. This article offers general recommendations and specific suggestions in some scenarios.

## General recommendations

- Use an officially supported software development kit (SDK). Unsupported or community SDKs might not support correlation. For a list of supported SDKs, see [Application Insights: Languages, platforms, and integrations](/azure/azure-monitor/app/app-insights-overview#supported-languages).

- Upgrade all components to the latest SDK version.

- Support Azure Functions with CSharp by upgrading to [Azure Functions V2](/azure/azure-functions/functions-versions).

- Ensure the [cloud role name](/azure/azure-monitor/app/app-map#set-cloud-role-names) is correctly configured.

- Confirm any missing dependencies are listed as [autocollected dependencies](/azure/azure-monitor/app/asp-net-dependencies#dependency-autocollection). If a dependency isn't listed, you can track it manually with a [track dependency call](/azure/azure-monitor/app/api-custom-events-metrics#trackdependency).

## Scenario 1: Too many nodes on map

**Application map** adds a component node for each unique cloud role name in your request telemetry. The process also adds a dependency node for each unique combination of type, target, and cloud role name.

If you have more than 10,000 nodes in your telemetry, **Application map** can't fetch all of the nodes and links. In this scenario, your map structure is incomplete. If this scenario occurs, a warning message appears when you view the map.

**Application map** can render a maximum of 1,000 separate ungrouped nodes at once. **Application map** reduces visual complexity by grouping dependencies together when they have the same type and callers.

If your telemetry has too many unique cloud role names or too many dependency types, the grouping is insufficient and the map isn't rendered.

To fix this issue, change your instrumentation to properly set the cloud role name, dependency type, and dependency target fields. Confirm your application adheres to the following criteria:

- Each dependency target represents the logical name of a dependency. In many cases, this value is equivalent to the server or resource name of the dependency. For example, if there are HTTP dependencies, the value is the hostname. The value shouldn't contain unique IDs or parameters that change from one request to another.

- Each dependency type represents the logical type of a dependency. For example, HTTP, SQL, or Azure Blob are typical dependency types. This value shouldn't contain unique IDs.

- Each cloud role name purpose applies the description in the [Set or override cloud role name](/azure/azure-monitor/app/app-map#set-cloud-role-names) section.

## Scenario 2: Intelligent view doesn't highlight an edge

**Intelligent view** might not highlight an edge as expected, even with a low sensitivity setting. A dependency might appear to be in failure but the model doesn't indicate the issue as a potential incident. Here are some possible scenarios:

- If the dependency commonly fails, the model might consider the failure a standard state for the component and not highlight the edge. **Intelligent view** focuses on problem-solving in real time.

- If the dependency has a minimal effect on the overall performance of the application, **Intelligent view** might ignore the component during machine learning modeling.

If your scenario is unique, you can use the Feedback option to describe your experience and help improve future model versions.

## Scenario 3: Intelligent view highlights an edge

When **intelligent view** highlights an edge, it indicates a performance hotspot or failure hotspot in the dependency between two components. In this scenario, perform the following actions:

1. Select the highlighted edge > **View details** to open detailed telemetry data in the side pane.
2. Review failure rates or high latency in the dependency calls.

    - If failures are high:

        1. Select **Investigate Failures** in the side pane to inspect exception types and failure rates.
        2. Check the corresponding dependency logs or failure traces to isolate the root cause.

    - If latency is high:

        1. Select **Investigate performance** to examine dependency response times.
        2. Identify slow endpoints or services, and then review their recent deployment or configuration changes.

For long-term analysis, consider setting up dependency health alerts using [Application Insights alerts](/azure/azure-monitor/alerts/alerts-overview).

## Scenario 4: Intelligent view doesn't load

If **Intelligent view** doesn't load, set the configured time frame to six days or less.

## Scenario 5: Intelligent view takes long time to load

If **Intelligent view** takes longer to load than expected, don't select the **Update map components** option. Enable **Intelligent view** only for a single Application Insights resource.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]