---
title: Restore HTTPS functionality with .NET 8 in Data API builder
description: Configure .NET 8 correctly to enable full HTTPS support when using Data API builder for Azure databases.
author: genlin
ms.author: genli
ms.reviewer: sidandrews
ms.service: data-api-builder
ms.date: 06/19/2024
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Tools and Connectors
---

# Restore HTTPS functionality with .NET 8 in Data API builder for Azure databases

Data API builder (DAB) runs locally for developers using the Command-Line Interface (CLI). Without extra configuration, DAB sets up and runs an HTTP and HTTPS endpoint. However, in some .NET 8 scenarios, DAB might not correctly run the HTTPS endpoint. This article reviews the steps to configure the HTTPS endpoint.

## Prerequisites

- [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0)
- Existing compatible database.
- Data API builder CLI. [Install the CLI](/azure/data-api-builder/how-to-install-cli)

## Symptoms

When a developer runs DAB in a local environment, some users see console output similar to what shown here. The resulting `http://[::]:8080` is the endpoint, but it isn't a valid URL.

```output
...
info: Azure.DataApiBuilder.Service.Startup[0]
      Successfully completed runtime initialization.
info: Microsoft.Hosting.Lifetime[14]
      Now listening on http://[::]:8080
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Development
...
```

## Cause

For developers running .NET 8 or later, the HTTPS endpoint requires the `ASPNETCORE_URLS` environment variable to be correctly configured.

## Solution: Setting environment variables with a file

To correctly configuration your local environment, set the `ASPNETCORE_URLS` environment variable. There are two ways to set environment variables, directly in the operating system or using a `.env` file. An `.env` file is a simple text file used to store environment variables in key-value pairs. To set the `ASPNETCORE_URLS` environment variable, introduce a `.env` next to your `dab-config.json` file with similar contents:

```env
SQL_CONNECTION_STRING={your-connection-string}
ASPNETCORE_URLS=http://localhost:5000;https://localhost:5001
```

## Solution: Setting environment variables in your operating system (optional)

Set the environment variable `ASPNETCORE_URLS` to `http://localhost:5000;https://localhost:5001` in Windows.

### [PowerShell](#tab/powershell)

```powershell
[Environment]::SetEnvironmentVariable("ASPNETCORE_URLS", "http://localhost:5000;https://localhost:5001", "User")
```

### [Command Line](#tab/command-line)

```cmd
setx ASPNETCORE_URLS "http://localhost:5000;https://localhost:5001"
```

---

## Next step

If your issue isn't resolved, provide feedback or report it in the [data-api-builder Discussions](https://github.com/azure/data-api-builder/discussions).

[!INCLUDE[Azure Help Support](../../includes/azure-help-support.md)]
