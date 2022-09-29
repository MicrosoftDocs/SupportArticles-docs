---
title: Troubleshoot VNet Integration Troubleshooting Guide
description: How to troubleshoot VNet Integration on Windows and Linux Apps
ms.date: 09/29/2022
ms.service: app-service
ms.author: hepiet
author:HelenePietz-MS
ms.reviewer:amymcel, amehrot, jugonza, madsd 
---
##Troubleshooting 

> [!NOTE]
> * Virtual network integration isn't supported for Docker Compose scenarios in App Service. Access restrictions are ignored if a private endpoint is present.

#Troubleshoot VNet Integration on Windows Apps

In natives Windows Apps, the tools **ping, nslookup,** and **tracert** won't work trough the console because of security constraints (they work in [custom Windows containers](../articles/app-service/quickstart-custom-container.md)).


To test DNS functionality, you can use **nameresolver.exe**. The syntax is:

```console
nameresolver.exe hostname [optional:DNS Server]
```

You can use **nameresolver** to check the hostnames that your app depends on. This way you can test if you have anything misconfigured with your DNS or perhaps don't have access to your DNS server. 


To test for TCP connectivity to a host and port combination, you can use **tcpping**. The syntax is.

```console
tcpping.exe hostname [optional: port]
```

The **tcpping** utility tells you if you can reach a specific host and port. It can show success only if there's an application listening at the host and port combination, and there's network access from your app to the specified host and port.


#Troubleshoot VNet Integration on Linux Apps
 


Once VNet integration is configured you might still encounter connectivity issues, if that is the case here are some steps to follow to help you troubleshoot:

To reach the Kudu console from your app, go to **Tools > Kudu**. You can also reach the Kudu console at [sitename].scm.azurewebsites.net. After the website load, go to the **SSH** console tab.

To test DNS functionality, you can use the command **nslookup**. The syntax is:

```console
nslookup hostname [optional:DNS Server]
```

Depending on the results of the above, you can check if there is something misconfigured on your DNS server.

> [!NOTE]
> * The nameresolver.exe tool currently doesn't work in Linux Apps.

To test connectivity, you can use the Curl command. The syntax is:

```console
curl -v https://hostname
curl hostname:[port]
```


#Network troubleshooter

You can also leverage the Network troubleshooter for Windows and  Linux Apps on Diagnose and solve problems.

:::image type="content" source="./media/vnet-integration-tsg/networktroubleshooter01.png" alt-text="Image that show Network Troubleshooter on Diagnose and solve problems.":::


This guided troubleshooter takes you step by step to understand your issue and provide curated solutions on your inputs.

:::image type="content" source="./media/vnet-integration-tsg/networktroubleshooter02.png" alt-text="Image that show Network Troubleshooter options.":::

> [!NOTE]
> * The connection issues flow don't support Linux or Container based Apps yet.

To check connection issues on Windows Apps, you can use the **Connection issues** flow. This troubleshooter will check the status of the VNet integration, the DNS settings (if any) and you can check a specific endpoint you want to test connectivity to.

:::image type="content" source="./media/vnet-integration-tsg/networktroubleshooter03.png" alt-text="Image that show Network Troubleshooter connection issues.":::

To check configuration issues, you can use the **Configuration issues** flow. This troubleshooter will check if your subnet is valid for VNet Integration.

:::image type="content" source="./media/vnet-integration-tsg/networktroubleshooter04.png" alt-text="Image that show Network Troubleshooter connection issues.":::

To check Subnet/VNet deletion issues, you can use the ** Subnet/VNet** deletion issue** flow. This troubleshooter will check if your subnet has any locks and if has any unused Service Association Links that might be blocking the deletion of the VNet/subnet.

:::image type="content" source="./media/vnet-integration-tsg/networktroubleshooter06.png" alt-text="Image that show Network Troubleshooter connection issues.":::


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]


##Related content

![GitHub logo](../../media/common/github.svg) For more information, see: [Integrate your app with an Azure virtual network - projectkudu/kudu Wiki (github.com)](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/app-service/overview-vnet-integration.md)



