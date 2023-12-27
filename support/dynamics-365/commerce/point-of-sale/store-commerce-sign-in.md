---
title: Troubleshoot Store Commerce sign-in issues
description: Explains how to solve the sign-in issues in the Microsoft Dynamics 365 Commerce Store Commerce app.
author: josaw1 
ms.author: josaw
ms.reviewer: brstor
ms.date: 09/01/2023
---
# Troubleshoot Store Commerce sign-in issues

This article explains how to troubleshoot sign-in issues in the Microsoft Dynamics 365 Commerce Store Commerce app.

## Symptoms

After you enter employee credentials on a point of sale (POS) sign-in screen, you might receive an error message like the following one:

> Audience validation failed. Contact your system administrator to properly configure identity providers in Commerce headquarters.

## Resolution 1

If the POS application is configured to use the personal ID and password sign-in authentication method, follow these steps to solve the issue:

1. In Commerce headquarters, go to **Commerce shared parameters** > **Identity Providers**.
1. For the **Commerce Identity Provider** identity provider issuer, in the **Relying parties** section, ensure that the **Cloud POS** and **Modern POS** records are correctly configured.

## Resolution 2

If the POS application is configured to use the Microsoft Entra sign-in authentication method, follow these steps to solve the issue:

1. In Commerce headquarters, go to **Commerce shared parameters** > Identity Providers**.
1. For identity provider issuers of the **Microsoft Entra ID** type, in the **Relying parties** and **Server resource IDs** sections, ensure that the records are correctly configured.

For detailed configuration steps, see [Update identity providers settings in Commerce headquarters](/dynamics365/commerce/cpos-custom-aad#update-identity-providers-settings-in-commerce-headquarters).
