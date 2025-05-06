---
title: 50,000 seats are assigned to RIGHTSMANAGEMENT_ADHOC SKU in Microsoft 365
description: Describes a scenario where you see an RIGHTSMANAGEMENT_ADHOC entry that has 50,000 seats assigned to it.
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - no-azure-ad-ps-ref
ms.date: 04/18/2025
---

# 50,000 seats are assigned to the RIGHTSMANAGEMENT_ADHOC SKU in your Microsoft 365 organization

> [!NOTE]
> Microsoft Azure Information Protection was previously known as Microsoft Azure Rights Management.

## Problem

In your Microsoft 365 subscription, you see that 50,000 seats are assigned to the RIGHTSMANAGEMENT_ADHOC SKU.

## Cause

The RIGHTSMANAGEMENT_ADHOC entry represents the "Rights Management for individuals" subscription, which is a free offering that anyone in an organization can use after they sign up.

When a person in your organization signs up for this offering, Microsoft allocates 50,000 seats of RIGHTSMANAGEMENT_ADHOC to your organization. Licenses are assigned to users only if they sign up.

The existence of the RIGHTSMANAGEMENT_ADHOC SKU in your list of SKUs doesn't affect Microsoft Azure Rights Management functionality or any other Microsoft 365 functionality. Microsoft doesn't charge for this SKU.

## Solution

You can safely ignore the RIGHTSMANAGEMENT_ADHOC SKU entry.

If Azure Rights Management is disabled in your organization, Azure Rights Management functionality remains disabled. An update will be available in the future to manage this SKU.

## More information

For more information about Azure Rights Management for individuals, see [Introducing Microsoft Rights Management for individuals](https://techcommunity.microsoft.com/t5/enterprise-mobility-security/introducing-microsoft-rights-management-for-individuals/ba-p/247832).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
