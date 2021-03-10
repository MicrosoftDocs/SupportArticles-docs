---
title: 401 Unauthorized Access is denied
description: Provides a solution to an error that occurs in Microsoft Dynamics CRM when using Claims-Based Authentication.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# 401 Unauthorized Access is denied An error occurs in Microsoft Dynamics CRM using Claims-Based Authentication

This article provides a solution to an error that occurs in Microsoft Dynamics CRM when using Claims-Based Authentication.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2686840

## Symptoms

Users may not be able to sign in to Microsoft Dynamics CRM using internal claims-based authentication or IFD. The user will be repeatedly prompted to sign in.

In the Microsoft Dynamics CRM user interface, the user will see the message below:

> HTTP Error 401 - Unauthorized Access is denied.

or

> An error has occurred.

## Cause

The Token-signing certificate and Token-Decrypting certificate in ADFS will automatically be renewed by the Auto Certificate Rollover feature because these certificates reach their expiration date.

## Resolution

In ADFS Management Console, update the Federation metadata URLs and do an IIS reset on CRM server. Then, restart the ADFS service.

If  above steps don't resolve the issue, follow below steps:

1. On the Microsoft Dynamics CRM server, go to Deployment Manager and disable the Claims-Based Authentication.
2. On the Microsoft Dynamics CRM server, select the **Start** menu, select **Run**, and type **iisreset** to complete an IIS reset.
3. Reconfigure Claims-Based Authentication from Deployment Manager, keeping all the settings same.
4. Reconfigure IFD through the Microsoft Dynamics CRM Deployment Manager.
5. On the Microsoft Dynamics CRM server, select the **Start** menu, select **Run**, and type **iisreset** to complete an IIS reset.
6. In ADFS Management Console on the ADFS server, update the corresponding Federation Metadata URLs.
    1. Go to the ADFS Server and open the ADFS management Console.
    1. Select **Relying Party Trusts** to display the internal and external relying party trusts.
    1. Right-click each and select **Update Federation Metadata**.
    1. Go to the Microsoft Dynamics CRM server, select the **Start** menu, select **Run** and type **iisreset** to complete an IIS reset.
    1. Next, browse to **Service** on the ADFS server and restart the ADFS service.

## More information

The signing certificate in ADFS (**Service** -> **Certificates** -> **Token-Decryption / Token-Signing**) shows two Token-decrypting and Token-signing certificates with one Primary and one Secondary status.

There are two signing certificates. The second signing certificate was created by ADFS automatically because the first signing certificate was reaching its expiration date. This feature in ADFS is called Auto Certificate Rollover.

In the Microsoft Dynamics CRM server database, it still has the old certificate entry, which causes the authentication to fail. The issue will be resolved once the database is updated with the recently renewed certificate after the reconfiguration of IFD and claims.

The following error can be seen in event viewer of the ADFS server (Application and Services Logs -> ADFS 2.0 -> Admin):

> Exception information:  
Exception type: SecurityTokenException  
Exception message: ID4175: The issuer of the security token was not recognized by the IssuerNameRegistry. To accept security tokens from this issuer, configure the IssuerNameRegistry to return a valid name for this issuer.  
at Microsoft.IdentityModel.Tokens.Saml11.Saml11SecurityTokenHandler.CreateClaims(SamlSecurityToken samlSecurityToken)  
at Microsoft.IdentityModel.Tokens.Saml11.Saml11SecurityTokenHandler.ValidateToken(SecurityToken token)  
at Microsoft.IdentityModel.Tokens.SecurityTokenHandlerCollection.ValidateToken(SecurityToken token)  
at Microsoft.IdentityModel.Web.TokenReceiver.AuthenticateToken(SecurityToken token, Boolean ensureBearerToken, String endpointUri)  
at Microsoft.IdentityModel.Web.WSFederationAuthenticationModule.SignInWithResponseMessage(HttpRequest request)  
at Microsoft.IdentityModel.Web.WSFederationAuthenticationModule.OnAuthenticateRequest(Object sender, EventArgs args)  
at Microsoft.Crm.Authentication.Claims.CrmFederatedAuthenticationModule.OnAuthenticateRequest(Object sender, EventArgs args)  
at System.Web.HttpApplication.SyncEventExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)

or

> Exception information:  
Exception type: SecurityTokenException  
Exception message: ID4175: The issuer of the security token was not recognized by the IssuerNameRegistry. To accept security tokens from this issuer, configure the IssuerNameRegistry to return a valid name for this issuer.  
at Microsoft.IdentityModel.Tokens.Saml11.Saml11SecurityTokenHandler.CreateClaims(SamlSecurityToken samlSecurityToken)  
