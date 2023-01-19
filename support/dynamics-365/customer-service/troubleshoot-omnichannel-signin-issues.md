---
title: Troubleshoot signin issues with Omnichannel for Customer Service
description: Provides resolutions for known issues that are related to signing in to Omnichannel for Customer Service or Customer Service workspace.
author: lalexms
ms.author: laalexan
ms.date: 01/19/2023
---

# Troubleshoot signin issues in Customer Service

This article helps you troubleshoot common errors you might encounter when signing in to Omnichannel for Customer Service or Customer Service workspace with Omnichannel enabled.

## Issue - Errors occur when I try to open Omnichannel for Customer Service or Customer Service workspace with Omnichannel enabled <a name="oc-csw-errors"></a> 

### Symptom

As an agent, when you log in to the Omnichannel for Customer Service application or when you log in on Customer Service Workspace with Omnichannel enabled, you see any an error message.

### Cause 

When you open the Omnichannel for Customer Service application or Customer Service workspace with Omnichannel enabled, the system performs various tasks, including signing in to Omnichannel, preparing for notifications, and setting your presence. If the system encounters any errors while performing these operations, they're displayed on the user interface.

#### Error messages 

  - There was a problem with your single sign-on account. Please sign out of all Microsoft Dynamics 365 apps and sign in again. If this continues, have your administrator contact Microsoft Support with client session ID.

  - Something went wrong while authenticating—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

  - We couldn't get your authentication token—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

  - We couldn't set up notifications—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

  - We couldn't set up presences—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

  - Something went wrong while setting up your workspace—please try again. If this continues, have your administrator contact Microsoft Support with the client session ID.

  - We couldn't set up presences due to missing roles — Ask your administrator to grant you Omnichannel roles. If this continues, have your administrator contact Microsoft Support with the client session ID. To learn more about security roles, see [Assign roles and enable users for Omnichannel for Customer Service](add-users-assign-roles.md). 

  - We couldn't get your authentication token — Your Teams subscription has expired, please contact your admin to renew it. If this continues, have your admin contact Microsoft Support with the Client Session ID:{0}. To resolve the issue, follow the steps in [Omnichannel provisioning fails due to expired Teams Service Principal](#omnichannel-provisioning-fails-due-to-expired-teams-service-principal).

### Resolution

Check whether **Security Defaults** is turned on. If it is turned on, the agent should have the right authentication set up. Alternatively, Security Defaults can be switched off if it isn't required.

To learn more about Security Defaults, see [What are security defaults?](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults).

If your tenant is configured with Azure Security Defaults, make sure your users have multi-factor authentication set up on their accounts. Otherwise, they might run into a single sign-on error. More information: [What are security defaults ?](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults)
