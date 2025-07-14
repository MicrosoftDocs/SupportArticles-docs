---
title: Restore HTTPS functionality with .NET 8 in Data API builder
description: Configures .NET 8 correctly to enable full HTTPS support when using Data API builder for Azure databases.
author: genlin
ms.author: genli
ms.reviewer: sidandrews
ms.service: data-api-builder
ms.date: 06/25/2024
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Tools and Connectors
---

# Restore HTTPS functionality with .NET 8 in Data API builder for Azure databases

Data API builder (DAB) runs locally for developers using the command-line interface (CLI). DAB sets up and runs HTTP and HTTPS endpoints without extra configuration. However, in some .NET 8 scenarios, DAB might not run the HTTPS endpoint correctly. This article provides steps to configure the HTTPS endpoint.

## Prerequisites

- [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0)
- An existing compatible database
- Data API builder CLI. [Install the CLI](/azure/data-api-builder/how-to-install-cli).

## Symptoms

When a developer runs DAB in a local environment, some users see console output similar to the following one:

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

> [!NOTE]
> The resulting `http://[::]:8080` is the endpoint, but it isn't a valid URL.

## Cause

For developers running .NET 8 or later, the HTTPS endpoint requires the `ASPNETCORE_URLS` environment variable to be correctly configured.

## Resolution

To correctly configure your local environment, use one of the following methods to set the `ASPNETCORE_URLS` environment variable.

### Solution 1: Set the environment variable with a .env file

A `.env` file is a simple text file that stores environment variables in key-value pairs. To set the `ASPNETCORE_URLS` environment variable, introduce a `.env` file next to your `dab-config.json` file with content similar to the following example:

```env
SQL_CONNECTION_STRING={your-connection-string}
ASPNETCORE_URLS=http://localhost:5000;https://localhost:5001
```

### Solution 2: Set the environment variable in your operating system (optional)

Set the `ASPNETCORE_URLS` environment variable to `http://localhost:5000;https://localhost:5001` in Windows.

#### [PowerShell](#tab/powershell)

```powershell
[Environment]::SetEnvironmentVariable("ASPNETCORE_URLS", "http://localhost:5000;https://localhost:5001", "User")
```

#### [Command Line](#tab/command-line)

```cmd
setx ASPNETCORE_URLS "http://localhost:5000;https://localhost:5001"
```

---

## More information

If your issue isn't resolved, provide feedback or report it in the [data-api-builder Discussions](https://github.com/azure/data-api-builder/discussions).

[!INCLUDE[Azure Help Support](../../includes/azure-help-support.md)]
