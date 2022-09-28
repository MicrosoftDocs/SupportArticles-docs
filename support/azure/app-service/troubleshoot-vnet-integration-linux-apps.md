---
title: Troubleshoot VNet Integration on Linux Apps
description: How to troubleshoot VNet Integration on Linux Apps
ms.date: 09/28/2022
ms.service: app-service
ms.author: hepiet
author:HelenePietz-MS
ms.reviewer:amymcel, amehrot, jugonza, madsd 
---

#Troubleshoot VNet Integration on Linux Apps

 
> [!NOTE]
> * Virtual network integration isn't supported for Docker Compose scenarios in App Service. Access restrictions are ignored if a private endpoint is present.

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

You can also leverage the Network troubleshooter for Linux Apps on Diagnose and solve problems.

:::image type="content" source="./media/vnet-integration-linux-tsg/linux_networktroubleshooter01.png" alt-text="Image that show Network Troubleshooter on Diagnose and solve problems.":::


This guided troubleshooter takes you step by step to understand your issue and provide curated solutions on your inputs.

:::image type="content" source="./media/vnet-integration-linux-tsg/linux_networktroubleshooter02.png" alt-text="Image that show Network Troubleshooter options.":::


##Related content

![GitHub logo](../../media/common/github.svg) For more information, see: [Integrate your app with an Azure virtual network - projectkudu/kudu Wiki (github.com)](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/app-service/overview-vnet-integration.md)


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
