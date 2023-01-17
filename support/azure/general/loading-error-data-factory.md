---
title: Error loading from Contents tab through Azure Data Factory, version 1
description: Describes an error when loading data files through Azure Data Factory, version 1. To resolve this problem, upgrade to Azure Data Factory, version 2.
ms.date: 08/14/2020
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: 
---
# A loading error occurs on Contents tab in Azure Data Factory, version 1

This article provides a solution to an issue in which you can't load data files through Azure Data Factory, version 1.

_Original product version:_ &nbsp; Data Factory  
_Original KB number:_ &nbsp; 4490161

## Symptoms

You may observe a loading issue on the "Contents" tab in Azure Data Factory, version 1. When you press the F12 function key, you receive the following error message:

> {Message: "There was an error processing your request. Please try again in a few moments.",…}  
HttpStatusCode: "InternalServerError"  
Message: "There was an error processing your request. Please try again in a few moments."  
StackTrace: null  
XMsServerRequestId: null  
value: [{name: "test",…}  
Error {code: "GatewayTimeout",…}  
code: "GatewayTimeout"  
message: "The gateway did not receive a response from 'Microsoft.DataFactory' within the specified time period."

## Cause

This problem may occur because there are duplicate assets, which cause the dispatcher service to error. For example:

> test-dataset

> TEST-DATASET

> [!NOTE]
> Duplicate assets might be created under a specific scenario such as when duplicated objects are created at the same time in version 1.

## Resolution

To fix this problem, upgrade to Azure Data Factory, version 2 to prevent the creation of duplicated objects.

## Workaround

To work around this problem, delete the duplicate asset.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
