---
title: Resolve Viva Insights errors
description: Discusses how to resolve errors that you encounter in Viva Insights.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
ms.date: 06/30/2025
ms.service: viva-insights
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - sap:Advanced Insights - Data Sources & Organizational Data Upload
---

# Resolve errors when you work with Viva Insights

This article provides an overview of common app-level error states that you might experience when you use the Viva Insights app. The error messages that you receive are related to the overall functionality of the app. If you see an error message that isn't listed here, the error might be related to specific app insights or the underlying platform. For more information, see the documentation pages for those features or contact your Microsoft 365 administrator.

## Advanced analysis

### Sign-in and page access

| Error message | Details | Solution | Resources |
|--- | --- |---|---|
| Manager settings can't be edited yet. Please try again in a few days. | You might receive this error on the **Manager settings** page for any of four reasons:<ul><li>Data processing isn't completed.</li><li>You don't meet the prerequisites to access the **Manager settings** page. </li><li>Fewer than 50 people in your organization have licenses.</li><li>Your organization uses a demo tenant. Demo accounts can't access advanced analysis. | Viva Insights requires a few days to process Microsoft 365 collaboration data. Assigned users might need several days to get the correct permissions. Most users are able to access the app within four to five days after the Microsoft 365 admin assigns licenses. <br/><br/>If you don't have access after five days: <ul><li>Review our documentation to make sure that you meet the prerequisites to access **Manager settings**. </li><li>Make sure that at least 50 people in your organization have Viva Insights licenses assigned to them.</li></ul> | [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)|
| This experience is currently unavailable for your organization. To unlock the potential of Copilot Analytics and the Viva Insights advanced analyst workbench, please contact your Microsoft 365 administrator. | This error occurs if either Viva Insights or the Copilot Dashboard aren't set up for your organization. Your organization might not have prerequisite licensing or role assignments configured for this feature to be enabled. | Contact your Microsoft 365 administrator to enable Copilot Analytics and the Viva Insights advanced analyst workbench. | [Learn about wellbeing and productivity tools](https://www.microsoft.com/microsoft-viva/insights). |
| Something went wrong. Please refresh the page and try again. If the issue persists, contact your administrator. | You might encounter this error if a temporary technical issue prevents Viva Insights or specific pages from loading. | Refresh the page. If the problem persists, contact your administrator for support. | |
| Unauthorized access. Kindly refresh the page to regain access. If the problem persists, contact the Microsoft 365 administrator. | This error typically occurs if your organization's Conditional Access policies (CAE) block your access. For example, access might be blocked if you try to access the tool from an unapproved device or location. | Refresh the page. If the problem persists, contact your Microsoft 365 administrator to make sure that your access complies with appropriate policies. | |
| It looks like you don't have the necessary permissions. Please contact your Microsoft 365 administrator to be assigned a role for Viva Insights. | This message indicates that your account doesn't have the correct permissions to access certain features. You might receive this message if:<ul><li>You don't have a Viva Insights license.</li><li>You don't have a role assignment that can access this page.</li><li>Your organization uses Privileged Identity Management (PIM) as an extra approval process, and your role isn't activated yet.</li><li>Your organization is using a demo tenant. Demo accounts can't access advanced analysis. | Contact your administrator to request the appropriate permissions or role to use Viva Insights. | [Learn how to assign roles in Viva Insights](/viva/insights/advanced/setup-maint/user-roles). |
| The Copilot Dashboard has been disabled by your administrator. Please contact your administrator for more information. | This error indicates that the Copilot Dashboard is disabled for your organization. | Contact your Microsoft 365 administrator to enable the Copilot Dashboard, if you need it. | |
| Advanced Insights has not been enabled for your tenant. To access this feature, please contact your Microsoft 365 admin. | This error indicates that advanced analysis isn't enabled for your organization. | Contact your Microsoft 365 administrator to enable advanced analysis, if you need it. | |
| Viva Insights is below the minimum assigned license requirement for this experience. To use the advanced insights app, your Viva Insights administrator must have assigned a minimum number of licenses. If they've already been assigned, please check back later as we get set up. | This error occurs if employees for whom you're measuring workplace behavior aren't assigned licenses to Viva Insights. Some features might remain restricted until the licensing requirement is fulfilled. This requirement makes sure that data can be presented at an aggregated level without enabling individual behavior to be identified. | To verify and resolve license-related issues, contact your Viva Insights administrator. If licenses are already assigned, allow time for the system to update before you try again. | [Learn how to assign licenses in Viva Insights](/viva/insights/advanced/setup-maint/assign-licenses). |
| Something went wrong. Please refresh the page and try again. If the issue persists, contact your administrator. | This error indicates that an internal error prevented this page from loading correctly. | Refresh the page. If the problem persists, contact your Microsoft 365 administrator for more support. | |
|  Advanced Insights setup is not complete. To use the advanced insights app, your Viva Insights administrator must complete additional setup steps. | This error occurs if your organization's Viva Insights admin did not complete all the required steps to enable Microsoft to process data. Also, this issue is common when the tool is newly activated for your organization. You might also receive this message if you're using a demo tenant. Demo tenants can't access advanced analysis capabilities. | Wait a few days for your tenant admin to complete the necessary steps and for data processing to finish. If the issue persists, contact your administrator. | [See the Viva Insights setup checklist](/viva/insights/advanced/setup-maint/setup-overview). |
| Collaboration data is being loaded. Please try again later. Contact your M365 administrator if the issue persists. | This error occurs while Viva Insights is gathering and processing collaboration data. This issue is common when the tool is newly activated for your organization. | Wait for the data processing to finish. Typically, this process takes a few days to finish. If the issue persists, contact your administrator. | [See the advanced analysis FAQ](/viva/insights/advanced/reference/faq). |
| You have not yet been assigned as an Analyst to any data partition. | This error occurs if you're assigned the Viva Insights Analyst role but you're not assigned as an Analyst to a specific data partition or global scope. Until this assignment is made, you can't access analyst-specific features. | Contact your Viva Insights administrator to be assigned as an Analyst to a data partition. | |
| Your session has expired due to inactivity. Please reload this page to refresh your credentials. If this doesn't work, contact your Microsoft 365 admin. | This error occurs if you remain inactive for a long period, and your session automatically logs out for security. | Reload the page to refresh your credentials. If this doesn’t work, contact your administrator for help. | |
| We cannot find this page. Please make sure that the page address is correct or return to the Viva Insights homepage. | This error occurs if the page that you're trying to access doesn't exist, if the link to the page is incorrect, or if the page was moved or deleted. | Verify that the page address is correct or return to the homepage. If the issue persists, contact your administrator. | |

