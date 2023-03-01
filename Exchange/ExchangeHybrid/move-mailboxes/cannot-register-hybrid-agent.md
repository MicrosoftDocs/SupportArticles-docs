---
title: Can't register a Hybrid Agent in Exchange Server
description: Provides a resolution for an issue in which you can't register a Hybrid Agent.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - CI 167780
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: haembab, ninob, meerak
appliesto:
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/10/2023
---

# Can't register a Hybrid Agent in Exchange Server

## Symptoms

When you use the Hybrid Configuration wizard (HCW) to set up a [Microsoft Hybrid Agent](/exchange/hybrid-deployment/hybrid-agent), you see the following registration error in the HCW for the installed Hybrid Agent.

:::image type="content" source="media/cannot-register-hybrid-agent/hybrid-agent-registration-error.png" alt-text="Screenshot of a Hybrid Agent registration error in the HCW." border="true":::

You also receive the following error entries in the HCW log:

```output
10333 \[Client=UX, fn=SendAsync, Thread=\<ID\>\] Results=NotFound {"error":
{"code":"Application_NotFound", "message":"Application '\<application GUID\>' not found or
OnPremisesPublishing is not enabled for your tenant."
```

```output
10333 \[Client=UX, fn=SendAsync, Thread=\<ID\>\] Results=BadRequest {"error":
{"code": "InternalUrl_Duplicate", "message":"Internal url '\<application URL\>' is invalid
since it is already in use."
```

## Cause

The errors occur if the internal URL that's used by the Hybrid Agent application is already in use within your organization. More specifically:

### Cause 1

The same internal URL is used by an existing enterprise on-premises app that uses [Microsoft Azure AD Application Proxy](/azure/active-directory/app-proxy/application-proxy).

### Cause 2

The same internal URL is used by a previously installed, orphaned Hybrid Agent application that's not fully registered. An orphaned Hybrid Agent application can be caused by a failed Hybrid Agent installation or uninstallation.

## Resolution

Use the appropriate resolution, depending on the cause.

### Resolution for Cause 1

Choose one of the following options:

- Assign a different internal URL to the existing enterprise app. For more information, see [Add an on-premises application](/azure/active-directory/app-proxy/application-proxy-add-on-premises-application) and [Set-AzureADApplicationProxyApplication](/powershell/module/azuread/set-azureadapplicationproxyapplication).

- Remove the existing enterprise app. For more information, see [Remove-AzureADApplicationProxyApplication](/powershell/module/azuread/remove-azureadapplicationproxyapplication).

### Resolution for Cause 2

Remove the previously installed, orphaned Hybrid Agent application. To do this, follow these steps:

1. Get the application GUID of the previous Hybrid Agent application. You can find this GUID by searching the HCW log for the following entry:

   `10386 [Client=UX, Thread=<ID>] Previous Connector Application Name found: <application GUID>`

   The entry might resemble the following example:

   `10386 [Client=UX, Thread=20] Previous Connector Application Name found: 8fc44b37-bf0d-45bf-8254-d4d033d93a6e`

2. Remove the previous Hybrid Agent application. To do this, follow these steps:

   1. Load the [HybridManagement PowerShell module](/exchange/hybrid-deployment/hybrid-agent#installation-prerequisites):

      1. Install the [Microsoft PackageManagement PowerShell module](https://www.powershellgallery.com/packages/PackageManagement).

      2. Install the [Microsoft Azure PowerShell module](/powershell/azure/servicemanagement/install-azure-ps#step-2-install-azure-powershell).

      3. Download the latest version of the Microsoft [HybridManagement.psm1](https://aka.ms/hybridconnectivity) PowerShell module to a server in your Exchange organization.

      4. In the folder that contains the HybridManagement module, run the following PowerShell command as an administrator:

         ```powershell
         Import-Module .\HybridManagement.psm1
         ```

   2. Pass the application GUID that you found in step 1 to the [Remove-HybridApplication](/exchange/hybrid-deployment/hybrid-agent#hybrid-agent-powershell-module) cmdlet:

      ```powershell
      Remove-HybridApplication -AppId <application GUID> -Credential (Get-Credential)
      ```

      Or, if you have MFA enabled, run:

      ```powershell
      Remove-HybridApplication -AppId <application GUID> -UserPrincipalName <tenant admin UPN>
      ```

      When you're prompted for credentials, enter your Microsoft 365 or Office 365 Global Administrator credentials.

Continue to set up the Hybrid Agent. To do this, follow these steps:

1. Check the status of the Hybrid Agent by using the [Get-HybridAgent](/exchange/hybrid-deployment/hybrid-agent#hybrid-agent-powershell-module) cmdlet:

   ```powershell
   Get-HybridAgent -Credential (Get-Credential)
   ```

   Or, if you have MFA enabled, run:

   ```powershell
   Get-HybridAgent -UserPrincipalName <tenant admin UPN>
   ```

   If you're prompted for credentials, enter your Microsoft 365 or Office 365 Global Administrator credentials.

   Make sure that the Hybrid Agent is active before you continue the setup process. If the Hybrid Agent is inactive, see [Troubleshooting Hybrid Migration Endpoints in Classic and Modern Hybrid](https://techcommunity.microsoft.com/t5/exchange-team-blog/troubleshooting-hybrid-migration-endpoints-in-classic-and-modern/ba-p/953006) and [Determine if the Hybrid Agent is installed and running.](https://techcommunity.microsoft.com/t5/exchange-team-blog/modern-hcw-hybrid-agent-troubleshooting-like-a-pro/ba-p/1558725)

2. Rerun the HCW to continue the [Hybrid Agent setup](/exchange/hybrid-deployment/hybrid-agent#installation-steps).

   > [!NOTE]
   > When you're prompted to choose a hybrid topology, select **Exchange Modern Hybrid Topology**.
