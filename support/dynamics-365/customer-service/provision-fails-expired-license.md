---
title: Provisioning fails due to expired license
description: Provides a solution for when provisioning fails due to expired license in Dynamics 365 Omnichannel for Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Provisioning fails due to expired license

This article provides a solution for when provisioning omnichannel fails due to an expired license.

## Symtom

Unable to provision omnichannel because of a license issue.

## Cause

If your tenant has an expired Microsoft 365 license, then the provisioning of Omnichannel for Customer Service will fail in your organization.

## Resolution

To avoid the provisioning failure, you must remove the Microsoft Teams service principal and Skype Teams Calling API Service in Azure Active Directory (Azure AD), and add it back. Follow these steps to remove the services:

1. Identify the services in Azure AD.
2. Use PowerShell to remove Microsoft Teams and Skype Teams Calling API Service.
3. Add the service principal back.

### Identify the services in Azure AD

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

### Use PowerShell to remove Microsoft Teams and Skype Teams Calling API Service

1. Select **Start**, type **PowerShell**, and right-click **Windows PowerShell** and select **Run as administrator**.  <br>
![Run PowerShell as an administrator.](media/powershell.png "Run PowerShell as an administrator")

1. Select **Yes** on the **User Control** dialog to allow the application to make changes.
1. Type the `Install-Module AzureAD` command in the PowerShell window, and press **Enter**. This command installs the PowerShell commands for interacting with Azure Active Directory. <br>
![Execute command.](media/powershell2.png "Execute command")

1. PowerShell prompts whether to trust the repository. Type **Y** for yes and press **Enter**.  <br>
![Run command.](media/powershell3.png "Run command")

1. Type the `Connect-AzureAD` command in the PowerShell window, and press **Enter**.
This establishes a connection with the tenant's Azure Active Directory, so you can manage it using PowerShell.
1. Sign in to your organization as a tenant admin.
1. Run the `Remove-AzureADServicePrincipal -ObjectID <ObjectID>` command in the PowerShell window twice, one each for Microsoft Teams and Skype Teams Calling API Service. Replace **`<ObjectID>`** with the object ID you had stored earlier. This command deletes the expired Teams service and Skype Teams Calling API Service from Azure Active Directory.

   > [!Note]
   > Right-click in the PowerShell window to paste the Object ID.

The Microsoft Teams Service and Skype Teams Calling API Service are removed from your organization. You can try to provision Omnichannel for Customer Service again.

### Add the service principal for the Permission service app

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
