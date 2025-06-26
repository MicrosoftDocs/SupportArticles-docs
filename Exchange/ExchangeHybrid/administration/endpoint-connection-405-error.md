---
title: 405 error in a hybrid deployment
description: Fixes an issue that occurs when you create the organization relationship by using the Autodiscover option or when you run the Get-FederationInformation Windows PowerShell cmdlet in a hybrid deployment in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, jmartin, jhayes, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# FederationInformation could not be received or 405 Method Not Allowed in a hybrid deployment

_Original KB number:_ &nbsp; 2773628

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

In a hybrid deployment of Exchange Online in Microsoft 365 and your on-premises Exchange Server 2010 environment, you experience one or more of the following symptoms:

- When you create the organization relationship from the Microsoft 365 organization by using the Autodiscover option, you get the following error message:

    > Federation Information could not be received from the external organization

- When a Microsoft 365 user tries to look up the free/busy information for an on-premises user, no free/busy information is displayed.
- When you run the `Get-FederationInformation` Windows PowerShell cmdlet, you get the following error message:

    > HTTP Error  
    > 405 Method Not Allowed

When you view the Internet Information Services (IIS) logs in the `C:\Inetpub\logs` folder of the on-premises Exchange 2010 hybrid server, you see a 405 error for the connection to the associated endpoint. The endpoints are as follows:

- The mailbox move endpoint is MrsProxy.svc.
- The Autodiscover endpoint is Autodiscover.svc.

For example, the error entry in the IIS log may resemble the following:

> \<Date>\<Time> 10.10.10.1 POST /EWS/mrsproxy.svc - 443 test\admin 10.10.10.12 - 405 0 1 15

## Cause

This issue occurs if the IIS configuration is missing the svc-Integrated handler mapping. The following screenshot shows an example of the svc-Integrated handler mapping in IIS:

:::image type="content" source="media/endpoint-connection-405-error/iis-configuration.png" alt-text="Screenshot of window for IIS configuration.":::

## Solution

To resolve this issue, in Internet Information Services (IIS) Manager, check the handler mappings at the server level:

- If the svc-Integrated handler mapping is missing, go to [Method 1](#method-1-reinstall-the-handler-mappings-in-iis).
- If the svc-Integrated handler mapping is present, go to [Method 2](#method-2-check-the-handler-mappings-at-the-server-level).

### Method 1: Reinstall the handler mappings in IIS

> [!NOTE]
> Before you follow these steps, back up your IIS configuration.

Run the `ServiceModelReg.exe -r` command to reinstall the handler mappings in IIS. To do this, follow these steps:

1. On the Exchange 2010 hybrid server, open a Command Prompt window, and then navigate to the following folder:

    `C:\Windows\Microsoft.Net\Framework\v3.0\Windows Communication Foundation`

2. Type the following command, and then press Enter:

    ```console
    ServiceModelReg.exe -r
    ```  

    > [!NOTE]
    > You may have to restart IIS after you run this command.

### Method 2: Check the handler mappings at the server level

1. In IIS Manager, expand **Default Web Site**, and then select the Autodiscover virtual directory.
2. Open the Handler Mappings.
   - If the svc-Integrated handler mapping is present, go to step 8.
   - If the svc-Integrated handler mapping is missing, go to step 3.
3. Back up the web.config file in the Autodiscover virtual directory.
4. In the **Actions** pane, click **Revert to Parent**, and then click **Yes** to confirm.
5. Confirm that the svc-Integrated handler mapping is present in the Autodiscover virtual directory.
6. Reset the Autodiscover virtual directory. To do this, open the Exchange Management Shell, and then run the following commands:

    ```powershell
    Remove-AutodiscoverVirtualDirectory "<ServerName>\Autodiscover (Default Web Site)"

    New-AutodiscoverVirtualDirectory -WebSiteName "Default Web Site" -WSSecurityAuthentication:$True
    ```

7. Copy the handlers from the backup web.config file, and then paste them into the web.config file. The handlers should be located within the \<system.webServer> and \</system.webServer> tags of the web.config file.

    At a minimum, the web.config file should contain the following handlers:

    ```console
    <handlers>
          <add name="AutodiscoverAsmxHandler" path="*.asmx" verb="*" type="System.ServiceModel.Activation.HttpHandler,
    System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" preCondition="integratedMode,runtimeVersionv2.0" />
          <add name="AutodiscoverXMLHandler" path="*.xml" verb="POST" type="System.ServiceModel.Activation.HttpHandler, System.ServiceModel,
    Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" preCondition="integratedMode,runtimeVersionv2.0" />
          <add name="AutodiscoverDiscoveryLegacyHandler" path="*.xml" verb="GET" type="Microsoft.Exchange.Autodiscover.WCF.LegacyHttpHandler,
    Microsoft.Exchange.Autodiscover, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" preCondition="integratedMode,runtimeVersionv2.0" />
          <add name="AutodiscoverDiscoveryHandler" path="*.svc" verb="GET" type="Microsoft.Exchange.Autodiscover.WCF.AutodiscoverDiscoveryHttpHandler,
    Microsoft.Exchange.Autodiscover, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" preCondition="integratedMode,runtimeVersionv2.0" />
        </handlers>
    ```

8. Restart IIS. To do this, run `iisreset /noforce` at a command prompt.

## More information

When you experience this issue, you may notice that other connections to the Client Access server (CAS), such as when you set up user profiles through the Autodiscover service, aren't affected. This is because this operation doesn't use the svc endpoint. Any connection that uses the svc endpoint doesn't work in this situation, but other endpoints typically remain unaffected.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
