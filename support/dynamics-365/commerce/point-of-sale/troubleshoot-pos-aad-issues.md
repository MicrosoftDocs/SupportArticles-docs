---
title: Troubleshooting Microsoft Entra ID sign-in issues with POS
description: Provides a resolution for Microsoft Entra ID (formerly Azure Active Directory (AAD)) sign-in issues when you use Point of Sale (POS) on Cloud Hosted Environments (CHE).
author: raybennett-msft
ms.author: bennettray
ms.date: 05/07/2024
ms.custom: sap:Point of sale (POS)\Issues with Store Commerce app reliability
#customer intent: As a developer, I want to resolve login issues with POS so that I can utilize POS on my CHE.
---
# Known issues: Commerce POS

This article helps you to troubleshoot Microsoft Entra ID (formerly Azure Active Directory (AAD)) sign-in issues when you use Point of Sale (POS) on Cloud Hosted Environments (CHE).

## POS reports an error that the redirect URI wasn't found

If you use non-PROD development virtual machines (VMs), such as those that originate from Life Cycle Services (LCS), can't interact with Microsoft Entra ID from within Cloud Point of Sale (CPOS) that are predeployed on those boxes. The error message shows that there's an issue that affects the Reply URL mismatch. This issue includes Device Activation and Employee Login if CPOS was set up to use Microsoft Entra ID for the Employee Login.

The error message would resemble the error message that's displayed here, except that the redirect URI would end with any of these domains:

`.axcloud.dynamics.com`  
`.cloud.onebox.dynamics.com`

:::image type="content" source="media/troubleshoot-pos-aad-issues/redirect-uri-does-not-match-for-application-error.png" alt-text="Example of an error message encountered.":::

## Description

That predeployed CPOS is based on the Retail SDK. The last Cloud Scale Unit (CSU) version where the Retail SDK was supported is 10.0.37, which was [retired](/dynamics365/fin-ops-core/dev-itpro/get-started/public-preview-releases#targeted-release-schedule-dates-subject-to-change) on March 15, 2024.

Although Microsoft continues to improve on internal infrastructure, a recent change prevents the CPOS (Store Commerce for Web) application from being able to communicate with Microsoft Entra ID.

## Resolution

We recommend not using a predeployed CPOS or other parts of CSU, such as Retail Server, because they're based on the Retail SDK, which is no longer supported.

To continue development against the CSU, the Commerce SDK must be used. This requires you to create and maintain your own Microsoft Entra ID applications. For more information, see [Migrate to Commerce SDK](/dynamics365/commerce/dev-itpro/retail-sdk/migrate-commerce-sdk).

You have to create your own Microsoft Entra ID applications if you still want to use those VMs where CPOS was predeployed. For more information, see [Configure Store Commerce for web to use a custom Microsoft Entra ID app](/dynamics365/commerce/dev-itpro/cpos-custom-aad).
