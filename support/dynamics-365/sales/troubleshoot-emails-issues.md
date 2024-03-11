---
title: Troubleshoot issues with emails
description: Provides resolutions for the known issues that are related to emails in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.reviewer: lavanyakr, aam, veparim
ms.date: 03/11/2024
ms.subservice: d365-sales-sales
---
# Troubleshoot issues with emails

This article helps you troubleshoot and resolve issues related to emails in Dynamics 365 Sales.

## Issue: Email editor shows incorrect title in contextual email popup window

After upgrading to Dynamics 365 2020 release wave 2, the email editor shows incorrect title in contextual email popup window.

### Cause

For out of the box email forms, the `onload` and `onchange` events are triggered that helps in updating email title and other attributes in the contextual email popup. If you have a custom email form or an unmanaged layer form, the `onload` and `onchange` events won't be available. Therefore, the email title is displayed incorrectly.

### Resolution

To resolve this issue, you must add the `onload` and `onchange` events to the custom email forms.

1. [Create a new solution](/powerapps/maker/common-data-service/create-solution).
2. Add the custom email form to the newly created solution.
3. [Export the solution](/powerapps/maker/common-data-service/export-solutions).
4. Add the following code in the form's XML:

    ```XML
    <events>
        <event name="onload" application="true" active="true">
            <InternalHandlers>
                <Handler functionName="Activities.Email.formOnload" libraryName="Activities/SystemLibraries/Email_main_system_library.js" handlerUniqueId="ecdfe4d8-d6d3-4d21-ab68-8ea75bb30a79" enabled="true" parameters="" passExecutionContext="true" />
                <Handler functionName="Activities.Email.NotifyPanelSubjectChange" libraryName="Activities/SystemLibraries/Email_main_system_library.js" handlerUniqueId="{706607A8-4424-4C9A-847A-602FC8035B48}" enabled="true" parameters="" passExecutionContext="true" solutionaction="Added"/>
            </InternalHandlers>
        </event>
        <event name="onchange" application="true" active="true" attribute="subject" solutionaction="Added">
            <Handlers>
                <Handler functionName="Activities.Email.NotifyPanelSubjectChange" libraryName="Activities/SystemLibraries/Email_main_system_library.js" handlerUniqueId="{706607A8-4424-4C9A-847A-602FC8035B48}" enabled="true" parameters="" passExecutionContext="true"/>
            </Handlers>
        </event>
    </events>
    <clientresources>
        <internalresources>
            <clientincludes>
                <internaljscriptfile src="$webresource:Activities/SystemLibraries/Email_main_system_library.js" />
            </clientincludes>
        </internalresources>
    </clientresources>
    ```

5. [Import the solution](/powerapps/maker/common-data-service/import-update-export-solutions).

## Issue: Can't view untracked emails and meetings in auto capture

[Auto capture](/dynamics365/sales/configure-auto-capture) doesn't show untracked emails and meetings for some or all users in an organization.

### Cause

Starting from version 9.2.24031.0010, Dynamics 365 Sales follows the [principle of least privilege access](/entra/identity-platform/secure-least-privileged-access), which prevents users who have [Conditional Access policies](/entra/identity/conditional-access/concept-conditional-access-policy-common?tabs=secure-foundation) on their tenants from accessing untracked emails and meetings.

If a user can't see untracked emails and meetings, perform the following steps to verify whether the issue is caused by a Conditional Access policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a Conditional Access administrator.
2. Go to **Identity** > **Monitoring & health** > **Sign-in logs**.
3. Switch to the **User sign-ins (non-interactive)** tab and add the following filters:
   - **Application** contains **Dataverse**
   - **Resource** contains **Microsoft Graph**
   - **Status** equals **Failure**

    If some results are returned for the affected users, the issue is due to a Conditional Access policy.

### Resolution

There's no resolution available for this issue. As an alternative, users can use [Microsoft Copilot for Sales in Outlook](/microsoft-sales-copilot/save-outlook-activities-crm) or [server-side synchronization](/power-platform/admin/email-message-filtering-correlation) to track all emails and meetings automatically.
