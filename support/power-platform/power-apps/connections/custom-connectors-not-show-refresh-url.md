---
title: Refresh URL isn't displayed
description: Describes issues in which custom connectors don't show the configured Refresh URL when Generic Oauth 2 is used.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/17/2021
author: squassina
ms.author: risquass
---
# Refresh URL isn't displayed for custom connectors when using Generic Oauth 2

_Applies to:_ &nbsp; Power Platform, Custom Connectors

## Symptoms

When you try to verify the configuration of custom connectors that use **Generic Oauth 2** as the identity provider, you experience the following issues:

- The **Security** page shows placeholder text instead of the configured value in the **Refresh URL** field.

    :::image type="content" source="media/custom-connectors-not-show-refresh-url/refresh-url-security.png" alt-text="Screenshot of the Refresh U R L field on the Security page.":::

- In the Swagger Editor, the **Refresh URL** value isn't listed or displayed as a security definition.

    :::image type="content" source="media/custom-connectors-not-show-refresh-url/swagger-security-definitions.png" alt-text="Screenshot shows the Refresh U R L value isn't listed in the Swagger Editor.":::

## Cause

These issues are by design. After a custom connector is created, the configured **Refresh URL** value isn't displayed on either the **Security** page or in the Swagger Editor even though the other fields are populated as expected.

## Workaround

To update the **Refresh URL** value of a custom connector, you can set the value on the **Security** page, and select **Update connector**. Then, the value will be updated and saved to the connector configuration even though the configured value isn't displayed. For more information, see the [OAuth 2.0](/connectors/custom-connectors/connection-parameters#oauth-20) authentication type.
