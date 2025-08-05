---
title: Resolve Function App Not Responding or Reporting Errors
description: Describes how to troubleshoot Azure Functions app if it's not responding or reports errors.
ms.date: 08/05/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: sap:Function app down or reporting errors
---

# Resolve function app not responding or reporting errors

## Common scenarios, error messages, and symptoms

Microsoft Azure Functions app failures typically fit into three major categories: configuration issues, customer code issues, and platform issues. This article explores these issues in detail and introduces the appropriate diagnostic tools for troubleshooting.

### Configuration issues

These issues are the most common. They include:

- Missing or incorrect application settings, such as `AzureWebJobsStorage`, `FUNCTIONS_WORKER_RUNTIME`, and binding-specific configurations. For more information, see the [App settings reference for Azure Functions](/azure/azure-functions/functions-app-settings).
- Storage account misconfigurations, including deleted accounts, rotated keys, and firewall restrictions. For more information, see [Storage considerations for Azure Functions](/azure/azure-functions/storage-considerations?tabs=azure-cli).
- Key Vault and Managed Identity access problems because of misconfigured permissions or missing identity assignments. For more information, see the following resources:
  - [Use Key Vault references as app settings - Azure App Service](/azure/app-service/app-service-key-vault-references?tabs=azure-cli#troubleshoot-key-vault-references)
  - [Create a function app without default storage secrets in its definition - Azure Functions](/azure/azure-functions/functions-identity-based-connections-tutorial)

### Customer code issues

These issues have the following causes:

- Faulty code patterns that cause high CPU or memory usage, SNAT exhaustion, or runtime exceptions (for example, division by zero or null reference).
- Long-running or inefficient functions that are especially problematic on consumption plans because of timeout constraints.

For more information, see the following resources:

- [Azure Functions best practices](/azure/azure-functions/functions-best-practices?tabs=csharp)
- [Improve Azure Functions performance and reliability](/azure/azure-functions/performance-reliability)
- [Manage connections in Azure Functions](/azure/azure-functions/manage-connections?tabs=csharp)

### Platform issues

These issues are less common but usually have a greater effect:

- Unsupported runtime versions (for example, Azure Functions `~2.x` or `~3.x`).
For more information, see the following resources:
  - [Azure Functions language stack support policy](/azure/azure-functions/language-support-policy?pivots=programming-language-csharp)
  - [Supported languages in Azure Functions](/azure/azure-functions/supported-languages?tabs=isolated-process%2Cv4&pivots=programming-language-csharp#languages-by-runtime-version)

- Host startup failures, including placeholder site specialization errors and container allocation issues.

### Typical error messages

You might experience common errors such as the following:

- **Azure Functions runtime is unreachable.**

    See [Troubleshoot error: Azure Functions runtime is unreachable](/azure/azure-functions/functions-recover-storage-account).

- **Function host not running.**

- **Access Denied**: `'C:\home\site\wwwroot\host.json'`.

- **HTTP 5*xx* errors**: 503, 502, 500, or timeouts.

### Symptoms to watch for

- Function not triggering or running. See [Analyze Azure Functions telemetry in Application Insights](/azure/azure-functions/analyze-telemetry-data#viewing-telemetry-in-monitor-tab).

- Missing invocation history or unexpected gaps.

- High resource consumption (CPU or memory spikes that are flagged by detectors).

- Timeouts or long response times, especially on Consumption plans (maximum of 230 seconds).

- Functions not listed on the overview page.

## Diagnostic tools

To identify and resolve issues, you can use the following tools in the Azure portal.

### Function App Down or Reporting Errors (Preview)

To access this tool, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Open **Function App**.
1. Select **Diagnose and solve problems**.
1. Search for **Function App Down or Reporting Errors (Preview)**.

**Features of this tool**

- Automates key troubleshooting checks by using existing detectors.
- Provides minimal noise and focused root cause analysis.
- Supports [conversational diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/power-of-conversational-diagnostics-public-preview-diagnostic-workflows/428866ution).

## Issue categories

Function app downtime errors are categorized as follows.

### Common configuration issues

- Misconfigured application settings
- Incorrect or unreachable storage account configuration
- Key Vault access permission issues
- Managed Identity authentication problems
- Binding or trigger misconfiguration
- Network connectivity issues

### Code and runtime resource issues

- High CPU or memory consumption
- SNAT port exhaustion
- TCP connection exhaustion
- Long-running or stuck functions
- Runtime exceptions and failures
- Poor error handling or retry logic

## Diagnostic checks performed

The diagnostic workflow evaluates the following aspects of your function spp:

- **General information**
  - Hosting plan type (Consumption, Premium, Dedicated, Flex)
  - Runtime version
  - Platform (Linux or Windows)
  - Trigger types and bindings
- **Startup issues**
  - Diagnostic events during app startup
  - Offline history analysis for unexpected downtimes
- **Recent deployments**
  - Highlights deployments that might have affected the app
- **Runtime and language version validation**
  - Confirms use of supported versions
- **Configuration checks**
  - Verifies mandatory app settings
  - Verifies Key Vault and Managed Identity configuration
  - Checks for SyncTrigger issues
  - Detects Function Host name collisions
- **Extension versions**
  - Identifies outdated or unsupported extensions
- **Hosting plan setup**
  - Analyzes configuration and scaling behavior
  - Checks for SNAT port exhaustion, high CPU, and memory issues
  - Includes risk alerts:
    - For Dedicated plans: verifies that **AlwaysOn** is enabled
    - For Elastic Premium: checks VNet routing and scaling
- **Execution health**
  - Detects:
    - Execution failures
    - Nontriggering functions
    - Stuck or long-running executions
- **AI-powered analysis**
  - Uses OpenAI to detect issue patterns and provide contextual recommendations

### Application Insights queries

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
> Sampling is enabled by default. If it's necessary, disable this feature temporarily during an investigation.

For more information, see [Analyze Azure Functions telemetry in Application Insights](/azure/azure-functions/analyze-telemetry-data#viewing-telemetry-in-monitor-tab).

### Network validator tool

> [!NOTE]
> This tool applies to all hosting plans, except for the Windows and Linux Consumption plans.

If your app shows errors such as `FAILED TO INITIALIZE RUN FROM PACKAGE.txt` or `host.json not found`, use the [network troubleshooter](../../app-service/troubleshoot-vnet-integration-apps.md#network-troubleshooter) to resolve the errors.

To access the tool, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate to **Diagnose and solve problems**.
1. Search for **Connectivity Troubleshooter**.

This tool checks for:

- DNS resolution
- Storage and Key Vault access
- Outbound restrictions (VNet, NSG, firewalls)

When you use the network validator, make sure that:

- VNet integration is correctly configured.
- No endpoint or firewall blocks are in place.

For more information, see the following resources:

- [Azure Functions networking options](/azure/azure-functions/functions-networking-options?tabs=azure-portal#troubleshooting)
- [Frequently asked questions about networking in Azure Functions](/azure/azure-functions/functions-networking-faq)

### Kudu logs (SCM)

> [!NOTE]
> This tool applies to all hosting plans, except for the Linux Consumption and Flex Consumption plans.

### Other logs

- **Host Logs**: `%HOME%\LogFiles\Application\Functions\Host`
- **Functions log**: `%HOME%\LogFiles\Application\Functions\Function\<your_triggername>`
- **System-level log**: `%HOME%\LogFiles\Eventlog.xml`

For more information, see [Understanding the Azure App Service file system](https://github.com/projectkudu/kudu/wiki/understanding-the-azure-app-service-file-system).
