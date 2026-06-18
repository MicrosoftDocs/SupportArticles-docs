---
title: Troubleshoot Function App language and runtime version upgrades
description: Resolve common issues when upgrading Azure Function App language versions, runtime versions, or migrating to the isolated worker model.
ms.service: azure-functions
ms.topic: troubleshooting
ms.date: 06/17/2026
ms.custom: sap:Configuring and Managing Function Apps/Updating Function App Language Version
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

## .NET in-process to isolated worker model migration

### Symptoms

- Portal shows a deprecation notification for the .NET in-process model.
- After changing `FUNCTIONS_WORKER_RUNTIME` to `dotnet-isolated`, the app fails to start.
- Functions return HTTP 500 with JSON deserialization errors after migration.
- Portal displays "runtime mismatch" warning between configuration and deployed artifacts.
- Functions aren't listed in the portal after migration.

### Cause

Migration from the in-process model to the isolated worker model requires both application code changes and platform configuration updates. Support for the in-process model ends on November 10, 2026. Changing only the app setting without updating the code, or updating the code without changing platform settings, causes a mismatch that prevents the Function App from starting correctly.

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

For complete migration guidance, see [Migrate .NET apps from the in-process model to the isolated worker model](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-dotnet-to-isolated-model).

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
| Functions not indexed | Older programming model used with a Node.js version that requires a newer model. Check [supported languages](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) for compatibility. |
| Trigger sync "Bad Request" | Certain newer Node.js versions require 64-bit platform on Windows |
| Startup timeout (AZFD0005) | Heavy initialization in `index.js` exceeding host startup tolerance |
| SSL connection errors during startup | Outdated extension bundle can't reach CDN endpoint |

### Resolution

