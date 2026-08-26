---
title: Troubleshoot virtual network integration - Azure App Service
description: Learn how to troubleshoot Azure App Service virtual network integration on Windows and Linux apps by verifying DNS, TCP connectivity, routes, and subnets.
ms.date: 08/25/2026
ms.service: azure-app-service
ms.topic: troubleshooting
ms.custom: sap:Networking,linux-related-content
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: jugonza, kaushika
---
# Troubleshoot virtual network integration with Azure App Service

## Summary

This article explains how to troubleshoot [Azure App Service virtual network integration](/azure/app-service/overview-vnet-integration) connection issues on Windows and Linux apps. Use these tools to verify configuration and identify DNS, TCP, routing, and subnet problems.

> [!NOTE]
> Virtual network integration isn't supported for Docker Compose scenarios in App Service. Access restriction policies are ignored if a private endpoint is present.

## Verify virtual network integration

To troubleshoot connection issues, first verify whether the virtual network integration is configured correctly and whether the private IP is assigned to all instances of the App Service plan.

Use one of the following methods to check these settings.

### Check the private IP in the Kudu Debug console

To access the Kudu console, in the [Azure portal](https://portal.azure.com), select the app service > **Development Tools** > **Advanced Tools** > **Go**. On the Kudu service page, select **Tools** > **Debug Console** > **CMD**. 

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/open-kudu.png" alt-text="Screenshot of the Azure portal options for opening the Kudu service page.":::

You can also go to the Kudu Debug console directly by using the following example URL: `[sitename].scm.azurewebsites.net/DebugConsole`.

In the Kudu Debug console, run one of the following commands:

**Windows OS-based apps**

```console
SET WEBSITE_PRIVATE_IP
```
If the private IP is assigned successfully, you get the following output:

```output
WEBSITE_PRIVATE_IP=<IP address>
```

**Linux OS-based apps**

```console
set| egrep --color 'WEBSITE_PRIVATE_IP'
```

### Check the private IP in the Kudu environment

Go to the Kudu environment at `[sitename].scm.azurewebsites.net/Env` and search for `WEBSITE_PRIVATE_IP`.

When you confirm that the virtual network integration is configured successfully, proceed with the connectivity test.

## Troubleshoot outbound connectivity on Windows apps

In native Windows apps, the tools ping, nslookup, and tracert don't work through the console because of security constraints. These tools work in custom Windows containers.

Go to the Kudu console directly at `[sitename].scm.azurewebsites.net/DebugConsole`.

To test Domain Name System (DNS) functionality, use nameresolver.exe directly with the following syntax:

```console
nameresolver.exe hostname [optional:DNS Server]
```

Use nameresolver to check the hostnames that your app depends on. You can test if you misconfigured your DNS server or don't have access to your DNS server. You can see the DNS server that your app uses in the console by looking at the environmental variables `WEBSITE_DNS_SERVER` and `WEBSITE_DNS_ALT_SERVER`.

> [!NOTE]
> The nameresolver.exe tool currently doesn't work in custom Windows containers.


To test Transmission Control Protocol (TCP) connectivity to a host and port combination, use tcpping.exe directly with the following syntax:

```console
tcpping.exe hostname [optional: port]
```

The tcpping utility tells you if you can reach a specific host and port. It shows success only if there's an application listening at the host and port combination and there's network access from your app to the specified host and port.

## Troubleshoot outbound connectivity on Linux apps

Go to Kudu directly at `[sitename].scm.azurewebsites.net`. On the Kudu service page, select **Tools** > **Debug Console** > **CMD**.

To test DNS functionality, use nslookup directly with the following syntax:

```console
nslookup hostname [optional:DNS Server]
```

Depending on the results, check if there's something misconfigured on your DNS server.

> [!NOTE]
> The nameresolver.exe tool currently doesn't work in Linux apps.

To test connectivity, use Curl directly with the following syntax:

```console
curl -v https://hostname
curl hostname:[port]
```

## Debug access to virtual network-hosted resources

A number of factors can prevent your app from reaching a specific host and port. Most of the time, it's one of the following:

- **A firewall is in the way.** If there's a firewall in the way, you encounter the TCP timeout. (The TCP timeout is usually 21 seconds). Use the tcpping utility to test connectivity. 
- **DNS isn't accessible.** The DNS timeout is three seconds per DNS server. If you have two DNS servers, the timeout is six seconds. Use nameresolver to see if the DNS is working. You can't use nslookup because it doesn't use the DNS your virtual network is configured with. If inaccessible, you might have a firewall or network security group (NSG) blocking access to DNS, or it might be down. Some DNS architectures that use custom DNS servers can be complex and sometimes experience timeouts. To determine if this is the case, the environment variable `WEBSITE_DNS_ATTEMPTS` can be set. For more information about DNS in App Services, see [Name resolution (DNS) in App Service](/azure/app-service/overview-name-resolution).

If these don't solve your problems, look for the following issues:

**Regional virtual network integration**

- Is your destination a non-RFC1918 address? Is **Route All** enabled?
- Is there an NSG blocking egress from your integration subnet?
- If you're going across Azure ExpressRoute or a virtual private network (VPN), is your on-premises gateway configured to route traffic back up to Azure? If you can reach endpoints in your virtual network but not on-premises, check your routes.
- Do you have enough permissions to set delegation on the integration subnet? During regional virtual network integration configuration, your integration subnet is delegated to Microsoft.Web/serverFarms. (The virtual network integration UI delegates the subnet to Microsoft.Web/serverFarms automatically.) If your account doesn't have sufficient networking permissions to set delegation, you need someone who can set attributes on your integration subnet to delegate the subnet. To manually delegate the integration subnet, go to the Azure Virtual Network subnet UI and set the delegation for Microsoft.Web/serverFarms.

Debugging networking issues can be a challenge because you can't see what's blocking access to a specific host:port combination. Some causes include:

- You have a firewall up on your host that prevents access to the application port from your point-to-site IP range. Crossing subnets often requires public access.
- Your target host is down.
- Your application is down.
- You had the wrong IP or hostname.
- Your application is listening on a different port than what you expected. You can match your process ID with the listening port by using "netstat -aon" on the endpoint host.
- Your network security groups are configured in such a manner that they prevent access to your application host and port from your point-to-site IP range.

You don't know what address your app actually uses. It could be any address in the integration subnet or point-to-site address range, so you need to allow access from the entire address range.

More debug steps include:

- Connect to a virtual machine (VM) in your virtual network and attempt to reach your resource host:port from there. To test for TCP access, use the PowerShell command **Test-NetConnection** with the following syntax:
   
```powershell
Test-NetConnection hostname [optional: -Port]
```

- Bring up an application on a VM and test access to that host and port from the console of your app by using the tcpping utility.

## Network troubleshooter

Use the network troubleshooter to troubleshoot connection issues for the apps in the App Service. To open the network troubleshooter, go to the app service in the Azure portal. Select **Diagnostic and solve problem**, and then search for **Network troubleshooter**.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/open-network-troubleshooter.png" alt-text="Screenshot of the Azure portal search results for opening Network troubleshooter.":::

> [!NOTE]
> **Connection issues** doesn't support Linux or container-based apps yet.

**Connection issues** checks the status of the virtual network integration. It checks if the private IP is assigned to all instances of the App Service plan and the DNS settings. If you don't configure a custom DNS, the troubleshooter applies the default Azure DNS. You can also run tests against a specific endpoint that you want to test connectivity to.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/connection-issue.png" alt-text="Screenshot of the Connection issues troubleshooter for testing virtual network integration.":::

**Configuration issues** checks if your subnet is valid for virtual network integration.

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/configuration-issue.png" alt-text="Screenshot of the Configuration issues troubleshooter for checking virtual network integration subnet settings.":::

**Subnet/VNet deletion issue** checks if your subnet has any locks and if it has any unused service association links blocking the deletion of the virtual network (VNet) or subnet. To delete unused service association links, see the [App Service virtual network integration troubleshooting steps](/azure/app-service/overview-vnet-integration#troubleshooting).

:::image type="content" source="./media/troubleshoot-vnet-integration-apps/deletion-issue.png" alt-text="Screenshot of the Subnet/VNet deletion issue troubleshooter for checking virtual network deletion blockers.":::

## Collect network traces

Collecting network traces can be helpful in analyzing issues. In App Services, network traces are taken from the application process. To obtain accurate information, reproduce the issue while starting the network trace collection.

### Collect network traces for Windows App Services

To collect network traces for Windows App Services, follow these steps:

1. In the Azure portal, go to your web app.
1. In the menu, select **Diagnose and Solve Problems**.
1. In the search box, type **Collect Network Trace**, and then select **Collect Network Trace** to start the network trace collection.

:::image type="content" source="media/troubleshoot-vnet-integration-apps/collect-network-trace-windows.png" alt-text="Screenshot of the Azure portal option used to collect a network trace for a Windows web app.":::

To get the trace file for each instance serving a web app, go to the Kudu console for the web app (`https://<sitename>.scm.azurewebsites.net`). Download the trace file from the C:\home\LogFiles\networktrace or D:\home\LogFiles\networktrace folder.

### Collect network traces for Linux App Services

To collect network traces for Linux App Services that don't use a custom container, follow these steps:

1. Install the `tcpdump` command line utility by running the following commands:

   ```bash
   apt-get update
   apt install tcpdump
   ```

2. Connect to the container using the Secure Shell Protocol (SSH).

3. Identify the interface that's up and running by running the following commands (for example, `eth0`):

   ```bash
   root@<hostname>:/home# tcpdump -D
   
   1.eth0 [Up, Running, Connected]
   2.any (Pseudo-device that captures on all interfaces) [Up, Running]
   3.lo [Up, Running, Loopback]
   4.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
   5.nflog (Linux netfilter log (NFLOG) interface) [none]
   6.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
   7.dbus-system (D-Bus system bus) [none]
   8.dbus-session (D-Bus session bus) [none]
   ```

4. Start the network trace collection by running the following command:

   ```bash
   root@<hostname>:/home# tcpdump -i eth0 -w networktrace.pcap
   ```

   Replace `eth0` with the name of the actual interface.

5. To download the trace file, connect to the web app using methods such as Kudu, FTP, or a Kudu API request. The following is arequest example for triggering the file download:

`https://<sitename>.scm.azurewebsites.net/api/vfs/<path to the trace file in the /home directory>/filename`

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]