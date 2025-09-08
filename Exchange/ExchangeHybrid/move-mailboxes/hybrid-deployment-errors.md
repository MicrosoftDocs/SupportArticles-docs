---
title: Hybrid deployment errors
description: Fixes an error that occurs when you move a mailbox to Microsoft 365 from your on-premises environment in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Exception has been thrown by the target error in a hybrid deployment

_Original KB number:_ &nbsp; 2626696

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

In a hybrid deployment of Microsoft Exchange Online in Microsoft 365 and your on-premises Microsoft Exchange Server 2010 environment, you experience one of the following symptoms:

- When you move a mailbox to Microsoft 365 from your on-premises environment, you receive the following error message:

  > Exception has been thrown by the target of an invocation.

  When you view the IIS logs in the `C:\Inetpub\Logs` folder of the on-premises Exchange Server 2010 hybrid deployment server, you see a **405** error for the connection to the associated endpoint. The endpoints are as follows:

  - The mailbox move endpoint is MrsProxy.svc.
  - The Autodiscover endpoint is Autodiscover.svc.

  For example, the error in the IIS log may resemble the following:

  > \<**Date**> \<**Time**> 10.10.10.1 POST /EWS/mrsproxy.svc - 443 test\admin 10.10.10.12 - 405 0 1 15W

- When you run the `Get-federationInformation -Verbose` cmdlet, you receive one of the following error messages:

  - > Request failed with http status 405: method not allowed

  - > Execution of the Get-FederationInformation cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.

  - > Exception has been thrown by the target of an invocation

- When you try to set up the hybrid deployment in the Hybrid Configuration wizard, you receive the following error message:

    > INFO:Cmdlet: Get-FederationInformation  
    > ERROR:System.Management.Automation.RemoteException: Federation information could not be received from the external organization

## Cause

This issue occurs if the Internet Information Services (IIS) configuration is missing the svc-Integrated handler mapping. The following screenshot shows an example of the svc-Integrated handler mapping in IIS:

:::image type="content" source="media/hybrid-deployment-errors/handler-mapping.png" alt-text="Screenshot of an example of the svc-Integrated handler mapping in IIS.":::

## Solution

> [!NOTE]
> Before you follow these steps, back up your IIS configuration.

To resolve this issue, run the `ServiceModelReg.exe -r` command to reinstall the handler mappings in IIS. To do this, follow these steps:

1. On the Exchange Server 2010 hybrid server, open a Command Prompt window, and then move to the following folder:

    `C:\Windows\Microsoft.Net\Framework\v3.0\Windows Communication Foundation\`

2. Type the following command, and then press Enter:

    ```console
    ServiceModelReg.exe -r
    ```  

    > [!NOTE]
    > You may have to restart IIS after you run this command.

## More information

When you experience this issue, you may notice that other connections to the Client Access Server (CAS), such as the connection for configuring user profiles through the Autodiscover service, aren't affected. This is because this operation doesn't use the svc endpoint. Any connection that uses the svc endpoint won't work. Other endpoints probably will not be affected.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
