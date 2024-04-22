---
title: 403 Forbidden error for Intune objects in Graph Explorer
description: Troubleshoot and resolve a 403 Forbidden error when running queries in Graph Explorer to inspect or modify Microsoft Intune objects. 
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Develop and Customize - Android\Intune Graph API
ms.reviewer: kaushika
---
# 403 Forbidden error when you query Intune objects in Graph Explorer

This article provides a solution for the **403 Forbidden** error that occurs when you try to use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to inspect or modify Microsoft Intune objects.

## Symptoms

When you try to run queries in [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to inspect or modify Microsoft Intune objects under the `https://graph.microsoft.com/beta/deviceManagement` namespace, you receive an error message:

> Failure - Status Code 403.  Looks like you may not have the permissions for this call. Please modify your permissions.  
> {  
&nbsp; &nbsp; "error": {  
&nbsp; &nbsp; &nbsp; &nbsp; "code": "Forbidden",  
&nbsp; &nbsp; &nbsp; &nbsp; "message": "{\r\n &nbsp;\\"_version\\": 3,\r\n &nbsp;\\"Message\\": \\"Application is not authorized to perform this operation. Application must have one of the following scopes: DeviceManagementConfiguration.Read.All, DeviceManagementConfiguration.ReadWrite.All - Operation ID (for customer support): 00000000-0000-0000-0000-000000000000 - Activity ID: 5c977c7f-ae03-4be0-82c2-408eafb65caf - Url: <`https://fef.msub05.manage.microsoft.com/DeviceConfiguration_1911/StatelessDeviceConfigurationFEService/deviceManagement?api-version=5019-09-20`>\\",\r\n &nbsp;\\"CustomApiErrorPhrase\\": \\"\\",\r\n &nbsp;\\"RetryAfter\\": null,\r\n &nbsp;\\"ErrorSourceService\\": \\"\\",\r\n &nbsp;\\"HttpHeaders\\": \\"{}\\"\r\n}",  
&nbsp; &nbsp; &nbsp; &nbsp; "innerError": {  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "request-id": "5c977c7f-ae03-4be0-82c2-408eafb65caf",  
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "date": "2019-11-15T18:53:00"  
&nbsp; &nbsp; &nbsp; &nbsp; }  
&nbsp; &nbsp; }  
}  

:::image type="content" source="media/403-error-graph-explorer-query/403-error.png" alt-text="Screenshot of the 403 error details.":::

## Cause

This issue occurs because the account you use to access Graph Explorer doesn't have the required read and read/write permissions to Intune device configuration and policies.

## Solution

To fix this issue, follow these steps to modify your account permissions.

1. Sign in to Graph Explorer by selecting **Sign In with Microsoft**, if you haven't already done this.

1. In the error message, select **modify your permissions**.

    :::image type="content" source="media/403-error-graph-explorer-query/modify-your-permissions.png" alt-text="Screenshot of modify your permissions link in the top of the error.":::

1. In the **Modify Permissions** dialog box, make sure that the following permissions are selected:

    - DeviceManagementConfiguration.Read.All
    - DeviceManagementConfiguration.ReadWrite.All

    :::image type="content" source="media/403-error-graph-explorer-query/modify-permissions-options.png" alt-text="Screenshot of the Modify Permissions options.":::

1. Select **Modify Permissions**.

    > [!NOTE]
    > You should be logged off from Graph Explorer and asked to select credentials. If this doesn't occur automatically, close the browser, and reopen Graph Explorer.

1. The next time that you try to access Graph Explorer by using the same account, you are prompted by a **Permissions requested** dialog box that resembles the following.

    :::image type="content" source="media/403-error-graph-explorer-query/permissions-requested-1.png" alt-text="Screenshot of the Permissions requested page.":::

1. Select **Accept** to apply the changes that you made in Step 3. If you want other Intune administrators to also be granted access to the site, select **Consent on behalf of your organization**. For details on this selection, see [More information about permissions consent](#more-information-about-permissions-consent) below.

1. Verify that your permissions are set correctly. To do this, select **modify permissions** for your account, and then verify that the following permissions are granted:

   - DeviceManagementConfiguration.Read.All
   - DeviceManagementConfiguration.ReadWrite.All

    :::image type="content" source="media/403-error-graph-explorer-query/modify-permissions.png" alt-text="Screenshot of the modify permissions page.":::

## Reset your tenant to default settings

If you still cannot resolve this issue, you can reset your tenant to its default settings. Follow these steps to safely delete and re-create a Graph Explorer enterprise application configuration.

> [!IMPORTANT]
> To avoid issues that affect browser caching, browse in **InPrivate** or **Incognito** mode when you troubleshoot access permissions.

1. Sign in to the Azure portal, go to **Microsoft Entra ID** > **Enterprise Applications**, and then select **Graph explorer** from the list of applications.
1. In the Graph explorer settings, select **Manage** > **Properties**.
1. Select **Delete**, and acknowledge the warning dialog box.
1. Wait for the **Application Graph explorer was deleted successfully** message from the Azure portal.
1. Sign in to Graph Explorer by selecting **Sign In with Microsoft**. If the app is successfully deleted, you will be prompted to accept the default permissions.

   > [!NOTE]
   > There may be several minutes of delay between when you remove access to Graph Explorer to when the permissions become effective in the application.

## More information about permissions consent

The first time that you log on to Graph Explorer, you are prompted by a **Permissions requested** dialog box that resembles the following.

:::image type="content" source="media/403-error-graph-explorer-query/permissions-requested-2.png" alt-text="Screenshot of the Permissions requested dialog box.":::

By selecting **Accept**, you grant the app permissions to your sign-in account. By selecting **Consent on behalf of your organization**, you allow other accounts to also use Graph Explorer to query Intune management objects. This creates an Enterprise application in Microsoft Entra ID that has the following settings:

- Name: Graph explorer
- Application ID: de8bc8b5-d9f9-48b1-a8ad-b748da725064
- Object ID:  unique GUID
- Enabled for user to sign in:  Yes
- User assignment required:  No
- Visible to users:  Yes
- Users and groups: By default, only the account that first granted access in the **Permissions requested** dialog box.

The following are the default user permissions that are set after you grant access under **User consent**.

> [!NOTE]
> You can view the permissions in the Azure portal in the following path:  
> **Microsoft Entra ID** > **Enterprise applications** > **All applications** > **Graph explorer** > **Users and groups** > **\<*Account Name*>** > **Applications** > **Assignment Detail** > **Permissions & Consent**

|API Name|Type|Permission|Granted through|
|---|---|---|---|
|Microsoft Graph|Delegated|Sign users in|User consent|
|Microsoft Graph|Delegated|View users' basic profiles|User consent|
|Microsoft Graph|Delegated|Read and write access to user profiles|User consent|
|Microsoft Graph|Delegated|Read all users' basic profiles|User consent|
|Microsoft Graph|Delegated|Edit or delete items in all site collections|User consent|
|Microsoft Graph|Delegated|Have full access to user contacts|User consent|
|Microsoft Graph|Delegated|Read users' relevant people lists|User consent|
|Microsoft Graph|Delegated|Read and write all OneNote notebooks that users can access|User consent|
|Microsoft Graph|Delegated|Create, read, update, and delete user tasks and projects|User consent|
|Microsoft Graph|Delegated|Read and write access to user mail|User consent|
|Microsoft Graph|Delegated|Have full access to all files that users can access|User consent|
|Microsoft Graph|Delegated|Have full access to user calendars|User consent|
  
  If you select **Consent on behalf of your organization**, you will have the following permissions under **Admin consent**.

|API Name|Type|Permission|Granted through|
|---|---|---|---|
|Microsoft Graph|Delegated|Sign users in|Admin consent|
|Microsoft Graph|Delegated|View users' basic profiles|Admin consent|
|Microsoft Graph|Delegated|Read and write access to user profiles|Admin consent|
|Microsoft Graph|Delegated|Read all users' basic profiles|Admin consent|
|Microsoft Graph|Delegated|Edit or delete items in all site collections|Admin consent|
|Microsoft Graph|Delegated|Have full access to user contacts|Admin consent|
|Microsoft Graph|Delegated|Read users' relevant people lists|Admin consent|
|Microsoft Graph|Delegated|Read and write all OneNote notebooks that users can access|Admin consent|
|Microsoft Graph|Delegated|Create, read, update, and delete user tasks and projects|Admin consent|
|Microsoft Graph|Delegated|Read and write access to user mail|Admin consent|
|Microsoft Graph|Delegated|Have full access to all files that users can access|Admin consent|
|Microsoft Graph|Delegated|Have full access to user calendars|Admin consent|
