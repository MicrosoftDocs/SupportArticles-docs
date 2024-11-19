---
title: Http server returned Forbidden exception
description: Provides a solution to an error that occurs when you select the Test & Enable Mailbox button on a mailbox record in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Http server returned Forbidden exception" error appears in Microsoft Dynamics 365 mailbox

This article provides a solution to an error that occurs when you select the **Test & Enable Mailbox** button on a mailbox record in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4483440

## Symptoms

When you select the **Test & Enable Mailbox** button on a mailbox record in Dynamics 365, the test results section shows Failure and the following alert is logged:

> "The email message "Your mailbox is now connected to Dynamics 365" cannot be sent because an error occurred while establishing a secure connection to the email server. Mailbox [Mailbox Name] didn't synchronize. The owner of the email server profile Microsoft Exchange Online has been notified.  
Email Server Error Code: Http server returned Forbidden exception."

If you select **Details**, the following other details are shown:

> "Error : System.Net.WebException: The request failed with HTTP status 403: Forbidden.  
   at System.Web.Services.Protocols.SoapHttpClientProtocol.ReadResponse(SoapClientMessage message, WebResponse response, Stream responseStream, Boolean asyncCall)  
   at System.Web.Services.Protocols.SoapHttpClientProtocol.EndInvoke(IAsyncResult asyncResult)  
   at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeServiceBinding.EndCreateItem(IAsyncResult asyncResult)  
   at Microsoft.Crm.Asynchronous.EmailConnector.ExchangeOutgoingEmailProvider.EndCreateItem()"

## Cause

Dynamics 365 communicates with Microsoft Exchange using Exchange Web Services (EWS) requests. If EWS is disabled, this error will occur. The following contents are some potential ways that EWS may be disabled or restricted in Exchange:

1. EWS is disabled for the mailbox
2. EWS is disabled for the entire organization
3. The `EwsApplicationAccessPolicy` is set to **EnforceAllowList** and `the EwsAllowList` doesn't allow access from Dynamics 365 (CRM).
4. The `EwsApplicationAccessPolicy` is set to **EnforceBlockList** and `the EwsBlockList` includes Dynamics 365 (CRM).

## Resolution

**If the issue only occurs for some mailboxes, check if EWS is disabled for the mailbox:**

1. First check to see if EWS has been disabled for the mailbox. Use the following PowerShell command:

    ```powershell
    Get-CASMailbox <mailbox-alias> | ft EwsEnabled
    ```

2. If **EwsEnabled** is set to **False**, use the following PowerShell command to enable Exchange Web Services (EWS) for the mailbox:

    ```powershell
    Set-CASMailbox <mailbox-alias> -EwsEnabled $True
    ```

    > [!IMPORTANT]
    > After running this command, it may take up to 120 minutes before the setting change takes effect.

 **If the issue occurs for all mailboxes, check if EWS is disabled at the organization level, or if the EwsAllowList is being used to limit what EWS traffic is allowed.**

1. Use the following PowerShell command to see if any of the EWS settings are configured:

    ```powershell
    Get-OrganizationConfig |ft Name, EwsEnabled,EwsApplicationAccessPolicy,EwsBlockList,EwsAllowList
    ```

2. Verify that **EwsEnabled** isn't set to **False**. The following command can be used to set **EwsEnabled** to **True** if it's currently set to **False**:

    ```powershell
    Set-OrganizationConfig -EwsEnabled $True
    ```

    > [!IMPORTANT]
    > After running this command, it may take up to 120 minutes before the setting change takes effect.

3. If `EwsApplicationAccessPolicy` is set to **EnforceAllowList** and the `EwsAllowList` doesn't contain a value for CRM (Example: CRM/\*), which would prevent Dynamics 365 (CRM) from being able to communicate with Exchange. Use the following command to update the list to include CRM/* and whatever other applications you want to allow (\<PreviousAllowList> in the following example):

    ```powershell
    Set-OrganizationConfig -EwsApplicationAccessPolicy:EnforceAllowList -EwsAllowList:CRM/*,<PreviousAllowedList>
    ```

    > [!IMPORTANT]
    > After running this command, it may take up to 120 minutes before the setting change takes effect.

4. If `EwsApplicationAccessPolicy` is set to **EnforceBlockList** and the **EwsAllowList** contains a value for CRM (Example: CRM/*), which would prevent Dynamics 365 (CRM) from being able to communicate with Exchange. Use the following command to update the list to no longer include CRM:

    ```powershell
    Set-OrganizationConfig -EwsApplicationAccessPolicy:EnforceBlockList -EwsBlockList:<PreviousBlockList WITH CRM REMOVED>
    ```

    > [!IMPORTANT]
    > After running this command, it may take up to 120 minutes before the setting change takes effect.

## More information

For more information about changing Exchange settings using PowerShell and controlling access to EWS, see the following articles:

- [Exchange Server PowerShell (Exchange Management Shell)](/powershell/exchange/exchange-management-shell)  
- [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
- [Control access to EWS in Exchange](/exchange/client-developer/exchange-web-services/how-to-control-access-to-ews-in-exchange)  
- [Set-CASMailbox](/powershell/module/exchange/set-casmailbox)
