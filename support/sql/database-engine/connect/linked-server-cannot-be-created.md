---
title: A linked server couldn't be created after migrating on-premises server
description: This article provides a resolution to the problem where the linked server can't be created after migrating on-premises server to Azure.
ms.date: 12/14/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# A linked server couldn't be created after migrating on-premises server to Azure

This article helps you resolve an issue when you can't create a linked server after you move the on-premises server to Azure.

## Symptoms

Consider the following output:

```output
Environment
Source
Product:          Microsoft SQL Server 2022 RTM 16.0.1000.6
Operating System: Windows Server 2022
Server Down:      Partially
Production:       Yes
Cluster:          No
Replication:      N/A
Virtual Server:   Yes, Azure, Standard_B8ms
Destination
Product:          Microsoft SQL Server 2012 SP4 11.0.7001.0 
Operating System: Windows Server 2012 R2
Server Down:      Partially  
Production:       Yes
Cluster:          No
Replication:      N/A
Virtual Server:   Yes
```

