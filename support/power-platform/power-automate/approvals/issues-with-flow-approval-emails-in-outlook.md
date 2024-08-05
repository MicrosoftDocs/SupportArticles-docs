---
title: Issues with flow approval emails in Outlook
description: Known issues and errors that users might face when receiving or responding to actionable flow approval emails directly within Outlook Desktop and Web.
ms.reviewer: sranjan, hamenon
ms.date: 03/31/2021
ms.custom: sap:Approvals\Approval emails
---
# Issues with flow approval emails in Outlook Desktop and Web

This article introduces the known issues and errors that you might have when receiving or responding to actionable flow approval emails directly within Microsoft Office Outlook.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4515128

## Summary

Microsoft Flow sends actionable messages to approval recipients so that they might respond to the requests directly from their inbox. For an overview of actionable messages, see the documentation: [Actionable messages in Outlook and Office 365 Groups](/outlook/actionable-messages/). For the minimum versions of Office that support actionable message, see the [Release Notes](/outlook/actionable-messages/#release-notes).

Actionable Messages must be enabled at the Microsoft 365 tenant level for any users to receive them. To ensure the options are enabled, use the following Microsoft 365 PowerShell command and verify that both options are set to **$true**:

```powershell
Get-OrganizationConfig | ft ConnectorsActionableMessagesEnabled,SmtpActionableMessagesEnabled
```

For users that aren't on the required version of Outlook, or are using another mail client like Mail.app for iOS/Mac OS X, etc., users will receive an HTML email with links to take the user to the Flow portal to respond to approvals.

The [Actionable Messages Debugger for Outlook](https://appsource.microsoft.com/product/office/WA104381686?tab=Overview) can help reveal common causes of issues with actionable messages. Installing this tool adds a button within Outlook Desktop and Web that will show diagnostic and error information.

Customers might run into a few issues regarding receiving and approving approval messages directly from within Outlook.

## Issue 1 - Neither Outlook Desktop nor Outlook Web (OWA) give the user actionable responses

This typically means that a user isn't using a supported version of Office 365, or mail for the specific account is being redirected to an on-premises mail server. For more information, see [Release Notes](/outlook/actionable-messages/#release-notes). Alternatively, actionable messages might be disabled at the tenant level (see above for how to check this).

This situation can also arise if there are SMTP mail delays between Microsoft Flow and the user's mailbox of over an hour (more frequently possible when a tenant is using a filtering service that receives mail before routing it to Office 365). The Actionable Messages Debugger will show a diagnostic message similar to:

> Message card signature validation failed - iat validation failure, card was processed 70 minutes from IAT

## Issue 2 - Outlook Desktop doesn't present actionable messages but Outlook Web (OWA) does

This is a known issue fixed in Outlook Desktop builds 1911(16.0.12228) and higher, involving user permissions accessing the Office Add-in store. A temporary workaround is to make sure that the affected users have access to the Office Store for Add-ins (though this is temporary and won't be necessary after Office desktop release). To verify this case, look for the following registry key. If empty, the user doesn't have access to the Office store and won't receive actionable emails in Outlook Desktop.

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\WebExt\MarketplaceUrls`

## Issue 3 - Users receive a message similar to "Sorry an error occurred please try again later" when responding to messages from Outlook Desktop

This is a known issue fixed in the June release train of Outlook Desktop, build version 16.0.11901.20167 and higher. The workaround in the meantime is to use Outlook Web (OWA).
