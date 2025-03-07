---
title: Privilege or permission error when using Dynamics 365 App for Outlook
description: Solves a privilege or permission error that occurs in Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.date: 03/06/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# A privilege or permission error occurs in Microsoft Dynamics 365 App for Outlook

This article helps solve errors that occur when you try to use or open Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4563997, 4229661

## Symptom 1

When you try to use Dynamics 365 App for Outlook, you receive an error that resembles the following one:

> You don't have required privilege (prvReadOrganization), which limits certain functionality. Please contact your administrator to get necessary access.

### Cause

This error occurs if the user associated with the mailbox record doesn't have sufficient privileges to use Dynamics 365 App for Outlook.

## Symptom 2

When you open Dynamics 365 App for Outlook, you receive the following error:

> We're sorry  
> We are unable to show Dynamics 365 App for Outlook because current user role does not have required permissions. Please contact your administrator to have required security role assigned to the Dynamics 365 App for Outlook solution.

If you select **Show more**, the additional details include the following information:

> Error: Don't have permissions to retrieve AppforOutlookModule id  
> Trace: Error: Don't have permissions to retrieve AppforOutlookModule id at new ...

### Cause

This error occurs if the Dynamics 365 security role doesn't have access to the app module used by the Dynamics 365 App for Outlook.

## Resolution

To solve these issues, use one of the following options.

### Option 1: Assign the "Dynamics 365 App for Outlook User" security role

The [Dynamics 365 App for Outlook User](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#step-3-provide-security-role-access) security role can be assigned to users who need to use Dynamics 365 App for Outlook. This security role is available from build 9.1.0.4206 or later. This option ensures that the users have the basic privileges needed to access Dynamics 365 App for Outlook.

### Option 2: Assign privileges to a custom security role

If you prefer to customize a security role to include the required privileges, refer to the [More information](#more-information) section for a list of privileges required to use Dynamics 365 App for Outlook.

> [!IMPORTANT]
> Custom security roles don't have access to the Dynamics 365 app module by default. The steps provided in [Step 3: Provide security role access](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#step-3-provide-security-role-access) are also required.

## More information

The following table lists privileges required to use Dynamics 365 App for Outlook and the tab in a security role where the privilege can be found.

A user with the System Administrator role can locate and modify a security role by navigating to **Settings** > **Security** > **Security Roles**.

To view which role(s) are assigned to a specific user, navigate to **Settings**, select **Security**, select **Users**, select the specific User record, and then select **Manage Roles**.

| Privilege name| Entity| Location (tab) within security role|
|---|---|---|
|prvReadEmailServerProfile|EmailServerProfile|Business Management|
|prvReadRole|Security Role|Business Management|
|prvReadUser|User|Business Management|
|prvWriteMailbox|Mailbox|Business Management|
|prvReadMailbox|Mailbox|Business Management|
|prvReadOrganization|Organization|Business Management|
|prvSyncToOutlook (exchangesyncidmapping)|Sync to Outlook|Business Management > Privacy-related privileges|
|prvUseOfficeApps|Use Dynamics 365 App for Outlook|Business Management > Privacy-related privileges|
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
|prvSearchAvailability|Search Availability|Service Management > Miscellaneous Privileges|

The following table lists additional privileges that are required to view some of the default views used inside the Dynamics 365 App for Outlook forms. Without these privileges, a user might see the following error instead of the expected view (subgrid) of records:

> You do not have permission to access these records. Contact your Microsoft Dynamics 365 administrator for help.

| Privilege name| Entity| Location (tab) within security role|
|---|---|---|
|prvReadIncident|Case|Service|
|prvReadOpportunity|Opportunity|Core Records|
|prvReadCompetitor|Competitor|Sales|
|prvReadConnection|Connection|Core Records|
