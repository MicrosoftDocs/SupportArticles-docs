---
title: Resolve issues when accessing Viva Glint survey results
description: Resolves some common issues that you might encounter when you try to view survey results for your team.
manager: dcscontentpm
ms.reviewer: aweixelman
ms.date: 10/15/2024
audience: ITPro
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - sap:User Management\User Permissions and Roles
  - CSSTroubleshoot
  - CI 195105
---

# Resolve issues when accessing Viva Glint survey results

Microsoft Viva Glint survey programs enable your organization to collect data and listen to feedback about employee job satisfaction. To access your Viva Glint dashboard as a leader or manager in your organization, sign in by using one of the following links based on the region of your organization:  

- US - [http://app.us1.glint.cloud.microsoft](http://app.us1.glint.cloud.microsoft)
- EU - [http://app.eu1.glint.cloud.microsoft](http://app.eu1.glint.cloud.microsoft)

After you sign in, you might occasionally encounter issues, such as unexpected connection or maintenance messages, when you try to view results for your team. This article lists some common issues and the steps to resolve them.

## No access to live surveys

Viva Glint has two levels of reporting access. Live access is usually restricted to admins, while phased access is recommended for managers and Human Resources Business Partners (HRBPs). As a manager, you can access only phased surveys. For more information, see [Grant live versus phased access in Viva Glint reporting](/viva/glint/setup/live-versus-phased-access).

## No access because of monthly maintenance

Viva Glint undergoes [monthly maintenance](/viva/glint/setup/monthly-release-dates) to release new features, enhancements, and fixes. If you receive a maintenance message when you try to view your results, wait one day, and then access your dashboard again.

## No Viva Glint access

When you try to sign in to Viva Glint, you receive the following error message:

> You do not have access. Please contact your Glint administrator for help.

You see this error message if you don't have permission to access the Viva Glint app.

To resolve the issue, ask your Glint admin for permission to access the Viva Glint app.

## No access to survey reports

You receive the following welcome message, but you can't access any survey reports:

> Welcome to Viva Glint  
> To access the survey reports, contact your Glint admin to assign you the necessary role to access them.

The resolve the issue, contact your Viva Glint admin.

## Not enough respondents to see your team's results

You receive the following error message in the dashboard:

> You don’t have enough respondents to see your team's results, but you can still have a successful ACT Conversation.

This error occurs in one of the following situations:

- The number of respondents is below the [confidentiality threshold](/viva/glint/setup/quick-guide-confidentiality) of five.
- You don't have access to a data segment to view the results.

To resolve the issue, select the appropriate solution for your situation:

- If the number of respondents is below the confidentiality threshold, select **View Guide for Smaller Teams**, and then follow the guidelines. If your organization has enabled [Broader Team Insights (BTI)](/viva/glint/reports/broader-team-insights), you can view the summary of your manager's results.
- If you lack access to a data segment, ask your Viva Glint admin for the required access.

## Incorrect team information

Recent changes to your team aren’t shown in your Viva Glint dashboard. For example, new members have joined your team, but this change isn't reflected in the dashboard.

This issue occurs if employee data wasn't updated before a survey was launched.

To resolve the issue, check whether the Viva Glint admin can update your results data.

## Connection to Glint

If you are repeatedly logged out of the Glint application or experience login issues, use this information to find a resolution.

### Unable to connect to the Glint service

You receive the following error message:

> Sorry, we are unable to connect to the Glint service. Please check your network connection and try again.

This error might occur if an issue prevents matching your user principal name (UPN) and email between the Viva Glint app and Microsoft Entra ID.

To resolve the issue, ask your Viva Glint admin to update the data so that it matches across the two systems.

### Repeated logouts

If you're repeatedly logged out of Glint:

- Reach out to your Microsoft Entra admin to confirm that your user principal name (UPN) and email between Glint and Entra match.
- Confirm that you only have **one** active Glint session open in your internet browser. If you have multiple sessions, logout, close all browser tabs/windows, and start a new session.
- Review [session timeout information](/viva/glint/setup/access-glint#session-timeout). Glint logs out a user after 30 total minutes of inactivity, with a prompt to continue the session after the first 20 minutes.
- Check the Glint link that you have bookmarked and verify that it doesn't contain any extra text like "/config" or "/dashboard." Your bookmarked link should be one of the following, depending on your region:
  
  - US - [http://app.us1.glint.cloud.microsoft](http://app.us1.glint.cloud.microsoft)
  - EU - [http://app.eu1.glint.cloud.microsoft](http://app.eu1.glint.cloud.microsoft)

- Check with your IT team to see if [idle session timeout](/microsoft-365/admin/manage/idle-session-timeout-web-apps) is enabled for your organization, which controls how long users can be inactive before being signed out of Microsoft 365 apps.

If you still experience logout issues after reviewing the items included here, reach out to your Viva Glint Admin to determine next steps with Microsoft 365 Support.
