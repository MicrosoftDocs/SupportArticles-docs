---
title: "Known issues: Commerce POS"
description: "Troubleshooting Entra sign-in issues with POS."
author: raybennett-msft
ms.author: bennettray
ms.topic: troubleshooting-known-issue
ms.date: 05/01/2024

#customer intent: As a developer, I want to resolve login issues with POS so that I can utilize POS on my CHE.

---

# Known issues: Commerce POS

This article helps you to troubleshoot Azure Active Directory (AAD) (now known as Entra) sign-in issues when utilizing Point of Sale (POS) on Cloud Hosted Environments (CHE).

## POS reports an error that the redirect URI wasn't found

Customers using non-PROD development virtual machines, like those originating from Life Cycle Services (LCS), aren't able to interact with Entra from within Cloud Point of Sale (CPOS) predeployed on those boxes. The error shows that there's an issue with the Reply URL mismatch. This issue includes Device Activation and Employee Login if CPOS was set up to use Entra for the Employee Login.

The error would be similar to the error message displayed here with the exceptions that the redirect URI would end with any of these domains:

.axcloud.dynamics.com  
.cloud.onebox.dynamics.com  

![Example of an error message encountered.](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/104783217/73659af1-b3aa-4ab7-8582-69517b21ac28)

## Description

That predeployed CPOS is based on the Retail SDK. The last CSU version where the Retail SDK was supported is 10.0.37, which was [retired](/dynamics365/fin-ops-core/dev-itpro/get-started/public-preview-releases#targeted-release-schedule-dates-subject-to-change)  on March 15 2024.
While Microsoft is continuing to improve on internal infrastructure, a change was made and the CPOS (Store Commerce for Web) application is no longer able to communicate with Entra (Microsoft Entra ID).
 

### Resolution

Customers shouldn't use predeployed CPOS or other parts of CSU, such as Retail Server because they're based on the Retail SDK, which is no longer supported.
To continue development against the Cloud Scale Unit (CSU), the Commerce SDK must be utilized which requires customers to create and maintain their own Entra applications: [Migrate to Commerce SDK](/dynamics365/commerce/dev-itpro/retail-sdk/migrate-commerce-sdk).

In case a customer, for any reason, still wants to use those VMs where CPOS was predeployed, they still have to create their own Entra applications: [Configure Store Commerce for web to use a custom Microsoft Entra app](/dynamics365/commerce/dev-itpro/cpos-custom-aad).
