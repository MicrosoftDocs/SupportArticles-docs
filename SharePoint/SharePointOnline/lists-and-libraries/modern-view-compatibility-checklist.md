---
title: SharePoint Online Lists and Libraries Modern View Compatibility check
description: A list of potential causes for a list or library not to render in Modern View.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
keyword: modern view
ms.custom: 
  - sap:Lists and Libraries\Views
  - CSSTroubleshoot
  - CI-158475
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online Lists and Libraries Modern View Compatibility check

The following is a list of potential reasons for a list or library not to render in Modern View.

## Recommended steps

## The View is not a List or Library View

**Detection:** The View is not a List or Library View.

**Recommendation:** Specify a List or Library View and rerun the diagnostic.

**More information:**

* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)

## The View is not in a standard List or Library location

**Detection:** The View is not in a standard List or Library location.

**Recommendation:** Create a List or Library View.

**More information:**

* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)

## The View utilizes Web Parts with relationships to other Web Parts

**Detection:** The View utilizes Web Parts with relationships to other Web Parts.

**Recommendation:** Create a View that has a single web part on it.

**More information:**

* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)

## JSLink based customizations detected on the View or Column(s)

**Detection:** JSLink based customizations detected on the View or Column(s).

**Recommendation:** Switch to SharePoint Column Formatting or Field Customizers and Remove the JSLink based customizations from the View or Column(s).

**More information:**

* [SharePoint Column Formatting](/sharepoint/dev/declarative-customization/column-formatting)
* [SharePoint Field Customizer](/sharepoint/dev/spfx/extensions/get-started/building-simple-field-customizer)
* [Migrating JSLink customizations to SharePoint Framework Field Customizers](/sharepoint/dev/spfx/extensions/guidance/migrate-jslink-to-spfx-extensions)
* [Tutorial - Migrating from JSLink to SharePoint Framework Extensions](/sharepoint/dev/spfx/extensions/guidance/migrate-from-jslink-to-spfx-extensions)
* [SharePoint Field Customizer](/sharepoint/dev/spfx/extensions/get-started/building-simple-field-customizer)

## XslLink based customizations detected

**Detection:** XslLink based customizations detected.

**Recommendation:** Switch to SharePoint Column Formatting or Field Customizers and Remove the XslLink based customizations.

**More information:**

* [Customizing "modern" lists and libraries](/sharepoint/dev/solution-guidance/modern-experience-customizations-customize-lists-and-libraries)
* [SharePoint Column Formatting](/sharepoint/dev/declarative-customization/column-formatting)

## The View's List or Library cannot be found

**Detection:** The View's List or Library cannot be found.

**Recommendation:** Create a List or Library View.

**More information:**

* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)

## The View contains External Data Column(s)

**Detection:** The View contains External Data Column(s).

**Recommendation:** Create a view that doesn't include External Data Column(s) or Remove the External Data Column(s) from the current View. You don't have to remove the column from the list or library.

**More information:**

