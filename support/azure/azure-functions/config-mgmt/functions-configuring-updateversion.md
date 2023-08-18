---
title: Upgrade the Functions app runtime version or language version
description: Describes how to upgrade the Azure Functions runtime to v4 and resolve issues during the upgrade.
ms.date: 08/16/2023
ms.reviewer: gasridha, v-sidong
---
# Upgrade Azure Functions runtime to v4 and resolve common issues during the upgrade

This article describes how to upgrade the Azure Functions runtime to v4 and resolve issues during the upgrade, such as runtime being unreachable and modules not being found. For more information, see the following common issues and recommendations.

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## Received an email "Action recommended: Update your Azure Functions apps to use .NET 6."

- Extended support for Microsoft .NET Core 3.1 ended on December 3, 2022. Azure Functions runtime v3 is based on .NET core 3.1. We recommend that you update your apps to [runtime version 4.x](/azure/azure-functions/dotnet-isolated-process-guide#supported-versions), which uses .NET 6 and has long-term support. After December 3, 2022, your apps aren't eligible for new features, security patches, performance optimizations, or support until you upgrade them to Functions runtime version 4.x.

- Your Functions apps on runtime v3 continue to run, and your applications aren't impacted. You can deploy code to these Functions applications after this date. Still, we may remove the ability for customers to create applications targeting the Functions runtime v3 using common paths.

- To avoid potential service disruptions or security vulnerabilities, [update your function app](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version) to runtime version 4.x, which uses .NET 6, before December 3, 2022.

- For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

- Migration guidance can be found here:

  - [Migrate apps from Azure Functions version 3.x to version 4.x](/azure/azure-functions/migrate-version-3-version-4)
  - [Migrate apps from Azure Functions version 1.x to version 4.x](/azure/azure-functions/migrate-version-1-version-4)

## Validate function app's compatibility with runtime v4

- Azure Functions provides a pre-upgrade validator to help you identify potential issues when migrating your function app to 4.x. In the Azure portal, go to the **Diagnose and solve problems** pane. In **Function App Diagnostics**, run the **Functions 4.x Pre-Upgrade Validator** and follow the recommendations.
- We strongly recommend upgrading your local project environment to version 4.x. Fully test your app locally using version 4.x of the Azure Functions core tools.
- Consider using a staging slot to test and verify your app in Azure on the new runtime version before deploying to a production slot. Remember to set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` for [migration with slots]( /azure/azure-functions/functions-versions#migrate-using-slots).

## Change the Functions runtime version for Windows

- You need to set [FUNCTIONS_EXTENSION_VERSION](/azure/azure-functions/functions-app-settings), which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
- Also, set the `netFrameworkVersion` site setting to target .NET 6. `netFrameworkVersion` is a SiteConfig setting, not an app setting. And it's not directly available in the Azure portal. But you can set it by using [Azure Resource Explorer](https://azure.microsoft.com/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/) or [Azure CLI/PowerShell](/azure/azure-functions/functions-versions#migrate-without-slots).
- For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Change the Functions runtime version for Linux

- You need to set `FUNCTIONS_EXTENSION_VERSION`, which is an app setting in the Azure portal **Configuration** pane, to `~4`. For more information, see [Change the runtime version](/azure/azure-functions/set-runtime-version#view-and-update-the-current-runtime-version).
- Additionally, set `LinuxFxVersion`, by using Command Line Interface (CLI), to `language|language version`, based on the language used. For more information, see [Change the runtime version](https://github.com/Azure/azure-functions-host/wiki/Using-LinuxFxVersion-for-Linux-Function-Apps).
- For example, to update to DOTNET 6, you can set `LinuxFxVersion` to `dotnet|6.0` and `FUNCTIONS_EXTENSION_VERSION` to `~4`.
- For more information, see [Functions runtime versions](/azure/azure-functions/functions-versions).

## Get a list of supported languages by the runtime version

See the [list of supported languages by the runtime version](/azure/azure-functions/supported-languages#languages-by-runtime-version).

## Update the language version setting for the function app after updating the code

- PowerShell: Set the `PowerShell Core version` by using the Azure portal. For more information, see [Change the PowerShell version](/azure/azure-functions/functions-reference-powershell#changing-the-powershell-version).
- Python: Set `linuxFxVersion` to `python|3.x`. For more information, see [Change the Python version](/azure/azure-functions/functions-reference-python#changing-python-version).
- Java: Specify the language version by using `-DjavaVersion` as 11 or 17 (Java 17 is in preview). For more information, see [Specify the deployment version](/azure/azure-functions/functions-reference-java#specify-the-deployment-version).
- Node, JavaScript: For Windows, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting to `~16`. For Linux, set `linuxFxVersion`, by using CLI, to `node|16`. For more information, see [Set the Node version](/azure/azure-functions/functions-reference-node#setting-the-node-version).

## Azure Functions proxies are available in Functions runtime v4

Support for proxies is available again in version 4.x so that you can successfully upgrade your function apps to the latest runtime version. Switch to integrating your function apps with Azure API Management as soon as possible. API Management lets you take advantage of a more complete set of features to define, secure, manage, and monetize your Functions-based APIs. For more information, see [How to migrate to APIM](/azure/azure-functions/functions-proxies#migration) and [Integrate Functions with APIM using Visual Studio](/azure/azure-functions/openapi-apim-integrate-visual-studio).

## Get a list of all the Azure Functions apps that use runtime version 1.x, 2.x, or 3.x

You can use App Service REST API calls ([GetSiteConfig](/rest/api/appservice/web-apps/get-configuration)) to figure out this issue. `LinuxFxVersion` and `WindowsFxVersion` provide the version.

## Move a .NET Framework 4.6.1 app from Functions runtime v1 to v4

.NET Framework 4.6.1 has reached end-of-life, so apps should be upgraded to .NET Framework 4.8. In Functions v4, you can run a .NET framework 4.8 app in out-of-process mode. For more information, see the [isolated process guide](/azure/azure-functions/dotnet-isolated-process-guide).

## A migrated function app isn't starting or has some runtime issues

- For .NET apps, remember to update the code to .NET 6 before building and deploying.
- Double-check the runtime version in the Azure portal.
- For Windows apps, you must also set `netFrameworkVersion` by using CLI or PowerShell.
- Make sure you're using the 2.x or later extension bundles, as recommended. Version 4.x of the Functions runtime requires versions 2.x or 3.0.0.
- Logging in to Azure Storage using *AzureWebJobsDashboard* is no longer supported in 4.x. Instead, use Application Insights for monitoring.
- If you receive a message that Azure Functions runtime is unreachable and you're sharing storage accounts, see [Host ID considerations](/azure/azure-functions/storage-considerations#host-id-considerations).
- See [Language versions supported for the v4 runtime](/azure/azure-functions/supported-languages#languages-by-runtime-version). Azure Functions 4.x doesn't support Node.js 10 and 12, Python 3.6, and PowerShell 6.
- For Python functions, if there are errors related to module collision and module not found, try setting `PYTHON_ISOLATE_WORKER_DEPENDENCIES` to *1* in app settings.
- Review [language-wise breaking changes](/azure/azure-functions/functions-versions#breaking-changes-between-3x-and-4x).
- For runtime issues, check the **Diagnose and Solve Problems** pane > **Function app down or reporting errors** detector for error messages and solutions. Also review the **Function Configuration checks** detector to make sure that the configuration is correct.
- Review the [troubleshooting guide: Issues when upgrading Azure function apps to V4](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/issues-you-may-meet-when-upgrading-azure-function-app-to-v4/ba-p/3288983).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
