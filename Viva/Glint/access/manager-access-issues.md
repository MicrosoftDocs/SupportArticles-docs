---
title: Resolve Issues When Accessing Viva Glint Survey Results
description: Resolves common issues that you might encounter when you try to view survey results for your team.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 04/01/2025
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - sap:User Management\User Permissions and Roles
  - CSSTroubleshoot
  - CI 195105
---

# Resolve issues when accessing Viva Glint survey results

Microsoft Viva Glint survey programs enable your organization to collect data and review feedback about employee job satisfaction. To access your Viva Glint dashboard as a leader or manager in your organization, sign in by using one of the following links, as appropriate for the region of your organization:  

- US - [http://app.us1.glint.cloud.microsoft](http://app.us1.glint.cloud.microsoft)
- EU - [http://app.eu1.glint.cloud.microsoft](http://app.eu1.glint.cloud.microsoft)

After you sign in, you might occasionally encounter such issues as unexpected connection or maintenance messages when you try to view results for your team. This article lists some common issues and the steps to resolve them.

To successfully access Viva Glint, your user account must meet the following requirements:

- It must exist in Microsoft Entra and have the user type set to **Member** or **Guest**. For more information about how Microsoft 365 Global Administrators or Entra admins can set up access, see [set up access to Viva Glint with Microsoft Entra ID](/viva/glint/setup/access-with-azure-ad).
  
   **Note**: Invited Guests from other tenants in a [multitenant organization](/viva/glint/setup/glint-mto) and [Support users](/viva/glint/setup/add-external-user) must select a domain when signing in. For more information, see [Sign in as a Guest or Support user](/viva/glint/setup/access-glint#sign-in-as-a-guest-or-support-user).
- It must exist in the Viva Glint app, be a member of the **Active Employees** role, and have an employee status set to **ACTIVE**.

## No access to live surveys

Viva Glint has two levels of reporting access. Live access is usually restricted to admins. Phased access is recommended for managers and Human Resources Business Partners (HRBPs). As a manager, you can access only phased surveys. For more information, see [Grant live versus phased access in Viva Glint reporting](/viva/glint/setup/live-versus-phased-access).

## No Viva Glint access

When you try to sign in to Viva Glint, you receive the following error message:

> You do not have access. Please contact your Glint administrator for help.

You see this error message if you don't have permission to access the Viva Glint app.

To resolve the issue, ask your Viva Glint admin for the missing permission.

## No access to survey reports

You receive the following welcome message, but you can't access any survey reports:

> Welcome to Viva Glint  
> To access the survey reports, contact your Glint admin to assign you the necessary role to access them.

To resolve the issue, contact your Viva Glint admin.

## Not enough respondents to see your team's results

You receive the following error message in the dashboard:

> You don't have enough respondents to see your team's results, but you can still have a successful ACT Conversation.

This error occurs in one of the following situations:

- The number of respondents is less than the [confidentiality threshold](/viva/glint/setup/quick-guide-confidentiality) of five people.
- You don't have access to a data segment to view the results.

To resolve the issue, select the appropriate solution for your situation:

- If the number of respondents is less than the confidentiality threshold, select **View Guide for Smaller Teams**, and then follow the guidelines. If your organization has enabled [Broader Team Insights (BTI)](/viva/glint/reports/broader-team-insights), you can view the summary of your manager's results.
- If you lack access to a data segment, ask your Viva Glint admin for the required access.

## Incorrect team information or broken trend

When you access reports, you might see incorrect team information or a break in a trend for some attributes. These issues can occur for the following reasons:

- Recent changes to your team that aren't shown in your Viva Glint dashboard because new data wasn't uploaded before a survey started. For example, new members joined your team, but this change isn't reflected in the dashboard.
- A change in an attribute value that breaks the trend for scores in reports. For example, if your organization relabeled a department from "HR" to "Human Resources," scores don't reflect the change even though the department remains the same.

To resolve the issue, check whether the Viva Glint admin can [update your results data](/viva/glint/setup/update-glint-reporting-data) or [grant/update custom access](/viva/glint/setup/custom-user-role) to view new and old values. 

## Repeatedly signed out of Viva Glint 

If you repeatedly get signed out of Viva Glint, try the following steps in the given order. If the issue persists after any step, go to the next step. 

1. Contact your Microsoft Entra admin to verify that your UPN and email address match between Viva Glint and Microsoft Entra ID.
1. Make sure that you have only one active Viva Glint session open in your web browser. If you have multiple sessions, sign out of all sessions, and close all browser tabs and windows. Then, start a new session. 
1. Check whether you're signed out because of [an inactivity time-out](/viva/glint/setup/access-glint#session-timeout). Viva Glint automatically signs out users after 30 minutes of inactivity. It prompts users to continue their session after the first 20 minutes. 
1. Check the Glint link that you bookmarked to make sure that it doesn't contain any extra text, such as "/config" or "/dashboard."  Use one of the following links, as appropriate for your region: 

   - US - [http://app.us1.glint.cloud.microsoft](http://app.us1.glint.cloud.microsoft)
   - EU - [http://app.eu1.glint.cloud.microsoft](http://app.eu1.glint.cloud.microsoft)
1. Contact your Microsoft Entra admin to determine whether [idle session time-out](/microsoft-365/admin/manage/idle-session-timeout-web-apps) is enabled for your organization. If it's enabled, you must select the option to stay signed in when you receive a notification.  

If you still experience logout issues, contact your Viva Glint admin for more assistance from Microsoft 365 Support.
