---
title: Troubleshoot issues with accounts used by failover clusters
description: Provides troubleshooting guidance for issues with accounts used by failover clusters.
ms.date: 01/10/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jdeffenbaugh, v-lianna
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Troubleshoot issues with accounts used by failover clusters

This article provides troubleshooting guidance for issues with accounts used by failover clusters.

When you create a failover cluster and [configure clustered services or applications](/windows-server/failover-clustering/configure-ad-accounts), the failover cluster wizard creates the necessary Active Directory accounts and gives them the correct permissions. Issues can occur if a needed account is deleted, or necessary permissions are changed. The following sections provide steps to troubleshoot these issues.

## Troubleshoot password issues with the cluster name account

You receive an event message about computer objects or the cluster identity that includes the following text:

```output
Logon failure: unknown user name or bad password.
```

The event message indicates that the password for the cluster name account no longer matches the corresponding password stored by the clustering software.

> [!NOTE]
> To complete the following steps:
>
> - Your account should be at least a member of the local Administrators group (or equivalent). In addition, your account should be given the **Reset password** permission for the cluster name account (unless it's a Domain Admins account or the Creator Owner of the cluster name account).
> - You can use the account that was used to install the cluster.
>
> For more information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).
>
> For more information about ensuring the cluster administrators have the correct permissions, see [Planning ahead for password resets and other account maintenance](/windows-server/failover-clustering/configure-ad-accounts#planning-ahead-for-password-resets-and-other-account-maintenance).

To resolve these issues, follow the steps:

1. Select **Start**, go to **Administrative Tools**, and then select **Failover Cluster Manager** to open the failover cluster snap-in. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then select **Yes**.
2. In the **Failover Cluster Manager** snap-in, check whether the cluster you want to configure is displayed. If it isn't displayed, in the console tree, right-click **Failover Cluster Manager**, select **Manage a Cluster**, and then select or specify the desired cluster.
3. In the center pane, expand **Cluster Core Resources**.
4. Under **Cluster Name**, right-click the **Name** item, and then select **Take Offline**.
5. Under **Cluster Name**, right-click the **Name** item, point to **More Actions**, and then select **Repair Active Directory Object**.

    > [!NOTE]
    > The **Repair Active Directory Object** option will be greyed out unless the cluster's **Name** resource is offline. Taking the cluster's **Name** resource offline shouldn't negatively impact other cluster groups, such as the SQL Server Failover Cluster Instance. This is because those other cluster groups don't depend on the cluster's **Name** resource.

## Troubleshoot issues caused by changes in cluster-related Active Directory accounts

If the cluster name account is deleted or permissions are removed from the account, you'll experience issues when you try to configure a new clustered service or application. In this scenario, use the **Active Directory Users and Computers** snap-in to view or change the cluster name account and other related accounts.

For more information about the related events (Event IDs 1193, 1194, 1206, and 1207), see [Active Directory Permissions for Cluster Accounts](https://go.microsoft.com/fwlink/?LinkId=118271).

> [!NOTE]
> The following steps require at least membership in the Domain Admins group (or equivalent). For more information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).

To resolve these issues, follow the steps:

1. On a domain controller, select **Start**, go to **Administrative Tools**, and then select **Active Directory Users and Computers**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then select **Yes**.
2. Expand the default **Computers** container or the folder in which the cluster name account (the computer account for the cluster) is located. The **Computers** container is located in **Active Directory Users and Computers**\\\<domain-node\>\\**Computers**.
3. Examine the icon for the cluster name account. The account shouldn't be disabled by having a downward-pointing arrow on it. If it's disabled, right-click it and select **Enable Account** if possible.
4. On the **View** menu, make sure that the **Advanced Features** option is selected.

    When the **Advanced Features** option is selected, you can see the **Security** tab in the properties of accounts (objects) in **Active Directory Users and Computers**.
5. Right-click the default **Computers** container or the folder in which the cluster name account is located, and then select **Properties**.
6. On the **Security** tab, select **Advanced**.
7. In the list of accounts with permissions, select the cluster name account, and then select **Edit**.
    > [!NOTE]
    > If the cluster name account isn't listed, select **Add** and add it to the list.

8. For the cluster name account (also known as the cluster name object or CNO), ensure that the **Allow** checkbox is selected for the **Create Computer objects** and **Read all properties** permissions.

    :::image type="content" source="media/troubleshoot-issues-accounts-used-failover-clusters/permission-entry-for-computers.png" alt-text="Screenshot of the Permission Entry for Computers window showing the Create Computer objects and Read all properties permissions.":::

9. Select **OK** until you return to the **Active Directory Users and Computers** snap-in.
10. Review domain policies (consult a domain administrator if applicable) related to the creation of computer accounts (objects). Ensure that the cluster name account can create a computer account each time you configure a clustered service or application. For example, if your domain administrator has configured settings that cause all new computer accounts to be created in a specialized container rather than the default **Computers** container, make sure that these settings also allow the cluster name account to create new computer accounts in that container.
11. Expand the default **Computers** container or the container in which the computer account for one of the clustered services or applications is located.
12. Right-click the computer account for one of the clustered services or applications, and then select **Properties**.
13. On the **Security** tab, confirm that the cluster name account is listed among the accounts that have permissions, and select it. Confirm that the cluster name account has the **Full control** permission (the **Allow** checkbox is selected). If it doesn't, add the cluster name account to the list and give it the **Full control** permission.

    :::image type="content" source="media/troubleshoot-issues-accounts-used-failover-clusters/application-properties-full-control.png" alt-text="Screenshot showing that the cluster name account is listed and has the Full control permission.":::

14. Repeat steps 12-13 for each clustered service and application configured in the cluster.
15. Make sure that the domain-wide quota (by default, `10`) for creating computer objects hasn't been reached (consult a domain administrator if applicable). If the previous items in this procedure have all been reviewed and corrected, and the quota has been reached, consider increasing the quota. To change the quota, follow these steps: 
    1. Open a command prompt as an administrator and run the `ADSIEdit.msc` command.
    2. Right-click **ADSI Edit**, and then select **Connect to** > **OK**. Then, **Default naming context** is added to the console tree.
    3. Double-click **Default naming context**, right-click the domain object under it, and then select **Properties**.
    4. Scroll to **ms-DS-MachineAccountQuota** and select it. Select **Edit**, change the value, and then select **OK**.
