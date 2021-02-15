---
title: Cannot delete autopilot deployment profile
description: Describes an issue in which you can't delete a Windows Autopilot deployment profile in Intune and receive an error.
ms.date: 05/13/2020
ms.prod-support-area-path: Windows enrollment
---
# You can't delete a Windows Autopilot deployment profile in Intune

This article provides the information to solve the error message that occurs when you try to remove a Windows Autopilot deployment profile in Microsoft Intune.

_Original product version:_ &nbsp; Azure Active Directory, Microsoft Intune  
_Original KB number:_ &nbsp; 4465007

## Symptoms

When you try to delete a Windows Autopilot deployment profile in Microsoft Intune, you receive the following error message:  

> Cannot delete \<Autopilot Profile Name>  
> The profile is assigned to groups. You must unassign all groups from this profile before you can delete it.

:::image type="content" source="media/cannot-delete-autopilot-deployment-profile/error.png" alt-text="screenshot of Error":::

## Cause

This issue occurs for either of the following reasons:

- The Autopilot deployment profile is still assigned to one or more groups in Azure Active Directory (Azure AD).
- The group that the Autopilot deployment profile was assigned to was deleted from Azure AD before the group was removed from the **Included groups** of the deployment profile.

    > [!NOTE]
    > In this scenario, you can use [Method 2 in the Resolution section](#method-2-if-the-group-was-deleted-from-azure-ad) to delete the profile immediately. Or, you can wait until the assignment to the deleted group is removed (this usually occurs within seven days), and then delete the profile in Intune.

## Resolution

To fix the issue, use one of the following methods, depending on whether the group that the Autopilot deployment profile was assigned to still exists in Azure AD:

### Method 1: If the group is still in Azure AD

1. Sign in to [Azure portal](https://portal.azure.com/).
2. Select **Intune** > **Device enrollment** > **Windows enrollment** > **Deployment Profiles**.
3. Select the Autopilot deployment profile that you want to delete, and then select **Assignments**.
4. Remove all groups in **Included groups**, and select **Save**.

After you delete the assignment, you can delete the Autopilot deployment profile.

### Method 2: If the group was deleted from Azure AD

#### Step 1: Find the AutopilotProfileID

To find the `AutopilotProfileID`, follow these steps:

1. Sign in to [Azure portal](https://portal.azure.com/).
2. Select **Intune** > **Device enrollment** > **Windows enrollment** > **Deployment Profiles**.
3. Select the Autopilot deployment profile that you want to delete, and then copy the `AutopilotProfileID` from the following URL in the address bar:

    `https://portal.azure.com/#blade/Microsoft_Intune_Enrollment/AutopilotMenuBlade/overview/id/<AutopilotProfileID>`

    :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/url.png" alt-text="screenshot of URL":::
  
#### Step 2: Find the GroupID of the assigned group that has been deleted

To find the GroupID, use one of the following methods:

- Perform a browser trace by following these steps:

  1. Sign in to [https://portal.azure.com/?trace=diagnostics](https://portal.azure.com/?trace=diagnostics).
  2. Go to the step that is immediately before the step in which issue occurs, and press F5 to refresh the webpage.
  3. Press F12 to start the Developer Tools browser.
  4. Select the **Network** tab, stop the trace, and then clear the session.
  5. Start the trace, reproduce the issue, and then stop the trace.
  6. In the trace log, look for the GET request that has the group name, and copy the GroupID.

- Use Graph Explorer by following these steps:
  1. Sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) by using a Global Administrator account of the tenant.
  2. Run the following query to get details of the profile:

     ```http
     GET https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>
     ```

     :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query1.png" alt-text="screenshot of Query 1":::

  3. Run the following query to get details of the assignment:

     ```http
     GET https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>/assignments
     ```

     :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query2.png" alt-text="screenshot of Query 2]":::

  4. Find the GroupID from the result. Here is an example:

      :::image type="content" source="media/cannot-delete-autopilot-deployment-profile/group-id.png" alt-text="screenshot of GroupID]":::
  
#### Step 3: Delete the profile assignment by using Graph Explorer

To delete the assignment, run the following query:

```http
DELETE https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>/assignments/<AutopilotProfileID>_<GroupID>
```

:::image type="content" source="media/cannot-delete-autopilot-deployment-profile/query3.png" alt-text="screenshot of Query 3]":::

You may receive the following error message when you run the DELETE query:

> Failure - Status Code 403 - Looks like you may not have the permissions for this call. Please modify your permissions.

If this occurs, select **Modify Permissions**, and then select the **DeviceManagementServiceConfig.ReadWrite.All** permission.

Click **Modify Permissions**, log on again to the Graph Explorer, and then rerun the DELETE query.

#### Step 4: Delete the profile by using Graph Explorer

To delete the profile, run the following query:

```http
DELETE https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotDeploymentProfiles/<AutopilotProfileID>
```
