---
title: Troubleshoot creating and deploying Azure resource groups throught Visual Studio
description: Learn how to resolve errors while creating and deploying Azure resource groups throught Visual Studio.
ms.date: 10/18/2024
author: mumian
ms.author: jgao
ms.reviewer: puichan
---

# Troubleshoot creating and deploying Azure resource groups throught Visual Studio

_Applies to:_&nbsp;Visual Studio

> [!NOTE]
> The Azure Resource Group project is now in extended support, meaning we will continue to support existing features and capabilities but won't prioritize adding new features.

This article assists you in troubleshooting issues related to creating and deploying Azure resource groups, which are often caused by unsupported older versions of Visual Studio.

## Symptoms

- Cannot Create a new Azure Resource Group project.
- Cannot add new resources to an existing Azure Resource Manager template via the **Add Resource** button in the JSON Outline tool window.
- Errors are not flagged in Azure Resource Manager template files in existing projects.  

## Resolution

Upgrade to the latest [Long-Term Support (LTS) version](/visualstudio/install/update-visual-studio?view=vs-2022). Upgrading to the latest version will enhance the reliability and overall experience of your Visual Studio installation.

## Additional resources for Visual Studio Support Resources: 

- [Release Dates and Build numbers](https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history#release-dates-and-build-numbers)
- [Visual Studio Product Lifecycle and Servicing](https://learn.microsoft.com/en-us/visualstudio/productinfo/vs-servicing)

## References

- [Use code coverage to determine how much code is being tested](/visualstudio/test/using-code-coverage-to-determine-how-much-code-is-being-tested)
