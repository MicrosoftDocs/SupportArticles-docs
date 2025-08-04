---
title: Function App Down or Reporting Errors
description: Describes how to troubleshoot the Azure Functions app if it's down or reporting errors.
ms.date: 08/04/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: sap:Function app down or reporting errors
---

# Troubleshoot Function App Down or Reporting Errors

The Azure portal provides several powerful tools that can help you quickly diagnose and resolve issues if your Azure Functions app is not responding or reports errors. This article highlights the most effective tools that you might want to consider.

## Function App Down or Reporting Errors tool (Preview)

To access this tool, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select **Your Function App**.
1. Select **Diagnose and solve problems**.
1. Search for **Function App Down or Reporting Errors (Preview)**.

Although the existing **Function App Down or Reporting Errors** detector still provides valuable insights, this new diagnostic workflow helps identify and resolve functions app issues more quickly and accurately.

### Tool features

The Function App Down or Reporting Errors tool (Preview) provides the following functionality:

- Automates major troubleshooting checks by using existing detectors.
- Identifies root causes while generating minimal irrelevant output.
- Supports [Conversational Diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/the-power-of-conversational-diagnostics-public-preview-and-diagnostic-workflows/4288668) for guided, AI-powered troubleshooting.
- Classifies and resolves issues across configuration and execution layers.

### Issue categories

Azure Functions App downtime or errors typically belong to either of the following categories:

- **Configuration issues:**
  - Misconfigured application settings
  - Incorrect or unreachable storage account configuration
  - Key Vault access or permission issues
  - Managed identity authentication problems
  - Binding or trigger misconfiguration
  - Network connectivity issues

- **Code and runtime resource issues:**
  - High CPU or memory consumption
  - SNAT port exhaustion
  - TCP connection exhaustion
  - Long-running or stuck functions
  - Runtime exceptions and failures
  - Poor error handling or retry logic

### Diagnostic checks performed

The diagnostic workflow evaluates the following aspects of your Azure Functions app:

- **General information:**
  - Hosting plan type (Consumption, Premium, Dedicated, Flex)
  - Runtime version
  - Platform (Linux or Windows)
  - Trigger types and bindings

- **Startup issues:**
  - Diagnostic events during app startup
  - Offline history analysis for unexpected downtimes

- **Recent deployments:**
  - Highlights deployments that might affect the app.

- **Runtime and language version validation:**
  - Confirms use of supported versions

- **Configuration checks:**
  - Confirms mandatory app settings
  - Confirms Key Vault and managed identity configuration
  - Checks for **SyncTrigger** issues
  - Detects Azure Functions host name collisions

- **Extension versions:**
  - Identifies outdated or unsupported extensions

- **Hosting plan setup:**
  - Analyzes configuration and scaling behavior
  - Checks for SNAT port exhaustion, high CPU, and memory issues
  - Includes risk alerts:
    - For Dedicated plans: Risk alert validates **AlwaysOn** is enabled
    - For Elastic Premium plans: Risk alert checks for VNet routing and scaling

- **Execution health detects:**
  - Execution failures
  - Nontriggering functions
  - Stuck or long-running executions

- **AI-powered analysis:**
  - Uses OpenAI to detect issue patterns and provide contextual recommendations

## Application Insights queries

For diagnostics, run these queries in Application Insights:

- **Requests per worker (last 30 minutes):**

    ```kusto
    requests
    | where timestamp > ago(30m)
    | summarize count() by cloud_RoleInstance, bin(timestamp, 1m)
    | render timechart
    ```

- **Traces for errors (last 30 minutes):**

    ```kusto
    traces
    | where timestamp > ago(30m)
    | where customDimensions.LogLevel == "Error"
    ```

- **Runtime exceptions (last 30 minutes):**

    ```kusto
    exceptions
    | where timestamp > ago(30m)
    ```

> [!NOTE]
> Sampling is enabled by default. Disable temporarily if needed during investigation.

## Network validator tool

If your app shows error entries such as `FAILED TO INITIALIZE RUN FROM PACKAGE.txt` or `host.json not found`, see [Troubleshoot virtual network integration with Azure App Service](../app-service/troubleshoot-vnet-integration-apps.md).

> [!NOTE]
> This error applies to all hosting plans, except for the Windows and Linux Consumption plans.

- To access this tool, follow these steps:
    1. Sign in to the [Azure portal](https://portal.azure.com).
    1. Select **Diagnose and solve problems**.
    1. Search for **Connectivity Troubleshooter**.

- The tool checks for:
  - DNS resolution
  - Storage and Key Vault access
  - Outbound restrictions (VNet, NSG, firewalls)

- Make sure that:
  - VNet integration is configured correctly.
  - No endpoint or firewall blocks are configured.

## Kudu logs (SCM)

You can access the logs at:

- **Host logs:** `%HOME%\LogFiles\Application\Functions\Host`
- **Azure Functions logs:** `%HOME%\LogFiles\Application\Functions\Function\<your_triggername>`
- **System-level logs:** `%HOME%\LogFiles\Eventlog.xml`

> [!NOTE]
> This log access applies to all hosting plans, except for the Linux Consumption and Flex Consumption plans.

## References

- [Conversational diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/the-power-of-conversational-diagnostics-public-preview-and-diagnostic-workflows/4288668)
- [Troubleshoot virtual network integration with Azure App Service](../app-service/troubleshoot-vnet-integration-apps.md)
