---
title: Troubleshoot High Data Ingestion in Application Insights
description: Provides a step-by-step guide to troubleshoot high data ingestion scenarios and provides methods to reduce costs.
ms.date: 04/21/2025
ms.service: azure-monitor
ms.reviewer: jeanbisutti, toddfous, aaronmax, v-weizhu
ms.custom: sap:Application Insights
---
# Troubleshoot high data ingestion in Application Insights

An increase in billing charges for Application Insights or Log Analytics often occurs due to high data ingestion. This article helps you troubleshoot this issue and provides methods to reduce data ingestion costs.

## General troubleshooting steps

### Step 1: Identify resources presenting high data ingestion

In the Azure portal, navigate to your subscription and select **Cost Management** > **Cost analysis**. This blade offers cost analysis views to chart costs per resource, as follows:

 :::image type="content" source="media/troubleshoot-high-data-ingestion/cost-analysis.png" alt-text="Screenshot that shows the 'cost analysis' blade.":::


### Step 2: Identify costly tables with high data ingestion

Once you've identified an Application Insights resource or a Log Analytics workspace, analyze the data and determine where the highest ingestion occurs. Consider the approach that best suits your scenario:

- Based on raw record count

    Use the following query to compare record counts across tables:

    ```Kusto
    search *
    | where timestamp &gt; ago(7d)
    | summarize count() by $table
    | sort by count_ desc
    ```

    This query can help identify the *noisiest* tables. From there, you can refine your queries to narrow down the investigation.

- Based on consumed bytes

    Determine tables with the highest byte ingestion using the [format_bytes()](/kusto/query/format-bytes-function) scalar function:
    
    ```Kusto
    systemEvents
    | where timestamp &gt; ago(7d)
    | where type == "Billing"
    | extend BillingTelemetryType = tostring(dimensions["BillingTelemetryType"])
    | extend BillingTelemetrySizeInBytes = todouble(measurements["BillingTelemetrySize"])
    | summarize TotalBillingTelemetrySize = sum(BillingTelemetrySizeInBytes) by BillingTelemetryType
    | extend BillingTelemetrySizeGB = format_bytes(TotalBillingTelemetrySize, 1 ,"GB")
    | sort by BillingTelemetrySizeInBytes desc
    | project-away BillingTelemetrySizeInBytes
    ```

    Similar to the record count queries, the preceding queries can help identify the most active tables, allowing you to pinpoint specific tables for further investigation.

- Using Log Analytics workspace Workbooks

    In the Azure portal, navigate to your Log Analytics workspace, select **Monitoring** > **Workbooks**, and then select **Usage** under **Log Analytics Workspace Insights**.

    :::image type="content" source="media/troubleshoot-high-data-ingestion/log-analytics-usage-workbook.png" alt-text="Screenshot that shows the Log Analytics workbook pane." lightbox="media/troubleshoot-high-data-ingestion/log-analytics-usage-workbook.png":::

    This workbook provides valuable insights, such as the percentage of data ingestion for each table and detailed ingestion statistics for each resource reporting to the same workspace.

### Step 3: Determine factors contributing to high data ingestion

After identifying the tables with high data ingestion, focus on the table with the highest activity and determine factors contributing to high data ingestion. This might be a specific application that generates more data than the others, an exception message that is logged too frequently, or a new logger category that emits too much information.

Here are some sample queries you can use for this identification:

```Kusto
requests
| where timestamp > ago(7d)
| summarize count() by cloud_RoleInstance
| sort by count_ desc
```

```Kusto
requests
| where timestamp > ago(7d)
| summarize count() by operation_Name
| sort by count_ desc
```

```Kusto
dependencies
| where timestamp > ago(7d)
| summarize count() by cloud_RoleName
| sort by count_ desc
```

```Kusto
dependencies
| where timestamp > ago(7d)
| summarize count() by type
| sort by count_ desc
```

```Kusto
traces
| where timestamp > ago(7d)
| summarize count() by message
| sort by count_ desc
```

```Kusto
exceptions
| where timestamp > ago(7d)
| summarize count() by message
| sort by count_ desc
```


You can try different telemetry fields. For example, perhaps you first run the following query and observe there's no obvious cause for the excessive telemetry:

```Kusto
dependencies
| where timestamp > ago(7d)
| summarize count() by target
| sort by count_ desc
```

However, you can try another telemetry field instead of `target`, such as `type`.

```Kusto
dependencies
| where timestamp > ago(7d)
| summarize count() by type
| sort by count_ desc
```

In some scenarios, you might need to investigate a specific application or instance further. Use the following queries to identify noisy messages or exception types:

```Kusto
traces
| where timestamp > ago(7d)
| where cloud_RoleName == 'Specify a role name'
| summarize count() by type
| sort by count_ desc
```

