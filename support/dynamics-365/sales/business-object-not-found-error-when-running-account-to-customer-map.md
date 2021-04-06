---
title: Business object not found error when running Account to Customer map in Dynamics GP Connector
description: When you run the Account to Customer map in Microsoft Dynamics GP Connector, you receive a Business object not found error. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 
---
# "Business object not found" error when running the Account to Customer map in Microsoft Dynamics GP Connector

This article provides a resolution for the issue that you may receive the **Business object not found** error when running the Account to Customer map in Microsoft Dynamics GP Connector.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2502754

## Symptoms

When running the Account to Customer map to integrate Microsoft Dynamics CRM accounts to Microsoft Dynamics GP customers, the following error occurs:

> [Account to Customer] has encountered an error while processing key [key]. Business object not found.

Users may also receive script errors in Microsoft Dynamics CRM when opening account records.

## Cause

The Address Name attribute was removed from the Microsoft Dynamics CRM Account form.

## Resolution

Add the Address Name attribute back to the Microsoft Dynamics CRM Account form by following the steps below:

1. Point to **Settings**, select **Customizations**, select **Customize Entities** and select **Account** from the list.
2. Select **Forms and Views**, and select **Form** from the list.
3. Select **Add Fields**.
4. Select Address 1: Name from the list, specify a location, and select OK.
5. Save your changes and publish customizations.
