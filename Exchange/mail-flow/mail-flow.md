---
title: "Mail flow and the transport pipeline"
ms.author: chrisda
author: chrisda
manager: serdars
ms.date: 6/8/2018
ms.audience: ITPro
ms.topic: overview
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.assetid: 14df5e1a-a5f7-4b0d-ba97-f53b76f0e7e0
description: "Summary: Learn about mail flow and the transport pipeline in Exchange Server 2016 or Exchange Server 2019."
---

# Mail flow and the transport pipeline

In Exchange Server, mail flow occurs through the transport pipeline. The *transport pipeline* is a collection of services, connections, components, and queues that work together to route all messages to the categorizer in the Transport service on an Exchange Mailbox server inside the organization.

For information about how to configure mail flow in a new Exchange 2016 or Exchange 2019 organization, see [Configure mail flow and client access](../plan-and-deploy/post-installation-tasks/configure-mail-flow-and-client-access.md).

## Understanding the transport pipeline
<a name="TransportPipeline"> </a>

The transport pipeline consists of the following services:

- **Front End Transport service on Mailbox servers**: This service acts as a stateless proxy for all inbound and (optionally) outbound external SMTP traffic for the Exchange Server organization. The Front End Transport service doesn't inspect message content, doesn't communicate with the Mailbox Transport service, and doesn't queue any messages locally.

- **Transport service on Mailbox servers**: This service is virtually identical to the Hub Transport server role in Exchange Server 2010. The Transport service handles all SMTP mail flow for the organization, performs message categorization, and performs message content inspection. Unlike Exchange 2010, the Transport service never communicates directly with mailbox databases. That task is now handled by the Mailbox Transport service. The Transport service routes messages among the Mailbox Transport service, the Transport service, the Front End Transport service, and (depending on your configuration) the Transport service on Edge Transport servers. The Transport service on Mailbox servers is described in more detail later in this topic.

- **Mailbox Transport service on Mailbox servers**: This service consists of two separate services:

  - **Mailbox Transport Submission service**: This service connects to the local mailbox database using an Exchange remote procedure call (RPC) to retrieve messages. The service submits the messages over SMTP to the Transport service on the local Mailbox server or on other Mailbox servers. The Mailbox Transport Submission service has access to the same routing topology information as the Transport service.

  - **Mailbox Transport Delivery service**: This service receives SMTP messages from the Transport service on the local Mailbox server or on other Mailbox servers and connects to the local mailbox database using RPC to deliver the messages.

    The Mailbox Transport service doesn't communicate with the Front End Transport service, the Mailbox Transport service, or mailbox databases on other Mailbox servers. It also doesn't queue any messages locally.

- **Transport service on Edge Transport servers**: This service is very similar to the Transport service on Mailbox servers. If you have an Edge Transport server installed in the perimeter network, all mail coming from the Internet or going to the Internet flows through the Transport service Edge Transport server. This service is described in more detail later in this topic.

The following diagram shows the relationships among the components in the Exchange transport pipeline.

> [!NOTE]
> Although the diagrams in this topic show the components on a single Exchange server, communication also occurs between those components on different Exchange servers. The only communication that always occurs on the local Exchange server is between the Mailbox Transport service and the local mailbox database.

**Overview of the transport pipeline in Exchange Server**

![Transport pipeline overview diagram](../media/Transport_PipelineOverview.png)

### How messages from external senders enter the transport pipeline
<a name="Inbound"> </a>

The way messages from outside the Exchange organization enter the transport pipeline depends on whether you have a subscribed Edge Transport server deployed in your perimeter network.

#### Inbound mail flow (no Edge Transport servers)

The following diagram and list describe inbound mail flow with only Exchange Mailbox servers.

![Inbound mail flow in the transport pipleline (no Edge Transport servers)](../media/45f8e675-43b1-4e3f-ba14-5c9a0d1551bf.png)

1. A message from outside the organization enters the transport pipeline through the default Receive connector named "Default Frontend _\<Mailbox server name\>_" in the Front End Transport service.

2. The message is sent to the Transport service on the local Mailbox server or on a different Mailbox server. The Transport service listens for messages on the default Receive connector named "Default _\<Mailbox server name\>_".

