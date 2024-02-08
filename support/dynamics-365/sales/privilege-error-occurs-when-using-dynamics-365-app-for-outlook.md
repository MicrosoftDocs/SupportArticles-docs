---
title: A privilege error when using Dynamics 365 App for Outlook
description: A privilege error occurs when attempting to use Microsoft Dynamics 365 App for Outlook. Provides options to solve this issue.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# A privilege error occurs when attempting to use Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the issue that you may receive the **You don't have required privilege (prvReadOrganization)** error when trying to use the Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4563997

## Symptoms

When attempting to use the Microsoft Dynamics 365 App for Outlook, you encounter an error referencing a missing privilege such as the following error:

> You don't have required privilege (prvReadOrganization), which limits certain functionality. Please contact your administrator to get necessary access.

## Cause

This error will appear if the user associated with the mailbox record does not have sufficient privileges to use Microsoft Dynamics 365 App for Outlook.

## Resolution

Option 1: Assign Microsoft Dynamics 365 App for Outlook User security role

A standard role exists to provide the privileges required to use Microsoft Dynamics 365 App for Outlook. This role is named Microsoft Dynamics 365 App for Outlook User and can be assigned to users who need to use App for Outlook. For more information on this role, see [Provide security role access](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#provide-security-role-access).

Option 2: Custom Role

If you prefer to customize a role to include the required privileges, refer to the More information section for a list of privileges required to use Microsoft Dynamics 365 App for Outlook.

## More information

The following table lists privileges required to use Microsoft Dynamics 365 App for Outlook and the tab in a security role where the privilege can be found. A user with the System Administrator role can locate and modify a security role by navigating to **Settings** > **Security** > **Security Roles**. To view which role(s) are assigned to a specific user, navigate to **Settings**, select **Security**, select **Users**, select the specific User record, and then select **Manage Roles**.

| Privilege name| Entity| Location (tab) within security role|
|---|---|---|
|prvReadEmailServerProfile|EmailServerProfile|Business Management|
|prvReadRole|Security Role|Business Management|
|prvReadUser|User|Business Management|
|prvWriteMailbox|Mailbox|Business Management|
|prvReadMailbox|Mailbox|Business Management|
|prvReadOrganization|Organization|Business Management|
|prvSyncToOutlook (exchangesyncidmapping|Sync to Outlook|Business Management --> Privacy-related privileges|
|prvUseOfficeApps|Use Dynamics 365 App for Outlook|Business Management --> Privacy-related privileges|
|prvAppendToAccount|Account|Core Records|
|prvReadAccount|Account|Core Records|
|prvDeleteActivity|Activity|Core Records|
|prvAppendActivity|Activity|Core Records|
|prvWriteActivity|Activity|Core Records|
|prvCreateActivity|Activity|Core Records|
|prvReadActivity|Activity|Core Records|
|prvAppendToActivity|Activity|Core Records|
|prvShareActivity|Activity|Core Records|
|prvAppendToContact|Contact|Core Records|
|prvReadContact|Contact|Core Records|
|prvCreateContact|Contact|Core Records|
|prvReadUserQuery|Saved View|Core Records|
|prvReadAppModule|Model-driven App|Customization|
|prvReadAttribute|Field|Customization|
|prvReadEntity|Entity|Customization|
|prvReadRelationship|Relationship|Customization|
|prvReadSystemApplicationMetadata|System Application Metadata|Customization|
|prvReadSystemForm|System Form|Customization|
|prvReadUserApplicationMetadata|User Application Metadata|Customization|
|prvReadQuery|View|Customization|
|prvReadWebResource|Web Resource|Customization|
|prvSearchAvailability|Search Availability|Service Management --> Miscellaneous Privileges|

The following table lists additional privileges that are required to view some of the default views used inside the Microsoft Dynamics 365 App for Outlook forms. Without these privileges, a user may see the following error instead of the expected view (subgrid) of records:

> You do not have permission to access these records. Contact your Microsoft Dynamics 365 administrator for help.

| Privilege name| Entity| Location (tab) within security role|
|---|---|---|
|prvReadIncident|Case|Service|
|prvReadOpportunity|Opportunity|Core Records|
|prvReadCompetitor|Competitor|Sales|
|prvReadConnection|Connection|Core Records|
