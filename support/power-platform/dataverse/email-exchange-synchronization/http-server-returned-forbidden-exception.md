---
title: Http server returned Forbidden exception
description: Provides a solution to an error that occurs when you select the Test & Enable Mailbox button on a mailbox record in Dynamics 365.
ms.reviewer: 
ms.date: 12/30/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "Http server returned Forbidden exception" error when testing a Dynamics 365 mailbox

This article provides a solution to an error that occurs when you select the **Test & Enable Mailbox** button on a mailbox record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4483440

## Symptoms

When you select the **Test & Enable Mailbox** button on a mailbox record in Dynamics 365, the test results section shows **Failure** and the following alert is logged:

> The email message "Your mailbox is now connected to Dynamics 365" cannot be sent because an error occurred while establishing a secure connection to the email server. Mailbox [Mailbox Name] didn't synchronize. The owner of the email server profile Microsoft Exchange Online has been notified.  
> **Email Server Error Code**: Http server returned Forbidden exception.

If you select **Details**, the following details are shown:

> Error : System.Net.WebException: The request failed with HTTP status 403: Forbidden.  
> at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
> at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
> at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndCreateItem(IAsyncResult asyncResult)  
> at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeOutgoingEmailProvider.EndCreateItem()

## Cause

Dynamics 365 communicates with Microsoft Exchange using Exchange Web Services (EWS) requests. If EWS is disabled, this error occurs. Here are some potential ways that EWS might be disabled or restricted in Exchange:

1. EWS is disabled for the mailbox.
2. EWS is disabled for the entire organization.
3. The `EwsApplicationAccessPolicy` is set to **EnforceAllowList** and the `EwsAllowList` doesn't allow access from Dynamics 365.
4. The `EwsApplicationAccessPolicy` is set to **EnforceBlockList** and the `EwsBlockList` includes Dynamics 365.

## Resolution

### Check if EWS is disabled for the mailbox if the issue only occurs for some mailboxes

1. First, check if EWS is disabled for a specific mailbox using this PowerShell command:

    ```powershell
    Get-CASMailbox <mailbox-alias> | ft EwsEnabled
    ```

2. If **EwsEnabled** is set to **False**, enable it using this command:

    ```powershell
    Set-CASMailbox <mailbox-alias> -EwsEnabled $True
    ```

    > [!IMPORTANT]
    > After running this command, it might take up to 120 minutes before the setting change takes effect.

## Check if EWS is disabled at the organization level or if the EwsAllowList limits the EWS traffic

1. Use this PowerShell command to check organization-level settings:

    ```powershell
    Get-OrganizationConfig |ft Name, EwsEnabled,EwsApplicationAccessPolicy,EwsBlockList,EwsAllowList
    ```

2. Ensure that `EwsEnabled` isn't set to **False**. If it is, enable it using:

    ```powershell
    Set-OrganizationConfig -EwsEnabled $True
    ```

    > [!IMPORTANT]
    > After running this command, it might take up to 120 minutes before the setting change takes effect.

3. If `EwsApplicationAccessPolicy` is set to **EnforceAllowList**, check if the `EwsAllowList` contains a value for CRM (for example, CRM/\*) to allow Dynamics 365 (CRM) to communicate with Exchange. If it does not, use the following command to update the list to include CRM/* and any other applications you want to allow. In this example \<PreviousAllowedList> is the list of applications that were previously in the allowlist:

    ```powershell
    Set-OrganizationConfig -EwsApplicationAccessPolicy:EnforceAllowList -EwsAllowList:CRM/*,<PreviousAllowedList>
    ```

    > [!IMPORTANT]
    > After running this command, it might take up to 120 minutes before the setting change takes effect.

4. If `EwsApplicationAccessPolicy` is set to **EnforceBlockList**, check if the `EwsBlockList` contains a value for CRM (for example, CRM/*), which prevents Dynamics 365 (CRM) from communicating with Exchange. If it does, use the following command to update the list to no longer include CRM. In this example \<PreviousBlockList WITH CRM REMOVED> is the list of applications that were previously in the blocklist except for CRM:

    ```powershell
    Set-OrganizationConfig -EwsApplicationAccessPolicy:EnforceBlockList -EwsBlockList:<PreviousBlockList WITH CRM REMOVED>
    ```

    > [!IMPORTANT]
    > After running this command, it might take up to 120 minutes before the setting change takes effect.

## More information

For more information about changing Exchange settings using PowerShell and controlling access to EWS, see the following articles:

- [Exchange Server PowerShell (Exchange Management Shell)](/powershell/exchange/exchange-management-shell)  
- [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
- [Control access to EWS in Exchange](/exchange/client-developer/exchange-web-services/how-to-control-access-to-ews-in-exchange)  
- [Set-CASMailbox](/powershell/module/exchange/set-casmailbox)
