---
title: Issues when creating and deploying Azure resource groups
description: Provides a resolution for issues that might occur when you try to create and deploy Azure resource groups through Visual Studio.
ms.date: 10/21/2025
ms.reviewer: jgao, puichan
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Issues when creating and deploying Azure resource groups through Visual Studio

_Applies to:_&nbsp;Visual Studio

> [!NOTE]
> The Azure Resource Group project has been in extended support since October 2024 and only ships in Visual Studio 2022 and older versions. This feature isn't available in Visual Studio 2026 and newer versions.

This article helps you solve issues related to creating and deploying Azure resource groups.

## Symptoms

When you try to [create and deploy Azure resource groups through Visual Studio](/azure/azure-resource-manager/templates/create-visual-studio-deployment-project), you encounter one or more of the following issues:

- You can't create a new Azure Resource Group project.
- You can't add new resources to an existing Azure Resource Manager template using the **Add Resource** button in the **JSON Outline** tool window.
- Errors aren't flagged in Azure Resource Manager template files in existing projects.

## Cause

These issues occur when using an unsupported version of Visual Studio.

## Resolution

Make sure you're using a supported version of Visual Studio. This feature is available in:

- Visual Studio 2017
- Visual Studio 2019
- Visual Studio 2022

## More information

- [Release Dates and Build numbers](/visualstudio/releases/2022/release-history#release-dates-and-build-numbers)
- [Visual Studio Product Lifecycle and Servicing](/visualstudio/productinfo/vs-servicing)
