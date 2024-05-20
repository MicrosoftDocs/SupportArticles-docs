---
title: Orphaned child domain controller isn't replicated
description: Describes an issue in which an orphaned child domain controller can't replicate information to other domain controllers in a domain, and provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, johnbay
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Orphaned child domain controller information is not replicated to other domain controllers

This article provides a solution to an issue where an orphaned child domain controller can't be replicated to other domain controllers.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 887430

## Symptoms

A Microsoft Windows Server-based child domain is orphaned from the rest of the forest. This child domain can receive changes that are replicated by domain controllers in the parent (root) domain, but no domain controllers in the root domain or any other child domains have knowledge of the domain controllers in the affected child domain.

When an administrator tries to view the domain controllers in the orphaned child domain from another domain, no domain controllers are displayed. For example, no domain controllers are displayed in the following configuration naming context:  
CN=Servers,CN= **Site_Name**,CN=Sites,CN=Configuration,DC= **Domain_Name**,DC=com

In this case, **Site_Name** and **Domain_Name** are attributes of the orphaned domain.

## Cause

This issue may occur if the child domain is orphaned from the parent domain.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, you must create a replication link and then enable one-way authentication instead of two-way authentication. To do this, follow these steps:

1. On a domain controller in the root domain, add the **Replicator Allow SPN Fallback** registry value. To do this, follow these steps on the domain controller.
    1. Select **Start** > **Run**, and then enter **regedt32**.
    2. Select the following registry subkey:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`
    3. Select **Edit** > **New** > **DWORD Value**.
    4. Enter **Replicator Allow SPN Fallback**.
    5. In the right pane, double-click **Replicator Allow SPN Fallback**, type **1** in the **Value data** box, and then select **OK**.
    6. Restart the domain controller.

2. Open a Command Prompt window, and run the following commands:

    ```console
    repadmin /options fully_qualified_domain_name_(FQDN)_of_the_root_domain_controller +DISABLE_NTDSCONN_XLATE  
    repadmin /add CN=Configuration,DC=Domain_Name,DC=Domain_Name FQDN_of_the_root_domain_controller FQDN_of_the_child_domain_controller  
    repadmin /showreps
    ```

    A successful incoming connection should be displayed for the configuration naming context from the child domain controller.

    > [!NOTE]
    > For information about the Repadmin.exe tool, see [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](/previous-versions/windows/it-pro/windows-server-2003/cc811551%28v=ws.10%29).

3. At the command prompt, run the command: `repadmin /options FQDN_of_the_root_domain_controller -DISABLE_NTDSCONN_XLATE`.

4. Remove the **Replicator Allow SPN Fallback** registry entry. To do this, follow these steps:

    1. Start Registry Editor, and select the following registry subkey:

        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`
    2. Right-click **Replicator Allow SPN Fallback**, select **Delete**, and then select **OK**.

5. Force replication between all domain controllers in the root domain. To do this, follow these steps:
    1. On a domain controller in the root domain, select **Start** > **Programs** > **Administrative Tools** > **Active Directory Sites and Services**.
    2. Expand **Sites** > **Servers**, expand your **Server_Name** folder, and then select **NTDS Settings**.
    3. If there are other domain controllers in your environment to replicate, they will be listed in the right pane. Right-click the first domain controller in the list, select **All Tasks**, and then select **Check Replication Topology** to start the Knowledge Consistency Checker (KCC).

        An incoming connection object from one or more of the child domain controllers is displayed. You may have to update the display by pressing F5.
    4. Repeat step 3 for each domain controller in the root domain.

6. Allow replication to occur throughout the forest. Then, run the `repadmin /showreps` command on the root domain controller and on the child domain controllers. This step makes sure that Active Directory Directory Service (AD DS) replication is successful.

The **Replication Allow SPN Fallback** registry entry enables the domain controller to use one-way authentication if two-way authentication cannot be performed because of a failure to resolve a Service Principal Name (SPN) to a computer account.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
