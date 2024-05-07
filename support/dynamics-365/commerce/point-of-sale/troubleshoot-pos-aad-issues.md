---
title: Troubleshooting AAD or Microsoft Entra ID sign-in issues with POS
description: Provides a resolution for the Azure Active Directory (AAD) (now known as Microsoft Entra ID) sign-in issues when you use Point of Sale (POS) on Cloud Hosted Environments (CHE).
author: raybennett-msft
ms.author: bennettray
ms.date: 05/07/2024
#customer intent: As a developer, I want to resolve login issues with POS so that I can utilize POS on my CHE.
---
# Known issues: Commerce POS

This article helps you to troubleshoot Azure Active Directory (AAD) (now known as Microsoft Entra ID) sign-in issues when you use Point of Sale (POS) on Cloud Hosted Environments (CHE).

## POS reports an error that the redirect URI wasn't found

Customers who use non-PROD development virtual machines (VMs), such as those that originate from Life Cycle Services (LCS), can't interact with Microsoft Entra ID from within Cloud Point of Sale (CPOS) predeployed on those boxes. The error message shows that there's an issue with the Reply URL mismatch. This issue includes Device Activation and Employee Login if CPOS was set up to use Microsoft Entra ID for the Employee Login.

The error message would resemble the error message that's displayed here, except that the redirect URI would end with any of these domains:

`.axcloud.dynamics.com `  
`.cloud.onebox.dynamics.com`

![Example of an error message encountered.](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/104783217/73659af1-b3aa-4ab7-8582-69517b21ac28)

## Description

That predeployed CPOS is based on the Retail SDK. The last CSU version where the Retail SDK was supported is 10.0.37, which was [retired](/dynamics365/fin-ops-core/dev-itpro/get-started/public-preview-releases#targeted-release-schedule-dates-subject-to-change)  on March 15, 2024.

Although Microsoft continues to improve on internal infrastructure, a recent change prevents the CPOS (Store Commerce for Web) application from being able to communicate with Microsoft Entra ID.
 
### Resolution

Customers shouldn't use predeployed CPOS or other parts of CSU, such as Retail Server, because they're based on the Retail SDK, which is no longer supported.

To continue development against the Cloud Scale Unit (CSU), the Commerce SDK must be used. This requires customers to create and maintain their own Microsoft Entra ID applications: [Migrate to Commerce SDK](/dynamics365/commerce/dev-itpro/retail-sdk/migrate-commerce-sdk).

In case a customer, for any reason, still wants to use those VMs where CPOS was predeployed, they still have to create their own Microsoft Entra ID applications: [Configure Store Commerce for web to use a custom Microsoft Entra ID app](/dynamics365/commerce/dev-itpro/cpos-custom-aad).