1. **Check programming model compatibility:**

    Newer Node.js versions may require a newer programming model. Check [Supported languages in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) to verify which programming model your target Node.js version requires.

    If migration is needed, see [Upgrade to Azure Functions Node.js programming model v4](https://learn.microsoft.com/en-us/azure/azure-functions/functions-node-upgrade-v4).

2. **Verify version configuration matches deployment:**
    - **Windows:** Check `WEBSITE_NODE_DEFAULT_VERSION` app setting matches your code target.
    - **Linux:** Check `LinuxFxVersion` via CLI:

        ```azurecli
        az functionapp config show --name <app-name> --resource-group <rg> --query "linuxFxVersion" -o tsv
        ```

3. **If using a newer Node.js version on Windows:** If the Function App uses a 32-bit worker process, try switching to 64-bit. This is typically the default for newer apps but may need to be changed on older Function Apps:

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

> [!NOTE]
> Running Python functions on Windows Function Apps isn't supported. Use Linux hosting instead. If your Function App is on Windows, migrate to a Linux-based plan before upgrading the Python version.

### Cause

| Symptom | Likely cause |
|---------|--------------|
| ModuleNotFoundError | Deployment package contains dependencies built for previous Python version |
| `_cffi_backend` missing | Native C extension not compiled for target Python version |
| Functions not found | Local dev container or Docker image not updated to target Python version |
| 503 on ZIP deploy | Deploying a package built for an older Python version to a newer runtime |
| Remote build failure | Network restrictions blocking Oryx build endpoints |

### Resolution

1. **Deploy with remote build (recommended):**

    Remote build automatically compiles dependencies for the correct Python version on Azure. This is the safest approach and avoids local environment mismatches.

    First, ensure the following app settings are configured:
    - `ENABLE_ORYX_BUILD=true`
    - `SCM_DO_BUILD_DURING_DEPLOYMENT=true`

    Then set the target Python version and deploy:

    ```azurecli
    az functionapp config set --name <app-name> --resource-group <rg> --linux-fx-version "PYTHON|<target-version>"
    ```

    ```azurecli
    az functionapp deployment source config-zip --name <app-name> --resource-group <rg> --src <package.zip> --build-remote true
    ```

    > [!IMPORTANT]
    > Set the runtime version **before** deploying so the remote build compiles dependencies against the correct Python version.

2. **Alternative: Local build (for restricted environments only):**

    If remote build isn't possible (for example, due to network restrictions), rebuild locally using the target Python binary explicitly:

    ```bash
    # Clean old artifacts
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -name "*.pyc" -delete

    # Rebuild with the TARGET Python version (e.g., 3.11)
    python3.11 -m pip install -r requirements.txt --target .python_packages/lib/site-packages
    ```

    > [!IMPORTANT]
    > Running `pip install` with a different Python version than the target (for example, building with Python 3.9 but deploying to Python 3.11) results in incompatible packages. Always use the target Python binary.

3. **For additional Python troubleshooting:** If module errors persist after rebuilding, see [Troubleshoot Python errors in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/recover-python-functions?tabs=vscode%2Cbash&pivots=python-mode-decorators) for guidance on resolving `ModuleNotFoundError`, dependency conflicts, and other Python-specific issues.

4. **Check for version-specific limitations:** Some Python versions may not support certain features (for example, worker extensions). Check [Supported languages in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) for known limitations of your target version.

5. **For network-restricted environments:** If remote build fails, build locally on the target Python version and deploy a pre-built package:

    ```azurecli
    az functionapp deployment source config-zip --name <app-name> --resource-group <rg> --src <package.zip>
    ```

    Set `SCM_DO_BUILD_DURING_DEPLOYMENT=false` to skip remote build.

6. **For module collision errors after upgrade:** Set the `PYTHON_ISOLATE_WORKER_DEPENDENCIES` application setting to `1`. This isolates the worker's dependencies from the Function host's dependencies and resolves conflicts between system packages and your application packages. This setting has no effect on Python 3.13 and later, where dependency isolation is built-in.

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
    - The Function App must have outbound access to `cdn.functions.azure.com` for extension bundle downloads.
    - If using VNet integration with egress restrictions, allowlist this endpoint.

4. **Test the upgrade in a staging environment first.** If the hosting plan supports deployment slots, use slot-based deployment for safe rollback.

## Functions runtime version migration (v1/v2/v3 → v4)

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
    - [Migrate from v1 to v4](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-1-version-4)
    - [Migrate from v3 to v4](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-3-version-4)

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

5. **Find all Function Apps that need upgrading:** In the Azure portal, navigate to any Function App → **Diagnose and solve problems** → search for *"Updating Function App Language or Runtime Version"*. Expand **List All Function Apps** to see all apps in the subscription that run on outdated versions.

## Worker process exit codes

### Symptoms

- Error: "dotnet exited with code 150 (0x96)."
- Error: "Failed to start language worker process for runtime: dotnet-isolated."
- Error: "Node process exited with code 1."

### Cause

| Exit code | Likely cause |
|-----------|--------------|
| 150 (0x96) | .NET target framework not supported on the current hosting plan, or stale hosting artifacts from a previous runtime. Check [Supported languages](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) for plan compatibility. |
| 1 (Node.js) | Syntax error or module loading failure in the Node.js application |
| General worker failure | Dependencies compiled for wrong OS/architecture, or network blocking required endpoints |

### Resolution

1. **For exit code 150:**
    - Verify the target framework is supported on your hosting plan. Not all .NET versions are available on all plan types — check [Supported languages](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) for details.
    - If previously upgraded in-place, try deleting and recreating the Function App to get a fresh hosting container.
    - Ensure deployment produces a clean publish output without stale artifacts.

2. **For Node.js exit code 1:**
    - Check that the Node.js version in the cloud matches your local development version.
    - Review the application's `index.js` for syntax not supported by the configured version.
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

- **Egress restrictions** block access to `cdn.functions.azure.com` (extension bundle CDN) or other platform endpoints.
- **Private DNS misconfiguration** causes requests to resolve to wrong endpoints (certificate name mismatch).
- **NAT gateway or forced tunneling** routes startup traffic through a path that blocks or modifies TLS connections.

### Resolution

1. **Allow required outbound endpoints:**
    - `cdn.functions.azure.com` — extension bundle downloads
    - Storage account endpoints (blob, file, queue, table)
    - `login.microsoftonline.com` — authentication
    - Platform-specific endpoints per [App Service networking documentation](https://learn.microsoft.com/en-us/azure/app-service/networking-features)

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
| Runtime version changed to unsupported value | Version set to a value not yet supported — check [Supported languages](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages) |

### Resolution

1. **Verify the configured runtime version is actually supported:**

    See [Supported languages in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages).

2. **Check that deployed artifacts match the configuration:**
    - For .NET: Ensure deployed DLLs target the correct framework.
    - For Python: Ensure dependencies were rebuilt for the target version.
    - For Node.js: Ensure you're using the correct programming model for your target version. Check [Supported languages](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages).

3. **Review startup logs:**
    - **Diagnose and solve problems** → **Function App Down or Reporting Errors**
    - Application Insights traces for worker startup errors
    - Platform logs in `/home/LogFiles/` (if accessible)

4. **If you recently changed the version and functions disappeared:**
    - Revert to the previous working version to restore functionality.
    - Plan the upgrade with a proper rebuild and redeploy cycle.

## More resources

- [Azure Functions language stack support policy](https://learn.microsoft.com/en-us/azure/azure-functions/language-support-policy)
- [Supported languages in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/supported-languages)
- [Migrate .NET apps to isolated worker model](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-dotnet-to-isolated-model)
- [Migrate from Functions v3 to v4](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-3-version-4)
- [Upgrade to Node.js programming model v4](https://learn.microsoft.com/en-us/azure/azure-functions/functions-node-upgrade-v4)
- [Update language stack versions in Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/update-language-versions)
- [Keep Your Azure Functions Up to Date: Identify Apps Running on Retired Versions](https://techcommunity.microsoft.com/blog/AppsonAzureBlog/keep-your-azure-functions-up-to-date-identify-apps-running-on-retired-versions/4398187)
