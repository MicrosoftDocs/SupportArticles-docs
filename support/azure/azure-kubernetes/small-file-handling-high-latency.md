---
title: Small file handling causes high latency on Azure Files
description: Understand why high latency can occur in an Azure Kubernetes Service (AKS) cluster in cases such as the handling of many small files.
ms.date: 5/25/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to know why high latency is occurring so that I can use my Azure Kubernetes Service (AKS) cluster more optimally.
---
# Handling of small files causes high latency on Azure Files

In some cases, such as the handling of many small files, you may experience high latency when using Azure Files when compared to Azure Disk.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
