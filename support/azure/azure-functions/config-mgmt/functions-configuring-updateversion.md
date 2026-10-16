---
title: Upgrade the Azure Functions runtime version or language version
description: Troubleshoot Azure Functions runtime upgrade issues, such as unreachable runtime, missing modules, and worker failures. Follow these steps to fix your app.
ms.date: 10/14/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.custom: sap:Configuring and Managing Function Apps
ms.reviewer: agaltrai, kaushika
ai.usage: ai-assisted
---
# Troubleshoot Azure Functions runtime upgrade issues

## Summary

This article helps you troubleshoot Azure Functions runtime upgrade issues that occur when you upgrade the runtime version or language version of a function app. It covers an unreachable runtime, missing modules, worker process failures, and functions that don't appear after an upgrade.

Use the following sections to validate your app before upgrading, change runtime and language version settings, and diagnose problems after migration.

## Current end-of-support notices

The following Azure Functions features and runtime versions have active retirement deadlines. Running an unsupported version can lead to issues, performance implications, and ineligibility for security patches or bug fixes. Upgrade before the end-of-support date.

| Feature or version | End-of-support date | Action required |
|---|---|---|
| **Azure Functions runtime v1** | September 14, 2026 | Migrate to runtime v4. See [Migrate from v1 to v4](/azure/azure-functions/migrate-version-1-version-4). |
| **.NET in-process model** | November 10, 2026 | Migrate to the isolated worker model. This requires code changes, not just a settings change. See [Migrate .NET apps to isolated worker model](/azure/azure-functions/migrate-dotnet-to-isolated-model). |
| **Runtime v3 on Linux Consumption plan** | September 30, 2026 | Migrate to runtime v4 or move to the Flex Consumption plan. See [Migrate from v3 to v4](/azure/azure-functions/migrate-version-3-version-4). |

For more information and migration guidance, see the following resources:

- [Azure Functions language support policy](/azure/azure-functions/language-support-policy)
- [Functions runtime versions](/azure/azure-functions/functions-versions)
- [Migrate apps from Azure Functions version 3.x to version 4.x](/azure/azure-functions/migrate-version-3-version-4)
- [Migrate apps from Azure Functions version 1.x to version 4.x](/azure/azure-functions/migrate-version-1-version-4)

## Validate function app compatibility for runtime v4

To validate your function app's compatibility with runtime v4, follow these steps:

