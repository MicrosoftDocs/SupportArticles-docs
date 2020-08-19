---
title: MSMQ functions over Network Load Balancing
description: This article describes how to support Network Load Balancing in Microsoft Message Queuing.
ms.date: 07/23/2020
ms.prod-support-area-path: 
ms.reviewer: nicoleh
ms.topic: how to
---
# Message Queuing can function over Network Load Balancing

This article describes how Microsoft Message Queuing (MSMQ) can function over Network Load Balancing (NLB).

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 899611

## Introduction

The following article discusses how MSMQ can function over NLB. This article also discusses possible incorrect configurations of MSMQ.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Supported configurations

MSMQ is supported in an NLB environment for both sending and receiving messages in the following configurations:

- Non-transactional messaging by using Direct=TCP
- Non-transactional messaging by using Direct=OS with validation disabled
- Non-transactional messaging by using Direct=HTTP
- Transactional messaging by using a specific configuration that uses store and forward servers and a single back-end server.

> [!NOTE]
> Only private queues are supported destinations in any one of these configurations. Because the virtual network name will not have a corresponding Active Directory directory service object, the properties of the destination queue cannot be queried. You may be able to send messages to public queues as long as the public queues are accessed by using a direct format name instead of by using the standard path.

### Non-transactional messaging by using Direct=TCP

This configuration functions without any particular configuration changes.

### Non-transactional messaging by using Direct=OS

This configuration only works when validation is disabled. To disable validation, you must add the following registry key in MSMQ 2.0 together with Windows 2000 and in MSMQ 3.0 together with Windows XP or Windows Server 2003.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. Follow these steps, and then quit Registry Editor:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following key in the registry:  
 `HKEY_LOCAL_MACHINE\Software\Microsoft\MSMQ\Parameters`
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *IgnoreOSNameValidation*, and then press **ENTER**.
5. On the **Edit** menu, click **Modify**.
6. Type *1*, and then click **OK**.

By default, MSMQ verifies the message that it receives to determine whether the message is intended for the local computer. If the message is not intended for the local computer, the message is rejected.

When a message is sent to a server that is behind a network load balancer, the message is sent by using the name of the load balancer or by using the network name that is assigned to the virtual IP in the network load balancer. Then, the network load balancer routes the message to an MSMQ receiver. However, the local Queue Manager on the MSMQ receiver identifies that the computer name and the destination name in the message do not match, and the Queue Manager discards the message. After you set this registry value, MSMQ no longer validates the destination computer name and will accept the message.

### Non-transactional messaging by using Direct=HTTP

This configuration is supported without any particular configuration changes.

### Transactional messaging by using a specific configuration that uses store and forward servers and a single back-end server

In this configuration, transactional messaging only supports HTTP messaging when nodes that receive messages map the receiving queue to a single back-end server. The HTTP transactional messages are not supported when the destination queues are on the individual nodes.

For more information about this configuration, see the *Microsoft Message Queuing (MSMQ) HTTP Deployment Scenarios for Windows Server 2003 and Windows XP Professional* white paper.

A configuration for transactional messaging where the destination queues reside on each member node behind a load balancer does not support sending or receiving messages for the following reasons:

- Duplicate messages
- Unacknowledged messages on senders
- Incomplete transactions

## Transactional messages and acknowledgments

When a transactional message is received by a computer, the message is written to storage, the message is logged, and an order acknowledgment is sent back to the sender. The order acknowledgment is sent back to the IP address that the original message came from by using direct=TCP. Then, the message is received by the sender, and the message is removed from the outgoing queue.

When an acknowledgment is not received by the sending server within a specified time, the original message is resent. When the message arrives at the destination, the destination server examines the log and finds that the server has already received that message. Therefore, the destination server rejects the message and sends back another acknowledgment. The destination server will continue to send acknowledgments until the order acknowledgment is received by the sender. The logging prevents a duplicate message from being received, and the order acknowledgment confirms to the sender that the message was received.

## Problems with network load balancers and transactional messages

When a message is sent through a load balancer, the destination computer sees the message as coming from the load balancer. Then, the destination computer sends the order acknowledgment through a new session. Therefore, the load balancer cannot use the same logic for maintaining state for a Web server or for a similar service.

The most common problem in this scenario is that several servers send messages across a load balancer, but all the order acknowledgments are sent to the incorrect server. This behavior causes unacknowledged messages to build up in the outgoing queue of sending computers. Additionally, when the order acknowledgment is not received by the sender, the sender will resend the message. The second try to send the message through the load balancer may send the message to a different computer. This computer will not have seen this message before, and the message will be processed as a new message. Remember that validation was disabled to allow for messages to travel across the NLB.

A message that was sent across a load balancer may be received and processed one time by all the servers that are behind the load balancer before an order acknowledgment is received. Additionally, transactions that span several messages cannot always be processed or arrive in order. Therefore, MSMQ does not support sending transactional messages when you use an NLB.
