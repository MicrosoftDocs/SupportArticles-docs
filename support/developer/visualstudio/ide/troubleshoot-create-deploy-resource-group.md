---
title: Troubleshoot creating and deploying Azure resource groups
description: Provides a resolution for an issue that occurs when you try to create and deploy Azure resource groups through Visual Studio.
ms.date: 10/22/2024
author: mumian
ms.author: jgao
ms.reviewer: puichan
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Troubleshoot creating and deploying Azure resource groups through Visual Studio

_Applies to:_&nbsp;Visual Studio

> [!NOTE]
> The Azure Resource Group project is now in extended support, meaning we will continue to support existing features and capabilities but won't prioritize adding new features.

This article helps you in troubleshooting issues related to creating and deploying Azure resource groups, which are often caused by unsupported older versions of Visual Studio.

## Symptoms

- You can't create a new Azure Resource Group project.
- You can't add new resources to an existing Azure Resource Manager template using the **Add Resource** button in the **JSON Outline** tool window.
- Errors aren't flagged in Azure Resource Manager template files in existing projects.

## Resolution

To solve this issue, upgrade your Visual Studio installation to the latest [Long-Term Support (LTS) version](/visualstudio/install/update-visual-studio). It will enhance the reliability and overall experience of your Visual Studio environment.

## More information

- [Release Dates and Build numbers](/visualstudio/releases/2022/release-history#release-dates-and-build-numbers)
- [Visual Studio Product Lifecycle and Servicing](/visualstudio/productinfo/vs-servicing)
