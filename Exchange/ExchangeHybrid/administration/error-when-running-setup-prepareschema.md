---
title: Cannot run Setup /PrepareSchema for hybrid
description: Describes an issue that triggers an error when you try to run Exchange Setup together with the /PrepareSchema switch to prepare the schema for an existing Exchange hybrid deployment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when running Setup /PrepareSchema to prepare the schema for an existing Exchange hybrid environment

_Original KB number:_ &nbsp; 3121439

## Symptoms

When you run Exchange Server Setup together with the `/PrepareSchema` to update the schema for an existing Exchange hybrid environment, you receive the following error message:

> A hybrid deployment with Office 365 has been detected. Please ensure that you are running setup with the /TenantOrganizationConfig switch. To use the TenantOrganizationConfig switch you must first connect to your Exchange Online tenant via PowerShell and execute the following command: "Get-OrganizationConfig | Export-Clixml -Path MyTenantOrganizationConfig.XML". Once the XML file has been generated, run setup with the TenantOrganizationConfig switch as follows "/TenantOrganizationConfig MyTenantOrganizationConfig.XML".
>
> If you continue to see this this message then it indicates that either the XML file specified is corrupt, or you are attempting to upgrade your on-premises Exchange installation to a build that isn't compatible with the Exchange version of your Microsoft 365 tenant. Your Microsoft 365 tenant must be upgraded to a compatible version of Exchange before upgrading your on-premises Exchange installation.

When you follow the instructions in the error message to generate the XML file, and then you run `Setup /PrepareSchema` together with the `/TenantOrganizationConfig` switch, you receive the following error message:

> The parameter 'TenantOrganizationConfig' is not valid for current operation 'PrepareSchema'. Setup checks failed: Invalid command line arguments.

## Cause

The `/PrepareSchema` switch is valid only for schema operations. The `/TenantOrganizationConfig` switch is used with the `/PrepareAD` switch.

## Resolution

To resolve this issue, run Setup together with the `/PrepareAD` and `/TenantOrganizationConfig` switches. For example, run the following command:

```powershell
Setup.exe /PrepareAD /TenantOrganizationConfig MyTenantOrganizationConfig.xml /IAcceptExchangeServerLicenseTerms
```

> [!NOTE]
> In this scenario, schema extension is performed implicitly by running the `/PrepareAD` switch. Therefore, to complete these steps, you must have Schema Admin rights to perform the schema changes in addition to the rights that are necessary to perform the `/PrepareAD` steps.

## More information

For more information, see [Prepare Active Directory and domains for Exchange Server](/Exchange/plan-and-deploy/prepare-ad-and-domains).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
