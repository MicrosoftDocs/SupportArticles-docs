---
title: "Known issues: Commerce POS"
description: "Troubleshooting AAD sign-in issues with POS."
author: raybennett-msft
ms.author: bennettray
ms.topic: troubleshooting-known-issue
ms.date: 05/01/2024

#customer intent: As a developer, I want to resolve login issues with POS so that I can utilize POS on my CHE.

---

# Known issues: Commerce POS

This article helps you to troubleshoot Azure Active Directory (AAD) (now known as Entra) sign-in issues when utilizing Point of Sale (POS) on Cloud Hosted Environments (CHE).

## POS reports an error that the redirect URI was not found

Customers using non-PROD development virtual machines, like those originating from Life Cycle Services (LCS), are not able to interact with AAD from within Cloud Point of Sale (CPOS) pre-deployed on those boxes. The error shows that there is an issue with the Reply URL mismatch. This issue includes Device Activation and Employee Login if CPOS was setup to use AAD for the Employee Login.

The error would be similar to the error message displayed here with the exceptions that the redirect URI would end with any of these domains:

.axcloud.dynamics.com  
.cloud.onebox.dynamics.com  

![Example of an error message encountered.](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/104783217/73659af1-b3aa-4ab7-8582-69517b21ac28)

## Description

That pre-deployed CPOS is based on the Retail SDK. The last CSU version where the Retail SDK was supported is 10.0.37, which was [retired](/dynamics365/fin-ops-core/dev-itpro/get-started/public-preview-releases#targeted-release-schedule-dates-subject-to-change)  on March 15 2024.
While continuing improving an internal infrastructure, a change was made and the CPOS (Store Commerrce for Web) application is no longer able to communicate with AAD (Microsoft Entra ID).
 

### Resolution

Customers should not use pre-deployed CPOS as well as other parts of CSU, such as Retail Server because they are based on the Retail SDK which is no longer supported.
To continue development against the Cloud Scale Unit (CSU), the Commerce SDK must be utilized which requires customers to create and maintain their own AAD applications: [Migrate to Commerce SDK](/dynamics365/commerce/dev-itpro/retail-sdk/migrate-commerce-sdk)

In case a customer, for any reason, still wants to use those VMs where CPOS was pre-deployed, they still have to create their own AAD applications: [Configure Store Commerce for web to use a custom Microsoft Entra app](/dynamics365/commerce/dev-itpro/cpos-custom-aad)