3. The message is sent from the Transport service to the Mailbox Transport Delivery service on the local Mailbox server or on a different Mailbox server.

4. The Mailbox Transport Delivery service uses RPC to deliver the message to the local mailbox database.

#### Inbound mail flow with Edge Transport servers

The following diagram and list describe inbound mail flow with an Edge Transport server installed in the perimeter network

![Inbound mail flow in the transport pipleline with Edge Transport servers](../media/e0983c92-784c-4c17-8483-8e2cb07cf097.png)

1. A message from outside the Exchange organization enters the transport pipeline through the default Receive connector named "Default internal Receive connector _\<Edge Transport server name\>_" in the Transport service on the Edge Transport server.

2. In the Transport service on the Edge Transport server, the default Send connector named "EdgeSync - Inbound to _\<Active Directory site name\>_" sends the message to a Mailbox server in the subscribed Active Directory site.

3. In the Front End Transport service on the Mailbox server, the default Receive connector named "Default Frontend _\<Mailbox server name\>_" accepts the message.

4. The message is sent from the Front End Transport service to the Transport service on the local Mailbox server or on a different Mailbox server. The Transport service listens for messages on the default Receive connector named "Default _\<Mailbox server name\>_".

5. The message is sent from the Transport service to the Mailbox Transport Delivery service on the local Mailbox server, or on a different Mailbox server.

6. The Mailbox Transport Delivery service uses RPC to deliver the message to the local mailbox database.

### How messages from internal senders enter the transport pipeline
<a name="Outbound"> </a>

SMTP messages from inside the organization enter the transport pipeline through the Transport service on a Mailbox server in one of the following ways:

- Through a Receive connector.

- From the Pickup directory or the Replay directory.

- From the Mailbox Transport Submission service.

- Through agent submission.

The message is routed based on the routing destination or delivery group.

#### Outbound mail flow (no Edge Transport servers)

By default, in a new Exchange Server organization, there's no Send connector that's configured to send messages to the Internet. You need to create the Send connector yourself. After you do that, Outbound mail flow occurs as described in the following diagram and list.

![Outbound mail flow in the transport pipleline (no Edge Transport servers)](../media/a672122e-435c-4e81-bd03-8f1643829e59.png)

1. The Mailbox Transport Submission service uses RPC to retrieve the outbound message from the local mailbox database.

2. The Mailbox Transport Submission service uses SMTP to send the message to the Transport service on the local Mailbox server or on a different Mailbox server.

3. In the Transport service, the default Receive connector named "Default _\<Mailbox server name\>_" accepts the message.

4. What happens next depends on the configuration of the Send connector:

  - **Default**: The Transport service uses the Send connector you created to send the message to the Internet.

  - **Outbound proxy**: The Transport service uses the Send connector you created to send the message to the Front End Transport service on the local Mailbox server or on a remote Mailbox server. In the Front End Transport service, the default Receive connector named "Outbound Proxy Frontend _\<Mailbox server name\>_" accepts the message. The Front End Transport services sends the message to the Internet.

#### Outbound mail flow with Edge Transport servers

If you have an Edge Transport server installed in the perimeter network, outbound mail never flows through the Front End Transport service. Outbound mail flow with an Edge Transport server is described in the following diagram and list.

![Outbound mail flow in the transport pipleline with Edge Transport servers](../media/2d0d3b5a-cc06-4dfa-8846-1a6885fdb19d.png)

1. The Mailbox Transport Submission service uses RPC to retrieve the outbound message from the local mailbox database.

2. The Mailbox Transport Submission service uses SMTP to send the message to the Transport service on the local Mailbox server or on a different Mailbox server.

3. In the Transport service on a Mailbox server in the subscribed Active Directory site, the default Receive connector named "Default _\<Mailbox server name\>_" accepts the message.

4. The message is sent to the Edge Transport server using the implicit and invisible intra-organization Send connector that automatically sends mail between Exchange servers in the same organization.

5. In the Transport service on the Edge Transport server, the default Receive connector named "Default internal Receive connector _\<Edge Transport server name\>_" accepts the message.

6. In the Transport service on the Edge Transport server, the default Send connector named "EdgeSync - _\<Active Directory site name\>_ to Internet" sends the message to the Internet.

