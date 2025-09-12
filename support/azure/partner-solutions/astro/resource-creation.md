---
title: Troubleshoot Astro Resource Creation in Azure
description: Learn how to resolve issues when creating Astro resources in Azure, including permission and user profile requirements.
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve issues when I create Astro resources so that I can successfully set up Astro integration.
---

# Can't create Astro resources in Azure

This article helps you resolve common issues that you can encounter when you try to create Astro resources in Microsoft Azure. These issues include permission errors and missing user profile information.

## Prerequisites

- You must have `Owner` access on the Azure subscription to set up Astro integration.
- Make sure that your user profile in Azure contains all required business information.

## Symptoms

- When you try to create an Astro resource, you get an error message that indicates that you're not a subscription owner.
- You can't create an Astro resource because of missing details in your user profile.

## Cause 1: Not a subscription owner

Only users who have `Owner` access on the Azure subscription can set up the Astro integration.

### Solution 1

1. Verify your access level on the Azure subscription.
2. If you don't have `Owner` access, ask your Azure admin to grant you the required permissions before you start the integration setup.

## Cause 2: Missing details in user profile

Your user profile has to be updated to include key business information for Astro resource creation.

### Solution 2

1. In the Azure portal, select **Users**, and fill out the required details.

2. Search for your username in the user information screen.

3. Edit **UserInformation** to make sure that all required fields are completed.

## Additional troubleshooting

- If the deployment process takes more than three hours to complete, contact support.
- If the deployment fails and the Astro resource has a status of `Failed`, delete the resource. After deletion, try to create the resource again.
- If you get a DeploymentFailed error message, check the status of your Azure subscription. Make sure it isn't suspended and doesn't have any billing issues.