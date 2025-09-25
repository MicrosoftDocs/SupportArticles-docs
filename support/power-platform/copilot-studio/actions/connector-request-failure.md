---
title: "Troubleshoot connector request failure"
description: "Troubleshoot connector request failure due to too much returned data using filtering."
ms.date: 10/16/2024
ms.topic: troubleshooting-problem-resolution
ms.reviewer:
  - peterswimm
  - erickinser
ms.custom: sap:Actions\Connector actions
---

# Connector request failure

When using connector actions with custom agents, you may encounter an HTTP error code 400 with the message _Error Code: 400, Error Message: Bad Request_. This error occurs when the request from the connector to the service returns too much data. Copilot Studio limits connector responses to 500 KB. This may happen whether the connector is configured for a specific topic or as an agent-wide action.

If you experience this issue, you need to take steps to filter the responses returned to the connector. You can do this by configuring the inputs to the connector action so that the service returns only the data the agent really needs to respond to the user's request.

## How to resolve

Each connector action has a set of inputs and outputs. Most connectors include inputs that can be used to filter the data request.
The details of this will vary from connector to connector. You can view information for specific connectors in the [connectors documentation](/connectors/).

For example, suppose you are using a connector to ServiceNow with the [getKnowledgeArticles](/connectors/service-now/#get-knowledge-articles) action enabled.

This action has a `Filter` input parameter that you can use to enter a filter query to limit the data returned by the service. You can also use the `Limit` input parameter to limit the number of records returned to the top few results.

These inputs can be configured in Copilot Studio. The configuration details depend on whether the connector action is configured as an agent-wide action or as a topic-specific connector action.

### Agent-wide action

To configure for an agent-wide action, follow these steps:

1. Under **Agents**, select the agent with the connector you want to configure.

1. Select **Actions** to see the list of actions associated with the agent.

1. Select the action you want to configure from the list of actions.

1. Select **Inputs** and edit the information for the input field you want to configure.

### Topic-specific connector action

To configure for a topic-specific connector action, follow these steps:

1. Under **Agents**, select the agent with the connector you want to configure.

1. Select **Topics** to see the list of topics for the agent.

1. Select the topic you want to configure. You can see the canvas for the topic flow.

1. On the canvas select the connector node for the connector you want to configure.

    The typical inputs that are identified from the user input are displayed under **Inputs**.

1. Select **Advanced inputs** to access configurations for additional inputs.

1. Configure the inputs as needed to filter your responses.
