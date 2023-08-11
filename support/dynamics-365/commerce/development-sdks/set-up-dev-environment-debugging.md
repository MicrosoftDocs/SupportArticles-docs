---

title: Set up an e-commerce development environment to debug against a Tier 1 Retail Server virtual machine
description: This article explains how to set up an e-commerce development environment to debug against a Tier 1 Retail Server virtual machine (VM).
author: Reza-Assadi
ms.author: josaw
ms.topic: troubleshooting
ms.date: 03/11/2021

---

# Set up an e-commerce development environment to debug against a Tier 1 Retail Server virtual machine

This article explains how to set up an e-commerce development environment to debug against a Tier 1 Retail Server virtual machine (VM).

## Description

Microsoft Dynamics 365 Commerce Tier 1 environments are typically deployed for Commerce runtime (CRT) and point of sale (POS) extension development. They are standalone environments. Because of the software as a service (SaaS) nature of the architecture, they don't include e-commerce components.

In some scenarios, you might want to test calls to extensions in a Tier 1 environment, so that you can debug extensions from e-commerce components. For general instructions, see [Debug against a Tier 1 Commerce development environment](/dynamics365/commerce/e-commerce-extensibility/debug-tier-1).

When you debug against a Tier 1 environment, because the site is now calling a different Retail Server, cross-server calls might cause various errors that are related to the content security policy.

The following illustration shows an example of an error that might occur when a variant is selected on a product details page.

![Error when a variant is selected on a product details page.](../../../media/common/unhandled-rejection-error.jpg)

The following illustration shows an example of a similar error in a browser's debugger tools (F12 Developer Tools). The error message mentions violation of the content security policy directive.

![Debugger tools error.](../../../media/common/debugger-tools-error.jpg)

## Resolution

### Disable the content security policy for the site in Commerce site builder

1. Select the site that you're working on.
1. Select **Settings**, and then select **Extensions**.
1. On the **Content security policy** tab, select **Disable content security policy**.
1. Select **Save and publish**.

> [!NOTE]
> Business-to-consumer (B2C) sign-in won't work in a local development environment. However, you can use guest checkouts or build page mocks to simulate a user sign-in as required.

## Additional resources

[Get started with e-commerce online extensibility development](/dynamics365/commerce/e-commerce-extensibility/sdk-getting-started)

[Manage content security policy (CSP) on e-commerce site](/dynamics365/commerce/manage-csp)
