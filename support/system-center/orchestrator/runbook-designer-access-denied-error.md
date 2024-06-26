---
title: Access Denied error in Runbook Designer
description: Fixes an Access Denied error that occurs when you try to connect to System Center Orchestrator management server using the Runbook Designer application.
ms.date: 06/26/2024
---
# Error Access Denied in Runbook Designer when connecting to the management server

This article helps fix an **Access Denied** error that occurs when you try to connect to System Center Orchestrator management server using the Runbook Designer application.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2779526

## Symptoms

When attempting to connect to your System Center Orchestrator management server using the Runbook Designer application, the following error is returned:

> Connection Error  
> Access Denied. If you are using the local administrators group to manage permissions, you might need to start the Runbook Designer with Run as Administrator.

## Cause

This issue can occur if the user account launching the Runbook Designer application doesn't have sufficient permissions to access, launch, and activate the omanagement distributed COM (DCOM) server on the management server computer from a remote computer.

## Resolution

Allowing users to connect to the System Center Orchestrator management server using the Runbook Designer application consists of two layers of authorization. The first layer, where this error occurs, is the ability to access, then launch and activate the DCOM server called omanagement. During the installation, a group referred to as the Orchestrator Users Group is either selected or created and granted the permissions to connect to the omanagement DCOM server remotely without requiring membership to the local administrators group on the management server.

To allow additional users the same authorization to access, launch and activate the omanagement DCOM server remotely, we must add those users either directly or indirectly via group membership into the DCOM security structure. It's recommended to add an Active Directory based security group rather than direct users so that the DCOM service doesn't need to be restarted each time a user is wanted to be added or removed from authorization.

To add additional users or security groups to be authorized for remote access, launch and activation of the omanagement DCOM server, follow the instructions below:

1. On the System Center Orchestrator management server, launch `dcomcnfg` to open up the **Component Services** applet.
2. Expand **Component Services** > **Computers** > **My Computer**.
3. Right-click **My Computer**, and then select **Properties**.
4. Select the **COM Security** tab.
5. Under **Access Permissions**, select **Edit Limits**.
6. Select **Add**, enter details of the wanted local or Active Directory based security group, and then click **OK**.
7. Click the new entry, select the **Allow** checkbox for each permission, and then click **OK**.
8. Under **Launch and Activation Permissions**, select **Edit Limits**.
9. Select **Add**, enter details of the wanted local or Active Directory based security group, and then click **OK**.
10. Click the new entry, select the **Allow** checkbox for each permission, and then click **OK**.
11. Click **OK** to close the **My Computer Properties** dialog.
12. Expand **My Computer**, and then select **DCOM Config**.
13. Locate **omanagement**, then right-click and choose **Properties**.
14. Select the **Security** tab.
15. Under **Launch and Activation Permissions**, select **Edit**.
16. Select **Add**, enter details of the wanted local or Active Directory based security group, and then click **OK**.
17. Click the new entry, select the **Allow** checkbox for each permission, and then click **OK**.
18. Under **Access Permissions**, select **Edit**.
19. Select **Add**, enter details of the wanted local or Active Directory based security group, and then click **OK**.
20. Click the new entry, select the **Allow** checkbox for each permission, and then click **OK**.
21. Click **OK** to save the changes.
22. Close the **Component Services** applet.
23. Open a Command Prompt.
24. Type `sc stop omanagement` and press **Enter**.
25. Type `sc start omanagement` and press **Enter**.

Once the Orchestrator Management Service (omanagement) is restarted, direct users and members of security groups that were added will now be able to successfully connect to the System Center Orchestrator management server using the Runbook Designer.

## More information

In addition to DCOM server authorization, the user account must have direct or indirect permissions granted inside the Runbook Designer to the various components. If the user doesn't have at least **Read** permissions to the **Runbooks** node in the Runbook Designer's navigation pane, they'll receive a different error message that could be misinterpreted as this problem because this is the default node that Runbook Designer takes the user to upon successful connection to the management server. That error message appears as below:

> General Error  
> A general error has occurred. The error returned was:  
> Access is denied. (80070005)
