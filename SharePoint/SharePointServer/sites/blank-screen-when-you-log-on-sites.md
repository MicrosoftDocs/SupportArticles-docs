---
title: Blank screen when you log on to a SharePoint site
description: Describes an issue in which you receive a blank screen when you open a SharePoint site. This issue occurs when FIPS is enabled on the SharePoint server.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# Blank screen when you log on to a SharePoint site  

## Symptom  

You see a blank screen when you sign in to a SharePoint site other than the Central Administration site. Additionally, you experience the following issues:   
 
- When an error occurs, the error message doesn't contain the correlation ID for the request.    
- The following error message is logged in the Unified Logging System (ULS) Log:     

  ```
  Foundation General 8nca Medium Application error when access /, Error=Exception of type 'System.ArgumentException' was thrown. Parameter name: encodedValue at Microsoft..Administration.Claims.SPClaimEncodingManager.DecodeClaimFromFormsSuffix(String encodedValue) at Microsoft.SharePoint.Administration.Claims.SPClaimProviderManager.GetProviderUserKey(IClaimsIdentity claimsIdentity, String encodedIdentityClaimSuffix) at Microsoft..Administration.Claims.SPClaimProviderManager.GetProviderUserKey(String encodedIdentityClaimSuffix) at Microsoft.SharePoint.ApplicationRuntime.SPHeaderManager.AddIsapiHeaders(HttpContext context, String encodedUrl, NameValueCollection headers) at Microsoft.SharePoint.ApplicationRuntime.SPRequestModule.PreRequestExecuteAppHandler(Object oSender, EventArgs ea) at System.Web.HttpApplication.SyncEventExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute() at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)       
  ```
- When you check SharePoint Health Analyzer alert, it says none of the SharePoint servers are issuing tokens. However, you can browse the security token service (STS) page.     
- You use the following script to check whether STS is generating tokens:

  ```  
  $farm = [Microsoft.SharePoint.Administration.SPFarm]::Local  
  $webServiceCollection = new-object Microsoft.SharePoint.Administration.SPWebServiceCollection($farm)  
  foreach ($service in $webServiceCollection)  
  {  
     foreach ($webApp in $service.WebApplications)  
     {  
        $firstWebApp = $webApp  
        #Get the context  
        $context = $firstWebApp.GetResponseUri([Microsoft.SharePoint.Administration.SPUrlZone]::Default)  
        Write-Host "Web Application Context:" $context.AbsoluteUri  
        #Call the token generator function  
        $token = [Microsoft.SharePoint.SPSecurityContext]::SecurityTokenForContext($context)  
        Write-Host "Token:" $token.InternalTokenReference  
        Write-Host "**************************"  
     }  
  }  
  ```  

  And you receive the following error message:

  ```     
  Token:
  **************************  
  Web Application Context: [http://Contoso.com/](http://contoso.com/)  
  Exception calling "SecurityTokenForContext" with "1" argument(s): "The serverwas unable to process the request due to an internal error. For more information about the error, either turn on IncludeExceptionDetailInFaults(either from ServiceBehaviorAttribute or from the< serviceDebug> configuration behavior) on the server in order to send the exception information back to the client, or turn on tracing as per the Microsoft .NET Framework SDK documentation and inspect the server trace logs."
  ```

## Cause  

This issue occurs if Federal Information Processing Standard (FIPS) is enabled on the SharePoint server.   

## Resolution  

To resolve the issue, disable FIPS by following these steps on the computer that has SharePoint Server installed:   

1. Start the Local Security Policy console (secpol.msc). Go to **Security Settings** > **Local Policies** > **Security Options**.     
2. Locate the **System cryptography: Use FIPS 140 compliant cryptographic algorithms, including encryption, hashing and signing algorithms** policy.     
3. If the policy is enabled, right-click the policy, click **Properties**, select **Disabled**, and then click **OK**.     
4. Open Registry Editor and locate the following registry subkey:  

  ```
  HKLM\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy  
  ```   
5. If the value of **Enabled** is 1, right-click **Enabled**, click **Modify**, type **0** in **Value data**, and then click **OK**.     
6. Restart the computer.       

## More Information  

SharePoint Server uses several Windows encryption algorithms for computing hash values that do not comply with Federal Information Processing Standard (FIPS) 140-2, Security Requirements for Cryptographic Modules. These algorithms are not used for security purposes. They are used for internal processing. For example, SharePoint Server uses MD5 to create hash values that are used as unique identifiers. Because SharePoint Server uses these algorithms, the program doesn't support the Windows security policy setting that requires FIPS-compliant algorithms for encryption and hashing.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