## Understanding the Transport service on Mailbox servers
<a name="TransportService"> </a>

Every message that's sent or received in an Exchange Server organization must be categorized in the Transport service on a Mailbox server before it can be routed and delivered. After a message has been categorized, it's put in a delivery queue for delivery to the destination mailbox database, the destination database availability group (DAG), Active Directory site or Active Directory forest, or to the destination domain outside the organization.

The Transport service on a Mailbox server consists of the following components and processes:

- **SMTP Receive**: When messages are received by the Transport service, message content inspection is performed and antispam inspection is performed if is enabled. The SMTP session has a series of events that work together in a specific order to validate the contents of a message before it's accepted. After a message has passed completely through SMTP Receive and isn't rejected by receive events, or by an antispam agent, it's put in the Submission queue.

- **Submission**: Submission is the process of putting messages into the Submission queue. The categorizer picks up one message at a time for categorization. Submission happens in three ways:

  - From SMTP Receive through a Receive connector.

  - Through the Pickup directory or the Replay directory. These directories exist on Mailbox servers and Edge Transport servers. Correctly formatted message files that are copied into the Pickup directory or the Replay directory are put directly into the Submission queue.

  - Through a transport agent.

- **Categorizer**: The categorizer picks up one message at a time from the Submission queue. The categorizer completes the following steps:

  - Recipient resolution, which includes top-level addressing, distribution group expansion, and message bifurcation.

  - Routing resolution.

  - Content conversion.

    Additionally, mail flow rules that the organization defined are applied. After messages have been categorized, they're put into a delivery queue that's based on the destination of the message. Messages are queued by the destination mailbox database, DAG, Active Directory site, Active Directory forest, or external domain.

- **SMTP Send**: How messages are routed from the Transport service depends on the location of the message recipients relative to the Mailbox server where categorization occurred. The message could be routed to one of the following locations:

  - To the Mailbox Transport Delivery service on the same Mailbox server.

  - To the Mailbox Transport Delivery service on a different Mailbox server that's part of the same DAG.

  - To the Transport service on a Mailbox server in a different DAG, Active Directory site, or Active Directory forest.

  - For delivery to the Internet through:

  - A Send connector on the same Mailbox server.

  - The Transport service on a different Mailbox server.

  - The Front End Transport service on the same Mailbox server or a different Mailbox server (if outbound proxy is configured).

  - The Transport service on an Edge Transport server in the perimeter network.

## Understanding the Transport service on Edge Transport servers
<a name="EdgeTransportService"> </a>

The components of the Transport service on Edge Transport servers are identical to the components of the Transport service on Mailbox servers. However, what actually happens during each stage of processing on Edge Transport servers is different. The differences are described in the following list.

- **SMTP Receive**: When an Edge Transport server is subscribed to an internal Active Directory site, the default Receive connector named "Default \<Edge Transport server name\>" is automatically configured to accept mail from internal Mailbox servers and from the Internet. When Internet messages arrive at the Edge Transport server, antispam agents filter connections and message contents and help identify the sender and the recipient while the message is being accepted into the organization. The antispam agents are installed and enabled by default. Additional attachment filtering and connection filtering features are available, but built-in malware filtering is not. Also, transport rules are controlled by the Edge Rule agent. Compared to the Transport Rule agent on Mailbox servers, only a small subset of transport rule conditions are available on Edge Transport servers. But, there are unique transport rule actions related to SMTP connections that are available only on Edge Transport servers.

- **Submission**: On an Edge Transport server, messages typically enter the Submission queue through a Receive connector. However, the Pickup directory and the Replay directory are also available.

- **Categorizer**: On an Edge Transport server, categorization is a short process in which the message is put directly into a delivery queue for delivery to internal or external recipients.

- **SMTP Send**: When an Edge Transport server is subscribed to an internal Active Directory site, two Send connectors are automatically created and configured. One named "EdgeSync - \<Active Directory site name\> to Internet" is responsible for sending outbound mail to Internet recipients; the other named "EdgeSync - Inbound to \<Active Directory site name\>" is responsible for sending inbound mail from the Internet to internal recipients. Inbound mail is sent to the Front End Transport service on an available Mailbox server in the subscribed Active Directory site.


