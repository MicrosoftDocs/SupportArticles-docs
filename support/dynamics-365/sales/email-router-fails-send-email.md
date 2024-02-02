---
title: Email Router fails to send E-mail
description: Email Router Fails to Send E-mail from Dynamics because of permissions.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Email Router fails to send E-mail from Microsoft Dynamics because of Permissions

This article provides a solution to an issue where Email Router fails to send E-mail from Microsoft Dynamics because of permissions.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4494727

## Symptoms

When using the Dynamics 365 Email Router to send email from a Dynamics 365 instance, the email may go into a Pending Send state and never actually send:

:::image type="content" source="media/email-router-fails-send-email/pending-send-state.png" alt-text="Screenshot shows the email in a Pending Send state.":::

The Dynamics Email Router exception logs may show the following error:

> An error occurred while checking for outgoing email messages to process: `https://disco.crm.dynamics.com/\<OrgName>`. System.ServiceModel.FaultException\`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]: User does not have send-as privilege. (Fault Detail is equal to Exception details:  
>
> ErrorCode: 0x8004480D  
Message: User does not have send-as privilege.

## Cause

This behavior may have worked without needing these permissions on earlier versions of the Dynamics 365 application. Because of changes introduced to the security model in certain iterations of versions 8.2.2 and 9.x, these permissions must be explicitly granted in order for the E-mail Router to send e-mails for another user.

## Resolution

The user sending this email must allow emails to be sent from other Dynamics users in their personal options:

:::image type="content" source="media/email-router-fails-send-email/select-check-box.png" alt-text="Screenshot to select the Allow other Microsoft Dynamics 365 users to send email on your behalf option.":::

The account is being used by the Email Router must also have the **Send Email as Another User** permission within Dynamics:

:::image type="content" source="media/email-router-fails-send-email/security-role.png" alt-text="Screenshot of the Send Email as Another User permission.":::

## More information

- [Dynamics 365, version 9.0 Email Router](https://www.microsoft.com/download/details.aspx?id=56974)
- [Microsoft Dynamics Email Router is deprecated](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn265924(v=crm.8)#microsoft-dynamics-email-router-is-deprecated)
- [Migrate settings from the Email Router to server-side synchronization](/dynamics365/customerengagement/on-premises/admin/migrate-settings-email-router-server-side-synchronization)
