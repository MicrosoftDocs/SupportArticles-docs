---
title: "No space available on drive E or F"
description: "Learn how to resolve a scenario in which there's zero free space on drive E or F in Azure Cloud Services."
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: piw, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure Cloud Services user, I want to know what to do if my drive E or F runs out of free space so that I can continue to use this data to help troubleshoot various problems.
---

# No space is available on drive E or F

This article discusses how to resolve a scenario in which drive E or F on Microsoft Azure Cloud Services runs out of free space.

## Symptoms

You host an instance of Cloud Services, but you discover that your drive E or F has zero free space.

## Cause

Because drives E and F are used as the application disk drive, no application-related data should be stored on those drives. Data storage can cause the space usage to be much greater than the sum of the individual file sizes. For more information, see [Where did my space go?](/archive/blogs/askcore/where-did-my-space-go).

The storage space that's used shouldn't affect the operation of the application. After the drives are created, Azure virtual machines don't write to them unless the application code does. The application code shouldn't be writing to these drives, anyway.

## Solution

For data that an application has to read from and write to, we recommend that you use an external storage service, such as [Azure Storage](/azure/storage/common/storage-introduction) or [Azure SQL Server](https://azure.microsoft.com/services/sql-database/campaign/).

If the location of the local data store is needed, make sure that the application code uses local storage resources. These are stored on the local drive C. For more information, see [Configure local storage resources](https://github.com/Huachao/azure-content/blob/master/articles/cloud-services/cloud-services-configure-local-storage-resources.md) and [Azure disk partitions](./disk-partition-preservation.md#azure-disk-partitions).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
