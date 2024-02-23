---
title: Provider-hosted add-ins stop working and HTTP 401 error after you configure SharePoint farm hybrid features
description: Fixes an Authentication realm issue for provider-hosted add-ins, Workflow Manager, and cross-farm trust scenarios that use SharePoint hybrid features.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Server Subscription Edition
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Provider-hosted add-ins stop working and HTTP 401 error after you configure SharePoint farm hybrid features  

## Symptoms  

Consider the following scenario. You have existing, deployed provider-hosted add-ins (PHA) that are registered as `RegisteredIssuerName` and that contain the original farm `RealmID` value for your SharePoint 2013 or SharePoint 2016 farm, and/or you created a Workflow Manager association in your farm.

In this scenario, when you access these PHAs after you configure SharePoint hybrid features in your farm, the PHAs stop functioning. Additionally, you receive an HTTP 401 error message when you are directed to the add-ins.

> [!NOTE]
> PHAs may include an externally hosted web application, service, database, or SharePoint component. This problem does not exist if you configure hybrid features first, and then deploy provider-hosted add-ins and/or Workflow Manager in a SharePoint 2013 or SharePoint 2016 farm.

## Cause  

Configuring SharePoint hybrid features for SharePoint 2013 or SharePoint 2016 disrupts server-to-server (S2S) trusts that are created before you configure hybrid features. When you try to establish an S2S trust by using the Cloud SSA on-boarding script or the Hybrid Picker, the on-premises farm's authentication realm is updated to match the Microsoft 365 tenant context ID. The script sets the authentication realm by using the [Set-SPAuthenticationRealm](/powershell/module/sharepoint-server/Set-SPAuthenticationRealm) cmdlet. After the authentication realm is changed, existing SharePoint add-ins fail to authenticate.

This authentication failure occurs because of how provider-hosted add-ins are authorized to access SharePoint. SharePoint add-ins are associated with `SPTrustedSecurityTokenIssuers` by using the `IssuerId` value. On request, an add-in tries to get a token from the Secure Token Service issuer (STS). The token issuers are tied to the authentication realm. After the realm is changed, the SharePoint add-ins can no longer authenticate successfully. The trusted token issuer that has the correct issuer ID still exists in the farm. However, it is associated with the previous authentication realm. The actual `RegisteredIssuerName` value is `IssuerId@OldAuthRealmGuid`, in which the `oldAuthRealmGuid` value no longer matches the current `AuthRealmGuid` value. The add-in fails to authenticate because the STS can't find a matching token issuer.

The following error message is logged to ULS logs and clearly indicates that the token issuer is no longer trusted because its `RealmID` value no longer matches the farm:

> SPApplicationAuthenticationModule: Failed to authenticate request, unknown error. Exception details: System.IdenitytModel.Tokens.SecurityTokenException: The issues of the token is not a trusted issuer.

## Resolution  

When you configure hybrid, `RealmID` is changed to match the tenant ID of your Office365 subscription. This causes add-ins to stop working, as explained in the "Symptoms" section. To restore SharePoint add-in functionality, register the provider-hosted add-ins by using the `RegisteredIssuerName` value that contains the new realm ID. Then, reapply the add-in permissions for each add-in instance.

To repair authentication-related issues that are associated with provider-hosted add-ins and hybrid features, follow these steps:

1. Run the following script to discover all the app instances that are deployed on a web application:  

   In the following script, replace {0} with your web application. The outputs of the script are the app title, app client ID and target Web of all provider-hosted add-ins. These values will be used as inputs in step 3.

   ```powershell
    Add-PsSnapin Microsoft.SharePoint.PowerShell
    Add-PsSnapin Microsoft.SharePoint.PowerShell
    $webApp = Get-SPWebApplication "{0}"
    foreach($site in $webApp.Sites){
    foreach($web in $site.AllWebs)
    {
    $appInstance = Get-SPAppInstance -Web $web.Url | ? {$_.LaunchUrl -notlike "~appWebUrl*"} | select Title, AppPrincipalId
    if($appInstance -ne $null)
    {
    foreach ($instance in $appInstance)
    {
    $tmp = $instance.AppPrincipalId.Split('|@',[System.StringSplitOptions]::RemoveEmptyEntries)
    $appInfo = $instance.Title + " - " + $tmp[$tmp.Count - 2] + " - " + $web.Url
    Write-Output $appInfo
    }
    }
    }
    }
   ```