* [Differences between the new and classic experiences for lists and libraries](https://support.office.com/article/Differences-between-the-new-and-classic-experiences-for-lists-and-libraries-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc)
* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)
* [Delete a column in a SharePoint list or library](https://support.office.com/article/delete-a-column-in-a-sharepoint-list-or-library-72cfd78d-dcca-4fa6-b499-c89214917604#ID0EAADAAA=Online,_2019)

## The View contains a Task Outcome Column(s), used for Workflow Tasks

**Detection:** The View contains a Task Outcome Column(s), used for Workflow Tasks.

**Recommendation:** Create a view that doesn't include Task Outcome Column(s) or Remove the Task Outcome Column(s) from the current View. You don't have to remove the Column(s) from the List or Library.

**More information:**

* [Differences between the new and classic experiences for lists and libraries](https://support.office.com/article/Differences-between-the-new-and-classic-experiences-for-lists-and-libraries-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc)
* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)
* [Delete a column in a SharePoint list or library](https://support.office.com/article/delete-a-column-in-a-sharepoint-list-or-library-72cfd78d-dcca-4fa6-b499-c89214917604#ID0EAADAAA=Online,_2019)

## The View contains a Publishing Column(s)

**Detection:** The View contains a Publishing Column(s).

**Recommendation:** Create a view that doesn't include publishing Column(s) or
remove the publishing Column(s) from the current View. You don't have to remove the Column(s) from the List or Library.

**More information:**

* [Differences between the new and classic experiences for lists and libraries](https://support.office.com/article/Differences-between-the-new-and-classic-experiences-for-lists-and-libraries-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc)
* [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9)
* [Delete a column in a SharePoint list or library](https://support.office.com/article/delete-a-column-in-a-sharepoint-list-or-library-72cfd78d-dcca-4fa6-b499-c89214917604#ID0EAADAAA=Online,_2019)

## The View is either a Calendar or Gantt type and is not Modern compatible

**Detection:** The View is either a Calendar or Gantt type and is not Modern compatible.

**Recommendation:** Provide feedback through [Feedback for Microsoft 365](https://feedbackportal.microsoft.com/) if this is an important feature for you.

## The List or Library is not Modern compatible

**Detection:** The List or Library is not Modern compatible.

**Recommendation:** Provide feedback through [Feedback for Microsoft 365](https://feedbackportal.microsoft.com/) if this is an important feature for you.

**More information:**

Supported Lists:

* Document Library
* Picture Library
* Contacts
* Issue Tracking
* Custom Grid
* Promoted Links
* XML Forms
* Publishing Libraries
* Announcements List
* Links List
* Web Page Library
* Generic List.

## The List or Library settings are set to Classic Mode only

**Detection:** The List or Library settings are set to Classic Mode only.

**Recommendation:** Navigate to the settings for the list or library,  select Advanced Settings

**More information:**

* Under the List experience section, select **New experience**.
* [Display list using new or classic experience - Advanced settings - Edit list settings in SharePoint Online](https://support.office.com/article/Edit-list-settings-in-SharePoint-Online-4d35793b-246e-42a3-990c-563a83795b7f).

## The View is not rendering using Modern due to a site collection feature being enabled

**Detection:** The View is not rendering using Modern due to a site collection feature being enabled.

**Recommendation:** Disable the E3540C7D-6BEA-403C-A224-1A12EAFEE4C4 feature to enable Modern in the site collection. This requires that you use PowerShell/code because the feature is hidden.

**More information:**

Run the following PNP commands:

1. [Install SharePoint PnP](/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets)
2. Start PowerShell
3. Enter the following commands:
   ``` powershell
   $UserCredentials = Get-Credential
   Connect-PnPOnline -Url https://YourTenant.sharepoint.com/sites/SiteCollectionUrl -Credentials $UserCredentials
   Disable-PnPFeature -Identity E3540C7D-6BEA-403C-A224-1A12EAFEE4C4
   ```

## The View is not rendering using Modern due to a site feature being enabled

**Detection:** The View is not rendering using Modern due to a site feature being enabled.

**Recommendation:** Disable the 52E14B6F-B1BB-4969-B89B-C4FAA56745EF feature to enable Modern in the site. This requires that you use PowerShell or code because the feature is hidden.

**More information:**

Run the following PNP commands:

1. [Install SharePoint PnP](/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets)
2. Start PowerShell
3. Enter the following:
   ``` powershell
   $UserCredentials = Get-Credential
   Connect-PnPOnline -Url https://YourTenant.sharepoint.com/sites/SiteCollectionUrl -Credentials $UserCredentials
   Disable-PnPFeature -Identity 52E14B6F-B1BB-4969-B89B-C4FAA56745EF -Scope Web
   ```

## The form page has been customized

**Detection:** The form page has been customized.

**Recommendation:** Recreate the form page or consider using [PowerApps](/powerapps/maker/canvas-apps/customize-list-form).

**More information:**

1. Navigate to Site Actions.
2. Navigate to Site Settings.
3. Reset to site definition (_layouts/15/reghost.aspx).
4. Specify the customized page.
5. Reset.

## The current Document Library has a new item form, and this is not compatible with Modern

**Detection:** The current Document Library has a new item form, and this is not compatible with Modern.

**Recommendation:** Provide feedback through [Feedback for Microsoft 365](https://feedbackportal.microsoft.com/) if this is an important feature for you.

## The form page contains Column(s) that are incompatible with Modern

**Detection:** The form page contains Column(s) that are incompatible with Modern.

**Recommendation:** Remove or set incompatible form Column(s) as hidden to render the form by using the Modern user experience.

The following columns are supported:

* Attachments
* true/false
* Calculated
* Currency
* Choice
* Multiline (append could impact modern) datetime
* Integers
* File
* Lookup
* Multiple Choice
* Number
* Text
* Url
* User and Taxonomy

## The form page contains an invalid Column(s)

**Detection:** The form page contains an invalid Column(s).

**Recommendation:** Remove the invalid column(s). They are usually classic publishing page Column(s).

The following columns are supported:

* Attachments
* true/false
* Calculated
* Currency
* Choice
* Multiline (append could impact modern) datetime
* Integers
* File
* Lookup
* Multiple Choice
* Number
* Text
* Url
* User and Taxonomy

## The form page contains an invalid control mode

**Detection:** The form page contains an invalid control mode.

**Recommendation:** Recreate the form page or consider using [PowerApps](/powerapps/maker/canvas-apps/customize-list-form).

**More information:**

* [Customize a SharePoint list form by using PowerApps](/powerapps/maker/canvas-apps/customize-list-form)

## The form page is customized

**Detection:** The form page is customized.

**Recommendation:** Recreate the form page or consider using PowerApps.

**More information:**

* [Customize a SharePoint list form by using PowerApps](/powerapps/maker/canvas-apps/customize-list-form)

## The View is customized

**Detection:** The View is customized.

**Recommendation:** Reset page to the site definition version.

**More information:**

1. Navigate to Site Actions.
2. Navigate to Site Settings.
3. Reset to site definition (_layouts/15/reghost.aspx).
4. Specify the customized page.
5. Reset.

## More information

For more information, see [Differences between the new and classic experiences for lists and libraries](https://support.office.com/article/differences-between-the-new-and-classic-experiences-for-lists-and-libraries-30e1aab0-a5cc-4363-b7f2-09e2ae07d4dc).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