### Data upload

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
| 0% of insights using organizational data are available due to missing or low-quality data fields | The Viva Insights web app doesn't have data, and the quality of data from Microsoft Entra ID is low. | To increase the percentage of insights and unlock different insights, add organizational data to the Viva Insights web app. | [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/>[Data quality](/viva/insights/advanced/analyst/data-quality-analyst-experience)|
| Another upload or delete action is currently underway. To continue, wait for that action to finish. | The Viva Insights web app is still processing the data. | Either wait a few hours for the data to finish processing and refresh the page, or cancel the update and start a new update.| [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first) 
| Submission for upload failed. If you already have an upload or delete action in progress, wait for it to finish. Otherwise, please try again. | Something caused your upload to fail. | If you don't have another upload in progress, check your file for errors, and then try again to upload the file. If another upload is in progress, wait until it's finished. If this error persists, contact our [support team](/microsoft-365/admin/get-help-support#online-support) for help. | [Upload organizational data](/viva/insights/advanced/admin/upload-org-data-first)<br/><br/> [Support](/microsoft-365/admin/get-help-support#online-support)<br/><br/>**Note:** If your data takes days or weeks to process, contact the Microsoft [Support team](/microsoft-365/admin/get-help-support#online-support) for help. If your Microsoft 365 admin assigned a license to you recently, the data can take up to five days to become available. For specific validation errors that are related to your data file, see our [data upload documentation](/viva/insights/advanced/admin/rules-validation-errors#validation-errors).

## Viva Insights app in Teams and on the web

| Error message | Details |Solution| Resources |
|--- | --- |---|---|
| Sorry, something went wrong | You might not have the correct license or roles to access organization insights. Or, your team might not meet the minimum team size requirement. | Contact your Microsoft 365 admin to make sure that they assign you the correct license and role. <br/><br/> To view organization insights, you must have at least the minimum-sized team. Your admin sets the size in **Manager settings**. Your team can consist of direct or indirect reports, but the reports have to be correctly mapped to you in the organizational data that your admin uploads to Viva Insights. | [Question 4. FAQ](/viva/insights/advanced/reference/faq#q4-our-admin-assigned-the-required-licenses-why-cant-insights-analysts-access-the-advanced-insights-app) <br/><br/> [Assign licenses](/viva/insights/advanced/setup-maint/assign-licenses)<br/><br/>[Assign roles](/viva/insights/advanced/setup-maint/assign-user-roles)<br/><br/>[Role access](/viva/insights/advanced/setup-maint/user-roles)<br/><br/>[Manager settings](/viva/insights/advanced/setup-maint/manager-settings) (to check your minimum team size requirement) <br/><br/>[Organization insights](/viva/insights/org-team-insights/org-insights) |
| This content needs additional organization data || See the information in "Sorry, something went wrong." ||

### Missing organization insights

If you can't see organization insights in the Viva Insights app (either in Microsoft Teams or on the web), your organization might not be assigned the minimum number of licenses, or it might not meet the team size requirement.

Contact your Microsoft 365 admin and Insights Administrator to make sure that the following requirements are met:

* At least 50 people in your organization have licenses.
* You have the appropriate license and role assignment to access organization insights.
* All your team members have licenses, your team meets the minimum team size, and your team members are correctly mapped to you in the organizational data that's uploaded to Viva Insights.
