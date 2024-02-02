---
title: Troubleshooting Flow Custom Connectors
description: Provide a guide for errors with defining Custom Connectors.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: power-automate-connections
---
# Troubleshooting Flow Custom Connectors

This article provides some troubleshooting steps and possible solutions to errors you might see while creating custom connectors in Flow or Power Apps.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4526409

## Custom Connector Test 500 error

> Error 500: Expression value is invalid. The template field is required.

:::image type="content" source="media/troubleshooting-flow-custom-connectors/operation-failed-500.png" alt-text="Screenshot of the custom connector test 500 error.":::

There can be several reasons for what might be causing this issue, but the most common reason is related to how the path and host fields are defined in the swagger. The path of each action is relative to the host of the API you're trying to reach, which ends up getting constructed as **\<host/path>**.

For this construction to happen successfully and to properly reach your API's endpoint, the path for the specific action can't be **/**. You should try having a path with **/** and a string value afterwards (such as `/foo/`) instead of just **/**.

## Example

Suppose you want to call the endpoint `contoso.com/helloworld`. When configuring your custom connector, you might see that the swagger is defined as:

:::image type="content" source="media/troubleshooting-flow-custom-connectors/define-the-swagger.png" alt-text="Screenshot shows the invalid swagger when configuring the custom connector.":::

The problem here's that the host has the name of the endpoint we're trying to call, but the path should be the one with the endpoint name of `/helloworld`. So the correct way of defining it is:

:::image type="content" source="media/troubleshooting-flow-custom-connectors/define-the-swagger-correctly.png" alt-text="Screenshot of the correctly configured custom connector.":::

For more information, see [Paths and Operations](https://swagger.io/docs/specification/paths-and-operations/).
