---
title: Error occurs in child business units
description: Provides a solution to an error that occurs when you're initially able to connect the app to your Microsoft Dynamics CRM organization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Something went wrong while initializing the app error message displays in the Microsoft Dynamics CRM app for users in child business units

This article provides a solution to an error that occurs when you're initially able to connect the app to your Microsoft Dynamics CRM organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2899860

## Symptoms

After you install the Microsoft Dynamics CRM tablet app, you're initially able to connect the app to your Microsoft Dynamics CRM organization. After a period of time or after reopening the app, you see the following error:

> "Sorry, something went wrong while initializing the app. Please try again, or restart the app"

When you tap the **Back** button or try to reopen the app, you continue to see the same error. You may see the sign-in page before you meet the error again. The issue only occurs for users in child business units with security roles inherited from a parent business unit.

## Cause

The error occurs because the inherited security roles in child business units are missing a modified date value. If you open the security role at the child business unit level and then select **Properties** from the **File** menu, you see that the Last Modified On date isn't populated.

Microsoft is aware of this issue and plans to provide a fix in a future update. The issue has already been resolved in Microsoft Dynamics CRM Online and a fix is planned for Microsoft Dynamics CRM 2013 on-premises. In the meantime, the workaround from the [Resolution](#resolution) section can be applied.

## Resolution

To work around the issue, follow the steps below which will update the inherited security role to include a Modified On date:

1. Sign into the Microsoft Dynamics CRM web application with a user that has the System Administrator security role.
2. From the navigation bar, select Microsoft Dynamics CRM and then select **Settings**.
3. From the navigation bar, select **Settings** and then select **Administration**.
4. Open the security role (at the parent business unit level) assigned to the user who meets this issue.
5. Without making any changes, select the **Save** button.
6. Select the **File** menu and then select **Properties**.
7. Verify the Last Modified On date has been updated.
8. Close the window for the security role.

    > [!NOTE]
    > Within the Security Roles sub-area you can select the **Business Unit** drop-down list to display roles for each business unit. If you check the role at the child business unit level, you should see that the Last Modified On date is now populated.

9. Repeat steps 4-8 for any additional security roles that are meeting this issue.
10. Verify that the issue has been resolved.

> [!NOTE]
> Because the default System Administrator role can't be modified, there isn't currently a workaround for users in child business units that have the System Administrator role. A copied version of the System Administrator role (created using the Copy Role feature) can be modified.

## More information

If you capture tracing, the following error is logged:

> *Error Message:System.NullReferenceException: Object reference not set to an instance of an object.*  
>
> *at Microsoft.Crm.Application.WebServices.ApplicationMetadataService.<>c__DisplayClass30.\<UserRolesChanged>b__2d(Entity role)*  
>
> *at System.Linq.Enumerable.Any[TSource](IEnumerable\`1 source, Func\`2 predicate)*  
>
> *at Microsoft.Crm.Application.WebServices.ApplicationMetadataService.UserRolesChanged(Guid[] clientUserRoles, DateTime syncTime, ExecutionContext context)*  
>
> *at Microsoft.Crm.Application.WebServices.ApplicationMetadataService.RetrieveUserContext(UserContextRetrieveRequest userContextRetrieveRequest)*
