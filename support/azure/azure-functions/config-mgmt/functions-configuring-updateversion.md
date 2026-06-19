---
title: Troubleshoot Function App language and runtime version upgrades
description: Resolve common issues when upgrading Azure Function App language versions, runtime versions, or migrating to the isolated worker model.
ms.date: 06/19/2026
ms.custom: sap:Configuring and Managing Function Apps/Updating Function App Language Version
ms.reviewer: gasridha, v-sidong, agaltrai
---

# Troubleshoot Function App language and runtime version upgrades

This article helps you resolve common issues that occur when upgrading Azure Function App language versions, runtime versions, extension bundles, or migrating from the .NET in-process model to the isolated worker model.

## Common scenarios

Language and runtime version upgrade failures typically fit into these categories:

- **Configuration mismatch** — The deployed code targets a different version than the platform configuration.
- **Dependency incompatibility** — Packages or modules were built for a previous runtime version.
- **Hosting plan limitations** — The target runtime isn't supported on the current hosting plan.
- **Network restrictions** — Egress controls block platform endpoints required during startup.
- **Incomplete migration** — Only settings were changed without updating application code.

## Validate Function App compatibility for runtime v4

Navigate to your Function App in the [Azure portal](https://portal.azure.com). Select **Diagnose and solve problems** to open [Azure Function App diagnostics](/azure/azure-functions/functions-diagnostics). In the **Search** bar, type *Updating Function App Language or Runtime Version* to run it directly. The diagnostic report includes guidance on the update. After validation completes, follow the recommendations and address any issues in your app.

We also provide a [pre-upgrade validator](/azure/azure-functions/migrate-version-3-version-4#run-the-pre-upgrade-validator) to help you identify potential issues when migrating your Function App to 4.x. From the same diagnostics search bar, type *Functions 4.x Pre-Upgrade Validator* to run it directly. After validation completes, follow the recommendations and address any issues in your app.

We strongly recommend [upgrading your local project environment](/azure/azure-functions/migrate-version-3-version-4#upgrade-your-local-project) to version 4.x. Fully test your app locally using version 4.x of the Azure Functions Core Tools.

Consider using a [staging slot](/azure/azure-functions/migrate-version-3-version-4#upgrade-using-slots) to test and verify your app in Azure on the new runtime version before deploying to a production slot. Remember to set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` for migration with slots.

## Change the Functions runtime version for Windows

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set the `netFrameworkVersion` site configuration property to target the desired .NET version (for example, `v8.0`). `netFrameworkVersion` is a SiteConfig setting, not an app setting, and it's not directly available in the Azure portal. Set it by using [Azure Resource Explorer](https://azure.microsoft.com/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/) or Azure CLI/PowerShell:

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --net-framework-version v8.0
    ```

1. For Node.js apps, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting to the target major version (for example, `~22`):

    ```azurecli
    az functionapp config appsettings set --name <app-name> --resource-group <rg> --settings WEBSITE_NODE_DEFAULT_VERSION=~22
    ```

For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Change the Functions runtime version for Linux

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set `LinuxFxVersion`, by using Azure CLI, to `<Language>|<LanguageVersion>`, based on the language used. For more information, see [Using LinuxFxVersion for Linux Function Apps](https://github.com/Azure/azure-functions-host/wiki/Using-LinuxFxVersion-for-Linux-Function-Apps).

    For example, to update to .NET 8 isolated:

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --linux-fx-version "DOTNET-ISOLATED|8.0"
    ```

    For Python 3.11:

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --linux-fx-version "PYTHON|3.11"
    ```

For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Update the language version setting after updating code

- **PowerShell:** In the [Azure portal](https://portal.azure.com), navigate to **Configuration** > **General Settings** tab and select the PowerShell version. For more information, see [Change the PowerShell version](/azure/azure-functions/functions-reference-powershell#changing-the-powershell-version).
- **Python:** Set `linuxFxVersion` to `PYTHON|3.x` using Azure CLI. For more information, see [Change the Python version](/azure/azure-functions/functions-reference-python#changing-python-version).
- **Java:** Specify the language version by using `-DjavaVersion` as 11, 17, or 21. For more information, see [Specify the deployment version](/azure/azure-functions/functions-reference-java#specify-the-deployment-version).
- **Node.js/JavaScript:** For Windows, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting (for example, `~22`). For Linux, set `linuxFxVersion` to `NODE|22` using Azure CLI. For more information, see [Set the Node version](/azure/azure-functions/functions-reference-node#setting-the-node-version).

## .NET in-process to isolated worker model migration

### Symptoms

- Portal shows a deprecation notification for the .NET in-process model.
- After changing `FUNCTIONS_WORKER_RUNTIME` to `dotnet-isolated`, the app fails to start.
- Functions return HTTP 500 with JSON deserialization errors after migration.
- Portal displays "runtime mismatch" warning between configuration and deployed artifacts.
- Functions aren't listed in the portal after migration.

### Cause

Migration from the in-process model to the isolated worker model requires both application code changes and platform configuration updates. Changing only the app setting without updating the code, or updating the code without changing platform settings, causes a mismatch that prevents the Function App from starting correctly.

Common specific causes:

- `FUNCTIONS_WORKER_RUNTIME` changed to `dotnet-isolated` but deployed artifacts still target the in-process model.
- Project file not updated to reference isolated worker packages.
- Missing `Program.cs` startup entry point required by the isolated worker host.
- Function attributes not updated (for example, still using `[FunctionName]` instead of `[Function]`).
- Request body parsing differences between in-process and isolated worker models causing deserialization failures.

### Resolution

1. **Verify the execution model before making changes:**

    ```azurecli
    az functionapp config appsettings list --name <app-name> --resource-group <rg> --query "[?name=='FUNCTIONS_WORKER_RUNTIME'].value" -o tsv
    ```

    - `dotnet` = in-process model (requires migration)
    - `dotnet-isolated` = already using isolated worker model

2. **Update the application code first:**
    - Update the project file target framework (for example, `net8.0` or `net10.0`).
    - Replace in-process SDK packages with isolated worker packages.
    - Add a `Program.cs` file with the isolated worker host builder.
    - Replace `[FunctionName]` with `[Function]` attributes.
    - Update binding and trigger packages to isolated worker versions.
    - Refactor dependency injection from `Startup.cs` to `Program.cs`.

3. **Update platform settings after code is ready:**

    ```azurecli
    az functionapp config appsettings set --name <app-name> --resource-group <rg> --settings FUNCTIONS_WORKER_RUNTIME=dotnet-isolated FUNCTIONS_EXTENSION_VERSION=~4
    ```

4. **Deploy and validate:**
    - Use a staging slot if available.
    - Set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` when using slots for migration.
    - Don't mark `FUNCTIONS_WORKER_RUNTIME` as a slot setting.
    - Restart the Function App after setting changes.

5. **Verify in the portal:**
    - Check that functions appear in the portal Functions list.
    - Portal code editing isn't available for isolated worker apps (expected behavior).

For complete migration guidance, see [Migrate .NET apps from the in-process model to the isolated worker model](/azure/azure-functions/migrate-dotnet-to-isolated-model).

## Node.js version upgrade failures

### Symptoms

- Function App fails to start after upgrading to a newer Node.js version.
- `SyntaxError` during startup.
- Functions not discovered or indexed.
- Error: "Azure.WebJobs.Script: Error building configuration in an external startup class."
- Trigger synchronization fails with "Bad Request" after changing Node.js version.
- Startup timeout (AZFD0005) after package upgrades.

### Cause

| Symptom | Likely cause |
|---------|--------------|
| SyntaxError at startup | Code uses syntax not supported by the configured Node.js version, or version mismatch between local dev and cloud |
| Functions not indexed | Older programming model used with a Node.js version that requires a newer model. Check [supported languages](/azure/azure-functions/supported-languages) for compatibility. |
| Trigger sync "Bad Request" | Certain newer Node.js versions require 64-bit platform on Windows |
| Startup timeout (AZFD0005) | Heavy initialization in `index.js` exceeding host startup tolerance |
| SSL connection errors during startup | Outdated extension bundle can't reach CDN endpoint |

### Resolution

1. **Check programming model compatibility:**

    Newer Node.js versions may require a newer programming model. Check [Supported languages in Azure Functions](/azure/azure-functions/supported-languages) to verify which programming model your target Node.js version requires.

    If migration is needed, see [Upgrade to Azure Functions Node.js programming model v4](/azure/azure-functions/functions-node-upgrade-v4).

2. **Verify version configuration matches deployment:**
    - **Windows:** Check `WEBSITE_NODE_DEFAULT_VERSION` app setting matches your code target.
    - **Linux:** Check `LinuxFxVersion` via CLI:

        ```azurecli
        az functionapp config show --name <app-name> --resource-group <rg> --query "linuxFxVersion" -o tsv
        ```

3. **If using a newer Node.js version on Windows:** Some versions require 64-bit. Ensure the platform is set correctly:

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --use-32bit-worker-process false
    ```

4. **Update extension bundle:** Ensure `host.json` uses extension bundle v4:

    ```json
    "extensionBundle": {
      "id": "Microsoft.Azure.Functions.ExtensionBundle",
      "version": "[4.0.0, 5.0.0)"
    }
    ```

5. **For startup timeout issues:**
    - Move expensive initialization out of the module-level code.
    - Initialize SDK clients lazily on first function execution.
    - Compare app settings between working and failing environments.

## Python version upgrade failures

### Symptoms

- `ModuleNotFoundError` after changing Python version (for example, `No module named 'azure.mgmt.compute.v2021_07_01'`).
- `ModuleNotFoundError: No module named '_cffi_backend'`.
- Functions not discovered: "No job functions found."
- ZIP deployment returns HTTP 503 after version change.
- Remote build fails for newer Python versions.

### Cause

| Symptom | Likely cause |
|---------|--------------|
| ModuleNotFoundError | Deployment package contains dependencies built for previous Python version |
| `_cffi_backend` missing | Native C extension not compiled for target Python version |
| Functions not found | Local dev container or Docker image not updated to target Python version |
| 503 on ZIP deploy | Deploying a package built for an older Python version to a newer runtime |
| Remote build failure | Network restrictions blocking Oryx build endpoints |

> [!IMPORTANT]
> Running Python functions on Windows Function Apps is not supported. Use Linux hosting exclusively.

### Resolution

1. **Rebuild the deployment package for the target Python version:**

    ```bash
    # Clean old artifacts
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -name "*.pyc" -delete

    # Rebuild with target Python version
    pip install -r requirements.txt --target .python_packages/lib/site-packages
    ```

2. **Deploy with remote build enabled:**

    ```azurecli
    az functionapp deployment source config-zip --name <app-name> --resource-group <rg> --src <package.zip> --build-remote true
    ```

    Required app settings for remote build:
    - `ENABLE_ORYX_BUILD=true`
    - `SCM_DO_BUILD_DURING_DEPLOYMENT=true`

3. **Verify the Function App runtime is set to the target version before deploying:**

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --linux-fx-version "PYTHON|<target-version>"
    ```

    > [!IMPORTANT]
    > Set the runtime version **before** deploying so the remote build compiles dependencies against the correct Python version.

4. **For module collision or module-not-found errors:** Set `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to `1` in app settings to isolate worker dependencies from the host. This setting has no effect on Python 3.13 and later, where isolation is built-in.

5. **For network-restricted environments:** If remote build fails, build locally on the target Python version and deploy a pre-built package:

    ```azurecli
    az functionapp deployment source config-zip --name <app-name> --resource-group <rg> --src <package.zip>
    ```

    Set `SCM_DO_BUILD_DURING_DEPLOYMENT=false` to skip remote build.

## Extension bundle upgrade failures

### Symptoms

- SSL connection errors during startup after Node.js or runtime upgrade.
- HTTP 409 Conflict when trying to save `host.json` changes in the portal.
- Portal shows "deprecated extension bundle version" warning.
- Functions fail after upgrading extension bundle version.

### Cause

| Symptom | Likely cause |
|---------|--------------|
| SSL/connection errors at startup | Outdated extension bundle range; runtime can't download bundle from CDN |
| HTTP 409 Conflict | Function App uses run-from-package deployment; files are read-only |
| Functions fail after bundle upgrade | Binding incompatibility between extension bundle v4 and legacy code patterns |

### Resolution

1. **Update `host.json` extension bundle configuration:**

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

2. **If using run-from-package or CI/CD deployment:**
    - Don't edit `host.json` in the portal. Update it in your source repository.
    - Remove stale ZIP packages from `/home/data/SitePackages/` if old packages conflict with new content.
    - Redeploy after changes.

3. **Verify CDN endpoint access:**
    - The Function App must have outbound access to `functionscdn.azureedge.net` for extension bundle downloads.
    - If using VNet integration with egress restrictions, allowlist this endpoint.

4. **Test the upgrade in a staging environment first.** If the hosting plan supports deployment slots, use slot-based deployment for safe rollback.

## Functions runtime version migration (v1/v2/v3 to v4)

### Symptoms

- Pre-upgrade validator won't run for apps on runtime v2.
- Timer-triggered functions fail with "%CronExpression% did not resolve to a value."
- Functions are unreachable after changing `FUNCTIONS_EXTENSION_VERSION`.
- Portal shows runtime error after version change.

### Cause

| Symptom | Likely cause |
|---------|--------------|
| Validator won't run | App is on v1 or v2; validator only supports v3 → v4 path |
| CRON placeholder error | Timer trigger app settings not present in the deployment slot |
| Runtime unreachable | Code still targets older runtime APIs or missing dependencies |
| Portal runtime error | Configuration changed without deploying updated application code |

### Resolution

1. **For v3 → v4 migration:** Use the pre-upgrade validator:
    - Navigate to the Function App → **Diagnose and solve problems** → search for *"Functions 4.x Pre-Upgrade Validator"*.
    - Address all flagged issues before changing the runtime version.

2. **For v1 or v2 → v4 migration:** The pre-upgrade validator doesn't support these paths. Follow the manual migration guide:
    - [Migrate from v1 to v4](/azure/azure-functions/migrate-version-1-version-4)
    - [Migrate from v3 to v4](/azure/azure-functions/migrate-version-3-version-4)

3. **Use deployment slots for safe migration:**

    ```azurecli
    # Create a staging slot
    az functionapp deployment slot create --name <app-name> --resource-group <rg> --slot staging

    # Update the slot to v4
    az functionapp config appsettings set --name <app-name> --resource-group <rg> --slot staging --settings FUNCTIONS_EXTENSION_VERSION=~4

    # Validate, then swap
    az functionapp deployment slot swap --name <app-name> --resource-group <rg> --slot staging
    ```

    Set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` on both slots before swapping.

4. **Ensure all timer trigger CRON expressions are defined as app settings** in the target slot, not just in the production slot.

## Move a .NET Framework 4.6.1 app from Functions runtime v1 to v4

.NET Framework 4.6.1 has reached end-of-life, so apps should be upgraded to .NET Framework 4.8. In Functions v4, you can run a .NET Framework 4.8 app in out-of-process (isolated) mode. For more information, see the [isolated process guide](/azure/azure-functions/dotnet-isolated-process-guide).

## Worker process exit codes

### Symptoms

- Error: "dotnet exited with code 150 (0x96)."
- Error: "Failed to start language worker process for runtime: dotnet-isolated."
- Error: "Node process exited with code 1."

### Cause

| Exit code | Likely cause |
|-----------|--------------|
| 150 (0x96) | .NET target framework not supported on the current hosting plan, or stale hosting artifacts from a previous runtime. Check [Supported languages](/azure/azure-functions/supported-languages) for plan compatibility. |
| 1 (Node.js) | Syntax error or module loading failure in the Node.js application |
| General worker failure | Dependencies compiled for wrong OS/architecture, or network blocking required endpoints |

### Resolution

1. **For exit code 150:**
    - Verify the target framework is supported on your hosting plan. Not all .NET versions are available on all plan types — check [Supported languages](/azure/azure-functions/supported-languages) for details.
    - If previously upgraded in-place, try deleting and recreating the Function App to get a fresh hosting container.
    - Ensure deployment produces a clean publish output without stale artifacts.

2. **For Node.js exit code 1:**
    - Check that the Node.js version in the cloud matches your local development version.
    - Review the application's entry point for syntax not supported by the configured version.
    - Verify all dependencies are compatible with the target Node.js version.

3. **General guidance:**
    - Check Application Insights for detailed startup exception traces.
    - Use the **Diagnose and solve problems** → **Function App Down or Reporting Errors** detector.
    - Verify outbound connectivity to required platform endpoints.

## SSL/TLS errors during startup

### Symptoms

- Error: "The SSL connection could not be established."
- Error: "Unable to read data from the transport connection."
- Error: "Connection reset by peer."
- Error: "RemoteCertificateNameMismatch."
- Errors appear during Function App startup, before customer code executes.

### Cause

These errors typically occur when the Function App can't reach required platform endpoints during startup. Common causes:

- **Egress restrictions** block access to `functionscdn.azureedge.net` (extension bundle CDN) or other platform endpoints.
- **Private DNS misconfiguration** causes requests to resolve to wrong endpoints (certificate name mismatch).
- **NAT gateway or forced tunneling** routes startup traffic through a path that blocks or modifies TLS connections.

### Resolution

1. **Allow required outbound endpoints:**
    - `functionscdn.azureedge.net` — extension bundle downloads
    - Storage account endpoints (blob, file, queue, table)
    - `login.microsoftonline.com` — authentication
    - Platform-specific endpoints per [App Service networking documentation](/azure/app-service/networking-features)

2. **For private endpoint/DNS issues:**
    - Verify DNS resolution from within the VNet returns correct private IP addresses.
    - Check for duplicate or stale private endpoint A records.
    - Confirm DNS zones are linked to the correct VNet.

3. **For NAT gateway issues:**
    - Remove NAT gateway from the Function App's subnet or ensure it doesn't interfere with platform endpoints.
    - Test with egress restrictions temporarily relaxed to confirm the endpoint is the issue.

## Functions not appearing after version upgrade

### Symptoms

- Functions list in the portal is empty after changing the language version.
- Message: "No job functions found."
- Function metadata loading fails during startup.

### Cause

| Scenario | Likely cause |
|----------|--------------|
| Python version changed without redeploying | Old dependencies incompatible with new Python version |
| Node.js upgraded without programming model migration | Older programming model can't index functions on newer Node.js versions |
| .NET isolated migration incomplete | Deployed artifacts still target in-process model |
| Runtime version changed to unsupported value | Version set to a value not yet supported — check [Supported languages](/azure/azure-functions/supported-languages) |

### Resolution

1. **Verify the configured runtime version is actually supported:**

    See [Supported languages in Azure Functions](/azure/azure-functions/supported-languages).

2. **Check that deployed artifacts match the configuration:**
    - For .NET: Ensure deployed DLLs target the correct framework.
    - For Python: Ensure dependencies were rebuilt for the target version.
    - For Node.js: Ensure you're using the correct programming model for your target version.

3. **Review startup logs:**
    - **Diagnose and solve problems** → **Function App Down or Reporting Errors**
    - Application Insights traces for worker startup errors
    - Platform logs in `/home/LogFiles/` (if accessible)

4. **If you recently changed the version and functions disappeared:**
    - Revert to the previous working version to restore functionality.
    - Plan the upgrade with a proper rebuild and redeploy cycle.

## Find Function Apps on retired runtime versions

1. Navigate to your Function App in the [Azure portal](https://portal.azure.com).
1. Select **Diagnose and solve problems** to open [Azure Function App diagnostics](/azure/azure-functions/functions-diagnostics).
1. In the **Search** bar, type *Updating Function App Language or Runtime Version* to run it directly.
1. In the diagnostic report, scroll down and select **List All Function App** > **View Details**.
1. Set the search filters and select **Show** to get the list of Function Apps in the current subscription.

Alternately, you can use the App Service REST API ([GetConfiguration](/rest/api/appservice/web-apps/get-configuration)) to determine this. `LinuxFxVersion` and `WindowsFxVersion` provide the version information.

For bulk discovery across subscriptions, see [Keep Your Azure Functions Up to Date: Identify Apps Running on Retired Versions](https://techcommunity.microsoft.com/blog/AppsonAzureBlog/keep-your-azure-functions-up-to-date-identify-apps-running-on-retired-versions/4398187).

## A migrated Function App isn't starting or has runtime issues

- For .NET apps, remember to update the code to the target .NET version before building and deploying.
- Double-check the runtime version of the app in the [Azure portal](https://portal.azure.com).
- For Windows apps, you must also set `netFrameworkVersion` by using CLI or PowerShell.
- Make sure you're using the 2.x or later [extension bundles](/azure/azure-functions/functions-versions#minimum-extension-versions), as recommended. Version 4.x of the Functions runtime requires versions 2.x or 3.0.0.
- Logging to Azure Storage using `AzureWebJobsDashboard` is no longer supported in 4.x. Instead, use [Application Insights](/azure/azure-functions/functions-monitoring) for monitoring.
- If you receive a message that Azure Function App runtime is unreachable and you're sharing storage accounts, see [Host ID considerations](/azure/azure-functions/storage-considerations#host-id-considerations).
- Azure Functions 4.x doesn't support Node.js 10 and 12, Python 3.6, and PowerShell 6. For more information, see [Language versions supported for the v4 runtime](/azure/azure-functions/supported-languages#languages-by-runtime-version).
- For Python functions, if there are errors related to module collision and module not found, try setting `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to `1` in app settings.
- For runtime issues, from the **Diagnose and Solve Problems** option in the [Azure portal](https://portal.azure.com), search for **Function app down or reporting errors** and review the diagnostic report for error messages and solutions. Also review the **Function Configuration checks** detector to make sure that the configuration is correct.

## More resources

- [Azure Functions language stack support policy](/azure/azure-functions/language-support-policy)
- [Supported languages in Azure Functions](/azure/azure-functions/supported-languages)
- [Migrate .NET apps to isolated worker model](/azure/azure-functions/migrate-dotnet-to-isolated-model)
- [Migrate from Functions v3 to v4](/azure/azure-functions/migrate-version-3-version-4)
- [Migrate from Functions v1 to v4](/azure/azure-functions/migrate-version-1-version-4)
- [Upgrade to Node.js programming model v4](/azure/azure-functions/functions-node-upgrade-v4)
- [Update language stack versions in Azure Functions](/azure/azure-functions/update-language-versions)
- [Keep Your Azure Functions Up to Date: Identify Apps Running on Retired Versions](https://techcommunity.microsoft.com/blog/AppsonAzureBlog/keep-your-azure-functions-up-to-date-identify-apps-running-on-retired-versions/4398187)

