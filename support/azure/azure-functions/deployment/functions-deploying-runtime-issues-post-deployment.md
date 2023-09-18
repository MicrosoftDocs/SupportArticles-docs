---
title: Function app runtime issues post deployment
description: This article helps you to resolve runtime issues in the function app after content deployment.
ms.date: 08/24/2023
ms.reviewer: gasridha, v-jayaramanp
---

# Resolve common runtime issues after deployment

This article describes the common causes of runtime issues and provides solutions to resolve these issues.

If your application is experiencing issues after deployment, it's important to determine whether the problem is related to deployment or runtime. A *deployment* issue can cause the wrong set of files to get deployed to your function app, or it can cause some files not to get deployed at all. A *runtime* issue occurs after deployment. The files in your **wwwroot** directory are exactly as they should be, but the function app isn't running correctly. When this scenario occurs, the technique that you used to deploy your site is no longer relevant. For a runtime issue, you should, instead, focus on what your code is doing at runtime and how it's failing.

## Common causes for application runtime issues after content deployment

Runtime failure can occur for any of the following reasons:

- The function runtime can't start because the function app has lost access to the storage account.
- In the runtime sandbox environment of Azure Functions, something is blocking certain operations that work on your local computer.
- Your Azure Functions app isn't configured correctly. For example, the function host doesn't start up because of incorrect values in the following settings:
  - Runtime or language version
  - Triggers connection strings
  - Key vault settings
- An external dependency (such as a database or messaging system) isn't set up correctly and is causing time-out errors.
- Sync triggers failed. This causes an incorrect loading of functions.
- Your code makes invalid assumptions about paths, such as hard-coding a path that exists only on your local computer.

## Solutions

To fix runtime issues after the content deployment, try one or more of the following methods:

- Manually restart the function app.
- Run the [Azure Functions Diagnostics](/azure/azure-functions/functions-diagnostics) to quickly diagnose and solve common function app problems.
- Verify whether [storage connections are set up correctly and that the storage account is accessible](/azure/azure-functions/functions-recover-storage-account).
- If you've enabled Application Insights for your function, see [Application Insights logs](/azure/azure-functions/functions-monitoring) to learn more about the full exception trace or error message that's causing errors.
- Review the function runtime [migration guides](/azure/azure-functions/migrate-version-3-version-4) if your deployment is updating the function app runtime or language version.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
