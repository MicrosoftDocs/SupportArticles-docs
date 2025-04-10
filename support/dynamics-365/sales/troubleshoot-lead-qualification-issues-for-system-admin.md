---
title: Troubleshoot issues with lead qualification for system admins
description: Provides resolutions for the lead qualification issues for system administrators in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/28/2022
ms.custom: sap:Lead
---

# Troubleshoot issues with lead qualification for system administrators

## Issue 1 - Insufficient permissions or Access denied error when a user is trying to qualify a lead

How you resolve this error depends on the following ownership scenarios for the lead records.

| Ownership scenario   |  Resolution steps       |
|--------------------- | -----------------       |
| The lead is owned by the user trying to qualify it. | <ol> <li> Make sure you have a system administrator role or equivalent permissions. </li><li> Go to **Settings** > **Security Role**.</li><li> Open the security role of the user.</li><li> On the **Core Records** tab, assign **Create**, **Read**, **Append**, and **Append To** permissions to the Security Role at User level on the following entities:<ul><li>  Account</li><li>Lead</li><li>Contact</li><li>Opportunity</li></ul> :::image type="content" source="media/troubleshoot-lead-qualification-issues-for-system-admin/security-role-sales-person.png" alt-text="Security role with access at User level."::: <br><br> <li> On the **Custom Entities** tab, assign Read access to any custom entity.</li><li> On the **Customizations** tab, assign **Read** access to **Attribute Map**, **Customizations**, **Entity**, and **Entity Map**.</li></ol> |
| The lead that the user is trying to qualify is in their business unit.| <ol><li>Go to **Settings** > **Security Role**.</li> <li> Open the security role of the user.</li><li> Assign **Create**, **Read**, **Append**, and **Append To** permissions to the user's Security Role at Business Unit level on the following entities:<ul><li> Account</li><li>Lead</li><li>Contact</li><li>Opportunity</li></ul>:::image type="content" source="media/troubleshoot-lead-qualification-issues-for-system-admin/security-role-sales-person-business-unit-access.png" alt-text="Security role with access at Business Unit level."::: <li> Assign **Read** access to any custom entity.</li><li>Assign **Read** access to **Attribute Map**, **Customizations**, **Entity**, and **Entity Map**.</li></ol>|
| The lead that the user is trying to qualify is in their organization.| <ol><li>Go to **Settings** > **Security Role**.</li> <li> Open the security role of the user.</li><li> Assign **Create**, **Read**, **Append**, and **Append To** permissions to the user's Security Role at Organization level on the following entities:<ul><li> Account</li><li>Lead</li><li>Contact</li><li>Opportunity</li></ul>:::image type="content" source="media/troubleshoot-lead-qualification-issues-for-system-admin/security-role-sales-person-org-access.png" alt-text="Security role with access at Organization level."::: <li> Assign **Read** access to any custom entity.</li><li>Assign **Read** access to **Attribute Map**, **Customizations**, **Entity**, and **Entity Map**.</li></ol>|

During qualification of a lead, the records that (optionally) get created are: Opportunity, Contact, and Account. For more information, see [Qualify or convert leads](/dynamics365/sales/qualify-lead-convert-opportunity-sales).

If the user is getting privilege-related errors even after assigning appropriate privileges as mentioned earlier in this section, it might be possible that they're missing privileges on some entities that are being accessed during creation of the account, contact, or opportunity records. For example, the user might be missing privileges on some custom entities that are accessed when some plug-ins or workflows run on some operation of the account, contact, or opportunity entities.

To troubleshoot this further, follow these steps:

1. **Isolate the issue to creation of Opportunity, Account or Contact record:** Ask the user to try creating individual records of Account, Contact, and Opportunity and see if they get the same privilege-related issue on creation of these records. They might have privilege issues on one or more type of records, so it's important to perform this step for each record type. For example, they might not have appropriate privileges on Account and Contact entities.

2. **Identify whether any plug-in/workflow registered on creation of entity is causing issues:** After isolating the issue to creation of a particular entity record, check whether any plug-in or workflow running on creation of these entity records is accessing some other entities on which the current user is missing privileges. For this, find out all the plug-ins or workflows registered on creation of entity records and deactivate them one by one to identify the plug-in or workflow causing the issue. Once you identify the plug-in or workflow causing the issue, deactivate it to unblock the record creation process. For more information about identifying all workflows registered for an entity, see [Deactivate custom workflow process](troubleshoot-multiple-tables-issues.md#deactivate-a-custom-workflow-process).

For more information about identifying plug-ins registered on creation of an entity record, see [Deactivate custom plug-in](troubleshoot-multiple-tables-issues.md#deactivate-a-custom-plug-in).

## Issue 2 - The "Qualify lead" command isn't available on the Lead record

### Cause

The out-of-the-box **Qualify lead** command is visible on the Lead form only if Account, Contact, Lead, and Opportunity entities are set as editable in Unified Interface, and the Account, Contact, and Opportunity entities are available in Mobile offline.

### Resolution

If the **Qualify lead** command isn't available, check the following:

- Account, Contact, Lead or Opportunity entities are set to read-only for mobile. If they are, clear the **Read-only in mobile** check box in entity customization so that the entity becomes editable for Unified Interface. For more information, see [Troubleshoot issues with Unified Interface](troubleshoot-unified-interface-issues.md).
- Check if the Account, Contact, and Opportunity entities are part of the mobile offline profile. If they aren't, add these entities to the profile and publish the changes. For more information, see [Enable entities for mobile offline synchronization](/dynamics365/mobile-app/setup-mobile-offline-for-admin#step-1-enable-entities-for-mobile-offline-synchronization).
