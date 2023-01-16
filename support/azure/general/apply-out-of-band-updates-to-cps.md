---
title: Apply out-of-band updates to the Microsoft Cloud Platform System Standard platform
description: Describes the procedures to manually update the Microsoft Cloud Platform System Standard solution.
author: genlin
ms.author: genli
ms.service: cloud-platform-system
ms.date: 08/14/2020
ms.reviewer: justini, paulcha, chengwei, jarrettr, twooley
---
# Apply out-of-band updates to the Microsoft Cloud Platform System Standard platform

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3141340

Follow the procedures in this article to manually update the Microsoft Cloud Platform System Standard solution.

## Prepare for the update

1. Before you begin the manual update process, make sure that you have established a clear servicing maintenance window. When you have successfully completed the procedures, you can let users back onto the system.
2. On a computer that has the Active Directory Users and Computers  snap-in installed, add the user account that you want to use for updating to the **Prefix** -Setup-Admins group in the organizational unit (OU) for the stamp (Parent OU\StampPrefix OU).

    > [!NOTE]
    >  You have to do this as a domain administrator or as a user who has delegated permissions to the OU for the CPS Standard stamp.

3. Open the System Center 2012 R2 - Virtual Machine Manager (VMM) console from your Console virtual machine (VM).
4. In the **Fabric** workspace, under **Servers**, expand **Infrastructure**, and then click **Update Server**.
5. In the Update Servers pane, right-click the listed server, and then click **Properties**.
6. On the Update Classifications tab, make sure that the following check boxes are selected:
   - Critical Updates
   - Definition Updates
   - Security Updates
   - Service Packs
   - Update Rollups

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/update-classification-tab.png" alt-text="Screenshot shows the check boxes are selected on the Update Classifications tab.":::

7. Click **OK**.
8. Right-click the update server again, and then click **Synchronize**.
9. Wait for the Synchronize Update Server  job to complete, and then close the Recent Jobs window when ready.
10. In the Library workspace of the VMM console, under Update Catalog and Baselines, right-click **Update Baselines**, and then click **Create Baseline**.
11. On the General tab, in the Name box, type 1512, 1601 OOB Servicing, and then click **Next**.
12. On the Updates tab, click **Add**, and then add the following updates to the baseline:
       - KB3099864
       - KB3100465
       - KB3108347
       - KB3108381
       - KB3109094
       - KB3109103
       - KB3110329
       - KB3121212
       - KB3121918
       - KB3124001
       - KB3122651
       - KB3122654
       - KB3123294
       - KB3126434
       - KB3126446
       - KB3126587
       - KB3126593
       - KB3133043
       - KB3134214
       - KB3134222

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/add-updates.png" alt-text="Screenshot shows steps to add the updates to the baseline." border="false":::

13. When you have finished, click **Next**.
14. On the Assignment Scope tab, select the All Hosts  check box and all the check boxes under Infrastructure.

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/assignment-scope.png" alt-text="Screenshot of the All Hosts check box and all the check boxes under Infrastructure." border="false":::

15. Click **Next** to continue.

    > [!NOTE]
    > On the Summary page, click **View Script**  to view the PowerShell script that will be used to create the baseline (if you want).

16. Click **Finish** to close the Update Baseline Wizard.
17. When the Create new baseline and Change properties of a baseline job are completed, close the Recent Jobs window.

### Update WSUS computer group membership

1. On the Console VM, open the Windows Server Update Services snap-in.
2. Right-click **Update Services**, click **Connect to Server**, specify the WSUS server name (in this case, the VMM server **Prefix** VMM01), and then click **Connect**.
3. Expand **ServerName**, expand Computers, expand All Computers, and then click Unassigned Computers.
4. Select all listed computers, right-click the selection, and then click **Change Membership**.
5. Select the SCVMM Managed Computers check box, and then click **OK**.

## Update the compute nodes

1. On the Console VM, open Cluster-Aware Updating.
2. In the Connect to a failover cluster box, select the computer cluster (**Prefix** CCL), and then click **Connect**.
3. Under Cluster Actions, click **Apply updates to this cluster**, and then click **Next**.
4. On the Advanced Options tab, leave the default settings, and then click **Next**.
5. On the Additional Options tab, leave the default settings, and then click Next.
6. On the Confirmation tab, leave the default settings, and then click **Update**.
7. Click **Close** to close the Completion page.
8. Each node in the cluster will iterate from entering maintenance mode to installing updates, to restarting the computer, and finally to rescanning for updates. Wait for the complete run to finish across all the nodes in the cluster.

    > [!NOTE]
    >  Each node may take approximately 10 minutes to be completed.

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/cluster-aware-updating.png" alt-text="Screenshot shows the Cluster-Aware Updating process is running." border="false":::

