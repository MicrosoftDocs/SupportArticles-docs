---
title: Error occurs while signing in via IFD and 2007 SDK endpoints
description: You receive an error while trying to sign in to Microsoft Dynamics CRM 2011 using IFD and the 2007 (CRM 4.0) SDK endpoints. Provides a resolution.
ms.reviewer: jrader
ms.topic: troubleshooting
ms.date: 
---
# You receive an error while signing in to Microsoft Dynamics CRM 2011 via IFD and the 2007 SDK endpoints

This article provides a resolution to make sure you can sign in to Microsoft Dynamics CRM 2011 through IFD and the 2007 SDK endpoints.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2642530

## Symptoms

The following error message occurs while accessing the Microsoft Dynamics CRM 2011 website after configuring the Internet Facing Deployment:

> The request failed with the HTTP 401: Unauthorized

Also, you receive the following errors while attempting to authenticate to Microsoft Dynamics CRM 2011 using IFD and the 2007 (CRM 4.0 - /MSCRMServices/2007/) SDK endpoints.

> System.Net.WebException: The request failed with HTTP status 401: Unauthorized.  
at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
at System.Web.Services.Protocols.SoapHttpClientProtocol.Invoke(String methodName, Object[] parameters)  
at \<SDKProject>.CrmSdk.Discovery.CrmDiscoveryService.Execute(Request Request)....

Additionally, you may see the following error (401.2 Unauthorized) in the IIS logs for the Microsoft Dynamics CRM Website:

> POST /MSCRMServices/2007/SPLA/CrmDiscoveryService.asmx - 443 - \<ClientRequestingIpAddress> Mozilla/4.0+(compatible;+MSIE+6.0;+MS+Web+Services+Client+Protocol+2.0.50727.4963) 401 2 5 29

## Cause

The above error might occur if the **Anonymous Authentication** is not enabled by default on the `/MSCRMServices/2007/SPLA/` directory in IIS for the Microsoft Dynamics CRM website.

## Resolution

Follow the below steps to change the authentication settings in the Microsoft Dynamics CRM website:

1. On the Microsoft Dynamics CRM Server, launch the IIS Administration Console (**Start** > **Run** > **Inetmgr**).
2. Expand the Server in the **Connections** pane.
3. Expand Sites.
4. Expand Microsoft Dynamics CRM.
5. Expand MSCRMServices.
6. Expand 2007.
7. Select the SPLA directory.
8. In the center pane, double-click Authentication.
9. Right-click Anonymous Authentication and select **Enable**.
10. Close IIS Manager and attempt to connect to Microsoft Dynamics CRM once again.

After the above change is made, you should be able to access the Microsoft Dynamics CRM website and the SDk endpoints successfully.
