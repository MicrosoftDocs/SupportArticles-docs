---
title: CRM Rule Deployment Wizard fails to apply rules
description: Microsoft Dynamics CRM Rule Deployment Wizard fails to apply rules to Microsoft Dynamics CRM users with mailboxes hosted on Microsoft Exchange Server 2010. Provides a resolution.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# Failed to access the default store for the user error when CRM Rule Deployment Wizard cannot apply rules

This article provides a resolution for the issue that you can't use the Microsoft Dynamics CRM Rule Deployment Wizard to deploy rules to Microsoft Dynamics CRM users whose mailboxes are hosted on Microsoft Exchange Server 2010.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2545688

## Symptoms

When deploying rules to Microsoft Dynamics CRM users with mailboxes on Microsoft Exchange Server 2010, utilizing the Microsoft Dynamics CRM Rule Deployment Wizard, the following error is displayed:

> Microsoft.Crm.Tools.ExchangeConnectorDeployment.RuleDeploymentException:Failed to access the default store for the user. ---> System.Runtime.InteropServices.COMException (0x8004010F): Failed to access the default store for the user.

## Cause

In Exchange Server 2007, the Microsoft Dynamics CRM Rule Deployment Wizard was able to use the System Attendant Mailbox to gain access to user mailboxes to deploy the forwarding rule. However, in Exchange Server 2010, the System Attendant Mailbox was removed. Thus for Exchange Server 2010, the Microsoft Dynamics CRM Rule Deployment Wizard now uses the Administrator's mailbox to gain access to the user mailboxes to deploy the forwarding rules using MAPI. However, if the account that is running the rule deployment wizard doesn't have appropriate rights to the Administrator mailbox, the rule deployment wizard will fail.

## Resolution

The user running the Microsoft Dynamics CRM Rule Deployment Wizard must have **Manage Full Access Permission...** on the default domain administrator's mailbox. To check for this setting, perform the following steps:

1. On the Exchange 2010 mailbox server, select **Start**, select **All Programs**, select **Microsoft Exchange Server 2010**, and select **Exchange Management Console**.
2. Select Microsoft Exchange On-Premises, select **Recipient Configuration**, **select** Mailbox.
3. Right-click the Administrator mailbox and select **Manage Full Access Permission...**
4. Ensure that the account running the Microsoft Dynamics CRM Rule Deployment Wizard is listed in the **Manage Full Access Permission** dialog box.
5. If the account is not listed, select **Add...**, search for the user account using the search box, and select **OK**.
6. Select **Manage** to complete the permission addition for the user account.

## More information

The Microsoft Dynamics CRM Rule Deployment Wizard will look for the Administrator's account in the Organizational Unit where the user mailbox resides. If the account is not found in this OU, the Microsoft Dynamics CRM Rule Deployment Wizard will perform a lookup for the *Well-known SID* of the domain administrator. This will work unless the domain administrator account was disabled or doesn't have an enabled mailbox. For more information regarding *Well-Known SID*, see the article [Well-known security identifiers in Windows operating systems](/troubleshoot/windows-server/identity/security-identifiers-in-windows).
