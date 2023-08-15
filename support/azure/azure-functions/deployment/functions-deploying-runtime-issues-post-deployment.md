---
title: Function app runtime issues post deployment 
description: Get answers to frequently asked questions about runtime issues in the Function app after content deployment.
ms.date: 08/15/2023
ms.reviewer: gasridha
---
# Resolve common runtime issues after deployment

If you're having issues with your application after deployment, it's important to determine whether the problem is related to deployment or to runtime. When you're having a *deployment* issue, this can cause the wrong set of files to get deployed to your function app, or it can cause some files to not get deployed at all. On the other hand, a *runtime* issue happens after deployment. The files in your **wwwroot** folder are exactly as they should be, but the function app isn't running correctly. When this happens, it's no longer relevant what technique you used to deploy your site. In this case, you should focus on what your code is doing at runtime and how it's failing, rather than how you deployed it.

Use the following guidance to learn about the common causes of runtime issues and to troubleshoot these issues.

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

## What are the common causes for application runtime issues after content deployment

Some of the common reasons for failure include:

* Network connectivity to the secure storage account, resulting in the function host not starting up.
* Your Azure Functions app may not be configured correctly. For example, incorrect runtime or language version, trigger connection strings, key vault settings, etc., which can lead to the function host not starting up.
* There could be an external dependency like a database or messaging system that's not set up correctly and is causing time-out errors.
* Sync triggers failed, which causes incorrect loading of functions.
* Your code could be making invalid assumptions about paths, like hard-coding something that exists only on your local machine.
* Something in the Azure Functions runtime sandbox environment might be blocking certain operations that work on your local machine.

## How can I troubleshoot runtime issues after content deployment

* Try manually restarting the Functions app to see if this resolves the issue.
* Run the [Azure Functions Diagnostics](/azure/azure-functions/functions-diagnostics) to quickly diagnose and solve common function app issues.
* Runtime issues after deployment can happen if the storage account used for the function app is either not accessible or the storage connection string has been changed or is incorrect. Verify the [storage connections are set up correctly](/azure/azure-functions/functions-recover-storage-account).
* If you've enabled Application Insights, review the [Application Insights logs](/azure/azure-functions/functions-monitoring) for your function to learn more about the full exception trace/error message that's causing errors.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
