---
title: Upgrade Function app runtime version or language version
description: Get answers to frequently asked questions about upgrading Function app runtime version or language version.
author: gasridha
ms.author: gasridha
ms.service: cloud-services
ms.date: 11/08/2023
ms.reviewer: 
---
# FAQs on how to upgrade Azure Functions runtime to v4 and resolve common issues during an upgrade

Review the following frequently asked questions (FAQ) for guidance to learn about upgrading Azure Functions runtime to v4 and resolving issues during the upgrade, such as runtime being unreachable, modules not being found, and other issues.

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## I received an email "Action recommended: Update your Azure Functions apps to use .NET 6." What should I do?
 
* Extended support for Microsoft .NET Core 3.1 has ended on December 3, 2022. Azure Functions runtime v3 is based on .Net core 3.1. We suggest updating Functions applications to [runtime version 4.x](https://learn.microsoft.com/azure/azure-functions/dotnet-isolated-process-guide#supported-versions), which uses .NET 6 and has long-term support. After December 3, 2022, your apps won't be eligible for new features, security patches, performance optimizations, or support until you upgrade them to Functions runtime version 4.x.
 
* Note that your Functions apps on runtime v3 will continue to run and your applications will not be impacted. You'll be able to deploy code to these Function applications after this date, but we may be removing the ability for customers to create applications targeting v3 of the Functions runtime using common paths. 
 
* To avoid potential service disruptions or security vulnerabilities, [update your Function app](https://learn.microsoft.com/azure/azure-functions/set-runtime-version?tabs=portal#view-and-update-the-current-runtime-version) to runtime version 4.x, which uses .NET 6, before December 3, 2022. 

* For more information, see [Functions runtime versions](https://learn.microsoft.com/azure/azure-functions/functions-versions).

* Migration guidance can be found here:
-	[Migrate apps from Azure Functions version 3.x to version 4.x](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-3-version-4?tabs=net7%2Cazure-cli%2Cwindows&pivots=programming-language-csharp)
-	[Migrate apps from Azure Functions version 1.x to version 4.x](https://learn.microsoft.com/en-us/azure/azure-functions/migrate-version-1-version-4?tabs=v4%2Cazure-cli%2Cwindows&pivots=programming-language-csharp)


## How can I validate my Function app's compatibility for runtime v4?
 
* Azure Functions provides a pre-upgrade validator to help you identify potential issues when migrating your function app to 4.x. In the Azure portal, go to the **Diagnose and solve problems** pane, in **Function App Diagnostics** run the **Functions 4.x Pre-Upgrade Validator** and follow the recommendations.
* We strongly recommend upgrading your local project environment to version 4.x. Fully test your app locally using version 4.x of the Azure Functions core tools.
* Consider using a staging slot to test and verify your app in Azure on the new runtime version first before deploying to a production slot. Remember to set `WEBSITE_OVERRIDE_STICKY_EXTENSION_VERSIONS=0` for [migration with slots]( https://learn.microsoft.com/azure/azure-functions/functions-versions?tabs=azure-cli%2Cin-process%2Cv4&pivots=programming-language-csharp#migrate-using-slots).
 
## How can I change Function runtime version for Windows?
 
* You'll need to set `FUNCTIONS_EXTENSION_VERSION`, which is an app setting in the Azure portal **Configuration** pane, to `~4`. See [Change runtime version](https://learn.microsoft.com/azure/azure-functions/set-runtime-version?tabs=portal#view-and-update-the-current-runtime-version).
* Also set the `netFrameworkVersion` site setting to target .NET 6. `netFrameworkVersion` is a SiteConfig setting, not an app setting. And it’s not directly available in the Azure portal. But you can set it by using [Azure Resource Explorer](https://azure.microsoft.com/blog/azure-resource-explorer-a-new-tool-to-discover-the-azure-api/), or you can use [Azure CLI/PowerShell](https://learn.microsoft.com/azure/azure-functions/functions-versions?tabs=azure-cli%2Cin-process%2Cv4&pivots=programming-language-csharp#migrate-without-slots).
* For more information, see [Functions runtime versions](https://learn.microsoft.com/azure/azure-functions/functions-versions).
 
## How can I change the Function runtime version for Linux?
 
* You'll need to set `FUNCTIONS_EXTENSION_VERSION`, which is an app setting in the Azure portal **Configuration** pane, to `~4`. See [Change runtime version](https://learn.microsoft.com/azure/azure-functions/set-runtime-version?tabs=portal#view-and-update-the-current-runtime-version).
* Additionally, set `LinuxFxVersion`, by using CLI, to `language|language version`, based on the language used. See [Change runtime version](https://github.com/Azure/azure-functions-host/wiki/Using-LinuxFxVersion-for-Linux-Function-Apps).
* For example, for updating to DOTNET 6, you'd set `LinuxFxVersion` to `dotnet|6.0` and set `FUNCTIONS_EXTENSION_VERSION` to `~4`.
* For more information, see [Functions runtime versions](https://learn.microsoft.com/azure/azure-functions/functions-versions).
 
## Supported languages by runtime version
 
See the [list of supported languages by runtime version](https://docs.microsoft.com/azure/azure-functions/supported-languages#languages-by-runtime-version).
 
## How can I update the language version setting for the Function app after updating the code?
 
* PowerShell: Set the `PowerShell Core version` by using the portal: **Configuration** > **General Settings** tab. See [Change the PowerShell version](https://learn.microsoft.com/azure/azure-functions/functions-reference-powershell?tabs=portal#changing-the-powershell-version).
* Python: Set `linuxFxVersion` to `python|3.x`. For more information, see [Change the Python version](https://docs.microsoft.com/azure/azure-functions/functions-reference-python?tabs=asgi%2Cazurecli-linux%2Capplication-level#changing-python-version).
* Java: Specify the language version by using `-DjavaVersion` as 11 or 17 (Java 17 is in preview). For more information, see [Specify the deployment version](https://docs.microsoft.com/azure/azure-functions/functions-reference-java?tabs=bash%2Cconsumption#specify-the-deployment-version).
* Node, Javascript: For Windows, set the `WEBSITE_NODE_DEFAULT_VERSION` app setting to `~16`. For Linux, set `linuxFxVersion`, by using CLI, to `node|16`. For more information, see [Set the node version](https://learn.microsoft.com/azure/azure-functions/functions-reference-node?tabs=v2-v3-v4-export%2Cv2-v3-v4-done%2Cv2%2Cv2-log-custom-telemetry%2Cv2-accessing-request-and-response%2Cwindows-setting-the-node-version#setting-the-node-version).
 
## I want to use Azure Function proxies. Is this available in Function runtime v4?
 
Support for proxies is available again in version 4.x so that you can successfully upgrade your function apps to the latest runtime version. As soon as possible, switch to integrating your function apps with Azure API Management. API Management lets you take advantage of a more complete set of features for defining, securing, managing, and monetizing your Functions-based APIs. For more information, see [How to migrate to APIM](https://learn.microsoft.com/azure/azure-functions/functions-proxies#migration) and [Integrate Functions with APIM using Visual Studio](https://learn.microsoft.com/azure/azure-functions/openapi-apim-integrate-visual-studio).
 
## Where can I get a list of all my Azure Functions apps that use runtime version 1.x or 2.x or 3.x?

You can use Appservice REST API calls to figure this out. [GetSiteConfig](https://learn.microsoft.com/rest/api/appservice/web-apps/get-configuration) LinuxFxVersion and WindowsFxVersion will provide the version. 
 
## How can I move a .NET Framework 4.6.1 app from Functions runtime v1 to v4?
 
.NET Framework 4.6.1 has reached end-of-life, so apps should be upgraded to .NET Framework 4.8. In Functions v4, you can run a .NET framework 4.8 app in out-of-process mode. For more information, see the [isolated process guide](https://learn.microsoft.com/azure/azure-functions/dotnet-isolated-process-guide).
 
## I have migrated my Function app, but it's not starting, or it has some runtime issues
 
* For .NET apps, remember to update the code to .NET 6 and then build and deploy.
* Double-check the runtime version in the Azure portal.
* For Windows apps, you must also set `netFrameworkVersion` by using CLI or PowerShell. For more information, see the FAQ above.
* Make sure you're using the 2.x or later extension bundles, as recommended. 4.x Functions runtime requires versions 2.* or 3.0.0.  
* Logging in to Azure Storage using *AzureWebJobsDashboard* is no longer supported in 4.x. Instead, use Application insights for monitoring. 
* If you receive a message that Azure functions runtime is unreachable and you're sharing storage accounts, review [Host ID considerations](https://learn.microsoft.com/azure/azure-functions/storage-considerations?tabs=azure-cli#host-id-considerations).
* See [Language versions supported for the v4 runtime](https://docs.microsoft.com/azure/azure-functions/supported-languages#languages-by-runtime-version). Also check the FAQ above. Node.js 10 and 12, Python 3.6, and PowerShell 6 aren't supported in Azure Functions 4.x.
* For Python functions, if there are module collision and module not found errors, try setting `PYTHON_ISOLATE_WORKER_DEPENDENCIES` in app settings to *1*.
* Review [language-wise breaking changes](https://learn.microsoft.com/azure/azure-functions/functions-versions?tabs=azure-cli%2Cin-process%2Cv4&pivots=programming-language-javascript#breaking-changes-between-3x-and-4x).
* For runtime issues, check the **Diagnose and Solve Problems** pane > **Function app down or reporting errors** detector for error messages and solutions. Also review the **Function Configuration checks** detector to make sure that the configuration is correct.
* Review our [troubleshooting guide: Issues when upgrading Azure function app to V4](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/issues-you-may-meet-when-upgrading-azure-function-app-to-v4/ba-p/3288983).
 
[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
