---
title: Tools to Troubleshoot Azure Functions App Issues
description: Describes how to troubleshoot the Azure Functions app if it's down or reporting errors.
ms.date: 08/04/2025
ms.reviewer: v-liuamson; v-gsitser
ms.custom: sap:Function app down or reporting errors
---

# Tools to troubleshoot Azure Functions App issues

Function App failures typically fall into three major categories, which are configuration issues, customer code issues, and platform issues. This article explores these issues in detail and introduces the appropiate diagnostic tools for troubleshooting.

## Configuration issues

These are the most frequent and include:

- Missing or incorrect application settings such as `AzureWebJobsStorage`, `FUNCTIONS_WORKER_RUNTIME`, or binding-specific configurations. For more info, check the [App settings reference for Azure Functions](/azure/azure-functions/functions-app-settings).
- Storage account misconfigurations, including deleted accounts, rotated keys, or firewall restrictions. For more info, check [Storage considerations for Azure Functions](/azure/azure-functions/storage-considerations?tabs=azure-cli).
- Key Vault and Managed Identity access problems due to misconfigured permissions or missing identity assignments. Check the resources below for more info:
  - [Use Key Vault references as app settings - Azure App Service](/azure/app-service/app-service-key-vault-references?tabs=azure-cli#troubleshoot-key-vault-references)
  - [Create a function app without default storage secrets in its definition - Azure Functions](/azure/azure-functions/functions-identity-based-connections-tutorial)

## Customer code issues

These issues originate from:

- Faulty code patterns that lead to high CPU/memory usage, SNAT exhaustion, or runtime exceptions (e.g., division by zero, null reference).
- Long-running or inefficient functions, which are especially problematic on consumption plans due to timeout constraints.

Check the following resources for more info:

- [Azure Functions best practices](/azure/azure-functions/functions-best-practices?tabs=csharp)
- [Improve Azure Functions performance and reliability](/azure/azure-functions/performance-reliability)
- [Manage connections in Azure Functions](/azure/azure-functions/manage-connections?tabs=csharp)

## Platform issues

Less frequent but impactful:

- Unsupported runtime versions (e.g., Azure Functions `~2.x` or `~3.x`).
Check the following resources for more info:
  - [Azure Functions language stack support policy](/azure/azure-functions/language-support-policy?pivots=programming-language-csharp)
  - [Supported languages in Azure Functions](/azure/azure-functions/supported-languages?tabs=isolated-process%2Cv4&pivots=programming-language-csharp#languages-by-runtime-version)

- Host startup failures, including placeholder site specialization errors or container allocation issues.

## Typical error messages

You may encounter common errors such as:

- **Azure Functions runtime is unreachable.**
 [Troubleshoot error: Azure Functions runtime is unreachable](/azure/azure-functions/functions-recover-storage-account).

- **Function host not running.**

- **Access Denied**: `'C:\home\site\wwwroot\host.json'`.

- **HTTP 5xx errors**: 503, 502, 500, or timeouts.

## Symptoms to watch

- Function not triggering or executing. [Analyze Azure Functions telemetry in Application Insights](/azure/azure-functions/analyze-telemetry-data#viewing-telemetry-in-monitor-tab)

- Missing invocation history or unexpected gaps.

- High resource consumption (CPU/memory spikes flagged by detectors).

- Timeouts or long response times, especially on Consumption plans (max 230 seconds).

- Functions not listed in the overview page.

## Diagnostic tools

You may use the following tools in the Azure portal to identify and resolve issues:

### Function App Down or Reporting Errors (Preview)

To access this tool, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate to **Function App**.
1. Select **Diagnose and solve problems**.
1. Search for **Function App Down or Reporting Errors (Preview)**.

**Features**:

- Automates key troubleshooting checks using existing detectors.
- Provides minimal noise and focused root cause analysis.
- Supports [Conversational diagnostics](https://techcommunity.microsoft.com/blog/appsonazureblog/power-of-conversational-diagnostics-public-preview-diagnostic-workflows/428866ution).

## Issue categories

Function App downtime errors are classified into:

### Common configuration problems

- Misconfigured application settings.
- Incorrect or unreachable storage account configuration.
- Key Vault access permission issues.
- Managed Identity authentication problems.
- Binding/trigger misconfiguration.
- Network connectivity issues.

### Code and runtime resource issues

- High CPU/memory consumption.
- SNAT port exhaustion.
- TCP connection exhaustion.
- Long-running or stuck functions.
- Runtime exceptions and failures.
- Poor error handling or retry logic.

## Diagnostic checks performed

The diagnostic workflow evaluates the following aspects of your Function App:

- **General information**
  - Hosting plan type (Consumption, Premium, Dedicated, Flex).
  - Runtime version.
  - Platform (Linux or Windows).
  - Trigger types and bindings.
- **Startup issues**
  - Diagnostic events during app startup.
  - Offline history analysis for unexpected downtimes.
- **Recent deployments**
  - Highlights deployments that may have impacted the app.
- **Runtime and language version validation**
  - Confirms use of supported versions.
- **Configuration checks**
  - Verifies mandatory app settings.
  - Validates Key Vault and Managed Identity configuration.
  - Checks for SyncTrigger issues.
  - Detects Function Host name collisions.
- **Extension versions**
  - Identifies outdated or unsupported extensions.
- **Hosting plan setup**
  - Analyzes configuration and scaling behavior.
  - Checks for SNAT port exhaustion, high CPU, and memory issues.
  - Includes risk alerts:
    - For Dedicated plans: validates **AlwaysOn** is enabled.
    - For Elastic Premium: checks VNet routing and scaling.
- **Execution health**
  - Detects:
    - Execution failures.
    - Non-triggering functions.
    - Stuck or long-running executions.
- **AI-powered analysis**
  - Uses OpenAI to detect issue patterns and provide contextual recommendations.

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
> Sampling is enabled by default. Disable temporarily if needed during investigation.

For more info, check [Analyze Azure Functions telemetry in Application Insights](/azure/azure-functions/analyze-telemetry-data#viewing-telemetry-in-monitor-tab).

### Network validator tool

> [!NOTE]
> This applies to all hosting plans, with the exception of the Windows and Linux Consumption plans.

If your app shows errors such as `FAILED TO INITIALIZE RUN FROM PACKAGE.txt` or `host.json not found`, use the [Network troubleshooter](../../app-service/troubleshoot-vnet-integration-apps#network-troubleshooter.md) to resolve.

**To access:**

- Log on to the [Azure portal](https://portal.azure.com).
- Navigate to **Diagnose and solve problems**.
- Search for **Connectivity Troubleshooter**.

**This tool checks for:**

- DNS resolution.
- Storage and Key Vault access.
- Outbound restrictions (VNet, NSG, firewalls).

**Ensure that:**

- VNet integration is correctly configured.
- No endpoint or firewall blocks are in place.

### Kudu logs (SCM)

> [!NOTE]
> This applies to all hosting plans, with the exception of the Linux Consumption and Flex Consumption plans.

Access logs under:

- **Host Logs**: `%HOME%\LogFiles\Application\Functions\Host`
- **Functions log**: `%HOME%\LogFiles\Application\Functions\Function\<your_triggername>`
- **System-level log**: `%HOME%\LogFiles\Eventlog.xml`

For more info, check [Understanding the Azure App Service file system](https://github.com/projectkudu/kudu/wiki/understanding-the-azure-app-service-file-system).

## References

- [Azure Functions networking options](/azure/azure-functions/functions-networking-options?tabs=azure-portal#troubleshooting)
- [Frequently asked questions about networking in Azure Functions](/azure/azure-functions/functions-networking-faq)
