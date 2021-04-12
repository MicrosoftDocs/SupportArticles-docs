---
title: Cannot set Dynamics CRM Outlook to external IFD web address
description: You can't configure the Microsoft Dynamics CRM Outlook client to the external web address. Provides a resolution.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The Microsoft Dynamics CRM 2011 Outlook client fails to configure to the external IFD web address

This article provides a resolution for the issue that users can't configure the Microsoft Dynamics CRM Outlook client to the external web address and the error **Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials** occurs.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2912175

## Symptoms

When the Microsoft Dynamics CRM 2011 deployment is configured for Internet Facing Deployment (IFD) using Active Directory Certificate Services (ADFS), users may receive the following error when attempting to configure the Microsoft Dynamics CRM Outlook client to the external web address:

> Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help.  

When reviewing the configuration log, the following exception is also captured:

> Error connecting to URL: `https://crmorg.domain.com/XRMServices/2011/Discovery.svc` Exception: System.ServiceModel.EndpointNotFoundException : There was no endpoint listening at `https://adfs.domain.com/adfs/services/trust/13/username` that could accept the message .

However, users may still be able to access the external URL through a web browser without error.

## Cause

The /adfs/services/trust/13/username endpoint may be enabled. When this endpoint is enabled, the client will be unable to reach the usernamemixed and kerberosmixed endpoints, which causes authentication to fail.

## Resolution

Disable the /adfs/services/trust/13/username endpoint and restart the ADFS service. To perform this action, see the below steps:

1. Open the AD FS Management Console.
2. In the left navigation pane, expand **Service**, and then select **Endpoints**.
3. In the endpoint list, locate and right-click the /adfs/services/trust/13/username endpoint.
4. Select **disable**.
5. Restart the AD FS service.
