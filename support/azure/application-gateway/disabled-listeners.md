---
title: Troubleshoot disabled listeners - Azure Application Gateway
titleSuffix: Azure Application Gateway
description: Learn how to identify why disabled listeners occur in Azure Application Gateway, resolve Key Vault access errors, and restore TLS termination.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
manager: dcscontentpm
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 08/28/2026
ms.custom: sap:Configuration and Setup,sfi-image-nochange
# Customer intent: As an IT administrator managing an Application Gateway, I want to troubleshoot disabled listeners due to Key Vault access issues, so that I can ensure the proper functioning of TLS termination and maintain the overall health of the gateway resource.
---

# Troubleshoot disabled listeners in Azure Application Gateway

## Summary

This article explains the concept of disabled listeners in Azure Application Gateway, the reasons behind their occurrence, and the steps to identify and resolve them.

You can reference the SSL/TLS certificates for Application Gateway's listeners from a customer's Azure Key Vault resource. Your application gateway must always have access to these resources (and its certificate object) to ensure smooth operations of the Transport Layer Security (TLS) termination feature and the overall health of the gateway resource.

Consider any impact on your Application Gateway resource when making changes or revoking access to your Key Vault resource. If the application gateway can't access the associated key vault or locate its certificate object, it automatically puts that listener into a disabled state. 

> [!NOTE]
> This action is triggered only for configuration errors. 

Any customer misconfigurations (like deletion or disablement of certificates or prohibiting the application gateway's access through Key Vault's firewall or permissions) can cause the key vault-based HTTPS listener to become disabled. Transient connectivity problems don't affect the listeners.

A disabled listener doesn't affect the traffic for other operational listeners on your Application Gateway. For example, the HTTP listeners or HTTPS listeners for which the .pfx certificate file is directly uploaded on the Application Gateway resource are never disabled.

The following illustration shows an example of an affected listener due to Key Vault access issues.

:::image type="content" source="../application-gateway/media/disabled-listeners/affected-listener.png" alt-text="An illustration showing affected listeners." lightbox="../application-gateway/media/disabled-listeners/affected-listener.png":::


## Periodic check and its impact on listeners

Understanding the behavior of the Application Gateway's periodic check and its potential impact on the state of a key vault-based listener can help you preempt such occurrences or resolve them much faster.

### How the periodic Key Vault check works

1. Application Gateway instances periodically poll the key vault resource to get a new certificate version.
1. During this activity, if the instances detect broken access to the Key Vault resource or a missing certificate object, the listeners associated with that key vault go into a disabled state. The instances update with a disabled status for the listeners within 60 seconds to provide consistent data plane behavior.
1. After the customer resolves the issue, the same four-hour periodic poll verifies access to the Key Vault certificate object and automatically re-enables listeners on all instances of that gateway.

## Identify disabled listeners

- The clients see the error "ERR_SSL_UNRECOGNIZED_NAME_ALERT" if they make any request to a disabled listener of your Application Gateway as shown in the following illustration.

:::image type="content" source="../application-gateway/media/disabled-listeners/client-error.png" alt-text="Screenshot of the client error ERR_SSL_UNRECOGNIZED_NAME_ALERT." lightbox="../application-gateway/media/disabled-listeners/client-error.png":::


1. You can verify if the client error results from a disabled listener on your gateway by checking your [Application Gateway's Resource Health page](/azure/application-gateway/resource-health-overview), as shown in the following illustration.

:::image type="content" source="../application-gateway/media/disabled-listeners/resource-health-event.png" alt-text="Screenshot of the user-driven resource health event on the Application Gateway Resource Health page." lightbox="../application-gateway/media/disabled-listeners/resource-health-event.png":::

## Resolve Key Vault configuration errors

You can narrow down the exact cause and find steps to resolve the problem by visiting the Azure Advisor recommendation in your account.
To do this, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Select **Advisor**.
1. Select the **Operational Excellence** category from the menu.
1. Find the recommendation titled **Resolve Azure Key Vault issue for your Application Gateway** (shown only if your gateway is experiencing this issue). Ensure the correct subscription is selected.
1. Select it to view the error details and the associated Key Vault resource along with the [troubleshooting guide](/azure/application-gateway/application-gateway-key-vault-common-errors) to fix your exact issue.

> [!NOTE]
> The disabled listeners are automatically enabled if Application Gateway resource detects the underlying problem is resolved. This check occurs every four hours. You can expedite it by performing any minor change to Application Gateway (for example, **HTTP Setting**, **Resource Tags**, and so on). This change forces a check against the Key Vault.

## References

[Troubleshooting key vault errors in Azure Application Gateway](/azure/application-gateway/application-gateway-key-vault-common-errors)
