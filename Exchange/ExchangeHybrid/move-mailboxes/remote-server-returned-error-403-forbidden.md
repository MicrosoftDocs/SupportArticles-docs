---
title: 403 Forbidden when moving mailboxes to Exchange Online
description: Describes an issue that triggers an error when you try to move mailboxes from the on-premises Exchange Server environment to Exchange Online in Microsoft 365. The solution involves enabling MRSProxy.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Service Pack 3
search.appverid: MET150
ms.date: 01/24/2024
---
# The remote server returned an error (403) Forbidden error when moving mailboxes to Exchange Online

_Original KB number:_ &nbsp; 3063913

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

When you try to onboard mailboxes or move them from an on-premises Exchange Server environment to Exchange Online in Microsoft 365 in a hybrid deployment, the operation fails. The error message that you receive depends on whether you use the Exchange admin center or remote PowerShell.

- In the Exchange admin center, you receive an error message that resembles the following:

  > error  
  > The connection to the server 'mail.\<DomainName>.com' could not be completed.

- When you use Exchange Online PowerShell, you receive the following error message:

  > The call to 'https://mail.\<DomainName>.com/EWS/mrsproxy.svc' failed. Error details: The HTTP request was forbidden with client authentication scheme 'Negotiate'. -->  
  The remote server returned an error: (403) Forbidden..  
  \+ CategoryInfo : NotSpecified: (:) [New-MoveRequest], RemoteTransientException  
  \+ FullyQualifiedErrorId : [Server=xxxxxxxxxxxx,RequestId=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx,TimeStamp=4/21/2015 2:07:09 PM] [FailureCategory=Cmdlet-RemoteTransien
tException] 284A32E1,Microsoft.Exchange.Management.RecipientTasks.NewMoveRequest  
  \+ PSComputerName : `outlook.office365.com`

## Cause

This problem occurs if the Mailbox Replication Proxy (MRS Proxy) service in the EWS virtual directory on the hybrid server is in a disabled state. This may occur if one of the following conditions is true:

- MRSProxy is not enabled.

  To verify that this is the cause of the issue, follow these steps:

  1. Open the Exchange Management Shell.
  2. Run the following command:

        ```powershell
        Get-WebServicesVirtualDirectory "ServerName\EWS (Default Web Site)" |FL Server,MRSProxyEnabled
        ```

     If **MRSProxyEnabled :False** is returned in the output, this is the cause of the issue.

- An issue occurred on the hybrid server in which `MRSProxy` shows as **Enabled** when you run the `Get-WebServicesVirtualDirectory` cmdlet, but `MRSProxy` is disabled.

  To verify that this is the cause of the issue, follow these steps:

  1. Open the Exchange Management Shell.
  2. Run the following command:

        ```powershell
        Get-WebServicesVirtualDirectory "ServerName\EWS (Default Web Site)" |FL Server,MRSProxyEnabled
        ```

  3. If **MRSProxyEnabled : True** is returned in the output, search the Application log in Event Viewer for an instance of event 1309 that resembles the following:
  
        > Event Warning:  
        Warning \<Date> \<Time> ASP.NET 4.0.30319.0 1309 Web Event  
        Description:  
        Exception information:  
        Exception type: HttpException  
        Exception message: MRS proxy service is disabled

## Resolution

To resolve this issue, do one of the following, as appropriate for your situation.

### Enable MRSProxy

1. Open the Exchange Management Shell.
2. Run the following command to enable MRSProxy:

    ```powershell
    Set-WebServicesVirtualDirectory "<ServerName>\EWS (Default Web Site)" -MRSProxyEnabled $true
    ```

3. Restart Internet Information Services (IIS) by using the iisreset command.

### Disable and then enable MRSProxy

1. Open the Exchange Management Shell.
2. Run the following command to disable MRSProxy:

    ```powershell
    Set-WebServicesVirtualDirectory "<ServerName>\EWS (Default Web Site)" -MRSProxyEnabled $false
    ```

3. Wait a few minutes, and then run the following command to enable MRSProxy:

    ```powershell
    Set-WebServicesVirtualDirectory "<ServerName>\EWS (Default Web Site)" -MRSProxyEnabled $true
    ```

4. Restart Internet Information Services (IIS) by using the iisreset command.

## More information

For more information, see the following resources:

- [Enable the MRS Proxy endpoint for remote moves](/exchange/enable-the-mrs-proxy-endpoint-for-remote-moves-exchange-2013-help)
- [Move mailboxes between on-premises and Exchange Online organizations in 2013 hybrid deployments](/exchange/hybrid-deployment/move-mailboxes)
- [Start the MRSProxy Service on a Remote Client Access server](/previous-versions/office/exchange-server-2010/ee732395(v=exchg.141))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
