---
title: Refresh URL isn't displayed
description: Describes issues in which custom connectors don't show the configured Refresh URL when Generic Oauth 2 is used.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 6/17/2021
---
# Refresh URL isn't displayed for custom connectors when using Generic Oauth 2

_Applies to:_ &nbsp; Power Automate, Custom Connectors

## Symptoms

When you try to verify the configuration of custom connectors that using **Generic Oauth 2** as the identity provider, you experience the following issues:

- The **Security** page shows the placeholder text instead of the configured value in the **Refresh URL** field.

    :::image type="content" source="./media/custom-connectors-not-show-refresh-url/refresh-url-security.png" alt-text="A screenshot of the Security page.":::

- In the Swagger Editor, the **Refresh URL** value isn't listed and displayed as a security definition.

    :::image type="content" source="./media/custom-connectors-not-show-refresh-url/swagger-security-definitions.png" alt-text="A screenshot of the Swagger Editor.":::

## Cause

These issues are by design. After a custom connector is created, only the configured **Refresh URL** value isn't displayed on the **Security** page or in the Swagger Editor.

## Workaround

To update the **Refresh URL** value of a custom connector, you can set the value on the **Security** page and select **Update connector**. Then, the value will be updated and saved to the connector configuration even though the configured value isn't displayed. For more information, see the [OAuth 2.0](/connectors/custom-connectors/connection-parameters#oauth-20) authentication type.
