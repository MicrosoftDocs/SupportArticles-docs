---
title: Function app runtime issues post deployment 
description: Get answers to frequently asked questions about runtime issues in the Function app after content deployment.
ms.date: 08/17/2023
ms.reviewer: gasridha, v-jayaramanp
---

# Resolve common runtime issues after deployment

This article describes the common causes of runtime issues and provides solutions to  resolve these issues.

If you're having issues with your application after deployment, it's important to determine whether the problem is related to deployment or to runtime. A *deployment* issue can cause the wrong set of files to get deployed to your Function app, or it can cause some files to not get deployed at all. On the other hand, a *runtime* issue occurs after deployment. The files in your **wwwroot** directory are exactly as they should be, but the Function app isn't running correctly. When this scenario occurs, it's no longer relevant what technique you used to deploy your site. For a runtime issue, you should focus on what your code is doing at runtime and how it's failing, instead of how you deployed it.

## Common causes for application runtime issues after content deployment

Some common reasons for failure include the following items:

- The function host can't start because there's poor network connectivity to the secure storage account.
  - The storage account that's used for the Function app isn't accessible.
  - The storage connection string was changed or is incorrect.
- In the runtime sandbox environment of Azure Functions, something is blocking certain operations that work on your local computer.
- Your Azure Functions app isn't configured correctly. For example, the function host doesn't start up because of incorrect values in the following settings:
  - Incorrect runtime or language version.
  - Trigger connection strings.
  - Key vault settings.
- An external dependency (such as a database or messaging system) isn't set up correctly and is causing time-out errors.
- Sync triggers failed, which causes incorrect loading of functions.
- Your code makes invalid assumptions about paths, such as hard-coding a path that exists only on your local computer.

## Solutions

Try one or more of the following methods to fix runtime issues after the content deployment:

- Manually restart the Function app.
- Run the [Azure Functions Diagnostics](/azure/azure-functions/functions-diagnostics) to quickly diagnose and solve common Function app problems.
- If the storage account used for the Function app, verify if the [storage connections are set up correctly](/azure/azure-functions/functions-recover-storage-account).
- If you've enabled Application Insights for your function, see [Application Insights logs](/azure/azure-functions/functions-monitoring) to learn more about the full exception trace or error message that's causing errors.

[!INCLUDE [support-disclaimer](../../../includes/support-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
