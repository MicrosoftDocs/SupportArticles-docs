---
title: Error when accessing Dynamics 365 over IFD
description: Describes how to add Microsoft Dynamics 365 IFD DNS records to Internet Explorer Trusted Sites.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-server
---
# The same client browser session has made 6 requests in the last 2 seconds error message displays when accessing Microsoft Dynamics 365 over IFD

This article provides a solution to an error that occurs when accessing Microsoft Dynamics 365 using Internet Facing Deployment (IFD).

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4012055

## Symptoms

After configuring Microsoft Dynamics 365 with claims authentication and Internet Facing Deployment (IFD), users aren't able to access Microsoft Dynamics 365 using IFD and the following error is displayed in the Event Viewer on the Active Directory Federation Server (ADFS)

> Exception details: Microsoft.IdentityServer.Web.InvalidRequestException: MSIS7042: The same client browser session has made '6' requests in the last '2' seconds. Contact your administrator for details.  
    at Microsoft.IdentityServer.Web.Protocols.PassiveProtocolHandler.UpdateLoopDetectionCookie(WrappedHttpListenerContext context) at Microsoft.IdentityServer.Web.Protocols.PassiveProtocolHandler.ProcessCommonCookiesInLastAuthenticationStage(ProtocolContext context) at Microsoft.IdentityServer.Web.Protocols.WSFederation.WSFederationProtocolHandler.SendSignInResponse(WSFederationContext context, MSISSignInResponse response) at Microsoft.IdentityServer.Web.Protocols.WSFederation.WSFederationProtocolHandler.Process(ProtocolContext context) at Microsoft.IdentityServer.Web.PassiveProtocolListener.ProcessProtocolRequest(ProtocolContext protocolContext, PassiveProtocolHandler protocolHandler) at Microsoft.IdentityServer.Web.PassiveProtocolListener.OnGetContext(WrappedHttpListenerContext context)

## Cause

One possible reason is that the external Host (A) DNS records that were created for IFD haven't been added to the Trusted Sites list in Internet Explorer settings.

## Resolution

Add the IFD DNS records to Internet Explorer Trusted Sites. It should include the Dynamics 365 organization name record, the Dynamics 365 discovery web service record, the ADFS record along with the Dynamics 365 IFD federation endpoint record.  
For Example:

`CRM2016.Contoso.com`- Dynamics 365 organization name record Dev.  
`Contoso.com` - Dynamics 365 discovery web service record  
`ADFS.Contoso.com` - ADFS record  
`Auth.Contoso.com` - Dynamics 365 IFD federation endpoint record

1. On the client computer, open the Control Panel and then select Internet Options.
2. Select the **Security** tab.
3. Select **Trusted Sites**, and then select the **Sites** button.
4. For each of the above DNS Host (A) records, enter each one individually in the field **Add this website to the zone:**, and then select the **Add** button.  

## More information

For more information about Microsoft Dynamics 365 IFD configuration, see [Configuring Claims-based Authentication for Microsoft Dynamics CRM Server](https://www.microsoft.com/download/details.aspx?id=41701).
