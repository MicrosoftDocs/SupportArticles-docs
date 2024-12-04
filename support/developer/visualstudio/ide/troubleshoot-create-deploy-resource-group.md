---
title: Issues when creating and deploying Azure resource groups
description: Provides a resolution for issues that might occur when you try to create and deploy Azure resource groups through Visual Studio.
ms.date: 10/22/2024
ms.reviewer: jgao, puichan, v-sidong
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Issues when creating and deploying Azure resource groups through Visual Studio

_Applies to:_&nbsp;Visual Studio

> [!NOTE]
> The Azure Resource Group project is now in extended support. We will continue to support existing features and capabilities but won't prioritize adding new features.

This article helps you solve issues related to creating and deploying Azure resource groups.

## Symptoms

When you try to [create and deploy Azure resource groups through Visual Studio](/azure/azure-resource-manager/templates/create-visual-studio-deployment-project), you encounter one or more of the following issues:

- You can't create a new Azure Resource Group project.
- You can't add new resources to an existing Azure Resource Manager template using the **Add Resource** button in the **JSON Outline** tool window.
- Errors aren't flagged in Azure Resource Manager template files in existing projects.

## Cause

These issues occur when you use unsupported older versions of Visual Studio.

## Resolution

To solve this issue, upgrade your Visual Studio installation to the latest [Long-Term Support (LTS) version](/visualstudio/install/update-visual-studio). Upgrading to the latest version can enhance the reliability and overall experience of your Visual Studio environment.

## More information

- [Release Dates and Build numbers](/visualstudio/releases/2022/release-history#release-dates-and-build-numbers)
- [Visual Studio Product Lifecycle and Servicing](/visualstudio/productinfo/vs-servicing)
