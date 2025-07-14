---
title: Troubleshooting Data API builder installation
description: Troubleshoot common problems that might occur when you install the Data API builder for Azure databases.
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: sidandrews
ms.service: data-api-builder
ms.date: 06/19/2024
ms.topic: troubleshooting-general
ms.custom: sap:Tools and Connectors
---

# Troubleshoot the installation of Data API builder for Azure databases

Data API builder is distributed as a NuGet package and can be installed using a .NET tool. This article provides solutions to common issues that might occur when you install Data API builder.

## .NET 8 isn't installed

Data API builder requires .NET 8 to be installed on your machine. If you don't have .NET 8 installed, you can install it by following the instructions in [Install .NET on Windows, Linux, and macOS](/dotnet/core/install/) or [Download .NET 8.0](https://dotnet.microsoft.com/download/dotnet/8.0).

## Issue when installing .NET 8 on Ubuntu 22

Installing .NET 8 on Ubuntu 22 can be tricky as the .NET package is available in both the Ubuntu repository and Microsoft repository, which can lead to conflicts or errors.

For example, when you execute the `dotnet` command on Linux, you might receive an error like the following example:

> A fatal error occurred. The folder [/usr/share/dotnet/host/fxr] does not exist.

To ensure you can install .NET 8 on Ubuntu successfully, review the installation instructions in the [Overview of .NET on Ubuntu](/dotnet/core/install/linux-ubuntu#im-using-ubuntu-2204-or-later-and-i-only-need-net).

## Issue when installing Data API builder using a .NET tool

Data API builder is distributed as a NuGet package and can be installed using the `dotnet tool` command. If you have issues using the `dotnet tool` command, [troubleshoot .NET tool usage issues](/dotnet/core/tools/troubleshoot-usage-issues).

## Data API builder command-line interface issue

After you install Data API builder, you might experience an issue where the `dab` command can't be found when running the Data API builder command-line interface (CLI).

To resolve this issue, make sure that the `PATH` environment variable on your machine contains the folder where the .NET tool stores the downloaded package. For more information, see [Global tools](/dotnet/core/tools/troubleshoot-usage-issues#global-tools).

To check the `PATH` environment variable, use the following command:

### [PowerShell](#tab/powershell)

```powershell
($env:PATH).Split(";")
```

#### [Bash](#tab/bash)

```bash
echo $PATH | tr ":" "\n"
```

---

## References

- [Troubleshoot usage of Data API builder for Azure databases](usage.md)
- [Known issues in the Azure/data-api-builder GitHub repository](https://github.com/azure/data-api-builder/labels/known-issue)

## Next step

If you're unsable to find a solution to your issue in this article, provide feedback or report bugs at the [azure/data-api-builder](https://github.com/azure/data-api-builder/discussions) GitHub repository.

[!INCLUDE[Azure Help Support](../../includes/azure-help-support.md)]
