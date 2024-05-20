---
title: Sellers can't make a phone call to PSTN in Dynamics 365 Sales
description: Provides resolutions for an issue where a seller can't make a phone call to a PSTN number in Microsoft Dynamics 365 Sales.
ms.date: 08/22/2023
ms.reviewer: asaftzuk, ilanak
author: t-ronioded
ms.author: ronihemed
---
# Sellers can't make a phone call to a PSTN number

This article provides resolutions for an issue where a seller can't make a phone call to a Public Switched Telephone Network (PSTN) number using [Microsoft Teams dialer](/dynamics365/sales/configure-microsoft-teams-dialer).

## Symptoms

As a seller, when you use Microsoft Teams for desktop or Microsoft Teams on the web, one of the following issues occur:

- You can't make a phone call to a PSTN number through Microsoft Teams dialer, and you receive the following error message:

  > Something went wrong  
  > Make sure the record has a valid phone number and try again.

  :::image type="content" source="media/cannot-make-phone-calls-to-pstn/no-phone-number-assigned-error.png" alt-text="Screenshot that shows the error that occurs when a seller can't make a phone call to a PSTN number.":::

- There's no work number displayed in Microsoft Teams.

  :::image type="content" source="media/cannot-make-phone-calls-to-pstn/check-work-number.png" alt-text="Screenshot that shows where the work number should be displayed in Microsoft Teams.":::

## Cause 1: The seller doesn't have a Teams license or phone number assigned

#### Resolution

To resolve this issue, [assign Teams add-on licenses to users](/microsoftteams/teams-add-on-licensing/assign-teams-add-on-licenses) or [assign a phone number for a user](/microsoftteams/assign-change-or-remove-a-phone-number-for-a-user#assign-a-phone-number-to-a-user).

## Cause 2: Cached browsing data

#### Resolution

To resolve this issue, follow the [Microsoft Teams dialer basic troubleshooting steps](dialer-basic-troubleshooting.md).
