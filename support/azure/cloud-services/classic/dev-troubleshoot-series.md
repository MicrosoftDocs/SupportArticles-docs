---
title: Azure Cloud Service Troubleshooting Series
description: Azure Cloud Service Troubleshooting Series
ms.date: 02/26/2024
ms.reviewer: 
ms.service: cloud-services
ms.subservice: troubleshoot-dev
ms.topic: overview
---
# Azure Cloud Service Troubleshooting Series

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 4466645

## Summary

Cloud service is one of most popular Azure PaaS service among web developers. These [blog series](/archive/blogs/kwill/windows-azure-paas-compute-diagnostics-data) includes some of the common problems faced by the customers while dealing with cloud service and how to troubleshoot those issues using various tools and logs. This blog focuses on some more common scenarios that you may face while developing and deploying cloud service solution to Azure.

In order to simulate the issues we have developed three cloud service applications and below are the links for instructions that you need to follow to set up the labs for each application:

- [Compressor](https://github.com/prchanda/compressor)
- [Super Convertor](https://github.com/prchanda/superconvertor)
- [Visitor Tracker](https://github.com/prchanda/visitortracker)

Let's deep dive into the troubleshooting series on Azure Cloud Service:

- [Scenario 1: An instance of ZipEngine role is looping between Restarting and Busy state throwing an unhandled exception](https://support.microsoft.com/help/4464909).
- [Scenario 2: AssemblyBinder role instances is throwing System.IO.IOException](https://support.microsoft.com/help/4464907).
- [Scenario 3: Autoscale is not triggering for FileUploader role](https://support.microsoft.com/help/4464899).
- [Scenario 4 : ProcessorEngine role is stuck in Busy state](https://support.microsoft.com/help/4464894).
- [Scenario 5 : My website is throwing HTTP Error 503](https://support.microsoft.com/help/4464854).
- [Scenario 6 : Can't RDP to only 'HealthMonitor' worker role instance](https://support.microsoft.com/help/4464850).
- [Scenario 7 : Can't access the website, although all role instances are in running state](https://support.microsoft.com/help/4464839).
- [Scenario 8 : ASP.NET SignalR application is not working](https://support.microsoft.com/help/4464827).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
