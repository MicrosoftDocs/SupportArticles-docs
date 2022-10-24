---
title: Azure App Service virtual network integration troubleshooting guide
description: How to troubleshoot virtual network integration on Windows and Linux apps.
ms.date: 10/21/2022
ms.service: app-service
author: hepiet
ms.author: hepiet
ms.reviewer: amymcel, amehrot, jugonza
---
# Troubleshoot virtual network integration with Azure App Service

This article describes tools you can use to troubleshoot connection issues in Azure App Service that [integrate with a virtual network](/azure/app-service/overview-vnet-integration).

> [!NOTE]
> Virtual network integration isn't supported for Docker Compose scenarios in App Service. Access restriction policies are ignored if a private endpoint is present.

## Verify virtual network integration

To troubleshoot the connection issues, you must first verify whether the virtual network integration is configured correctly and whether the private IP is assigned to all instances of the App Service Plan.

To do this, use one of the following methods:

### Check the private IP in the Kudu Debug console

To access the Kudu console, select the app service in the Azure portal, go to **Development Tools**, select **Advanced Tools**, and then select **Go**. In the Kudu service page, select **Tools** > **Debug Console** > **CMD**. 

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/open-kudu.png" alt-text="Screenshot that shows how to open Kudu service page in the Azure portal.":::

You can also go to the Kudu Debug console directly by the URL `[sitename].scm.azurewebsites.net/DebugConsole`.

In the Debug console, run one of the following commands:

**Windows OS-based apps**

```console
SET WEBSITE_PRIVATE_IP
```
If the private IP is assigned successfully, you'll get the following output:

```output
WEBSITE_PRIVATE_IP=<IP address>
```

**Linux OS-based apps**

```console
set| egrep --color 'WEBSITE_PRIVATE_IP'
```

### Check the private IP in the Kudu environment

Go to the Kudu environment at `[sitename].scm.azurewebsites.net/Env` and search for `WEBSITE_PRIVATE_IP`.

Once we've established that the virtual network integration is configured successfully, we can proceed with the connectivity test.

## Troubleshoot outbound connectivity on Windows Apps

In native Windows Apps, the tools **ping**, **nslookup**, and **tracert** won't work through the console because of security constraints (they work in custom Windows Containers).

Go to the Kudu console directly at `[sitename].scm.azurewebsites.net/DebugConsole`.

To test DNS functionality, you can use **nameresolver.exe**. The syntax is:

```console
nameresolver.exe hostname [optional:DNS Server]
```

You can use **nameresolver** to check the hostnames that your app depends on. This way, you can test if you have anything misconfigured with your DNS or perhaps don't have access to your DNS server. 

To test TCP connectivity to a host and port combination, you can use **tcpping**. The syntax is.

```console
tcpping.exe hostname [optional: port]
```

The **tcpping** utility tells you if you can reach a specific host and port. It can show success only if there's an application listening at the host and port combination and there's network access from your app to the specified host and port.

## Troubleshoot outbound connectivity on Linux Apps

Go to Kudu directly at `[sitename].scm.azurewebsites.net`. In the Kudu service page, select **Tools** > **Debug Console** > **CMD**.

To test DNS functionality, you can use the command **nslookup**. The syntax is:

```console
nslookup hostname [optional:DNS Server]
```

Depending on the above results, you can check if there's something misconfigured on your DNS server.

> [!NOTE]
> The nameresolver.exe tool currently doesn't work in Linux apps.

To test connectivity, you can use the **Curl** command. The syntax is:

```console
curl -v https://hostname
curl hostname:[port]
```

## Network troubleshooter

You can also use the Network troubleshooter to troubleshoot the connection issues for the apps in the App Service. To open the network troubleshooter, go to the app service in the Azure portal. Select **Diagnostic and solve problem**, and then search for **Network troubleshooter**.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/open-network-troubleshooter.png" alt-text="Screenshot that shows how to open network troubleshooter in the Azure portal.":::

> [!NOTE]
> The **connection issues** scenario doesn't support Linux or Container-based apps yet.

**Connection issues** - It will check the status of the virtual network integration, including checking if the Private IP has been assigned to all instances of the App Service Plan and the DNS settings. If a custom DNS isn't configured, default Azure DNS will be applied. You can also run tests against a specific endpoint that you want to test connectivity to.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/connection-issue.png" alt-text="Screenshot that shows run troubleshooter for connection issues.":::

**Configuration issues** - This troubleshooter will check if your subnet is valid for virtual network Integration.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/configuration-issue.png" alt-text="Screenshot that shows how to run  troubleshooter for configuration issues in the Azure portal.":::

**Subnet/VNet deletion issue** - This troubleshooter will check if your subnet has any locks and if it has any unused Service Association Links that might be blocking the deletion of the VNet/subnet.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/deletion-issue.png" alt-text="Screenshot that shows how to run troubleshooter for subnet or virtual network deletion issues.":::

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]


