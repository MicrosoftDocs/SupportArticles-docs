---
title: Free/busy lookups fail in hybrid deployment
description: Describes an issue that you cannot look up the free/busy information from a mailbox in Exchange Online to an on-premises mailbox. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Issue viewing Free Busy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: benwinz, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Free/busy lookups fail from Exchange Online to on-premises in a hybrid deployment

_Original KB number:_ &nbsp; 4456110

## Symptoms

Assume that you have a hybrid deployment that has a Microsoft 365 tenant. In this deployment, `contoso.com` is configured as the primary on-premises domain. For on-premises mailbox users, Microsoft Entra Connect synchronizes mailbox users in the on-premises Exchange organization, and creates mail-enabled users in Exchange Online.

The `TargetAddress` (`ExternalEmailAddress`) attribute‎ value is automatically calculated as `SMTP:user@contoso.com`. However, for one or more mail-enabled users, the `ExternalEmailAddress` attribute‎ value is set to another domain, such as `SMTP:user@fourthcoffee.com`.

You can verify the `ExternalEmailAddress` attribute‎ value on a mail-enabled user from Exchange Online Remote PowerShell by running the following command:

```powershell
Get-MailUser "Identity of MailUser" | fl name, *ext*
```

Notice that the `ExternalEmailAddress` value in the output is the following:

```console
ExternalEmailAddress : SMTP:user@fourthcoffee.com
```

You can also verify the `ExternalEmailAddress` attribute‎ value from the Microsoft 365 Exchange Admin Center. To do this, locate **Recipients**, and then select **Contacts**. Double-click the mail user in question, and then view the email addresses section. Scroll down to the bottom of the page to see the external email address.

:::image type="content" source="media/hybrid-freebusy-lookups-fail/set-external-email.png" alt-text="Screenshot for ExternalEmailAddress value from Microsoft 365 Exchange Admin Center.":::

> [!NOTE]
> When users are synchronized from on-premises by using the Microsoft Entra Connect synchronization tool, you cannot change the external email address directly in Exchange Online. Instead, you must change the synchronized user in the on-premises organization.

## Workaround

Exchange Online calculates the `ExternalEmailAddress` attribute value only during synchronization. If there are no changes to the email addresses of the on-premises mailbox user, the Microsoft Entra Connect tool does not synchronize that attribute value during the scheduled delta synchronizations.

Additionally, it's not expected that the `TargetAddress` attribute value will ever be populated on a mailbox user.

To work around this issue, follow these steps:

1. Make sure that the `TargetAddress` attribute value is no longer populated for the on-premises mailbox user.
2. Make a change to the email addresses of the on-premises mailbox user. For example, add a new email address temporarily.
3. Perform a delta synchronization by using the Microsoft Entra Connect tool.

You should see that the `ExternalEmailAddress` (`TargetAddress`) attribute value changes back to the expected value of `SMTP:user@contoso.com`. After you verify this change, you can revert the change to the on-premises email addresses if you want.

> [!NOTE]
> You must also make sure that there are no validation errors on the Microsoft Entra object that could prevent synchronization to Exchange Online. For more information about how to check the status through the Microsoft 365 Portal or the Azure Active Directory module for Windows PowerShell, see [You see validation errors for users in the Microsoft 365 portal or in the Azure Active Directory module for Windows PowerShell](https://support.microsoft.com/help/2741233).

## Status

This behavior is by design.

## More information

When Exchange Online performs free/busy lookups, it uses the `ExternalEmailAddress` attribute value to determine which Organization Relationship or which Intra-Organization Connector to use. Exchange Online usually calculates the `ExternalEmailAddress` attribute value automatically based on the primary SMTP address of the on-premises mailbox user.

If the `TargetAddress` attribute is populated on the on-premises mailbox user, Microsoft Entra Connect synchronizes the `TargetAddress` attribute and overwrites the calculated value. When Exchange Online performs a free/busy request, this request may be sent to an unexpected location.

Even if the `TargetAddress` attribute value is later cleared on-premises, the `ExternalEmailAddress` attribute value in Exchange Online does not revert to the expected value.
