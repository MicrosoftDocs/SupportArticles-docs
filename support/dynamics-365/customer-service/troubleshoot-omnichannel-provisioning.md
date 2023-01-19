---
title: Troubleshoot issues with provisioning Omnichannel for Customer Service
description: Provides resolutions for known issues that are related to provisioning Omnichannel for Customer Service..
author: lalexms
ms.author: laalexan
ms.date: 01/17/2023
---

# Troubleshoot issues with provisioning Omnichannel for Customer Service

This article helps you troubleshoot and resolve provisioning issues with Omnichannel for Customer Service.

## Issue 1 - Instance unavailable to select on the provisioning application <a name="provision"></a>

### Symptom

Cannot see all the instances from the Organizational selector.

### Cause

For security, reliability, and performance reasons, Omnichannel for Customer Service is separated by geographical locations known as "regions". The provisioning webpage only displays instances in the same region, so you might experience issues where you don’t see all the instances from the Organization selector if you have instances in more than one region and you provision Omnichannel for Customer Service without selecting the correct region.

### Resolution

Go to the Power Platform admin center (https://admin.powerplatform.microsoft.com/). Expand Resources, and select Dynamics 365. Select the region in the upper-right corner and select a new region from the dropdown list.

   > [!div class=mx-imgBorder]
   > ![Power Platform admin center change region.](media/oc-region-menu.png "Power Platform admin center change region")

The portal will reload when you change the region. After it has finished reloading, go to **Applications** > **Omnichannel for Customer Service**, and then do the provisioning steps.

The provisioning application you're directed to is associated with the region you chose, and all instances located in that region are displayed as options for provisioning.

   > [!div class=mx-imgBorder]
   > ![Manage Omnichannel environments.](media/oc-region-provision.png "Manage Omnichannel environments")


## Issue 2 - Omnichannel provisioning fails due to expired Teams service principal

### Symptom

 When you're provisioning Omnichannel for Customer Service, the following errors are displayed:

-  **Unable to perform the requested operation due to lack of permissions**, if the user is logged in as a System Administrator on a child business unit instead of the root business unit.
- **Request validation failed. Failed to execute action in CRM for selected environment**, if the user doesn't have read privileges for System roles.

### Resolution

- Check the permissions for the user, and change the business unit of the system user to root business unit.
- Ensure that the user is assigned at least one security role, preferably Omnichannel Administrator, other than the System Administrator role.


## Issue 3 - Provisioning fails due to expired license

### Symtom

Unable to provision omnichannel because of a license issue.

### Cause
If your tenant has an expired Microsoft 365 license, then the provisioning of Omnichannel for Customer Service will fail in your organization.

### Resolution

To avoid the provisioning failure, you must remove the Microsoft Teams service principal and Skype Teams Calling API Service in Azure Active Directory (Azure AD), and add it back. Follow these steps to remove the services:

1. Identify the services in Azure AD.
2. Use PowerShell to remove Microsoft Teams and Skype Teams Calling API Service.
3. Add the service principal back.

#### Identify the services in Azure AD

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Select **Azure Active Directory** in the left pane.
3. Select **Enterprise Applications**.
4. In the search criteria, select **All Applications** and **Disabled** in **Application Type** and **Application Status**.
5. In the search box, enter the application ID `cc15fd57-2c6c-4117-a88c-83b1d56b4bbe` for Microsoft Teams.

   > [!div class=mx-imgBorder]
   > ![Microsoft Teams object and app IDs.](media/teams-object-appid.png "Microsoft Teams object and app IDs")

6. In the result that appears, copy the **Object ID**, and save it. Ensure that the application ID is  `cc15fd57-2c6c-4117-a88c-83b1d56b4bbe` as this ID is same for every tenant.

7. Now, search for Skype Teams Calling API Service by entering its application ID `26a18ebc-cdf7-4a6a-91cb-beb352805e81` in the search box.

   > [!div class=mx-imgBorder]
   > ![Skype object and app IDs.](media/skype-object-appid.png "Skype object and app IDs")

8. In the result that appears, copy the **Object ID**. Make sure that the application ID is `26a18ebc-cdf7-4a6a-91cb-beb352805e81`.

#### Use PowerShell to remove Microsoft Teams and Skype Teams Calling API Service

1. Select **Start**, type **PowerShell**, and right-click **Windows PowerShell** and select **Run as administrator**.  <br>
![Run PowerShell as an administrator.](media/powershell.png "Run PowerShell as an administrator")

2. Select **Yes** on the **User Control** dialog to allow the application to make changes.
3. Type the `Install-Module AzureAD` command in the PowerShell window, and press **Enter**. This command installs the PowerShell commands for interacting with Azure Active Directory. <br>
![Execute command.](media/powershell2.png "Execute command")

4. PowerShell prompts whether to trust the repository. Type **Y** for yes and press **Enter**.  <br>
![Run command.](media/powershell3.png "Run command")

5. Type the `Connect-AzureAD` command in the PowerShell window, and press **Enter**.
This establishes a connection with the tenant's Azure Active Directory, so you can manage it using PowerShell.
6. Sign in to your organization as a tenant admin.
7. Run the `Remove-AzureADServicePrincipal -ObjectID <ObjectID>` command in the PowerShell window twice, one each for Microsoft Teams and Skype Teams Calling API Service. Replace **`<ObjectID>`** with the object ID you had stored earlier. This command deletes the expired Teams service and Skype Teams Calling API Service from Azure Active Directory.

   > [!Note]
   > Right-click in the PowerShell window to paste the Object ID.

The Microsoft Teams Service and Skype Teams Calling API Service are removed from your organization. You can try to provision Omnichannel for Customer Service again.

#### Add the service principal for the Permission service app

After removing the expired Microsoft Teams license from the tenant, you can add the chat to the tenant again by doing the following steps:

1. Run the following commands in the PowerShell window:

   `Login-AzureRmAccount`

   `$appId="6d32b7f8-782e-43e0-ac47-aaad9f4eb839"`

   `$sp=Get-AzureRmADServicePrincipal -ServicePrincipalName $appId`
   
   `if ($sp -eq $null) { New-AzureRmADServicePrincipal -ApplicationId $appId }`

   `Start-Process "https://login.microsoftonline.com/common/adminconsent?client_id=$appId"`

2. In the browser window that appears, sign in to your organization as a tenant admin to grant the admin consent.

   > [!NOTE]
   > Ignore the error page that appears with the message "no reply URLs configured".

1. Sign in to the [Azure portal](https://portal.azure.com/) as a tenant admin to enable Azure AD for user sign-in.

1. Go to **Azure Active Directory** > **Enterprise Applications**.

1. In the search box, enter **6d32b7f8-782e-43e0-ac47-aaad9f4eb839** for the application ID. The Permission Service O365 is listed.

1. Select the app, go to the **Properties** tab, and turn on the **Enabled for users to sign-in** toggle.

The chat is added to the tenant again.
