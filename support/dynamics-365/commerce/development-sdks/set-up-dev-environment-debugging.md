---
title: Errors when debugging against a Tier 1 Retail Server virtual machine
description: Resolves errors that occur when you debug a Tier 1 Retail Server VM in an e-commerce development environment in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Development and SDKs\Issues with e-commerce module development
---
# Errors when you debug against a Tier 1 Retail Server virtual machine in an e-commerce development environment

This article provides a resolution for an issue where you might receive an error when you debug against a Tier 1 Retail Server virtual machine (VM) in an e-commerce development environment in Microsoft Dynamics 365 Commerce.

## Introduction

Microsoft Dynamics 365 Commerce Tier 1 environments are typically deployed for [Commerce runtime (CRT)](/dynamics365/commerce/dev-itpro/crt-services) and [point of sale (POS) extension](/dynamics365/commerce/dev-itpro/pos-extension/pos-extension-overview) development. They are standalone environments. Because of the software as a service (SaaS) nature of the architecture, they don't include e-commerce components.

In some scenarios, you might need to test calls to extensions in a Tier 1 environment so that you can debug extensions from e-commerce components. For general instructions, see [Debug against a Tier 1 Commerce development environment](/dynamics365/commerce/e-commerce-extensibility/debug-tier-1).

## Symptoms

When you debug against a Tier 1 environment, because the site is now calling a different Retail Server, cross-server calls might cause various errors that are related to the content security policy.

The following screenshot shows an example of an error that might occur when a variant is selected on a product details page.

> Unhandled Rejection (ActionError): Error

:::image type="content" source="media/set-up-dev-environment-debugging/unhandled-rejection-error.png" alt-text="Screenshot that shows an Unhandled Rejection Action error.":::

The following screenshot shows an example of a similar error in a browser's debugger tools (F12 Developer Tools). The error message mentions a violation of the content security policy directive.

:::image type="content" source="media/set-up-dev-environment-debugging/debugger-tools-error.png" alt-text="Screenshot that shows an error that mentions a violation of the content security policy directive in a browser's debugger tools.":::

## Resolution

To solve this issue, disable the [content security policy (CSP)](/dynamics365/commerce/manage-csp) for the site in Dynamics 365 Commerce site builder.

1. Select the site that you're working on.
1. Select **Settings** > **Extensions**.
1. On the **Content security policy** tab, select **Disable content security policy**.
1. Select **Save and publish**.

> [!NOTE]
> Business-to-consumer (B2C) sign-in won't work in a local development environment. However, you can use guest checkouts or build page mocks to simulate a user sign-in as required.

## More information

[Get started with e-commerce online extensibility development](/dynamics365/commerce/e-commerce-extensibility/sdk-getting-started)
