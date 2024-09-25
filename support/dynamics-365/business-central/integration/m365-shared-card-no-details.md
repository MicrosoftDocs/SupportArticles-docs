---
title: Card from a shared link is minimal and doesn't include Details button
description: Provides a resolution for an issue that occurs when sharing a Business Central link in Teams.
ms.author: mikebc
ms.reviewer: jswymer
ms.date: 05/20/2024
ms.custom: sap:Integration\Teams
---
# Card from a shared link is minimal and doesn't include the "Details" button

This article provides a resolution for an issue where cards from a shared link are minimal and don't include the **Details** button in Microsoft Dynamics 365 Business Central.

## Symptoms

When a Microsoft 365 license holder without a Business Central license [shares a Business Central link in Microsoft Teams](/dynamics365/business-central/across-working-with-teams), it automatically expands into a card that has no useful information and only shows Business Central without the **Details** button.

## Cause

Users who have a Microsoft 365 license but no Business Central licenses aren't allowed to share links as cards. If the user has the Business Central app for Teams installed and pastes a link into the compose area, only a minimal card is displayed.

## Resolution

To [share a Business Central link as a card in Teams](/dynamics365/business-central/across-working-with-teams#include-a-business-central-card-in-a-teams-conversation), users must have a Business Central license.

## More information

- [Business Central and Microsoft Teams Integration](/dynamics365/business-central/across-teams-overview)
- [Business Central Access with Microsoft 365 Licenses](/dynamics365/business-central/admin-access-with-m365-license)