- Go to your function app in the [Azure portal](https://portal.azure.com). Select **Diagnose and solve problems** to open [Azure Functions diagnostics](/azure/azure-functions/functions-diagnostics). In the **Search** bar, type **Updating Functions Language or Runtime Version** to run it directly. The diagnostic report includes guidance on the update. After validation completes, follow the recommendations and address any issues in your app.
- Use the [pre-upgrade validator](/azure/azure-functions/migrate-version-3-version-4#run-the-pre-upgrade-validator) to identify potential problems when migrating your function app to 4.x. From the same diagnostics search bar, type **Functions 4.x Pre-Upgrade Validator** to run it directly. After validation completes, follow the recommendations and address any issues in your app.
- [Upgrade your local project environment](/azure/azure-functions/migrate-version-3-version-4#upgrade-your-local-project) to version 4.x. Fully test your app locally by using version 4.x of the Azure Functions core tools.
- Consider using a [staging slot](/azure/azure-functions/migrate-version-3-version-4#upgrade-using-slots) to test and verify your app in Azure on the new runtime version before deploying to a production slot. Remember to set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` for migration with slots. Don't mark `FUNCTIONS_WORKER_RUNTIME` as a deployment slot setting.

## Change the Azure Functions runtime version for Windows

Follow these steps:

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set the `netFrameworkVersion` site setting to target .NET 8. `netFrameworkVersion` is a SiteConfig setting, not an app setting. It's not directly available in the Azure portal. Set it by using [Azure Resource Explorer](https://azure.microsoft.com/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/) or [Azure CLI/PowerShell](/azure/azure-functions/migrate-version-3-version-4#update-without-slots).

For more information, see [Azure Functions runtime versions](/azure/azure-functions/functions-versions).

## Change the Azure Functions runtime version for Linux

Follow these steps:

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set `LinuxFxVersion`, by using a command-line interface (CLI) tool, to `<Language>|<LanguageVersion>`, based on the language used. For more information, see [Using LinuxFxVersion for Linux Function Apps](https://github.com/Azure/azure-functions-host/wiki/Using-LinuxFxVersion-for-Linux-Function-Apps). For example, to update to .NET 8 by using the isolated worker model, set `LinuxFxVersion` to `DOTNET-ISOLATED|8.0` and `FUNCTIONS_EXTENSION_VERSION` to `~4`.

For more information, see [Azure Functions runtime versions](/azure/azure-functions/functions-versions).

## Get supported languages by runtime version

See the [list of supported languages by the runtime version](/azure/azure-functions/supported-languages#languages-by-runtime-version).

## Update the language version setting for the function app after updating the code

Use the option that best suits your scenario, and then follow the appropriate steps:

- **PowerShell** - In the [Azure portal](https://portal.azure.com), set the `PowerShell Core version`. For more information, see [Change the PowerShell version](/azure/azure-functions/functions-reference-powershell#changing-the-powershell-version).
- **Python** - Running Python function apps on Windows isn't supported; use Linux hosting instead. Set `linuxFxVersion` to `python|3.x`. For more information, see [Change the Python version](/azure/azure-functions/functions-reference-python#changing-python-version).
- **Java** - Specify the language version by using `-DjavaVersion` as 11, 17, or 21. For more information, see [Specify the deployment version](/azure/azure-functions/functions-reference-java#specify-the-deployment-version).
- **Node, JavaScript** - For Windows, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting to `~22`. For Linux, set `linuxFxVersion`, by using CLI, to `node|22`. For more information, see [Set the Node version](/azure/azure-functions/functions-reference-node#setting-the-node-version).

## Use Azure Functions app proxies in version 4.x

Azure Functions proxies is a legacy feature for versions 1.x through 3.x. You can temporarily re-enable proxies in version 4.x to help you upgrade your function apps to the latest runtime version. However, proxies aren't automatically available in version 4.x — you must explicitly re-enable them by adding `EnableProxies` to the `AzureWebJobsFeatureFlags` application setting. Even when re-enabled, you can't manage proxies through the Azure portal. You must edit the *proxies.json* file directly. For more information, see [Re-enable proxies in Functions v4.x](/azure/azure-functions/legacy-proxies#re-enable-proxies-in-functions-v4x).

We recommend that you switch to integrating your function apps with Azure API Management as soon as possible. API Management lets you take advantage of a more complete set of features to define, secure, manage, and monetize your Functions-based APIs. For more information, see [How to migrate to APIM](/azure/azure-functions/functions-proxies#moving-from-functions-proxies-to-api-management) and [Integrate Functions with APIM using Visual Studio](/azure/azure-functions/openapi-apim-integrate-visual-studio).

## Get a list of any instances of Azure Functions that use runtime version 1.x, 2.x, or 3.x

Follow these steps:

1. Go to your function app in the [Azure portal](https://portal.azure.com).
1. Select **Diagnose and solve problems** to open [Azure Functions diagnostics](/azure/azure-functions/functions-diagnostics).
1. In the **Search** bar, type **Updating Functions Language or Runtime Version** to run it directly.
1. In the diagnostic report, scroll down and select **List All Azure Functions** > **View Details**.
1. Set the search filters and select **Show** to get the list of functions apps in the current subscription.

You can also use App Service REST API calls ([GetConfiguration](/rest/api/appservice/web-apps/get-configuration)) to determine this information. `LinuxFxVersion` and `WindowsFxVersion` provide the version information.

For bulk discovery across a subscription, see [Keep your Azure Functions up to date - Identify apps running on retired versions](https://techcommunity.microsoft.com/blog/AppsonAzureBlog/keep-your-azure-functions-up-to-date-identify-apps-running-on-retired-versions/4398187).

## Move a .NET Framework 4.6.1 app from Functions runtime v1 to v4

.NET Framework 4.6.1 reached end of life, so upgrade apps to .NET Framework 4.8. In Functions v4, you can run a .NET Framework 4.8 app in out-of-process mode. For more information, see the [isolated process guide](/azure/azure-functions/dotnet-isolated-process-guide).

## A migrated function app isn't starting or has some runtime issues

Use the following guidelines to troubleshoot and resolve common issues with migrated function apps:

- For .NET apps, update the code to .NET 8 (or a later supported version) before building and deploying.
- Double-check the runtime version of the app in the [Azure portal](https://portal.azure.com).
- For Windows apps, set `netFrameworkVersion` by using CLI or PowerShell.
- Make sure you're using [extension bundles](/azure/azure-functions/functions-versions#minimum-extension-versions) version 4.x, as recommended. Version 4.x of the Azure Functions runtime requires extension bundle version `[4.0.0, 5.0.0)`.
- Signing in to Azure Storage by using *AzureWebJobsDashboard* isn't supported in 4.x. Instead, use [Application Insights](/azure/azure-functions/functions-monitoring) for monitoring.
- If you receive a message that Azure Functions runtime is unreachable and you're sharing storage accounts, see [Host ID considerations](/azure/azure-functions/storage-considerations#host-id-considerations).
- Azure Functions 4.x doesn't support Node.js 10 and 12, Python 3.6, and PowerShell 6. For more information, see [Language versions supported for the v4 runtime](/azure/azure-functions/supported-languages#languages-by-runtime-version).
- For Python functions, if there are errors related to module collision and module not found, try setting `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to *1* in app settings. This setting has no effect on Python 3.13 and later, where dependency isolation is built-in.
- For Node.js function apps on Windows, if the app fails to start after upgrading, check whether the app is running in a 32-bit worker process. Try setting `use32BitWorkerProcess` to `false` under **Configuration** > **General Settings** in the Azure portal.
- If the Azure portal shows read-only mode or a deployment returns `HTTP 409 Conflict`, the app is running from a deployment package. Update `host.json` in the source repository and redeploy rather than editing files in the portal.
- If Secure Socket Layer (SSL) or connection errors occur at startup, confirm that outbound access to `functionscdn.azureedge.net` (the extension bundle content delivery network (CDN) endpoint) and to your storage account endpoints isn't blocked.
- Review [Migrate existing function apps](/azure/azure-functions/functions-versions#migrate-existing-function-apps).
- For runtime issues, from the **Diagnose and Solve Problems** option in the [Azure portal](https://portal.azure.com), search for **Function app down or reporting errors** and review the diagnostic report for error messages and solutions. Also review the **Function Configuration checks** detector to make sure that the configuration is correct.
- Review the blog [Issues when upgrading Azure Functions to V4](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/issues-you-may-meet-when-upgrading-azure-function-app-to-v4/ba-p/3288983) for additional troubleshooting tips.

## .NET in-process to isolated worker model migration

The following guidelines help you migrate a .NET in-process function app to the isolated worker model.

### Symptoms

The following symptoms might indicate that a .NET in-process function app needs to be migrated to the isolated worker model:

- The portal shows a deprecation notification for the .NET in-process model.
- After changing `FUNCTIONS_WORKER_RUNTIME` to `dotnet-isolated`, the app fails to start.
- Functions return `HTTP 500` with JSON deserialization errors after migration.
- Functions aren't listed in the portal after migration.

### Cause

Migration from the in-process model to the isolated worker model requires both application code changes and platform configuration updates. Changing only the app setting without updating the code (or vice versa) causes a mismatch that prevents the function app from starting.

Common specific causes include the following:

- `FUNCTIONS_WORKER_RUNTIME` changed to `dotnet-isolated` but deployed artifacts still target the in-process model.
- Project file not updated to reference isolated worker packages.
- Missing `Program.cs` startup entry point required by the isolated worker host.
- Function attributes not updated (for example, still using `[FunctionName]` instead of `[Function]`).

### Resolution

Follow these steps to migrate your .NET in-process function app to the isolated worker model:

1. Verify the execution model before making changes. Use Azure CLI to run the following command.

    ```azurecli
    az functionapp config appsettings list --name <app-name> --resource-group <rg> --query "[?name=='FUNCTIONS_WORKER_RUNTIME'].value" -o tsv
    ```

    - `dotnet` = in-process model (requires migration)
    - `dotnet-isolated` = already using isolated worker model

1. Update the application code first. Make the necessary changes to your project file and code to target the isolated worker model:
    - Update the project file target framework (for example, `net8.0` or `net10.0`).
    - Replace in-process SDK packages with isolated worker packages.
    - Add a `Program.cs` file with the isolated worker host builder.
    - Replace `[FunctionName]` with `[Function]` attributes.
    - Update binding and trigger packages to isolated worker versions.

3. Update platform settings after code is ready. Run the following Azure CLI command to update the function app settings.

    ```azurecli
    az functionapp config appsettings set --name <app-name> --resource-group <rg> --settings FUNCTIONS_WORKER_RUNTIME=dotnet-isolated FUNCTIONS_EXTENSION_VERSION=~4
    ```

1. Deploy and validate. Follow these steps:
    - Use a staging slot if available.
    - Set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` when using slots for migration.
    - Don't mark `FUNCTIONS_WORKER_RUNTIME` as a slot setting.
    - Restart the function app after setting changes.

For complete migration guidance, see [Migrate .NET apps from the in-process model to the isolated worker model](/azure/azure-functions/migrate-dotnet-to-isolated-model).

## Node.js version upgrade failures

The following guidelines help you troubleshoot Node.js version upgrade failures in Azure Functions.

### Symptoms

The following symptoms might indicate Node.js version upgrade failures:

- Function app fails to start after upgrading to a newer Node.js version.
- `SyntaxError` during startup.
- Functions not discovered or indexed.
- Trigger synchronization fails with "Bad Request" after changing Node.js version.
- Startup timeout (AZFD0005) after package upgrades.

### Cause

The following table summarizes common causes for Node.js version upgrade failures.

| Symptom | Likely cause |
|---------|----------------|
| SyntaxError at startup | Code uses syntax not supported by the configured Node.js version, or version mismatch between local development environment (dev) and cloud. |
| Functions not indexed | Older programming model used with a Node.js version that requires a newer model. Check [supported languages](/azure/azure-functions/supported-languages) for compatibility. |
| Trigger sync "Bad Request" | Certain newer Node.js versions require 64-bit platform on Windows. |
| Startup timeout (AZFD0005) | Heavy initialization in `index.js` exceeding host startup tolerance. |
| SSL connection errors during startup | Outdated extension bundle can't reach CDN endpoint. |

### Resolution

Follow these steps to resolve Node.js version upgrade failures:

1. Check programming model compatibility. Newer Node.js versions might require a newer programming model. Check [Supported languages in Azure Functions](/azure/azure-functions/supported-languages) to verify which programming model your target Node.js version requires. If migration is needed, see [Upgrade to Azure Functions Node.js programming model v4](/azure/azure-functions/functions-node-upgrade-v4).
1. Verify version configuration matches deployment. Use the following steps as applicable to your scenario:
    - **Windows** - Check that the `WEBSITE_NODE_DEFAULT_VERSION` app setting matches your code target.
    - **Linux** - Check `LinuxFxVersion`. Use Azure CLI and run the following command.

        ```azurecli
        az functionapp config show --name <app-name> --resource-group <rg> --query "linuxFxVersion" -o tsv
        ```

1. Ensure the platform is set correctly. If you're using a newer Node.js version on Windows, some versions require 64-bit. Use Azure CLI to run the following command.

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --use-32bit-worker-process false
    ```

1. Update the extension bundle and ensure `host.json` uses extension bundle v4. Run the following command.

    ```json
    "extensionBundle": {
      "id": "Microsoft.Azure.Functions.ExtensionBundle",
      "version": "[4.0.0, 5.0.0)"
    }
    ```

## Python version upgrade failures

The following section summarizes common causes for Python version upgrade failures.

### Symptoms

The following symptoms indicate Python version upgrade failures:

- `ModuleNotFoundError` after changing Python version.
- `ModuleNotFoundError: No module named '_cffi_backend'`.
- Functions not discovered: "No job functions found."
- ZIP deployment returns HTTP 503 after version change.
- Remote build fails for newer Python versions.

> [!IMPORTANT]
> Running Python functions on Windows function apps isn't supported. Use Linux hosting exclusively.

### Cause

The following table maps common symptoms to their likely causes.

| Symptom | Likely cause |
|---------|----------------|
| ModuleNotFoundError | Deployment package contains dependencies built for previous Python version. |
| `_cffi_backend` missing | Native C extension not compiled for target Python version. |
| Functions not found | Local dev container or Docker image not updated to target Python version. |
| 503 on ZIP deploy | Deploying a package built for an older Python version to a newer runtime. |
| Remote build failure | Network restrictions blocking Oryx build endpoints. |

### Resolution

Follow these steps to resolve Python version upgrade failures:

1. Rebuild the deployment package for the target Python version. Run the following command.

    ```bash
    # Rebuild with target Python version
    pip install -r requirements.txt --target .python_packages/lib/site-packages
    ```

1. Deploy with remote build enabled. Run the following command.

    ```azurecli
    az functionapp deployment source config-zip --name <app-name> --resource-group <rg> --src <package.zip> --build-remote true
    ```

    Required app settings for remote build: `ENABLE_ORYX_BUILD=true` and `SCM_DO_BUILD_DURING_DEPLOYMENT=true`.

1. Verify the runtime is set to the target version before deploying. Run the following command.

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --linux-fx-version "PYTHON|<target-version>"
    ```

    > [!IMPORTANT]
    > Set the runtime version **before** deploying so the remote build compiles dependencies against the correct Python version.

1. For module collision or module-not-found errors, set `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to `1` in app settings. This setting has no effect on Python 3.13 and later, where isolation is built-in.

## Extension bundle upgrade failures

The following section summarizes common causes for extension bundle upgrade failures.

### Symptoms

The following symptoms indicate extension bundle upgrade failures:

- SSL connection errors during startup after Node.js or runtime upgrade.
- `HTTP 409 Conflict` when trying to save `host.json` changes in the portal.
- Portal shows "deprecated extension bundle version" warning.
- Functions fail after upgrading extension bundle version.

### Cause

The following table maps common symptoms to their likely causes.

| Symptom | Likely cause |
|---------|----------------|
| SSL or connection errors at startup | The outdated extension bundle range and runtime can't download bundle from CDN. |
| `HTTP 409 Conflict` | The function app uses run-from-package deployment and files are read-only. |
| Functions fail after bundle upgrade | There is a binding incompatibility between extension bundle v4 and legacy code patterns. |

### Resolution

Follow these steps to resolve extension bundle upgrade failures:

1. Update the `host.json` extension bundle configuration. Run the following command.

    ```json
    {
      "version": "2.0",
      "extensionBundle": {
        "id": "Microsoft.Azure.Functions.ExtensionBundle",
        "version": "[4.0.0, 5.0.0)"
      }
    }
    ```

    > [!NOTE]
    > The `"version": "2.0"` at the root of `host.json` is the **schema version**, not the extension bundle version.

1. If you're using run-from-package or at CI (Continuous Integration (CI)) or Continuous Delivery (CD) deployment, do the following:
    - Don't edit `host.json` in the portal. Update it in your source repository.
    - Redeploy after changes.
1. Verify the CDN endpoint access. The function app must have outbound access to `functionscdn.azureedge.net` for extension bundle downloads. If you're using VNet integration with egress restrictions, allow list this endpoint.

## SSL and TLS errors during startup

The following section describes common SSL and TLS errors that occur during function app startup and their resolutions.

### Symptoms

The following are common symptoms of SSL and TLS errors during function app startup:

- Error: "The SSL connection could not be established."
- Error: "Unable to read data from the transport connection."
- Error: "Connection reset by peer."
- Error: "RemoteCertificateNameMismatch."
- Errors appear during function app startup before any customer code executes.

### Cause

These errors typically occur when the function app can't reach required platform endpoints during startup. Common causes include the following:

- **Egress restrictions** block access to `functionscdn.azureedge.net` (extension bundle CDN) or other platform endpoints.
- **Private DNS misconfiguration** causes requests to resolve to wrong endpoints.
- **Network Address Translation (NAT) gateway or forced tunneling** routes startup traffic through a path that blocks or modifies TLS connections.

### Resolution

Follow these steps to resolve SSL and TLS errors during function app startup:

1. Allow required outbound endpoints, including:
    - `functionscdn.azureedge.net` — extension bundle downloads
    - Storage account endpoints (blob, file, queue, table)
    - `login.microsoftonline.com` — authentication
    - Platform-specific endpoints per [App Service networking documentation](/azure/app-service/networking-features)
1. For private endpoint or DNS issues, do the following:
    - Verify DNS resolution from within the VNet returns correct private IP addresses.
    - Check for duplicate or stale private endpoint A records.
    - Confirm DNS zones are linked to the correct VNet.
1. For NAT gateway issues, test with egress restrictions temporarily relaxed to confirm the endpoint is the issue.

## Functions not appearing after version upgrade

The following sections describe common issues and resolutions when functions don't appear after a version upgrade.

### Symptoms

The following symptoms might indicate that functions don't appear after a version upgrade:

- The functions list in the portal is empty after changing the language version.
- You see the message: "No job functions found."
- Azure Functions metadata fails to load during startup.

### Cause

The following table summarizes common scenarios and their likely causes.

| Scenario | Likely cause |
|----------|----------------|
| Python version changed without redeploying | Old dependencies are incompatible with the new Python version. |
| Node.js upgraded without programming model migration | The older programming model can't index functions on newer Node.js versions. |
| .NET isolated migration incomplete | The deployed artifacts still target the in-process model. |
| Runtime version changed to unsupported value | Check the [Supported languages](/azure/azure-functions/supported-languages). |

### Resolution

Follow these steps to resolve issues when functions don't appear after a version upgrade:

1. Verify the configured runtime version is supported. For more information, see[Supported languages in Azure Functions](/azure/azure-functions/supported-languages).
1. Check that deployed artifacts match the configuration. Follow these guidelines:
    - For .NET: Ensure deployed DLLs target the correct framework.
    - For Python: Ensure dependencies are rebuilt for the target version.
    - For Node.js: Ensure you're using the correct programming model for your target version.
1. Review startup logs. Follow these steps:
    - Go to **Diagnose and solve problems** > **Function App Down or Reporting Errors**.
    - Check Application Insights traces for worker startup errors.
1. If functions disappeared after a version change, revert to the previous working version to restore functionality. Then, plan the upgrade with a proper rebuild and redeploy cycle.

## Worker process exit codes

The following section describes common worker process exit codes, their causes, and resolutions.

### Symptoms

The following errors might indicate worker process exit issues:

- Error: "dotnet exited with code 150 (0x96)."
- Error: "Failed to start language worker process for runtime: dotnet-isolated."
- Error: "Node process exited with code 1."

### Cause

The following table summarizes common worker process exit codes, their likely causes, and suggested resolutions.

| Exit code | Likely cause |
|-----------|----------------|
| 150 (0x96) | .NET target framework isn't supported on the current hosting plan, or stale hosting artifacts from a previous runtime. Check [Supported languages](/azure/azure-functions/supported-languages) for plan compatibility. |
| 1 (Node.js) | There's a syntax error or module loading failure in the Node.js application. |
| General worker failure | Dependencies were compiled for the wrong OS, architecture, or network blocking required endpoints |

### Resolution

Follow these steps to resolve common worker process exit issues:

1. For exit code 150, follow these steps:
    - Verify the target framework is supported on your hosting plan.
    - Ensure deployment produces a clean publish output without stale artifacts.

1. For Node.js exit code 1, follow these steps:
    - Check that the Node.js version in the cloud matches your local development version.
    - Review the application's entry point for syntax not supported by the configured version.

1. For general worker process failures, follow these steps:
    - Check Application Insights for detailed startup exception traces.
    - Go to **Diagnose and solve problems** > **Function App Down or Reporting Errors**.
    - Verify outbound connectivity to required platform endpoints.

## References

- [Azure Functions language stack support policy](/azure/azure-functions/language-support-policy)
- [Supported languages in Azure Functions](/azure/azure-functions/supported-languages)
- [Migrate .NET apps to isolated worker model](/azure/azure-functions/migrate-dotnet-to-isolated-model)
- [Migrate from Functions v3 to v4](/azure/azure-functions/migrate-version-3-version-4)
- [Migrate from Functions v1 to v4](/azure/azure-functions/migrate-version-1-version-4)
- [Upgrade to Node.js programming model v4](/azure/azure-functions/functions-node-upgrade-v4)
- [Update language stack versions in Azure Functions](/azure/azure-functions/update-language-versions)
- [Keep Your Azure Functions Up to Date: Identify Apps Running on Retired Versions](https://techcommunity.microsoft.com/blog/AppsonAzureBlog/keep-your-azure-functions-up-to-date-identify-apps-running-on-retired-versions/4398187)