2. Update **SPTrustedSecurityTokenIssuers** by using the following script:

   ```powershell
    $NewRealm = Get-SPAuthenticationRealm
    $sts = Get-SPTrustedSecurityTokenIssuer | ? {$_.Name -ne 'EvoSTS-Trust' -and $_.Name -ne 'ACS_STS'} | Select RegisteredIssuerName
    $realm = $sts | ?{$_.RegisteredIssuerName -ne $null} | %{$($($_.RegisteredIssuerName).toString().split('@',2)[1]).toString()} | ?{$_ -ne '*' -and $_ -ne $newRealm}
    if($Realm.count -gt 0) {
    $TempRealm = '*@$($NewRealm)'
    $Issuers = Get-SPTrustedSecurityTokenIssuer | ?{$_.Name -ne 'EvoSTS-Trust' -and $_.Name -ne 'ACS_STS' -and $_.RegisteredIssuerName -ne $null -and $_.RegisteredIssuerName -notlike '*@`*' -and $_.RegisteredIssuerName -notlike $TempRealm}
    
    $Guid = [guid]::NewGuid()
    foreach ($Issuer in $Issuers)
    {
    $NameCopy = $Issuer.Name
    $NewIssuerName = $Guid
    $IssuerCertificate = $Issuer.SigningCertificate
    $OldRegisteredIssuerID = $Issuer.RegisteredIssuerName
    $IssuerID = $OldRegisteredIssuerID.Split('@')[0]
    $NewRegisteredIssuerName = $IssuerID + '@' + $NewRealm
    $NewIssuer = New-SPTrustedSecurityTokenIssuer -Name $NewIssuerName -Certificate $IssuerCertificate -RegisteredIssuerName $NewRegisteredIssuerName -IsTrustBroker
    Remove-SPTrustedSecurityTokenIssuer $Issuer -Confirm:$false
    $NewIssuer.Name = $NameCopy
    $NewIssuer.Update()
    }
    }
   ```

3. Fix each provider-hosted add-in that was found in step 1 by running the following script:  

   In the script, replace {0}, {1} and {2} with the values you obtained in step 1.

   ```powershell
    $appTitle = '{0}'
    $clientID = '{1}'
    $targetWeb = Get-SPWeb '{2}'
    $Scope = 'Site'
    $Right = 'Full Control'
    $authRealm = Get-SPAuthenticationRealm -ServiceContext $targetWeb.Site
    $AppIdentifier = $clientID + '@' + $authRealm
    Register-SPAppPrincipal -NameIdentifier $AppIdentifier -Site $targetWeb -DisplayName $appTitle
    $appPrincipal = Get-SPAppPrincipal -Site $targetWeb -NameIdentifier $AppIdentifier
    Set-SPAppPrincipalPermission -Site $targetWeb -AppPrincipal $appPrincipal -Scope $Scope -Right $Right
   ```

   To update the authentication realm for Workflow Manager, run the following cmdlet:

   ```powershell
    $workflowproxy = Get-SPWorkflowServiceApplicationProxy
    $webapp = get-spwebapplication
    if ($webapp)
    {
    $webappurl = $webapp[0].url
    $Site=get-spsite $webappurl
    if ($site)
    {
    $workflowaddress = $workflowproxy.GetWorkflowServiceAddress($site)
    $workflowscopename = $workflowproxy.GetWorkflowScopeName($site)
    $TrimScope = '/'+$workflowscopename+'/'
    $wfmaddress = $workflowaddress.TrimEnd($Trimscope)
    }
    }
    $workflowproxy.delete()
    Register-SPWorkflowService -SPSite $Site -WorkflowHostUri $wfmaddress -Force
   ```

   If you deployed cross-farm trust scenarios before you configured hybrid features, use the methods in the following TechNet topics to fix the scenarios manually:

   - [Share service applications across farms in SharePoint Server](/SharePoint/administration/share-service-applications-across-farms)

## More Information  

In the scenario where you configure hybrid workloads that require S2S before you implement the provider-hosted add-ins or Workflow Manager, the add-ins will be registered after the `SPAuthenticationRealm` cmdlet is updated to match the Microsoft 365 tenant context ID. They'll always work because the RealmID value won't change again. If hybrid workloads are added or reconfigured, the realm ID remains the same as the Microsoft 365 tenant context ID.

To create a server-to-server trust between your SharePoint on-premises environment and Microsoft 365, run the [Set-SPAuthenticationRealm](/powershell/module/sharepoint-server/Set-SPAuthenticationRealm).

> [!IMPORTANT]
> The topic contains a "Caution" section that warns that any access tokens that are created for a specific realm won't work after you change the `SPAuthenticationRealm` value.  

To create SharePoint provider-hosted add-ins, see [Get started creating provider-hosted SharePoint Add-ins](/sharepoint/dev/sp-add-ins/get-started-creating-provider-hosted-sharepoint-add-ins).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