```Kusto
exceptions
| where timestamp > ago(7d)
| where cloud_RoleInstance == 'Specify a role instance'
| summarize count() by type
| sort by count_ desc
```

### Step 4: Investigate the evolution of ingestion over time

Examine the evolution of ingestion over time based on the factors identified previously. This way can determine whether this behavior has been consistent or if changes occurred at a specific point. By analyzing data in this way, you can pinpoint when the change happened and provide a clearer understanding of the causes behind the high data ingestion. This insight will be important for addressing the issue and implementing effective solutions.

In the following queries, the [bin()](/kusto/query/bin-function) Kusto Query Language (KQL) scalar function is used to segment data into one-day intervals. This approach facilitates trend analysis as you can see how data has changed or not changed over time.

```Kusto
dependencies
| where timestamp > ago(30d)
| summarize count() by bin(timestamp, 1d), operation_Name
| sort by timestamp desc
```

Use the `min()` aggregation function to identify the earliest recorded timestamp for specific factors. This approach helps establish a baseline and offers insights into when events or changes first occurred.

```Kusto
dependencies
| where timestamp > ago(30d)
| where type == 'Specify dependency type being investigated'
| summarize min(timestamp) by type
| sort by min_timestamp desc
```

## Troubleshooting steps for specific scenarios

### Scenario 1: High data ingestion in Log Analytics

1. Query all tables within a Log Analytics workspace:

    ```Kusto
    search *
    | where TimeGenerated > ago(7d)
    | where _IsBillable == true
    | summarize TotalBilledSize = sum(_BilledSize) by $table
    | extend IngestedVolumeGB = format_bytes(TotalBilledSize, 1, "GB")
    | sort by TotalBilledSize desc
    | project-away TotalBilledSize
    ```
    
    You can know which table is the biggest contributor to costs. Here's an example of `AppTraces`:

    :::image type="content" source="media/troubleshoot-high-data-ingestion/apptraces-table.png" alt-text="Screenshot that shows that the AppTraces table is the biggest contributor to costs.":::

2. Query the specific application driving the costs for traces:

    ```Kusto
    AppTraces
    | where TimeGenerated > ago(7d)
    | where _IsBillable == true
    | summarize TotalBilledSize = sum(_BilledSize) by  AppRoleName
    | extend IngestedVolumeGB = format_bytes(TotalBilledSize, 1, "GB")
    | sort by TotalBilledSize desc
    | project-away TotalBilledSize
    ```

    :::image type="content" source="media/troubleshoot-high-data-ingestion/specific-application-driving-costs-for-traces.png" alt-text="Screenshot that shows the specific application driving the costs for traces.":::

3. Run the following query specific to that application and look further into the specific logger categories sending telemetry to the `AppTraces` table:

    ```Kusto
    AppTraces
    | where TimeGenerated > ago(7d)
    | where _IsBillable == true
    | where AppRoleName contains 'transformation'
    | extend LoggerCategory = Properties['Category']
    | summarize TotalBilledSize = sum(_BilledSize) by tostring(LoggerCategory)
    | extend IngestedVolumeGB = format_bytes(TotalBilledSize, 1, "GB")
    | sort by TotalBilledSize desc
    | project-away TotalBilledSize
    ```

    The result shows two main categories responsible for the costs:

    :::image type="content" source="media/troubleshoot-high-data-ingestion/logger-categories-sending-telemetry-to-apptraces.png" alt-text="Screenshot that shows the specific logger categories sending telemetry to the AppTraces table.":::

### Scenario 2: High data ingestion in Application Insight

To determine the factors contributing to the costs, follow these steps:

1. Query the telemetry across all tables and obtain a record count per table and SDK version:

    ```Kusto
    search *
    | where TimeGenerated > ago(7d)
    | summarize count() by $table, SDKVersion
    | sort by count_ desc
    ```

    The following exmaple shows Azure Functions is generating lots of trace and exception telemetry:
    
    :::image type="content" source="media/troubleshoot-high-data-ingestion/table-sdkversion-count.png" alt-text="Screenshot that shows which table and SDK is generating the most Trace and Exception telemetry.":::
    

2. Run the following query to get the specific app generating more traces than the others:

    ```Kusto
    AppTraces
    | where TimeGenerated > ago(7d)
    | where SDKVersion == 'azurefunctions: 4.34.2.22820'
    | summarize count() by AppRoleName
    | sort by count_ desc
    ```


    :::image type="content" source="media/troubleshoot-high-data-ingestion/app-generating-more-traces.png" alt-text="Screenshot that shows which app is generating the most traces.":::

