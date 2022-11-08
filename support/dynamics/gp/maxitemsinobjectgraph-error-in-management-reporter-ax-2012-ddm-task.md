---
title: MaxItemsInObjectGraph error in Management Reporter AX 2012 DDM task
description: Describes an error message that you may receive when you run the initial load for Microsoft Dynamics AX 2012 DataMart for Management Reporter. Provides a resolution.
ms.reviewer: kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# MaxItemsInObjectGraph error in Microsoft Management Reporter AX 2012 DDM task

This article provides a resolution to solve the **MaxItemsInObjectGraph** error that may occur when you run the initial load for Microsoft Dynamics AX 2012 DataMart for Management Reporter.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2748925

## Symptoms

You receive the following error during the initial load of the Management Reporter AX 2012 DDM Integration:

> [AX 2012 General Ledger Transactions to Fact] has encountered an error. Processing will be aborted. Error text: The formatter threw an exception while trying to deserialize the message: There was an error while trying to deserialize parameter `http://tempuri.org/:GetTableMetadataByNameResult`. The InnerException message was 'Maximum number of items that can be serialized or deserialized in an object graph is '65536'. Change the object graph or increase the MaxItemsInObjectGraph quota. '. Please see InnerException for more details.

## Cause

This is caused when the metadata for certain Microsoft Dynamics AX 2012 tables is greater than the default MaxItemsInObjectGraph value, which is 65536. The metadata information increases when a table is customized or many dimensions exist.

## Resolution

Install the .NET 4.5 Framework on the server where the Management Reporter Services is installed. You can download [Microsoft .NET Framework 4.5](https://www.microsoft.com/download/details.aspx?id=30653).
