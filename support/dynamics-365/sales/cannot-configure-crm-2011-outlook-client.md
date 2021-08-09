---
title: Cannot configure CRM 2011 Outlook client
description: Provides solutions to errors that occur when you try to configure the Microsoft Dynamics CRM 2011 Outlook client on Windows 8.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to configure the Microsoft Dynamics CRM 2011 Outlook client on a Windows 8 computer

This article provides solutions to errors that occur when you try to configure the Microsoft Dynamics CRM 2011 Outlook client on Windows 8.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2727137

## Symptoms

When attempting to configure the Microsoft Dynamics CRM 2011 Outlook client on Windows 8, a user may receive the following error when configuring to a deployment setup for Claims-based authentication:

> "Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help."

Users configuring to an On-Premise organization that isn't set up for Claims-based authentication may receive the following error:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator."

When inspecting the client configuration log, the following error information is found for both symptoms:

> 14:12:40| Error| Error connecting to URL: `https://crm.contoso.com:444/XRMServices/2011/Discovery.svc` Exception: System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.IdentityModel, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.  
File name: 'Microsoft.IdentityModel, Version=3.5.0.0 , Culture=neutral, PublicKeyToken=31bf3856ad364e35'  
at Microsoft.Crm.Outlook.ClientAuth.ClaimsBasedAuthProvider`1.SignIn()  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow, Credential credentials)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.InternalLoadOrganizations(OrganizationDetailCollection orgs, AuthUIMode uiMode, Form parentWindow)

## Cause

The Windows Identity Foundation 3.5 feature component isn't active on the Operating System.

## Resolution

- Method 1: Enable Windows Identity Foundation 3.5

    To do it, follow these steps:

    1. In the **Start** menu, right-click, and then select **All Apps**.
    2. Under the **Windows System** group, select **Control Panel**.
    3. Select **Programs**, and then select **Programs and Features**.
    4. In the left menu, select **Turn Windows features on or off**.
    5. Scroll through the list until Windows Identity Foundation 3.5 is found.
    6. Select the **Windows Identity Foundation 3.5** check box, and then select **OK**.

- Method 2: Install Microsoft Dynamics CRM Update Rollup 11

    If method 1 doesn't resolve the problem, install Update Rollup 11 for Microsoft Dynamics CRM 2011. For more information about Update Rollup 11 for Microsoft Dynamics CRM 2011, see [Microsoft Dynamics CRM 2011 Update Rollup 11](https://support.microsoft.com/help/2739504).

## More information

In Windows 7 systems, the Microsoft Dynamics CRM 2011 setup program will detect if the Windows Identity Foundation update is installed on the system. If the update isn't present, the setup program will automatically install the update during installation. However, if this update is removed after installation, the configuration process will fail with the same error mentioned in this article.

Windows 8 includes Windows Identity Foundation 3.5 out of the box, but is disabled by default.