9. Each node is complete when the update status changes to Succeeded. Keep the Cluster-Aware Updating window open for the next procedure.

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/update-status-succeeded.png" alt-text="Screenshot shows the update status changes to Succeeded." border="false":::

## Update the SQL Server guest clusters

1. In the Connect to a failover cluster  box in the same Cluster-Aware Updating  window, select the SQL Server cluster (**Prefix** SQLCL), and then click **Connect**. In the Disconnecting from cluster **Cluster_Name** warning box, click **OK**.
2. Click **Apply updates to this cluster**, accept all the default settings as you did earlier for the compute cluster nodes, click **Update**, and then click **Close** on the Completion page.
3. Each node will update one at a time. The updates are complete when all nodes have an update status of Succeeded.

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/all-nodes-update-status-succeeded.png" alt-text="Screenshot shows the updates are complete when all nodes have an update status of Succeeded." border="false":::

4. Close the Cluster-Aware Updating window.

## Update the infrastructure virtual machines

1. In the VMM console, open the VMs and Services  workspace, and then click All Hosts.
2. On the ribbon (at the top), click **VMs**.

    In this procedure, you'll update the following VMs in the following order:

    - **Prefix** APA01
    - **Prefix** APT01
    - **Prefix** OM01
    - **Prefix** VMM01
    - **Prefix** CON01 (You must update the Console VM after the other VMs are completed.)

    > [!NOTE]
    > This excludes the Linux VMs hosting the VSA runtime.

3. Right-click a VM (such as **Prefix** APA01), point to Connect or View, and then click **Connect via Console**.

    > [!NOTE]
    >  When you get to the VMM server, if you receive an error when you try to connect through the console, use Hyper-V Manager instead to connect to the VM.

4. Log on to the VM by using the same account that you use for installing updates.
5. At the command prompt, type sconfig, and then press Enter to open Server Configuration management.
6. Type 6 for the option to download and install updates, and then press Enter.
7. In the new Command Prompt window, type A, press Enter and then wait for the search to be completed.
8. Type A for Select an option (to install all updates), and then press Enter.

    The updates will download from the WSUS server and install on the VM.

9. Repeat steps 3-8 for the listed infrastructure VMs in step 2, _except_ for the Console VM.
10. For each VM, select Yes  when you're prompted with A restart is required to complete Windows Updates. Restart now?  You should restart the VMM server last. When you update the VMM server, expect the VMM console to disconnect and reconnect when it's available.
11. Finally, after all other VMs are updated and restarted, update the Console VM by running sconfig in a local elevated Windows PowerShell session (for example, Run as administrator). The Server Configuration tool may take a while to open.

    Notes

    - You don't have to update the SQL Server VMs because they were already updated by using the Cluster-Aware Updating tool.
    - The list of applicable updates may vary from VM to VM, depending on roles and services installed. This is expected.

## Revert the WSUS computer group membership

1. Open the Windows Server Update Services snap-in.
2. Expand **ServerName**, expand Computers, expand All Computers, and then click **SCVMM Managed Computers**.
3. Select all the computers except for the compute nodes and the VMM server, right-click the selection, and then click Change Membership.
4. Clear the SCVMM Managed Computers check box, and then click **OK**.
5. Refresh the view to make sure the computers are moved back to the Unassigned Computers group.

    :::image type="content" source="media/apply-out-of-band-updates-to-cps/update-services.png" alt-text="Screenshot to check the computers are moved back to the Unassigned Computers group.":::

## Post-update clean up

1. The manual update process is completed. We recommend that you open the System Center 2012 R2 - Operations Manager console and review any active alerts.
2. We recommend that you remove the account that you used for patching from the **Prefix** -Setup-Admins group.

    > [!NOTE]
    >  If this is an active account that you use for CPS Standard administration, make sure that it's a member of another group such as **Prefix** -Ops-Admins .

3. It's now safe to close the servicing maintenance window and let users back on the system.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
