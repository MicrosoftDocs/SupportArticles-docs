---
title: Upgrade the Azure Functions app runtime version or language version
description: Describes how to upgrade the Azure Functions runtime to v4 and resolve issues during the upgrade.
ms.date: 08/24/2023
ms.reviewer: gasridha, v-sidong
---
# Troubleshoot common issues during Azure Runtime upgrade

This article describes how to resolve some of the common issues that may occur during the update of the function app language or runtime version, like runtime being unreachable and modules not being found.

## Actions to take if you receive an email "Action recommended: Update your Azure Functions apps to use .NET 6."

- Extended support for Microsoft .NET Core 3.1 ended on December 3, 2022. Azure Functions runtime v3 is based on .NET core 3.1. We recommend that you [update your function app](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version) to runtime version 4.x, which uses .NET 6 and has long-term support. After December 3, 2022, your apps aren't eligible for new features, security patches, performance optimizations, or support until you upgrade them to Functions runtime version 4.x.

- Your Functions apps on runtime v3 will continue to run, and your applications aren't impacted. You can deploy code to these Functions applications after this date. But we may remove the ability for you to create applications targeting the Functions runtime v3 using common paths.

- For more information and migration guidance, see:

  - [Functions runtime versions](/azure/azure-functions/functions-versions)
  - [Migrate apps from Azure Functions version 3.x to version 4.x](/azure/azure-functions/migrate-version-3-version-4)
  - [Migrate apps from Azure Functions version 1.x to version 4.x](/azure/azure-functions/migrate-version-1-version-4)

## Validate function app's compatibility for runtime v4

