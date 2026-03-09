---
title: Fix Connector Request Failure in Copilot Studio
description: Resolve HTTP 400 Bad Request errors in Microsoft Copilot Studio caused by connector responses exceeding the 500 KB limit. Learn how to filter data effectively.
ms.date: 03/06/2026
ms.reviewer: ankmak, erickinser, v-shaywood
ms.custom: sap:Actions\Connector actions
---

# Connector request failure

## Summary

This article helps you resolve an HTTP 400 Bad Request error that occurs when a [connector](/connectors/) action returns too much data in Microsoft Copilot Studio. Connector responses are limited to 500 KB. A response that exceeds this limit causes the request to fail. This problem can occur whether you configure the connector as an agent-wide action or a topic-specific action. To fix this error, configure the connector action inputs to filter the data that the service returns.

## Symptoms

When you use connector tools together with custom agents in Copilot Studio, you encounter HTTP error code 400 and receive the following message:

> Error Code: 400, Error Message: Bad Request

## Cause

The connector request to the service returns more than 500 KB of data. This amount exceeds the Copilot Studio connector response limit.

## Solution

Filter the connector response data by configuring the inputs to the connector action. Most connectors include input parameters that limit the data that the service returns. The available parameters vary by connector. For connector-specific details, see the [connectors documentation](/connectors/).

For example, the ServiceNow connector [Get Knowledge Articles](/connectors/service-now/#get-knowledge-articles) action provides these filtering options:

- `Filter` input parameter - accepts a filter query to limit results
- `Limit` input parameter - restricts the number of records that are returned

Configure these inputs in Copilot Studio by using the steps for either an agent-wide or a topic-specific connector tool.

### Agent-wide connector tool

1. Under **Agents**, select the agent that has the connector that you want to configure.

1. Select **Tools** to see the list of actions that are associated with the agent.

1. Select the tool that you want to configure.

1. Select **Inputs**, and then edit the input field that you want to configure.

### Topic-specific connector tool

1. Under **Agents**, select the agent that has the connector that you want to configure.

1. Select **Topics** to see the list of topics for the agent.

1. Select the topic that you want to configure to open the canvas for the topic flow.

1. On the canvas, select the connector node for the connector that you want to configure. The typical inputs that are identified from user input are displayed under **Inputs**.

1. Select **Advanced inputs** to access configurations for more input parameters.

1. Configure the inputs to filter responses.

## Related content

- [Use Power Platform connectors as tools](/microsoft-copilot-studio/advanced-connectors)
- [Quotas and limits for Copilot Studio](/microsoft-copilot-studio/requirements-quotas)
