---
title: Error when you retrieve data from OData endpoint
description: This article provides a resolution for the problem that occurs when you attempt to connect Power Query for Excel to Dynamics CRM 2013 Service Pack 1 On Premises using Claims-Based Authentication.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "The given URL neither points to an OData service or a feed" error when retrieving data from a Dynamics CRM 2013 OData endpoint

This article helps you resolve the problem that occurs when you attempt to connect Power Query for Excel to Dynamics CRM 2013 Service Pack 1 On Premises using Claims-Based Authentication.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013 Service Pack 1  
_Original KB number:_ &nbsp; 3133137

## Symptoms

When attempting to connect Power Query for Excel to Dynamics CRM 2013 Service Pack 1 On Premises using Claims-Based Authentication (AD FS), the following error occurs when specifying the correct OData feed URL:

> Unable to Connect  
We encountered an error while trying to connect.  
Details: "OData: The given URL neither points to an OData service or a feed:  
'`https://<adfs FQDN>/adfs/ls/wia?wa=wsignin1.0&wtrealm=https://<CRMaddress>/&wctx=rm=1&id=cf10e7d7-f0c8-4685-b357-e60206c80d44&ru=%252fcontoso%252fXRMServices%252f2011%252fOrganizationData.svc%252f&wct=2015-12-30T11:22:54Z&wauth=urn:federation:authentication:windows`'."
..."

## Cause

This is a by design behavior of the Power Query for Excel when trying to retrieve data from a Dynamics CRM On Premises Organization OData service, when it is behind an AD FS and the OAuth authentication method is not yet configured on the Dynamics CRM and AD FS deployment.

The add-in needs OAuth2/AD FS 3.0 to be configured over the CRM 2013 On Premises deployment to allow the **Organization account** authentication method to allow the sign-in on the AD FS, and to add it in the **Approved AD FS Authentication Service** list during the retrieving of the OData service.

## Resolution

Example of the referenced working scenario:

- AD FS 3.0
- CRM 2013 SP1 claims based enabled
- Client machine with Excel 2013 and Microsoft Power Query for Excel 2.27.4163.242 onboard with Internet connectivity

Step by step on how to configure the environment:

1. Enable Form Based Authentication on AD FS 3.0  

   1. Log on to the AD FS server as an administrator.

   2. Open the AD FS management wizard.

   3. Click **Authentication Policies** > **Primary Authentication** > **Global Settings** > **Authentication Methods** > **Edit**.

   4. Click (check) **Form Based Authentication** on the **Intranet** tab.

   5. Restart the AD FS service

2. Configure/Allow the OAuth on Dynamics CRM deployment  

   1. Log on to the Microsoft Dynamics CRM server as an administrator.

   2. In a **Windows PowerShell** console window, run the following script.

        ```powershell
        Add-PSSnapin Microsoft.Crm.PowerShell

        $fedurl = Get-CrmSetting -SettingType ClaimsSettings

        $fedurl.FederationProviderType = 1

        Set-CrmSetting $fedurl
        ```

   3. Run an IISReset command

3. Register the client application (Excel with Power Query add-in onboard)  

   1. Log on to the AD FS server as administrator.

   2. In a **PowerShell** window, execute the following command.

        ```powershell
        Add-AdfsClient -ClientId "a672d62c-fc7b-4e81-a576-e60dc46e951d" -Name "Microsoft Power BI" -RedirectUri @("https://de-users-preview.sqlazurelabs.com/account/reply/", "https://preview.powerbi.com/views/oauthredirect.html") -Description "ADFS OAuth 2.0 client for Microsoft Power BI"
        ```

4. Configure Power Query for Excel

   1. On the client machine, Open Excel and open/create a workbook.

   2. Click on **Power Query**, then in the **Get External Data** section of the ribbon, click on **From other sources** and then choose **From OData feed**.

   3. Specify the Dynamics CRM Organization OData URL and click **OK**. (internal or  external URL depending on your scenario)

   4. Click On **Organizational account** as the authentication method and then click on **Sign in**.

   5. When prompted, click **Allow** to confirm that you trust the AD FS as your identity provider for your OData feed.

      > [!NOTE]
      > During this phase, the client machine with the Excel and Power Query onboard, needs Internet connectivity to reach the PowerBI authentication endpoint hosted in Azure @(`"https://de-users-preview.sqlazurelabs.com/account/reply/", "https://preview.powerbi.com/views/oauthredirect.html"`).  
     The AD FS end point will be added to the Approved AD FS Authentication Service list, to access the list click on **Power Query**, then in the **Settings** section of the ribbon, click on **Options** and then click on **Security**.

   6. Click **Connect** and you will be presented the entity list as usual to start working with Power Query.
