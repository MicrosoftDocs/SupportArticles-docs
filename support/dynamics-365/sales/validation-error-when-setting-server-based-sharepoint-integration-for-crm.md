---
title: Validation Error when setting SharePoint integration
description: Discusses an issue in which you receive a Validation Error error message when you try to configure server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online. Provides a resolution.
ms.reviewer: tylerol, aaronric
ms.topic: troubleshooting
ms.date: 
---
# Validation Error when setting server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online

This article provides the steps to solve the issue that a **Validation Error** occurs when trying to set server-based SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2978295

## Symptoms

When you try to configure server-based Microsoft SharePoint integration for Microsoft Dynamics CRM Online and SharePoint Online, you receive the following error message:

> Validation Error

This error blocks the configuration of server-based SharePoint integration.

## Cause

When you use the new server-based SharePoint integration, absolute URLs are no longer supported when you create or use SharePoint Document Locations in Microsoft Dynamics CRM.

In the previous Microsoft Dynamics CRM List Component integration with SharePoint, document locations in Microsoft Dynamics CRM may have been created by using an absolute URL to reference a SharePoint folder. For example, to create a document location for an Account record by using CRM List Component, you select **Add Location**, and then you type a full URL (for example, you type `https://contoso.sharepoint.com/ExampleAccount`) in the **Site URL** field. This absolute URL differs from the relative URL that is used in server-based SharePoint integration. A relative URL is created in a document location record when you create a folder in a specified parent site.

## Resolution

Before you configure the new server-based SharePoint integration, any document locations that were created by using absolute URLs must be either changed to use relative URLs or removed from Microsoft Dynamics CRM.

### Step 1 - Verify the URL type

To verify which document locations in Microsoft Dynamics CRM have absolute URLs, follow these steps:

1. In Microsoft Dynamics CRM, open the **Settings** page.
2. Select **Document Management** from the **Settings** list in the navigation bar.
3. Select **SharePoint Document Locations**.
4. Select the ellipses button on the Microsoft Dynamics CRM command bar, and then select **View**.

    > [!NOTE]
    > A dialog box for editing the current view appears.

5. Select **Add Columns**.
6. Select **Absolute URL** from the list of available columns.
7. Select **Save & Close**.

### Step 2 - Change or delete the document locations

Use one of the following methods, depending on the result that you want.

#### Method 1 - Update absolute URLs

Use this method to update all existing document location references. After you do this, the integration will be already connected to SharePoint when you locate to the *Regarding* record. In this case, the user is not prompted to connect to a new document location.

To update absolute URLs, follow these steps:

1. Determine the absolute URL for a document location. To do this, follow these steps:

   1. In Microsoft Dynamics CRM, open the **Settings** page.
   2. On the navigation bar, select **Document Management** from the **Settings** list.
   3. Select **SharePoint Document Locations**.
   4. In the **SharePoint Document Locations** section, select a document location that points to an absolute URL.
   5. Select **Edit**.
   6. In the editing form, copy the URL that is specified in the **Absolute URL** field for your reference. For example, copy `https://contoso.sharepoint.com/account/exampleAccount`.
2. Create a document location to point to the document library found in the absolute URL. To do this, follow these steps:

   1. On the Microsoft Dynamics CRM command bar, select **New** in the **SharePoint Document Locations** section.
   2. Enter the name of the new document location. For example, enter Account to reference the Account document library in `https://contoso.sharepoint.com/account/exampleAccount`.
   3. Under **URL Type**, select **Relative URL**.
   4. Make sure that the **Parent Site** field or **Location** field points to the SharePoint site that the document library is located on. For example, verify or enter `https://contoso.sharepoint.com`.
   5. In the **Relative URL** field, type the name of the SharePoint document library that is being referenced. For example, type Account to reference the Account document library in `https://contoso.sharepoint.com/account/exampleAccount`.
   6. Select **Save and Close**.
3. Change the original document location that is configured to use an absolute URL to use a relative URL instead. To do this, follow these steps:
   1. Reopen the document location that is discussed in Step 1.
   2. Under **URL Type**, select **Relative URL**.
   3. In the **Parent Site** field or **Location** field, select the document location that references the document library in which this folder is located. For example, select the document location record that is named **Account** and that was created in Step 2.
   4. Under **Relative URL**, type the name of the SharePoint folder that is being referenced. For example, type exampleAccount for the folder that is represented in `https://contoso.sharepoint.com/account/exampleAccount`.
   5. Select **Save and Close**.

#### Method 2 - Delete absolute URLs

Use this method to remove document locations that are associated with some records. After you do this, a user who is accessing those records will again receive the following prompt to create a document location for the records.

:::image type="content" source="media/validation-error-when-setting-server-based-sharepoint-integration-for-crm/create-folder-prompt.png" alt-text="prompt to create a document location for the records" border="false":::

To delete absolute URLs, follow these steps:

1. In Microsoft Dynamics CRM, open the **Settings** page.
2. On the navigation bar, select **Document Management** from the **Settings** list.
3. Select **SharePoint Document Locations**.
4. In the **SharePoint Document Locations** section, select all the document location records that use an absolute URL.
5. Select **Delete**.

After you replace any document locations that use absolute URLs by using relative URLs, or after you remove any document locations that use absolute URLs, try to enable server-based SharePoint integration again.
