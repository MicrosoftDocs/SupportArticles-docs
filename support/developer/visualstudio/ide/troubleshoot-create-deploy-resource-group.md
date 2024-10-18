---
title: Troubleshoot creating and deploying Azure resource groups through Visual Studio
description: Learn how to resolve errors while creating and deploying Azure resource groups through Visual Studio.
ms.date: 10/18/2024
author: mumian
ms.author: jgao
ms.reviewer: puichan
---

# Troubleshoot creating and deploying Azure resource groups through Visual Studio

_Applies to:_&nbsp;Visual Studio

> [!NOTE]
> The Azure Resource Group project is now in extended support, meaning we will continue to support existing features and capabilities but won't prioritize adding new features.

This article assists you in troubleshooting issues related to creating and deploying Azure resource groups, which are often caused by unsupported older versions of Visual Studio.

## Symptoms

- Can't Create a new Azure Resource Group project.
- Can't add new resources to an existing Azure Resource Manager template via the **Add Resource** button in the JSON Outline tool window.
- Errors aren't flagged in Azure Resource Manager template files in existing projects.  

## Resolution

Upgrade to the latest [Long-Term Support (LTS) version](/visualstudio/install/update-visual-studio). Upgrading to the latest version enhances the reliability and overall experience of your Visual Studio installation.

## References

- [Release Dates and Build numbers](/visualstudio/releases/2022/release-history#release-dates-and-build-numbers)
- [Visual Studio Product Lifecycle and Servicing](/visualstudio/productinfo/vs-servicing)
