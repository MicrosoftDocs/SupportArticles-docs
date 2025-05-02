---
title: Resolve Viva Insights errors
description: Describes how to resolve errors that you might encounter in Viva Insights.
author: helenclu
ms.author: luche
manager: dcscontentpm
ms.date: 04/25/2025
ms.service: viva-insights
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot  
---

# Resolve errors when you work with Viva Insights

When using the Viva Insights app, you might encounter various error messages. These messages are designed to help you understand and resolve issues that might arise while using the app.  

This document provides an overview of common app-level error states that you might see, related to the overall functioning of the app. If you come across an error that isn't listed here, it might be related to specific app insights or the underlying platform. For further assistance, refer to the documentation pages for those features or contact your Microsoft 365 administrator. 

## Advanced insights

### Sign-in and page access

| Error message | Details | Solution | Resources |
|--- | --- |---|---|
|Manager settings can't be edited yet. Please try again in a few days.|You might get this error on the **Manager settings** page for one of four reasons:<ul><li>Data processing hasn't completed.</li><li>You might not have the right prerequisites to access the **Manager settings** page. </li><li>Fewer than 50 people in your organization have licenses.</li><li>Your organization might be using a demo tenant, and demo accounts can't access advanced insights.|It takes a few days for Viva Insights to process Microsoft 365 collaboration data and for assigned users to get the right permissions. Most customers are able to access the app four to five days after the Microsoft 365 admin assigns licenses. <br/><br/>If it's been four to five days: <ul><li>Review our documentation to make sure you have the right prerequisites to access **Manager settings**. </li><li>Make sure at least 50 people in your organization have Viva Insights licenses assigned to them.</li></ul>| [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)|
| This experience is currently unavailable for your organization. To unlock the potential of Copilot Analytics and the Viva Insights advanced analyst workbench, please contact your Microsoft 365 administrator. | This error occurs when your organization hasn't yet set up Viva Insights or the Copilot Dashboard. This could mean that your organization doesn't have prerequisite licensing or role assignments in place for this feature to be enabled. | Contact your Microsoft 365 administrator who can enable Copilot Analytics and the Viva Insights advanced analyst workbench. | [Learn about wellbeing and productivity tools](https://www.microsoft.com/microsoft-viva/insights). |
| Something went wrong. Please refresh the page and try again. If the issue persists, contact your administrator. | You might encounter this error if there's a temporary technical issue with Viva Insights that prevents the app or specific pages from loading. | Refresh the page. If the problem continues, contact your administrator for support. | |
| Unauthorized access. Kindly refresh the page to regain access. If the problem persists, contact the Microsoft 365 administrator. | This error usually appears when your organization's Conditional Access policies (CAE) block your access. For example, this could happen if you're trying to access the tool from an unapproved device or location. | Refresh the page. If the problem continues, contact your Microsoft 365 administrator to make sure your access complies with appropriate policies. | |
| It looks like you don't have the necessary permissions. Please contact your Microsoft 365 administrator to be assigned a role for Viva Insights. | This error means your account doesn't have the correct permissions to access certain features. Some reasons you might see this message:<ul><li>Your Viva Insights admin hasn't assigned you a Viva Insights license.</li><li>Your Microsoft 365 admin hasn't assigned you a role that can access this page.</li><li>Your organization might use Privileged Identity Management (PIM) as an extra approval process, and you haven't activated your role yet.</li><li>Your organization might be using a demo tenant, and demo accounts can't access advanced insights. | Reach out to your administrator to request the appropriate permissions or role for using Viva Insights. | [Learn how to assign roles in Viva Insights](/viva/insights/advanced/setup-maint/user-roles). |
| The Copilot Dashboard has been disabled by your administrator. Please contact your administrator for more information. | This error indicates that your organization's Microsoft 365 administrator has intentionally disabled the Copilot Dashboard. | Contact your Microsoft 365 administrator to enable the Copilot Dashboard if needed. | |
| Advanced Insights has not been enabled for your tenant. To access this feature, please contact your Microsoft 365 admin. | This error indicates that your organization's administrator has intentionally disabled advanced insights. | Contact your Microsoft 365 administrator to enable advanced insights if needed. | |
| Viva Insights is below the minimum assigned license requirement for this experience. To use the advanced insights app, your Viva Insights administrator must have assigned a minimum number of licenses. If they've already been assigned, please check back later as we get set up. | This occurs when your organization hasn't assigned enough licenses to Viva Insights to employees from whom you're measuring workplace behaviors. Some features might remain restricted until the licensing requirement is fulfilled. This license requirement ensures that data can be presented at an aggregated level without enabling individual behaviors to be definitively identified.  | Contact your Viva Insights administrator to confirm and resolve license-related issues. If licenses have already been assigned, allow some time for the system to update before retrying. | [Learn how to assign licenses in Viva Insights](/viva/insights/advanced/setup-maint/assign-licenses). |
| Something went wrong. Please refresh the page and try again. If the issue persists, contact your administrator. | This error indicates that there was an internal error that caused this page to not load properly. | Refresh the page. If the problem continues, contact your Microsoft 365 administrator for more support. | |
|  Advanced Insights setup is not complete. To use the advanced insights app, your Viva Insights administrator must complete additional setup steps. | This error occurs when your organization's Viva Insights admin still has configuration steps to complete before Microsoft can begin processing data. This is common when the tool has been newly activated for your organization. You might also receive this message if you're using a demo tenant, because demo tenants can't access advanced analysis capabilities.  | Wait a few days for your tenant admin to complete the necessary steps and for data processing to complete. If the issue continues, contact your administrator. | [See the Viva Insights setup checklist](/viva/insights/advanced/setup-maint/setup-overview). |
| Collaboration data is being loaded. Please try again later. Contact your M365 administrator if the issue persists. | This error occurs when Viva Insights is still in the process of gathering and processing collaboration data. This is common when the tool has been newly activated for your organization. |  Wait for the data processing to complete, which usually takes a few days. If the issue continues, contact your administrator. | [See the advanced insights FAQ](/viva/insights/advanced/reference/faq). |
| You have not yet been assigned as an Analyst to any data partition. | This error occurs when you have been assigned the Viva Insights Analyst role, but you haven't been assigned as an analyst to any specific data partition or global scope as an Analyst. Until this assignment is made, you won't have access to analyst-specific features. | Contact your Viva Insights administrator to be assigned as an Analyst to a data partition. | |
| Your session has expired due to inactivity. Please reload this page to refresh your credentials. If this does not work, contact your Microsoft 365 admin. | This error occurs when you remain inactive for a long period, and your session automatically logs out for security reasons. | Reload the page to refresh your credentials. If this doesn’t work, contact your administrator for help. | |
| We cannot find this page. Please make sure that the page address is correct or return to the Viva Insights homepage. | This error means the page you're trying to access doesn't exist, the link is incorrect, or the page has been moved or deleted. | Verify that the page address is correct or return to the homepage. If the issue continues, contact your administrator. | |

### Data upload

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
|0% of insights using organizational data are available due to missing or low-quality data fields|You haven't added data to the advanced insights app, and the quality of data from Microsoft Entra ID is too low. | Add organizational data to the advanced insights app to increase this percentage and unlock different insights.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/>[Data quality](/viva/insights/advanced/analyst/data-quality-analyst-experience)|
|Another upload or delete action is currently underway. To continue, wait for that action to be completed.| You or another admin have added data to the advanced insights app, and it's still processing.|Either wait a few hours for the data to finish processing and refresh the page, or cancel the update and start a new one.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)|
|Submission for upload failed. If you already have an upload or delete action in progress, wait for it to finish. Otherwise, please try again.|Something caused your upload to fail. |If you don't have another upload in progress, check your file for errors and try uploading it again. If another upload is in progress, wait until it's done processing. Contact our [support team](/microsoft-365/admin/get-help-support#online-support) for help if you keep getting this error.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/> [Support](/microsoft-365/admin/get-help-support#online-support)|

If your data takes days or weeks to process, contact the Microsoft [Support team](/microsoft-365/admin/get-help-support#online-support) for help. If your Microsoft 365 admin assigned a license to you recently, it can take up to five days for the data to become available.

For specific validation errors related to your data file, refer to our [data upload documentation](/viva/insights/advanced/admin/rules-validation-errors#validation-errors).

## Viva Insights app in Teams and on the web

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
|Sorry, something went wrong|You might not have the right license or roles to access organization insights. Or, your team might not meet the minimum team size. |Contact your Microsoft 365 admin to make sure that they assign you the right license and role. <br/><br/> To view organization insights, you need to have at least the minimum team size, which your admin sets in **Manager settings**. Your team can be made up of direct or indirect reports, but they need to be correctly mapped to you in the organizational data your admin uploads to Viva Insights. |[Question 4. FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app) <br/><br/> [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)<br/><br/>[Assign roles](/viva/insights/advanced/setup-maint/assign-user-roles)<br/><br/>[Role access](/viva/insights/advanced/setup-maint/user-roles)<br/><br/>[Manager settings](/viva/insights/advanced/setup-maint/manager-settings) (to check your minimum team size) <br/><br/>[Organization insights](/viva/insights/org-team-insights/org-insights)|
|This content needs additional organization data|Refer to the information in "Sorry, something went wrong."|||

### Missing organization insights

If you can't see organization insights in the Viva Insights app in Teams or on the web, your organization might not have the minimum number of licenses assigned, or you don't meet the minimum team size.

Contact your Microsoft 365 admin and Insights Administrator to make sure that:

* At least 50 people in your organization have licenses.
* You have the right license and role assignment to access organization insights.
* Your team members all have licenses, your team meets the minimum team size, and your team members are correctly mapped to you in the organizational data uploaded to Viva Insights.
