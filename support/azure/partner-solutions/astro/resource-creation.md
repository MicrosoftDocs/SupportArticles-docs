---
title: Troubleshoot Astro Resource Creation in Azure
description: Learn how to resolve issues when creating Astro resources in Azure, including permission and user profile requirements.
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick, v-ryanberg
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.custom:
  - sap:Apache Airflow on Astro - an Azure Native ISV Service
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve issues when I create Astro resources so that I can successfully set up Astro integration.
---

# Can't create Astro resources in Azure

This article helps you resolve common issues that you might encounter when you try to create Astro resources in Microsoft Azure. These issues include permission errors and missing user profile information.

## Prerequisites

- You must have `Owner` access on the Azure subscription to set up Astro integration.
- Your user profile in Azure must contain all required business information.

## Symptoms

- When you try to create an Astro resource, you receive an error message that states that you're not a subscription owner.
- You can't create an Astro resource because of missing details in your user profile.

## Cause 1: Not a subscription owner

Only users who have `Owner` access on the Azure subscription can set up the Astro integration.

### Solution 1

1. Verify your access level on the Azure subscription.
2. If you don't have `Owner` access, ask your Azure administrator to grant you the required permissions before you start the integration setup.

## Cause 2: Missing details in user profile

Your user profile has to be updated to include key business information for Astro resource creation.

### Solution 2

1. In the Azure portal, select **Users**, and complete the required details.
2. In the user information screen, search for your username.
3. Edit **UserInformation** to complete all required fields.

## Additional troubleshooting

- If the deployment process takes more than three hours to complete, contact support.
- If the deployment fails and the Astro resource has a status of `Failed`, delete the resource. Then, try again to create the resource.
- If you receive a "DeploymentFailed" error message, check the status of your Azure subscription. Make sure that it isn't suspended and has no billing issues.

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

 