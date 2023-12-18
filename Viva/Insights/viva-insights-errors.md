---
title: Resolve Viva Insights errors
description: Describes how to resolve errors that you might encounter in Viva Insights.
author: helenclu
ms.author: luche
manager: dcscontentpm
ms.date: 12/18/2023
ms.service: viva
ms.subservice: viva-insights
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot  
localization_priority: Normal
---

# Resolve errors when you work with Viva Insights

This article lists error messages for Viva Insights.

## Advanced insights

### Sign-in and page access

| Error message | Details | Solution | Resources |
|--- | --- |---|---|
| Oops! System is not yet ready to run queries. Please check with Viva Insights Admin if at least 10 licenses have been assigned. If already done, then please wait until we get the system ready for running queries.| Your setup might not have completed yet or your organization might not have enough licenses assigned. | It takes a few days for Viva Insights to process Microsoft 365 collaboration data and for assigned users to get the right permissions. Most customers are able to access the app four to five days after the Insights admin assigns licenses. <br/><br/> Contact your Microsoft 365 admin to make sure your organization has enough assigned licenses. At least 10 people need to have licenses. |[Question 4, FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app)  <br/><br/>[Setup advanced insights](/viva/insights/advanced/setup-maint/setup-overview)<br/><br/>[Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)|
| Oops! You haven't been assigned a role in Viva Insights yet. Please contact M365 admin for role assignment. | You might get this error in the advanced insights app for one of three reasons:<ul><li>Your Microsoft 365 global admin hasn't assigned you a Viva Insights license. </li><li>Your Microsoft 365 admin hasn't assigned you to a role that can access this page.</li><li>Your organization might use Privileged Identity Management (PIM) as an additional approval process, and you haven't activated your role yet.</li></ul>|Contact your Microsoft 365 admin to confirm they've assigned you the right license and role. <br/><br/>Check whether your role has [permissions](/viva/insights/advanced/setup-maint/user-roles#feature-access) to access this page. <br/><br/>If applicable, activate your role in PIM. You can validate and view pending role activations using Microsoft Entra ID. To find out how to do this, refer to [Activate a role](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role#activate-a-role).|[Question 4, FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app) <br/><br/>[Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)<br/><br/>[Assign roles](/viva/insights/advanced/setup-maint/assign-user-roles)<br/><br/>[Feature access](/viva/insights/advanced/setup-maint/user-roles#feature-access) <br/><br/>[Activate a role](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role#activate-a-role)|
|Oops! Something's wrong and we can't render this page right now. Please try again later.| You might not have a license or the right role assigned to access this page.|Contact your Microsoft 365 admin to make sure they've assigned you the right license and role.|[Question 4, FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app) <br/><br/>[Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)<br/><br/>[Assign roles](/viva/insights/advanced/setup-maint/assign-user-roles)<br/><br/>[Feature access](/viva/insights/advanced/setup-maint/user-roles#feature-access)|
|Oops! Something's wrong and we can't find that page. | Refer to the information above, in "Oops! Something's wrong and we can't render this page right now..." | | |
|Manager settings can't be edited yet. Please try again in a few days.|You might get this error on the **Manager settings** page for three reasons:<ul><li>Data processing hasn't completed.</li><li>You might not have the right prerequisites to access the **Manager settings** page. </li><li>Fewer than 10 people in your organization have licenses.</li></ul>|It takes a few days for Viva Insights to process Microsoft 365 collaboration data and for assigned users to get the right permissions. Most customers are able to access the app four to five days after the Microsoft 365 admin assigns licenses. <br/><br/>If it's been four to five days: <ul><li>Review our documentation to make sure you have the right prerequisites to access **Manager settings**. </li><li>Make sure at least 10 people in your organization have Viva Insights licenses assigned to them.</li></ul>| [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)|

### Data upload

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
|0% of insights using organizational data are available due to missing or low-quality data fields|You haven't added data to the advanced insights app, and the quality of data from Microsoft Entra ID is too low. | Add organizational data to the advanced insights app to increase this percentage and unlock different insights.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/>[Data quality](/viva/insights/advanced/analyst/data-quality-analyst-experience)|
|Another upload or delete action is currently underway. To continue, wait for that action to be completed.| You or another admin have added data to the advanced insights app, and it's still processing.|Either wait a few hours for the data to finish processing and refresh the page, or cancel the update and start a new one.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)|
|Submission for upload failed. If you already have an upload or delete action in progress, wait for it to finish. Otherwise, please try again.|Something caused your upload to fail. |If you don't have another upload in progress, check your file for errors and try uploading it again. If another upload is in progress, wait until it's done processing. Contact our [support team](/microsoft-365/admin/get-help-support#online-support) for help if you keep getting this error.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/> [Support](/microsoft-365/admin/get-help-support#online-support)|

If your data takes days or weeks to process, contact our [support team](/microsoft-365/admin/get-help-support#online-support) for help. If your Microsoft 365 admin just assigned licenses, keep in mind that it can take up to five days for data to become available.

For specific validation errors related to your data file, refer to our [data upload documentation](/viva/insights/advanced/admin/rules-validation-errors#validation-errors).

## Workplace Analytics

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
|It looks like you don't have access to this space. Go to the new and enhanced Viva Insights platform for the most up-to-date experience.| You'll get this error on the legacy Workplace Analytics app if you no longer have access to it.| All customers are given a 90-day period to transition from the legacy Workplace Analytics app to the new advanced insights app. After this period, you'll see this error.<br/><br/> If you want to temporarily access the legacy Workplace Analytics app to retrieve data, contact our support team for help. If you're only assigned [roles for our new platform](/viva/insights/advanced/setup-maint/user-roles), you're not able to access the legacy app.| [Introduction to advanced insights](/viva/insights/advanced/introduction-to-advanced-insights) <br/><br/> [User roles](/viva/insights/advanced/setup-maint/user-roles)|

## Viva Insights app in Teams and on the web

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
|Sorry, something went wrong|You might not have the right license or roles to access organization insights. Or, your team might not meet the minimum team size. |Contact your Microsoft 365 admin to make sure they've assigned you the right license and role. <br/><br/> To view organization insights, you need to have at least the minimum team size, which your admin sets in **Manager settings**. Your team can be made up of direct or indirect reports, but they need to be correctly mapped to you in the organizational data your admin uploads to Viva Insights. |[Question 4. FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app) <br/><br/> [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)<br/><br/>[Assign roles](/viva/insights/advanced/setup-maint/assign-user-roles)<br/><br/>[Role access](/viva/insights/advanced/setup-maint/user-roles)<br/><br/>[Manager settings](/viva/insights/advanced/setup-maint/manager-settings) (to check your minimum team size) <br/><br/>[Organization insights](/viva/insights/org-team-insights/org-insights)|
|This content needs additional organization data|Refer to the information above, in "Sorry, something went wrong."|||

### Missing organization insights

If you can't see organization insights in the Viva Insights app in Teams or on the web, your organization might not have the minimum number of licenses assigned, or you don't meet the minimum team size.

Contact your Microsoft 365 admin and Insights Administrator to make sure that:

* At least 10 people in your organization have licenses.
* You have the right license and role assigned to access organization insights.
* Your team members all have licenses, your team meets the minimum team size, and your team members are correctly mapped to you in the organizational data uploaded to Viva Insights.

## Next steps

If you've tried the provided solution to your error and you're still getting the same message, [contact our support team](/microsoft-365/admin/get-help-support#online-support) for help.
