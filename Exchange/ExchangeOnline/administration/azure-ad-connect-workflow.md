---
title: Microsoft Entra Connect workflow in Microsoft 365
description: Describes the workflow with which Microsoft Entra Connect works in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.reviewer: kerbo, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# How Microsoft Entra Connect works in Microsoft 365

_Original KB number:_ &nbsp; 4052070

## Summary

Microsoft Entra Connect is used to synchronize data to Microsoft Entra ID. Microsoft Entra Connect checks and validates information along the way. Sync errors may occur, and new objects or updated values may not reach Microsoft Entra ID.

It's important to understand the flow of data from on-premises to the cloud in Exchange Online. If a failure or error occurs, this article can help determine where the problem is occurring and how to fix it.

## High-level workflow

:::image type="content" source="media/azure-ad-connect-workflow/workflow.png" alt-text="Screenshot of the High-Level workflow from source on-premises AD to a source connector space.":::

1. The data flows from source on-premises AD to a source connector space.

    During this process, new objects and changes to existing objects are evaluated and if any conflicts exist, they're flagged. If the object is new and errors are present, the object isn't provisioned.

    If it's an existing object, the conflicting data may not be passed forward. The object may continue to function. However, the desired change, intended or accidental, isn't made. It triggers a DirSync error that has to be corrected in source AD.  

    For more information, see the following articles:

    - [Introduction to the Microsoft Entra Connect Synchronization Service Manager UI](/azure/active-directory/hybrid/how-to-connect-sync-service-manager-ui)
    - [Using the Sync Service Manager Operations tab](/azure/active-directory/hybrid/how-to-connect-sync-service-manager-ui-operations)

2. If a change passes the first stage, it enters the **Metaverse**, and then the change is passed along to the Target Connector Space. For more information, see [Sync Service Manager Metaverse Search](/azure/active-directory/hybrid/how-to-connect-sync-service-manager-ui-mvsearch).

3. If there are no issues, the change is populated into the Target Data Store and Microsoft Entra ID. At this point, you can use the [Get-MSOLUser](/powershell/module/msonline/get-msoluser) command and other Azure commands against the object to view them in Microsoft Entra ID.

    If a problem occurs between the Target Connector Space and Microsoft Entra ID, you may have to remove the object from Microsoft Entra ID by using the [Remove-MsolUser](/powershell/module/msonline/remove-msoluser) cmdlet. You can't force Microsoft Entra ID to reevaluate the object as you can in MMSSPP.

4. Finally, the data synchronizes to Exchange, where the object exists as a Mailbox, MailUser, Resource, and so on. It's known as **Forward Sync**. If there's a problem on an object between Microsoft Entra ID and Exchange Online (represented by validation errors), ask Microsoft to submit the object for a Forward Sync from Microsoft Entra ID to Exchange Online to force this action.

## More information

For more information about this topic, see the following article and explore the topics in the left navigation pane:

[What is hybrid identity with Microsoft Entra ID?](/azure/active-directory/hybrid/whatis-hybrid-identity)

A related topic is Active Directory Federation Services. See the following articles for more information.

- [Microsoft Entra Connect and federation](/azure/active-directory/hybrid/how-to-connect-fed-whatis)
- [Troubleshooting errors during synchronization](/azure/active-directory/hybrid/tshoot-connect-sync-errors)

Here are articles for some common issues:

- [Exchange Online object isn't present or updated in Microsoft Entra Connect](https://support.microsoft.com/help/4051392/a-vnext-object-is-not-present-or-updated-in-azure-ad-connect-for)
- [Mailbox not provisioned in Microsoft Entra Connect for Microsoft 365](https://support.microsoft.com/help/4051375/mailbox-is-not-provisioned-in-azure-ad-connect-for-office-365)
- [A user is missing from a group in Microsoft Entra Connect for Microsoft 365](https://support.microsoft.com/help/4052041/a-user-is-missing-from-a-group-in-azure-ad-connect-for-office-365)
- [Mailbox is present in both Office 365 Legacy Dedicated and vNext after license is applied](https://support.microsoft.com/help/3202607/can-t-complete-auto-discover-or-connect-to-a-mailbox-after-the-mailbox)
- [You see validation errors for users in the Microsoft 365 portal or in the Azure Active Directory module for Windows PowerShell](https://support.microsoft.com/help/2741233/you-see-validation-errors-for-users-in-the-office-365-portal-or-in-the)
- [Validation errors for a mailbox archive GUID for Microsoft 365 users](./validation-errors-for-mailbox-archive-guid.md)
