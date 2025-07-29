---
title: Troubleshoot Azure Functions App issues
description: Describes how to troubleshoot the Azure Functions app when it's down or reporting errors.
ms.date: 07/29/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: sap:Function App down or reporting errors
---

# Troubleshoot Azure Functions App issues

There are several powerful tools available in the Azure portal that can help you quickly diagnose and resolve issues when your Azure Functions app is down or reporting errors. This page highlights the most effective tools you may consider.

## Function App down or Reporting Errors tool (Preview)

You may access this tool by following these steps:

1. Log in to the [Azure portal](https://portal.azure.com).
1. Select **Your Function App**.
1. Select **Diagnose and solve problems**.
1. Search for **Function App down or reporting errors (Preview)**.

While the existing **Function App Down or Reporting Errors** detector still provides valuable insights, this new diagnostic workflow helps identify and resolve Functions app issues more quickly and accurately.

### Tool features

1. Automates major troubleshooting checks using existing detectors.
1. Identifies root causes with minimal irrelevant output.
1. Supports [Conversational Diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/the-power-of-conversational-diagnostics-public-preview-and-diagnostic-workflows/4288668) for guided, AI-powered troubleshooting.
1. Classifies and resolves issues across configuration and execution layers.

### Issue categories

Azure Functions app downtime or errors typically fall into two categories:

1. **Configuration issues:**
    1. Misconfigured application settings.
    1. Incorrect or unreachable storage account configuration.
    1. Key Vault access or permission issues.
    1. Managed identity authentication problems.
    1. Binding or trigger misconfiguration.
    1. Network connectivity issues.

1. **Code and runtime resource issues:**
    1. High CPU or memory consumption.
    1. SNAT port exhaustion.
    1. TCP connection exhaustion.
    1. Long-running or stuck functions.
    1. Runtime exceptions and failures.
    1. Poor error handling or retry logic.

### Diagnostic checks performed

The diagnostic workflow evaluates the following aspects of your Azure Functions app:

1. **General information:**
    1. Hosting plan type (Consumption, Premium, Dedicated, Flex).
    1. Runtime version.
    1. Platform (Linux or Windows).
    1. Trigger types and bindings.

1. **Startup issues:**
    1. Diagnostic events during app startup.
    1. Offline history analysis for unexpected downtimes.

1. **Recent deployments:**
    1. Highlights deployments that may have impacted the app.

1. **Runtime and language version validation:**
    1. Confirms use of supported versions.

1. **Configuration checks:**
    1. Verifies mandatory app settings.
    1. Validates Key Vault and managed identity configuration.
    1. Checks for **SyncTrigger** issues.
    1. Detects Azure Functions host name collisions.

1. **Extension versions:**
    1. Identifies outdated or unsupported extensions.

1. **Hosting plan setup:**
    1. Analyzes configuration and scaling behavior.
    1. Checks for SNAT port exhaustion, high CPU, and memory issues.
    1. Includes risk alerts:
        1. For Dedicated plans: Risk alert validates **AlwaysOn** is enabled.
        1. For Elastic Premium plans: Risk alert checks for VNet routing and scaling.

1. **Execution health detects:**
    1. Execution failures.
    1. Non-triggering functions.
    1. Stuck or long-running executions.

1. **AI-powered analysis:**
    1. Uses OpenAI to detect issue patterns and provide contextual recommendations.

## Application Insights queries

For diagnostics, run these queries in Application Insights:

1. **Requests per worker (last 30 minutes):**

    ```kusto
    requests
    | where timestamp > ago(30m)
    | summarize count() by cloud_RoleInstance, bin(timestamp, 1m)
    | render timechart
    ```

1. **Traces for errors (last 30 minutes):**

    ```kusto
    traces
    | where timestamp > ago(30m)
    | where customDimensions.LogLevel == "Error"
    ```

1. **Runtime exceptions (last 30 minutes):**

    ```kusto
    exceptions
    | where timestamp > ago(30m)
    ```

> [!NOTE]
> Sampling is enabled by default. Disable temporarily if needed during investigation.

## Network validator tool

If your app shows errors such as `FAILED TO INITIALIZE RUN FROM PACKAGE.txt` or `host.json not found`, refer to the [Troubleshoot virtual network integration with Azure App Service](../app-service/troubleshoot-vnet-integration-apps.md) article for further guidance.

> [!NOTE]
> This applies to all hosting plans, with the exception of the Windows and Linux Consumption plans.

1. You may access this tool by following these steps:
    1. Log in to the [Azure portal](https://portal.azure.com).
    1. Select **Diagnose and solve problems**.
    1. Search for **Connectivity Troubleshooter**.

1. The tool checks for:
    1. DNS resolution.
    1. Storage and Key Vault access.
    1. Outbound restrictions (VNet, NSG, firewalls).

1. Ensure that:
    1. VNet integration is correctly configured.
    1. No endpoint or firewall blocks are in place.

## Kudu logs (SCM)

You may access the logs under:

1. **Host logs:** `%HOME%\LogFiles\Application\Functions\Host`
1. **Azure Functions logs:** `%HOME%\LogFiles\Application\Functions\Function\<your_triggername>`
1. **System-level logs:** `%HOME%\LogFiles\Eventlog.xml`

> [!NOTE]
> This applies to all hosting plans, with the exception of the Linux Consumption and Flex Consumption plans.

## References

- [Conversational Diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/the-power-of-conversational-diagnostics-public-preview-and-diagnostic-workflows/4288668)
- [Troubleshoot virtual network integration with Azure App Service](../app-service/troubleshoot-vnet-integration-apps.md)
