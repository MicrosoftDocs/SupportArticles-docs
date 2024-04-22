---
title: Forms show an error about being read-only
description: Resolves the issues with read-only forms in Dynamics 365 Field Service.
author: jshotts
ms.author: jasonshotts
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:Customizations and Integrations
---
# Forms show an error about being read-only in Dynamics 365 Field Service

This article helps resolve an error message that occurs in Microsoft Dynamics 365 Field Service forms.

## Symptoms

The error message occurs in the Dynamics 365 Field Service forms:

> This form can only be used on service-maintenance based records. Record is read only.

## Resolution

The Dynamics 365 Field Service makes the out-of-the-box Field Service opportunity, lead, quote, and invoice forms read-only once Field Service detects the record isn't a service-maintenance based record. Field Service forms or the forms copied from Field Service forms don't support opportunity, lead, quote, and invoice records other than Field Service opportunity, lead, quote, and invoice.

To use an opportunity form for non-Field Service-related opportunities, use the out-of-the-box opportunity (**Opportunity: Opportunity**) form or create a copy of the Field Service form for further customization. The same applies for the Field Service forms for lead, quote, and invoice.
