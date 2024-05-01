---
title: "Known issues: Commerce POS"
description: "Troubleshooting AAD sign-in issues with POS."
author: raybennett-msft
ms.author: bennettray
ms.service: pos
ms.topic: troubleshooting-known-issue
ms.date: 05/01/2024

#customer intent: As a developer, I want to resolve login issues with POS so that I can utilize POS on my CHE.

---

# Known issues: Commerce POS

This article will help you to troubleshoot AAD (now known as Entra) sign-in issues when utilizing POS on Cloud Hosted Environments.

## POS reports an error that the redirect URI was not found

Customers using non-PROD development VMs, like those originating from LCS/VHD, are not able to interact with AAD from within CPOS pre-deployed on those boxes due to the error complaining on Reply URL mismatch. This includes Device Activation as well as Employee Login if CPOS was setup to use AAD for the Employee Login.

The error would be similar to the below one with the exceptions that the redirect URI would end with any of these:

.axcloud.dynamics.com
.cloud.onebox.dynamics.com

![Example of an error message encountered.](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/104783217/73659af1-b3aa-4ab7-8582-69517b21ac28)

## Prerequisites

That pre-deployed CPOS is based on the Retail SDK. The last CSU version where the Retail SDK was supported is 10.0.37 which was [retired](h/dynamics365/fin-ops-core/dev-itpro/get-started/public-preview-releases#targeted-release-schedule-dates-subject-to-change)  on March 15 2024.
In order to make sure our internal infrastructure is compliant with Microsoft's policies, we had to make changes to CPOS First Party AAD applications which resulted in the Reply URLs corresponding to those VMs no longer being valid.

### Possible causes

Customers should not use pre-deployed CPOS as well as other parts of CSU, such as Retail Server because they are based on the Retail SDK which is no longer supported.
To continue development against CSU, the Commerce SDK must be utilized which requires customers to create and maintain their own AAD applications: [Migrate to Commerce SDK](/dynamics365/commerce/dev-itpro/retail-sdk/migrate-commerce-sdk)

In case a customer, for any reason, still wants to leverage those VMs where CPOS was pre-deployed, they still have to create their own AAD applications: [Configure Store Commerce for web to use a custom Microsoft Entra app](/dynamics365/commerce/dev-itpro/cpos-custom-aad)