- Navigate to your function app in the [Azure portal](https://portal.azure.com). Select **Diagnose and solve problems** to open [Azure Functions diagnostics](/azure/azure-functions/functions-diagnostics). In the **Search** bar, type *Updating Function App Language or Runtime Version* to run it directly. The diagnostic report includes guidance on the update. After validation completes, follow the recommendations and address any issues in your app.
- We also provide a [pre-upgrade validator](/azure/azure-functions/migrate-version-3-version-4#run-the-pre-upgrade-validator) to help you identify potential issues when migrating your function app to 4.x. From the same diagnostics search bar, type *Functions 4.x Pre-Upgrade Validator* to run it directly. After validation completes, follow the recommendations and address any issues in your app.
- We strongly recommend [upgrading your local project environment](/azure/azure-functions/migrate-version-3-version-4#upgrade-your-local-project) to version 4.x. Fully test your app locally using version 4.x of the Azure Functions core tools.
- Consider using a [staging slot](/azure/azure-functions/migrate-version-3-version-4#upgrade-using-slots) to test and verify your app in Azure on the new runtime version before deploying to a production slot. Remember to set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` for migration with slots.

## Change the Functions runtime version for Windows

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set the `netFrameworkVersion` site setting to target .NET 6. `netFrameworkVersion` is a SiteConfig setting, not an app setting. And it's not directly available in the Azure portal. But you can set it by using [Azure Resource Explorer](https://azure.microsoft.com/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/) or [Azure CLI/PowerShell](/azure/azure-functions/functions-versions#migrate-without-slots).

For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Change the Functions runtime version for Linux

1. Set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
1. Set `LinuxFxVersion`, by using Command Line Interface (CLI), to `<Language>|<LanguageVersion>`, based on the language used. For more information, see [Using LinuxFxVersion for Linux Function Apps](https://github.com/Azure/azure-functions-host/wiki/Using-LinuxFxVersion-for-Linux-Function-Apps). For example, to update to .NET 6, you can set `LinuxFxVersion` to `dotnet|6.0` and `FUNCTIONS_EXTENSION_VERSION` to `~4`.

For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Get a list of supported languages by the runtime version

See the [list of supported languages by the runtime version](/azure/azure-functions/supported-languages#languages-by-runtime-version).

## Update the language version setting for the function app after updating the code

- PowerShell: In the [Azure portal](https://portal.azure.com), set the `PowerShell Core version`. For more information, see [Change the PowerShell version](/azure/azure-functions/functions-reference-powershell#changing-the-powershell-version).
- Python: Set `linuxFxVersion` to `python|3.x`. For more information, see [Change the Python version](/azure/azure-functions/functions-reference-python#changing-python-version).
- Java: Specify the language version by using `-DjavaVersion` as 11 or 17. For more information, see [Specify the deployment version](/azure/azure-functions/functions-reference-java#specify-the-deployment-version).
- Node, JavaScript: For Windows, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting to `~16`. For Linux, set `linuxFxVersion`, by using CLI, to `node|16`. For more information, see [Set the Node version](/azure/azure-functions/functions-reference-node#setting-the-node-version).

## Azure Functions Proxies usage

Support for proxies is available again in version 4.x so that you can successfully upgrade your function apps to the latest runtime version. However, we recommend that you switch to integrating your function apps with Azure API Management as soon as possible. API Management lets you take advantage of a more complete set of features to define, secure, manage, and monetize your Functions-based APIs. For more information, see [How to migrate to APIM](/azure/azure-functions/functions-proxies#migration) and [Integrate Functions with APIM using Visual Studio](/azure/azure-functions/openapi-apim-integrate-visual-studio).

## Get a list of all the Azure Functions apps that use runtime version 1.x, 2.x, or 3.x

1. Navigate to your function app in the [Azure portal](https://portal.azure.com).
1. Select **Diagnose and solve problems** to open [Azure Functions diagnostics](/azure/azure-functions/functions-diagnostics).
1. In the **Search** bar, type *Updating Function App Language or Runtime Version* to run it directly.
1. In the diagnostic report, scroll down and select **List All Function App** > **View Details**.
1. Set the search filters and select **Show** to get the list of functions apps in the current subscription.

Alternately, you can use App Service REST API calls ([GetConfiguration](/rest/api/appservice/web-apps/get-configuration)) to determine this. `LinuxFxVersion` and `WindowsFxVersion` provide the version information.

## Move a .NET Framework 4.6.1 app from Functions runtime v1 to v4

.NET Framework 4.6.1 has reached end-of-life, so apps should be upgraded to .NET Framework 4.8. In Functions v4, you can run a .NET framework 4.8 app in out-of-process mode. For more information, see the [isolated process guide](/azure/azure-functions/dotnet-isolated-process-guide).

## A migrated function app isn't starting or has some runtime issues

- For .NET apps, remember to update the code to .NET 6 before building and deploying.
- Double-check the runtime version of the app in the [Azure portal](https://portal.azure.com).
- For Windows apps, you must also set `netFrameworkVersion` by using CLI or PowerShell.
- Make sure you're using the 2.x or later [extension bundles](/azure/azure-functions/functions-versions#minimum-extension-versions), as recommended. Version 4.x of the Functions runtime requires versions 2.x or 3.0.0.
- Logging in to Azure Storage using *AzureWebJobsDashboard* is no longer supported in 4.x. Instead, use [Application Insights](/azure/azure-functions/functions-monitoring) for monitoring.
- If you receive a message that Azure Functions runtime is unreachable and you're sharing storage accounts, see [Host ID considerations](/azure/azure-functions/storage-considerations#host-id-considerations).
- Azure Functions 4.x doesn't support Node.js 10 and 12, Python 3.6, and PowerShell 6. For more information, see [Language versions supported for the v4 runtime](/azure/azure-functions/supported-languages#languages-by-runtime-version).
- For Python functions, if there are errors related to module collision and module not found, try setting `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to *1* in app settings.
- Review [Migrating existing function apps](/azure/azure-functions/functions-versions#migrating-existing-function-apps).
- For runtime issues, from the **Diagnose and Solve Problems** option in the [Azure portal](https://portal.azure.com), search for **Function app down or reporting errors** and review the diagnostic report for error messages and solutions. Also review the **Function Configuration checks** detector to make sure that the configuration is correct.
- Review the blog [Issues when upgrading Azure function apps to V4](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/issues-you-may-meet-when-upgrading-azure-function-app-to-v4/ba-p/3288983) for additional troubleshooting tips.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
