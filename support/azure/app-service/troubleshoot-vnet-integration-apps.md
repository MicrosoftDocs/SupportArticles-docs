---
title: Azure App Service virtual network integration troubleshooting guide
description: How to troubleshoot virtual network integration on Windows and Linux apps.
ms.date: 10/21/2022
ms.service: app-service
author: hepiet
ms.author: hepiet
ms.reviewer: jugonza
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

You can use **nameresolver** to check the hostnames that your app depends on. This way, you can test if you have anything misconfigured with your DNS or perhaps don't have access to your DNS server. You can see the DNS server that your app uses in the console by looking at the environmental variables WEBSITE_DNS_SERVER and WEBSITE_DNS_ALT_SERVER.

> [!NOTE]
> * The nameresolver.exe tool currently doesn’t work in custom Windows containers.


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

## Debug access to virtual network-hosted resources

A number of factors can prevent your app from reaching a specific host and port. Most of the time, it's one of the following:

* **A firewall is in the way.** If you have a firewall in the way, you hit the TCP timeout. The TCP timeout is 21 seconds in this case. Use the **tcpping** tool to test connectivity. TCP timeouts can be caused by many things beyond firewalls, but start there.
* **DNS isn't accessible.** The DNS timeout is 3 seconds per DNS server. If you have two DNS servers, the timeout is 6 seconds. Use nameresolver to see if DNS is working. You can't use nslookup, because that doesn't use the DNS your virtual network is configured with. If inaccessible, you could have a firewall or NSG blocking access to DNS or it could be down.

If those items don't answer your problems, look first for things like:

**Regional virtual network integration**

* Is your destination a non-RFC1918 address and you don't have **Route All** enabled?
* Is there an NSG blocking egress from your integration subnet?
* If you're going across Azure ExpressRoute or a VPN, is your on-premises gateway configured to route traffic back up to Azure? If you can reach endpoints in your virtual network but not on-premises, check your routes.
* Do you have enough permissions to set delegation on the integration subnet? During regional virtual network integration configuration, your integration subnet is delegated to Microsoft.Web/serverFarms. The VNet integration UI delegates the subnet to Microsoft.Web/serverFarms automatically. If your account doesn't have sufficient networking permissions to set delegation, you'll need someone who can set attributes on your integration subnet to delegate the subnet. To manually delegate the integration subnet, go to the Azure Virtual Network subnet UI and set the delegation for Microsoft.Web/serverFarms.

Debugging networking issues is a challenge because you can't see what's blocking access to a specific host:port combination. Some causes include:

* You have a firewall up on your host that prevents access to the application port from your point-to-site IP range. Crossing subnets often requires public access.
* Your target host is down.
* Your application is down.
* You had the wrong IP or hostname.
* Your application is listening on a different port than what you expected. You can match your process ID with the listening port by using "netstat -aon" on the endpoint host.
* Your network security groups are configured in such a manner that they prevent access to your application host and port from your point-to-site IP range.

You don't know what address your app actually uses. It could be any address in the integration subnet or point-to-site address range, so you need to allow access from the entire address range.

More debug steps include:

* Connect to a VM in your virtual network and attempt to reach your resource host:port from there. To test for TCP access, use the PowerShell command **Test-NetConnection**. The syntax is:
   
```powershell
Test-NetConnection hostname [optional: -Port]
```

* Bring up an application on a VM and test access to that host and port from the console from your app by using **tcpping**.

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
