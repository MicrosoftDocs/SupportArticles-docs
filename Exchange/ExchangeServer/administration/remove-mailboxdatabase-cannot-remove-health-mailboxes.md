---
title: Remove MailboxDatabase cannot clean up health mailboxes
description: Health mailboxes cannot be cleaned up by running the Remove-MailboxDatabase cmdlet in Exchange Server 2016 and 2013. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Health set unhealthy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, jarrettr, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Remove MailboxDatabase operation fails to clean up health mailboxes

_Original KB number:_ &nbsp; 3046530

## Symptoms

When you try to remove a mailbox database from Exchange Server 2016 or Exchange Server 2013, you receive these warnings:

EMS:

:::image type="content" source="media/remove-mailboxdatabase-cannot-remove-health-mailboxes/screenshot-of-ems-warning.png" alt-text="Screenshot of EMS warning.":::

EAC:

:::image type="content" source="media/remove-mailboxdatabase-cannot-remove-health-mailboxes/screenshot-of-eac-warning.png" alt-text="Screenshot of EAC warning.":::

## Cause

This attempt to remove the mailbox database fails to remove the AD User accounts of health mailboxes in the database, and this triggers the warning messages.

The AD user accounts cannot be removed in this case because the Exchange Servers security group inherits explicit deny permissions for deleting objects in the Monitoring Mailboxes container.

## Workaround

To work around this issue, follow these steps to add an explicit allow permission to the Exchange Servers group on the Monitoring Mailboxes container. To do this, follow these steps:

1. Open Active Directory Users and Computers.
2. Select **View**, and then make sure that **Advanced Features** is selected. If it is not, select it.
3. Navigate to the following container:

    :::image type="content" source="media/remove-mailboxdatabase-cannot-remove-health-mailboxes/monitoring-mailboxes-container.png" alt-text="Screenshot of Monitoring mailboxes container.":::

4. Right-click **Monitoring Mailboxes**, select **Properties**, and then select the **Security** tab.

5. Select **Advanced** on the **Security** tab. You now see this dialog box:

    :::image type="content" source="media/remove-mailboxdatabase-cannot-remove-health-mailboxes/advanced-security-settings-for-monitoring-mailboxes.png" alt-text="Screenshot of advanced security settings for monitoring mailboxes.":::

6. Select **Add**, type *Exchange Servers*, select **Check Names**, and then select **OK**.

7. Select the **Allow** check box for the **Delete subtree** permission.

    :::image type="content" source="media/remove-mailboxdatabase-cannot-remove-health-mailboxes/permission-entry-monitoring-mailboxes.png" alt-text=" Screenshot of Permission Entry Monitoring Mailboxes.":::

8. Select **OK** in all the remaining windows.

9. Wait for AD replication.

If you have Exchange deployment in a multi-AD domain environment, follow the preceding steps on all the domains in which Exchange servers are deployed.
