---
title: How to send EDI Interchange
description: Describes how to set up filters to send the batched EDI.
ms.date: 03/17/2020
ms.prod-support-area-path: Accelerators
ms.reviewer: mquian
---
# How to set up filters to send the batched EDI Interchange

This article describes how to set up filters to send the batched electronic data interchange (EDI).

_Original product version:_ &nbsp;  BizTalk Server  
_Original KB number:_ &nbsp; 2655256

## Summary

The steps outlined in [Walkthrough (X12): Sending Batched EDI Interchanges](/biztalk/core/walkthrough-x12-sending-batched-edi-interchanges), needs clarification on step 8. This step requires a send port that picks up the batched interchange by subscribing on the context properties `EDI.ToBeBatched==False`, `EDI.BatchName` and, `EDI.DestinationPartyName`.

`DestinationPartyName` needs to be promoted in a pipeline custom component or an orchestration. It can also be entered in the **Parties** > **Agreement** > **Interchange Settings** > **Identifiers** > **Additional Agreement Resolver** > **DestinationPartyName**.

The filter criteria for the send port can also be modified to only include `EDI.ToBeBatched==False` and `EDI.BatchName`.

## Symptoms

The behavior is that the batch is not created, an exception occurs, or a subscription error might result.

You might also receive an error in the application event log similar to:

> Event ID: 10034  
> Level: Error  
> Computer: Test  
> Description:  
>........  
> The following information was included with the event: xlang/s engine event log entry: Uncaught exception (see the 'inner exception' below) has suspended an instance of service 'Microsoft.BizTalk.Edi.BatchingOrchestration.BatchingService(2a16c595-614b-9563-c13f-ebd20e4a6154)'.  
> The service instance will remain suspended until administratively resumed or terminated. If resuming the instance will continue from its last persisted state and may rethrow the same unexpected exception.  
> ........  
>Inner exception: Object reference not set to an instance of an object.  
>Exception type: NullReferenceException  
>Source: Microsoft.BizTalk.Edi.BatchingOrchestration  
>Target Site: Microsoft.XLANGs.Core.StopConditions segment24(Microsoft.XLANGs.Core.StopConditions)  
>........  
>Event ID: 8116  
>Level: Error  
>Computer: Test  
>Description:An exception has occurred during the batch submission in the batching Orchestration. Batch Id = 4, ErrorMessage = Object reference not set to an instance of an object.

## Workaround 1

Enter the **destinationpartyname** value in **Parties** > **Agreement** > **Interchange Settings** > **Identifiers** > **Additional Agreement Resolver** > **DestinationPartyName**.

This will allow you to use the filter criteria `EDI.ToBeBatched==False`, `EDI.BatchName`, and `EDI.DestinationPartyName` as documented in the tutorial.

## Workaround 2

- Don't specify a **destinationpartyname** value.
- Use filter criteria of only `EDI.ToBeBatched==False` and `EDI.BatchName`.
