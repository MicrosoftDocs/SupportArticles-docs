---
title: MSMQ not sending or listening for Multicast messages
description: This article provides resolutions for the problem where MSMQ not sending or listening for Multicast messages.
ms.date: 09/24/2020
ms.prod-support-area-path: 
ms.reviewer: adamwich
---
# MSMQ not sending or listening for Multicast messages

This article helps you resolve the problem where MSMQ not sending or listening for Multicast messages.

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 2000902

## Symptoms

MSMQ not sending or listening for Multicast messages.

## Cause

The problem is caused by the absence of **Reliable Multicast Protocol** for the Network Connection.

## Resolution

The solution is to manually add the missing `RMCAST` protocol to the Network Connection.

1. Open Control Panel - Network Connections.
2. Right click "Local Area Connection" and select Properties.
3. Click Install...
4. Select **Protocol** then click **Add**...
5. If **Reliable Multicast Protocol** is not available in the list, you may have to browse the Windows installation media, for example, under `\I386\INF` folder.
6. Select *NETPGM.INF* and choose **OK**. (The edit box will just display `<drive>:\I386\INF`, but this is expected.)
7. Select **Reliable Multicast Protocol** then click **OK**.
8. Stop and Restart Message Queuing Service.

Multicasting messages should now start working.  

## More information

There were a couple of symptoms found in testing:

1. Cannot receive multicast messages in the application event log, MSMQ generated an event 2160:

    > "The queue cannot listen/bind to the multicast address 234.1.1.1:8001 (Error:273c)." 0x273C translates to 10044 - WSAESOCKTNOSUPPORT - "The support for the specified socket type does not exist in this address family."

1. Unable to send multicast messages In Computer Management, the outgoing queue would stay in a 'waiting to connect' state.  What made the troubleshooting tricky was that the multicasting driver (*RMCAST.SYS*) seemed to be installed. At the command prompt, we could execute `NET STOP RMCAST` and `NET START RMCAST` without error. Also, the Message Queuing service had a dependency on RMCAST so if the Multicast driver was down, MSMQ would not have started anyway.
