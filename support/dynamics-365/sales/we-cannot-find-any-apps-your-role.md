---
title: We cannot find any apps for your role
description: Provides a solution to an error that occurs when using Microsoft Dynamics 365 for phones and tablets.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-mobile-apps
---
# We can't find any apps for your role error message in Microsoft Dynamics 365 for phones and tablets

This article provides a solution to an error that occurs when using Microsoft Dynamics 365 for phones and tablets.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4486472

## Symptoms

When using Dynamics 365 for phones and tablets, you receive the following message:

> "We can't find any apps for your role. To check for recently-added apps, select Refresh.  
If you can't find your app, change your search criteria and try again."

## Cause

**Cause 1**: You don't have any Dynamics 365 security roles that provide access to any Unified Interface apps.

**Cause 2**: You don't have a Dynamics 365 security role with the Model-driven Apps privilege.

## Resolution

**Resolution 1**: Verify user has access to at least one Unified Interface app.

1. Access the Dynamics 365 web application as a user with the System Administrator security role.
2. Navigate to **Settings** and then select **My Apps**.

    > [!NOTE]
    > If you don't see My Apps, you can add **/apps** to the end of your URL:
    > `https://<your_organization_URL>/apps`  
    > Example: `https://contoso.crm.dynamics.com/apps`

3. Locate the app you want the user to use and select the ellipses (**...**) option and then select **Manage Roles**.

    > [!NOTE]
    > The **...** option only appears on apps of type Unified Interface which are the only apps supported to use with Dynamics 365 for phones and tablets. If you don't have a Unified Interface app already, you can use the **Create new App** option.

4. A list of Dynamics 365 security roles will appear. Verify at least one role assigned to the user is selected and then select **Save**.

For more information, see [Manage access to apps by using security roles](/dynamics365/customerengagement/on-premises/customize/manage-access-apps-security-roles).

**Resolution 2**: Verify the user's role includes the Model-driven App privilege

1. Access the Dynamics 365 web application as a user with the System Administrator security role.
2. Navigate to **Settings,** select **Security**, and then select **Security Roles**.
3. Open the role assigned to the user.
4. Select the **Customization** tab and locate the **Model-driven App** privilege. Verify the role includes at least **Read** access for this privilege.
5. Select **Save and Close**.
