---
title: Troubleshooting installation
titleSuffix: Data API builder
description: Troubleshoot common problems that might occur and their solutions when installing the Data API builder for Azure databases.
author: seesharprun
ms.author: sidandrews
ms.reviewer: jerrynixon
ms.service: data-api-builder
ms.topic: troubleshooting-general
ms.date: 04/01/2024
---

# Troubleshoot installation in Data API builder for Azure databases

Data API builder is distributed as a NuGet package and installed via .NET tool. This article provides solutions to common problems that might arise when you're installing Data API builder.

## Verify .NET 6 installation

Data API builder requires .NET 6 to be installed on your machine. If you don't have .NET 6 installed, you can install it by following the instructions in the [.NET 6 installation guide](/dotnet/core/install/).

Data API builder requires .NET 6 to be installed on your machine. If you don't have .NET 6 installed, you can download and install it by following the instructions at <https://dotnet.microsoft.com/download/dotnet/6.0>.

### Installing .NET 6 on Ubuntu 22

Installing .NET 6 on Ubuntu 22 can be tricky as the .NET package are available both in the Ubuntu repo and also in the Microsoft repo, which can lead to conflicts. If you're having issues executing `dotnet` on Linux, you might receive an error like `A fatal error occurred. The folder [/usr/share/dotnet/host/fxr] does not exist`.

Review the installation instructions for [.NET SDK on Ubuntu](/dotnet/core/install/linux-ubuntu).

## Using .NET tool

Data API builder is distributed as a NuGet package and can be installed using the `dotnet tool` command. If you're having issues using `dotnet tool`, review [troubleshoot .NET tool usage issues.](/dotnet/core/tools/troubleshoot-usage-issues)

## Command-line interface

After installation, you might experience issues running the `dab` command-line interface (CLI).

### `dab` command can't be found

Make sure that the folder where .NET tool stores the downloaded package is in your PATH variable: [Global tools](/dotnet/core/tools/troubleshoot-usage-issues#global-tools).

#### [PowerShell](#tab/powershell)

```powershell
($env:PATH).Split(";")
```

#### [Bash](#tab/bash)

```bash
echo $PATH | tr ":" "\n"
```

---

## Provide feedback

If you're unsable to find a solution to your issue in this article, provide feedback or report bugs at the [azure/data-api-builder](https://github.com/azure/data-api-builder/discussions) GitHub repository.

## Related content

- [Troubleshoot usage](usage.md)
- [Known issues](https://github.com/azure/data-api-builder/labels/known-issue)
