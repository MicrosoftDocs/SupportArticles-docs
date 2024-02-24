---
title: A batch of Event ID 4780 are logged in the PDC
description: Helps to resolve the issue in which you see a batch of Event ID 4780 logged in the primary domain controller (PDC) security event log.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# A batch of Event ID 4780 are logged in the primary domain controller

This article helps to resolve the issue in which you see a batch of Event ID 4780 logged in the primary domain controller (PDC) security event log.

You've changed the audit or system access control list (SACL) of container type objects (organizational units and containers) in Active Directory where admin users and groups are located. When you check the security event log, you see a batch of Event ID 4780 logged in the PDC every hour.

Here's an example of Event ID 4780:

```output
Level:    Information
Source: Microsoft-Windows-Security-Auditing
Message:  The ACL was set on accounts which are members of administrators groups.

Subject:
       Security ID:        *No String Type*
       Account Name:       ANONYMOUS LOGON
       Account Domain:            NT AUTHORITY
       Logon ID:           998

Target Account:
       Security ID:        *No String Type*
       Account Name:       <Account Name>
       Account Domain:            DC=contoso,DC=com

Additional Information:
       Privileges:         -
```

The reported accounts are all members of administrator-type groups. They're protected by the AdminSDHolder task, and the Security Descriptor (SD) is overwritten from the template SD.

When you inspect the discretionary access control list (DACL) of the reported users, it's the same as AdminSDHolder DACL and the DACL of admin users that aren't reported in Event ID 4780.

## The SD differs from the template SD of the AdminSDHolder object

The AdminSDHolder enforcement job runs on the PDC emulator once an hour. The job builds a list of accounts it protects and ensures the current SD is the same as the template SD of the AdminSDHolder object on the binary level.

The event is triggered by the different SD. The difference in the SD is in the SACL. The SACL, by default, has three entries, and the inheritance is enabled.

The inheritance flag means that when the AdminSDHolder enforcement job writes the SD to enforce AdminSDHolder, the codes merge the SACL written with the SACL of the parent object. This action may lead to additional system access control entries (SACEs) on the freshly written SD.

On the next run of the AdminSDHolder enforcement job, the different SACL leads to a different SD. Then, a new SD will be built and written, but the same happens again. The new SACL written will differ from the template on the AdminSDHolder object.

## Edit the SD of the AdminSDHolder object to not inherit the SACL

> [!NOTE]
> There's no resolution in a software update as of October 2022. It's complex to solve the issue in a software update. The current SACL used by customers may be suitable for deployment, and the inheritance flag may be set on purpose. You can ignore Event ID 4780, and we don't recommend clearing the inheritance flag for existing domains.

If you have problems due to Event ID 4780 and the excessive updates, edit the SD of the AdminSDHolder object to not inherit the SACL. Select **Advanced** in the **AdminSDHolder Properties** window and select **Disable inheritance** on the **Auditing** tab of the **Advanced Security Settings for AdminSDHolder** window. Here are the screenshots:

:::image type="content" source="media/a-batch-of-event-4780-logged-pdc/advanced-security-settings-for-adminsdholder.png" alt-text="Screenshot of the Advanced Security Settings for AdminSDHolder window showing the Auditing entries on the Auditing tab.":::

Avoid the entries inherited from the parent object. Copy or remove the existing entries as needed. Alternatively, adjust the SACL to fit the needs of the protected users and groups.
