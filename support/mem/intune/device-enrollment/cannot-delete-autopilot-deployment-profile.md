---
title: Troubleshoot when you cannot delete a Windows Autopilot deployment profile
description: Describes an issue in which you can't delete a Windows Autopilot deployment profile in Microsoft Intune, and receive an error.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Autopilot\Profile Assignment
ms.reviewer: kaushika
---

# You can't delete a Windows Autopilot deployment profile in Intune

This article helps resolve the error message that occurs when you try to remove a Windows Autopilot deployment profile in Microsoft Intune.

## Symptoms

When you try to delete a Windows Autopilot deployment profile in Intune, you receive the following error message:  

> Cannot delete \<Autopilot Profile Name>  
> The profile is assigned to groups. You must unassign all groups from this profile before you can delete it.

:::image type="content" source="media/cannot-delete-autopilot-deployment-profile/cannot-delete-error.png" alt-text="Screenshot of the Cannot delete Autopilot Profile error.":::

## Cause

This issue occurs for either of the following reasons:

- The Windows Autopilot deployment profile is still assigned to one or more groups in Microsoft Entra ID.
- The group that the Windows Autopilot deployment profile was assigned to was deleted from Microsoft Entra ID before the group was removed from the **Included groups** of the deployment profile.

    > [!NOTE]
    > In this scenario, you can use [Solution 2](#solution-2) to delete the profile immediately. Or, you can wait until the assignment to the deleted group is removed (this usually occurs within seven days), and then delete the profile in Intune.

To fix the issue, use one of the following solutions, depending on whether the group that the Windows Autopilot deployment profile was assigned to still exists in Microsoft Entra ID.

## Solution 1

If the group the deployment profile was assigned to *still exists* in Microsoft Entra ID, use the following steps to resolve the issue.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Devices** > **Windows** > **Windows enrollment** > **Deployment Profiles**.
1. Select the Windows Autopilot deployment profile that you want to delete, and then select **Assignments**.
1. Remove all groups in **Included groups**, and select **Save**.

After you delete the assignment, you can delete the Windows Autopilot deployment profile.

## Solution 2

If the group the deployment profile was assigned to *was deleted* from Microsoft Entra ID, complete the following procedures.

### Step 1: Find the AutopilotProfileID

To find the `AutopilotProfileID`, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Devices** > **Windows** > **Windows enrollment** > **Deployment Profiles**.
3. Select the Autopilot deployment profile that you want to delete, and then copy the `AutopilotProfileID` from the following URL in the address bar:

    `https://portal.azure.com/#blade/Microsoft_Intune_Enrollment/AutopilotMenuBlade/overview/id/<AutopilotProfileID>`

    :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/url.png" alt-text="Screenshot of the URL in the address bar.":::
  
### Step 2: Find the GroupID of the assigned group that has been deleted

To find the GroupID, use one of the following methods:

- Perform a browser trace by following these steps:

  1. Sign in to [https://portal.azure.com/?trace=diagnostics](https://portal.azure.com/?trace=diagnostics).
  2. Go to the step that is immediately before the step in which the issue occurs, and press F5 to refresh the webpage.
  3. Press F12 to start the Developer Tools browser.
  4. Select the **Network** tab, stop the trace, and then clear the session.
  5. Start the trace, reproduce the issue, and then stop the trace.
  6. In the trace log, look for the GET request that has the group name, and copy the GroupID.

- Use the following steps in Graph Explorer:
  1. Sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) with a Global Administrator account of the tenant.
  2. Run the following query to get details of the profile:

     ```http
     GET https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>
     ```

     :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query-1.png" alt-text="Screenshot of Query 1.":::

  3. Run the following query to get details of the assignment:

     ```http
     GET https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>/assignments
     ```

     :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query-2.png" alt-text="Screenshot of Query 2.":::

  4. Find the GroupID from the result. Here is an example:

      :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/group-id.png" alt-text="Screenshot of GroupID in the result.":::
  
### Step 3: Delete the profile assignment in Graph Explorer

To delete the assignment, run the following query in [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer):

```http
DELETE https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>/assignments/<AutopilotProfileID>_<GroupID>
```

:::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query-3.png" alt-text="Screenshot of Query 3.":::

You may receive the following error message when you run the DELETE query:

> Failure - Status Code 403 - Looks like you may not have the permissions for this call. Please modify your permissions.

If this occurs, select **Modify Permissions**, and then select the **DeviceManagementServiceConfig.ReadWrite.All** permission.

Click **Modify Permissions**, log on again to the Graph Explorer, and then rerun the DELETE query.

### Step 4: Delete the profile in Graph Explorer

To delete the profile, run the following query in [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer):

```http
DELETE https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>
```
