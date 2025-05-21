---
title: Can't register a Hybrid Agent in Exchange Server
description: Provides a fix for an error message that states an app URL isn't found or is already in use, an app GUID isn't found, or OnPremisesPublishing isn't enabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - CI 167780, 3940
  - Exchange Hybrid
  - CSSTroubleshoot
  - no-azure-ad-ps-ref
ms.reviewer: haembab, ninob, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/14/2025
---

# Can't register a Hybrid Agent in Exchange Server

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

## Symptoms

When you use Hybrid Configuration Wizard (HCW) to set up a [Microsoft Hybrid Agent](/exchange/hybrid-deployment/hybrid-agent), you see the following registration error in HCW for the installed Hybrid Agent.

:::image type="content" source="media/cannot-register-hybrid-agent/hybrid-agent-registration-error.png" alt-text="Screenshot of a Hybrid Agent registration error in HCW." border="true":::

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

The same internal URL is used by an existing enterprise on-premises app that uses [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy).

### Cause 2

The same internal URL is used by a previously installed, orphaned Hybrid Agent application that's not fully registered. An orphaned Hybrid Agent application can be caused by a failed Hybrid Agent installation or uninstallation.

## Resolution for Cause 1

Choose one of the following options:

- **Assign a different internal URL to the existing enterprise app**. Follow these steps:

  1. Run the following PowerShell cmdlets to connect to your tenant:

     ```powershell
     Import-Module Microsoft.Graph.Beta.Applications
     Connect-Graph -Scopes "Application.ReadWrite.All"
     ```

  2. Run the following PowerShell commands to assign a different internal URL to the enterprise app.

     ```powershell
     $params = @{
       onPremisesPublishing = @{
         internalUrl = "<internal app URL>"
         externalUrl = "<external app URL>"
       }
     }
     Update-MgBetaApplication -ApplicationId <app ID> -BodyParameter $params
     ```

     Although the intended change is to update the internal URL, the external URL is included as part of the update. You can use the existing external URL or an updated one.

     For more information, see [Update-MgBetaApplication](/powershell/module/microsoft.graph.beta.applications/update-mgbetaapplication) and [Add an on-premises application](/azure/active-directory/app-proxy/application-proxy-add-on-premises-application).

- **Remove the existing enterprise app**. Follow these steps:

  1. Run the following PowerShell cmdlets to connect to your tenant:

     ```powershell
     Import-Module Microsoft.Graph.Applications
     Connect-Graph -Scopes "Application.ReadWrite.All"
     ```

  2. Run the following PowerShell cmdlet to remove the enterprise app.

     ```powershell
     Remove-MgApplication -ApplicationId <app ID>
     ```

     For more information, see [Remove-MgApplication](/powershell/module/microsoft.graph.applications/remove-mgapplication).

## Resolution for Cause 2

Remove the previously installed, orphaned Hybrid Agent application. Follow these steps:

1. Get the application GUID of the previous Hybrid Agent application. You can find this GUID by searching the HCW log for the following entry:

   `10386 [Client=UX, Thread=<ID>] Previous Connector Application Name found: <application GUID>`

   The entry might resemble the following example:

   `10386 [Client=UX, Thread=20] Previous Connector Application Name found: 8fc44b37-bf0d-45bf-8254-d4d033d93a6e`

2. Remove the previous Hybrid Agent application. Follow these steps:

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

      When you're prompted for credentials, enter your Microsoft 365 or Office 365 Global administrator credentials.
3. Rerun HCW in classic mode to unregister the Application Proxy service in Microsoft Entra ID.
4. Go to **Programs and Features** in Control Panel, and verify that **Microsoft Hybrid Service** isn't [installed](/exchange/hybrid-deployment/hybrid-agent#additional-information). If it is, rerun step 2 to remove the Hybrid Agent application.
5. Rerun HCW in modern mode.
  
   > [!NOTE]
   > When you're prompted to choose a hybrid topology, select **Exchange Modern Hybrid Topology**.

If the Hybrid Agent application isn't successfully removed, follow these steps:

1. Run the following PowerShell cmdlets to connect to your tenant:

   ```powershell
   Import-Module Microsoft.Graph.Applications
   Import-Module Microsoft.Graph.Beta.Applications
   Connect-Graph -Scopes "Application.ReadWrite.All"
   ```

2. If you don't know the application ID, run the following PowerShell cmdlet to get the application ID:
 
   ```powershell
   Get-MgBetaServicePrincipal | where {$_.Tags -Contains "WindowsAzureActiveDirectoryOnPremApp"}| FL AppId, DisplayName
   ```

3. Run the following PowerShell cmdlet to remove the hybrid application:

   ```powershell
   Remove-MgApplication -ApplicationId <application GUID>
   ```

If you still can't remove the Hybrid Agent application, [contact Microsoft Support](https://support.microsoft.com/contactus). 