3. Refine the query to include that specific app and generate a count of records per each individual message:

    ```Kusto
    AppTraces
    | where TimeGenerated > ago(7d)
    | where SDKVersion == 'azurefunctions: 4.34.2.22820'
    | where AppRoleName contains 'inbound'
    | summarize count() by Message
    | sort by count_ desc
    ```

    The result can show the specific message increasing ingestion costs:

    :::image type="content" source="media/troubleshoot-high-data-ingestion/app-message-count.png" alt-text="Screenshot that shows a count of records per each message.":::

### Scenario 3: Reach daily cap unexpectedly

Assume you reached the daily cap unexpectedly on September 4. Use the following query to obtain a count of custom events and identify the most recent timestamp associated with each event:

```Kusto
customEvents
| where timestamp between(datetime(8/25/2024) .. 15d)
| summarize count(), min(timestamp) by name
```

This analysis indicates that certain events started being ingested on September 4 and subsequently became noisy very quickly.

:::image type="content" source="media/troubleshoot-high-data-ingestion/custom-events.png" alt-text="Screenshot that shows a count of custom events." lightbox="media/troubleshoot-high-data-ingestion/custom-events.png":::

## Reduce data ingestion costs

After identifying the factors in the Azure Monitor tables responsible for unexpected data ingestion, reduce data ingestion costs using the following methods per your scenarios.

### Method 1: Update the daily cap configuration

Adjust the daily cap to prevent excessive telemetry ingestion.

### Method 2: Switch the table plan

Switch to another supported table plan for Application Insights. Billing for data ingestion depends on the table plan and the region of the Log Analytics workspace. See [Table plans](/azure/azure-monitor/logs/data-platform-logs#table-plans) and [Tables that support the Basic table plan in Azure Monitor Logs](/azure/azure-monitor/logs/basic-logs-azure-tables).

### Method 3: Use telemetry SDK features for the Java agent

The default recommended solution is using [sampling overrides](/azure/azure-monitor/app/java-standalone-sampling-overrides). The Application Insights Java agent provides [two types of sampling](/azure/azure-monitor/app/java-standalone-config#sampling). A common use case is [suppressing collecting telemetry for health checks](/azure/azure-monitor/app/java-standalone-sampling-overrides#suppress-collecting-telemetry-for-health-checks).

There are some supplemental methods for sampling overrides:

- Reduce the cost from the `traces` table:

    - [Reduce the telemetry log level](/azure/azure-monitor/app/java-standalone-config#autocollected-logging).
    - [Remove application (not frameworks/libs) logs with the MDC attribute and sampling override](/azure/azure-monitor/app/java-standalone-sampling-overrides#suppress-collecting-telemetry-for-log).
    - Disable log instrumentation by updating the **applicationinsights.json** file:

        ```JSON
        {
          "instrumentation": {
            "logging": {
              "enabled": false
            }
          }
        }
        ```

- Reduce the cost from the `dependencies` table:

    - [Suppress collecting telemetry for the Java method producing the dependency telemetry](/azure/azure-monitor/app/java-standalone-sampling-overrides#suppress-collecting-telemetry-for-a-java-method).
    - [Disable the instrumentation](/azure/azure-monitor/app/java-standalone-config#suppress-specific-autocollected-telemetry) producing the dependency telemetry data. 
    
        If the dependency is a database call, you won't see the database on the application map. If you remove the dependency instrumentation of an HTTP call or a message (for example, a Kafka message), all the downstream telemetry data are dropped.

- Reduce the cost from the `customMetrics` table:

    - [Increase the metrics interval](/azure/azure-monitor/app/java-standalone-config#metric-interval).
    - [Exclude a metric with a telemetry processor](/azure/azure-monitor/app/java-standalone-telemetry-processors#metric-filter).
    - [Increase the heartbeat interval](/azure/azure-monitor/app/java-standalone-config#heartbeat).

- Reduce the cost of OpenTelemetry attributes:

    OpenTelemetry attributes are added to the **customDimensions** column. They're represented as properties in Application Insights. You can remove attributes by using [an attribute telemetry processor](/azure/azure-monitor/app/java-standalone-telemetry-processors#attribute-processor). For more information, see [Telemetry processor examples - Delete](/azure/azure-monitor/app/java-standalone-telemetry-processors-examples#delete).

### Method 4: Update the application code (log levels or exceptions)

In some scenarios, updating the application code directly might help reduce the amount of telemetry generated and consumed by the Application Insights backend service. A common example might be a noisy exception surfaced by the application.

## References

- [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/)
- [Change pricing tier for Log Analytics workspace](/azure/azure-monitor/logs/change-pricing-tier)
- [Table plans in Azure Monitor](/azure/azure-monitor/logs/data-platform-logs#table-plans)
- [Azure Monitor cost and usage](/azure/azure-monitor/cost-usage)
- [Analyze usage in a Log Analytics workspace](/azure/azure-monitor/logs/analyze-usage)
- [Cost optimization in Azure Monitor](/azure/azure-monitor/fundamentals/best-practices-cost)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
