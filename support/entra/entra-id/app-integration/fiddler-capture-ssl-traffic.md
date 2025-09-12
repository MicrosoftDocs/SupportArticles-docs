---
title: Capture SSL Traffic with Fiddler
description: Introduces how to make Fiddler to capture SSL traffic in two specific scenarios.
ms.service: entra-id
ms.date: 04/15/2025
ms.reviewer: bachoang, v-weizhu
ms.topic: how-to
ms.custom: sap:Enterprise Applications
---
# Capture SSL traffic with Fiddler

This article provides instructions to use Fiddler to capture Secure Sockets Layer (SSL) traffic to troubleshoot Microsoft Entra apps.

## Scenario 1: Capture Node.js web traffic with Fiddler

To capture Node.js web application traffic using Fiddler, you need to proxy Node.js requests through Fiddler. The default proxy is 127.0.0.1:8888. To do so, before running the `npm start` command to start the Node.js server, enable the proxy settings by running the following commands:

```nodejs
set https_proxy=http://127.0.0.1:8888
set http_proxy=http://127.0.0.1:8888
set NODE_TLS_REJECT_UNAUTHORIZED=0
```

> [!NOTE]
> To find out which port Fiddler is listening on, select **Tools** > **Options** > **Connections** from the Fiddler menu.

## Scenario 2: Capture the Azure Key Vault secrets client (from Azure SDK for .NET) with Fiddler

To capture Azure Key Vault traffic using Fiddler, set Fiddler as a proxy by setting the `http_proxy` and `https_proxy` environment variables in the application code as follows:

```csharp

using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
...
// add these lines in your method to call Azure Key Vault
Environment.SetEnvironmentVariable("HTTP_PROXY", "http://127.0.0.1:8888");
Environment.SetEnvironmentVariable("HTTPS_PROXY", "http://127.0.0.1:8888");

var client = new SecretClient(new Uri(keyVaultUrl), credential);
KeyVaultSecret result = client.GetSecret("MySecret");
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]