---
title: Exchange Mailbox Assistants crashes and event 4999 in Exchange
description: Fixes an issue that causes the Exchange Mailbox Assistant to crash every few minutes in Exchange Server 2013. This affects OAB generation and public folder hierarchy synchronization. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mnanjund, benwinz, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Mailbox Assistants service crashes and triggers event 4999 in Exchange Server 2013

_Original KB number:_ &nbsp;3140828

## Symptoms

The Microsoft Exchange Mailbox Assistants service (MSExchangeMailboxAssistants) crashes repeatedly at intervals of several minutes in an Exchange Server 2013 environment. The crash affects activities such as Offline Address Book (OAB) generation and public folder hierarchy synchronization.

Additionally, the following 4999 event is logged in the Application log during the intervals:

```console
Log Name: Application
Source: MSExchange Common
Date: 1/4/2016 5:21:43 AM
Event ID: 4999
Task Category: General
Level: Error
Keywords: Classic
User: N/A
Computer: EXHV-0535.EXHV-0535dom.extest.microsoft.com
Description:
Watson report about to be sent for process id: 10420, with parameters: E12IIS, DART-DBG-AMD64, 15.00.1130.007, MSExchangeMailboxAssistants, M.Exchange.Assistants, M.E.A.TimeBasedAssistantController.UpdateWorkCycle, System.ArgumentOutOfRangeException, ff31, 15.00.1130.005.
ErrorReportingEnabled: True
exData=|exHResult=-2146233086|exStacktrace= at System.Threading.Timer.Change(Int64 dueTime, Int64 period)
at System.Threading.Timer.Change(TimeSpan dueTime, TimeSpan period)
at Microsoft.Exchange.Assistants.TimeBasedAssistantController.UpdateWorkCycle(Object callerName) in \\REDMOND\EXCHANGE\BUILD\E15Ent\15.00.1130.005\SOURCES\sources\dev\assistants\src\Assistants\TimeBasedAssistantController.cs:line 844
at Microsoft.Exchange.Assistants.TimeBasedAssistantController.ReadAndUpdateWorkCycleConfiguration(Object state) in \\REDMOND\EXCHANGE\BUILD\E15Ent\15.00.1130.005\SOURCES\sources\dev\assistants\src\Assistants\TimeBasedAssistantController.cs:line 781
at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
at System.Threading.TimerQueueTimer.CallCallback()
at System.Threading.TimerQueueTimer.Fire()
at System.Threading.QueueUserWorkItemCallback.System.Threading.IThreadPoolWorkItem.ExecuteWorkItem()
at System.Threading.ThreadPoolWorkQueue.Dispatch()|exTargetSite=|exSource=mscorlib|exMessage=Time-out interval must be less than 2^32-2.
Parameter name: dueTime
```

> [!NOTE]
> To determine whether you're experiencing this issue, verify that both of the following strings appear in the event data:
>
> - `MSExchangeMailboxAssistants, M.Exchange.Assistants, M.E.A.TimeBasedAssistantController.UpdateWorkCycle, System.ArgumentOutOfRangeException`
> - `exMessage=Time-out interval must be less than 2^32-2.Parameter name: dueTime`
>
> These symptoms may be caused by an administrator or by third-party applications (such as Odin or Parallels, which are used for hosted Exchange Server 2013 deployments). However, these symptoms don't occur in Exchange Server 2016 because the value of the `OABGeneratorWorkCycleCheckpoint` property can't be changed on an Exchange Server 2016 server.

## Cause

This issue occurs because the `OABGeneratorWorkCycleCheckpoint` property is set to a value greater than 49 on an Exchange Server 2013 mailbox server.

## Workaround

To work around this issue, run the following cmdlet to change the value of the `OABGeneratorWorkCycleCheckpoint` property to a value that's less than or equal to 49 days:

```powersshell
set-mailboxserver -OABGeneratorWorkCycleCheckpoint <value> -identity <servername>
```

> [!NOTE]
> The default value of the property is *1* day, and the string of the property resembles the following:  
`OABGeneratorWorkCycleCheckpoint : 01.00:00:00`

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
