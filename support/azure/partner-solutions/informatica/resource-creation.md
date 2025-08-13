---
title: Troubleshoot Informatica Resource Creation in Azure
description: Learn how to resolve issues when creating Informatica resources in Azure, including permission and user profile requirements.
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution 
ms.date: 08/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve issues when I create Informatica resources so that I can successfully set up Informatica integration.
---

# Can't create Informatica resource in Azure

This article helps you resolve common issues that you might encounter when you try to create Informatica resources in Microsoft Azure. These issues include permission errors and missing user profile information.

## Prerequisites

- You must have **Owner** access on the Azure subscription to set up Informatica integration.
- Make sure that your user profile in Azure contains all required business information.

## Symptoms

- When you try to create an Informatica resource, you receive an error message that indicates that you're not a subscription owner.
- You can't create an Informatica resource because of missing details in your user profile.

## Cause 1: Not a subscription owner

Only users who have _Owner_ access on the Azure subscription can set up the Informatica integration.

### Solution 1

1. Verify your access level on the Azure subscription.
1. If you don't have **Owner** access, ask your Azure administrator to grant you the required permissions before you start the integration setup.

## Cause 2: Missing details in user profile

Your user profile has to be updated to include key business information for Informatica resource creation.

### Solution 2

1. In the Azure portal, select **Users**, and fill out the required details.

    :::image type="content" source="media/user.png" alt-text="Screenshot that shows the user resource provider in the Azure portal.":::

1. Search for your username in the user information screen.

    :::image type="content" source="media/user-search.png" alt-text="Screenshot that shows searching for the username in the Azure portal.":::

1. Edit **UserInformation** to make sure that all required fields are completed.

    :::image type="content" source="media/user-info.png" alt-text="Screenshot that shows the user information screen in the Azure portal.":::
