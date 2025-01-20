---
title: Reasons for broken connections
description: Learn how to troubleshoot and resolve broken connections.
services: connectors
ms.service: power-platform
ms.workload: connectors
author: nravindra-msft
ms.author: nravindra
ms.reviewer: angieandrews
ms.topic: how-to
ms.date: 01/16/2025
---
# Reasons for broken connections

In this article, you will learn about the various reasons for broken connections and how to troubleshoot them effectively. We will cover common issues such as connection timeouts, Data Loss Prevention (DLP) blocks, invalid authenticated devices, and more. By understanding these reasons and following the provided troubleshooting steps, you can resolve connection problems and ensure a smoother experience with your applications and services.

## Reason: Connection time out

This occurs when a client (such as a web browser or an application) tries to establish a connection with a server, but the server does not respond within a specified time limit. This can happen for various reasons, such as the server being offline, network issues, or the server taking too long to process the request. When the connection times out, the client stops waiting for a response and terminates the connection attempt

Possible error string seen by users </br>
<i>-	“The user could not be authenticated as the grant is expired. The user must sign in again.”</i>

Troubleshoot </br>
1.	Check your internet connection: Ensure that the internet connection is stable and working properly.<br>
2.	Check the server status: Verify if the server you are trying to connect to is online and not experiencing any downtime.<br>
3.	Try increasing the timeout limit: Sometimes, increasing the timeout limit will help in getting the connection from the servers.

## Reason: DLP block
Reason: DLP block 
Data Loss Prevention (DLP) is a security measure that prevents sensitive information from being shared or transferred inappropriately. A DLP block occurs when a DLP policy detects that an action, such as sending an email or sharing a file, violates the organization's data protection rules. The DLP system then blocks the action to prevent potential data breaches or unauthorized access to sensitive information

Possible error string seen by users
-	“Access has been blocked by Conditional Access policies. The access policy does not allow token issuance.”
-	“Device is not in required device state: domain_joined. Conditional Access policy requires a domain joined device, and the device is not domain joined.”

Troubleshoot
1.	Review DLP policies: Check the DLP policies configured in the organization to understand what actions are being blocked and why.
2.	Consult with your admin: There might be a chance that the admin has blocked the particular connector or connection. It's a good idea to consult with them and discuss the issue to unblock it.

## Reason: Invalid authenticated devices 
Reason: Invalid authenticated devices 
This refers to a situation where a user tries to authenticate using a device for multi-factor authentication (MFA), but the device has been disabled. This issue is not related to Power Automate but rather to the tenant's configuration at the administrative level. 

Possible error string seen by users
-	“Device object was not found in the tenant 'b880eeca-f1fb-4c91-bff6-82e84350a6e6' directory.”
-	“Device is not in required device state: compliant. Conditional Access policy requires a compliant device, and the device is not compliant. The user must enroll their device with an approved MDM provider like Intune.”
-	"Device used during the authentication is disabled.”
-	“Application needs to enforce Intune protection policies.”

Troubleshoot
1.	Reach out to the tenant admin   to understand why the device was disabled and to resolve the issue
2.	Try re-authorizing the connection

## Reason: Due to inactivity for a very long duration  
Reason: Due to inactivity for a very long duration  
This refers to a situation where a connection becomes invalid because it has not been used for a specified period. For example, the SharePoint connector requires usage at least once every 90 days to remain active. If the connection is not used within this period, it will expire. The suggested troubleshooting method is to either create a new connection or reauthorize the existing one. 

Possible error string seen by users
-	 “The refresh token has expired due to inactivity. The token was issued on 2024-03-17T12:07:02.0086301Z and was inactive for 90.00:00:00.”
-	“The provided authorization code or refresh token has expired due to inactivity. Send a new interactive authorization request for this user and resource.”

Troubleshoot
1.	To troubleshoot, user must create a new connection or reauthorize the existing one.

## Reason: Connection issue related to attended mode
Reason: Connection issue related to attended mode

This refers to problems that occur when a user tries to use features that require a license for unattended mode but does not have the necessary license. In attended mode, the user must be present and interact with the system, whereas unattended mode allows for fully automated processes without user interaction. If a user without the appropriate license attempts to use unattended mode, the connection will fail. 
Learn more about Attended and unattended scenarios here: Attended and unattended scenarios for process automation - Power Automate | Microsoft Learn 

Troubleshoot
1.	The user must have the correct license to interact with the system as required in attended mode.

## Reason: Password modification by the user 
Reason: Password modification by the user 
This occurs when the account password you have added to create the connection is deleted or changed or expired. Since account verification is a crucial part of authentication whenever a connection is triggered, the connection will break if new password is not updated. To avoid this, use services like Microsoft Entra ID, learn more about it here

Possible error string seen by users
-	“The provided grant has expired due to it being revoked, a fresh auth token is needed. The user might have changed or reset their password. The grant was issued on '2022-07-06T08:47:42.5388987Z' and the TokensValidFrom date (before which tokens are not valid) for this user is '2024-08-01T12:39:32.0000000Z'.”

Troubleshoot
1.	Every time user update your password, the existing connections with those passwords would become invalid, so user must create a new connection for each of those connectors or edit the existing connection 

## Reason: AAD configuration change
Reason: AAD configuration change
This refers to modifications made at the Azure Active Directory (AAD) level that affect user identities or access policies. These changes can include moving to a new location, altering user roles, or updating security settings. Such changes can invalidate existing tokens and require users to reauthenticate. 

Possible error string seen by users
-	“Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access '00000003-0000-0000-c000-000000000000'.”

Troubleshoot
1.	User must reach out to the tenant admin to understand the specific changes and reauthorize the connection if necessary

## Reason: Connection owner account is deleted/disabled
Reason: Connection owner account is deleted/disabled
This refers to a situation where the account that created a connection is either removed or disabled in the directory. This results in the invalidation of the connection, affecting all users who shared the connection. 

Possible error string seen by users
-	“The user account {EUII Hidden} has been deleted from the 1a188ae6-a002-4149-8234-e47371d17cce directory. To sign into this application, the account must be added to the directory.”
-	" The user account is disabled.”
-	“The user account {EUII Hidden} does not exist in the 66dc1f77-2e0d-4d13-b961-7c2e63aa376b directory. To sign into this application, the account must be added to the directory.”

Troubleshoot
1.	To resolve this, another user with access can reauthorize the connection, thereby updating the ownership and restoring functionalities for all users. 

## Reason: Tenant admin disabled the app
Reason: Tenant admin disabled the app
This means that the administrator of the tenant has deactivated an application registered in Azure Active Directory (AAD). This action invalidates any service principal connections associated with the app, as the app can no longer issue tokens. To resolve this, the tenant admin needs to re-enable the app or create a new service principal connection. 

Possible error string seen by users
-	“The service principal for resource '00000003-0000-0ff1-ce00-000000000000' is disabled. This indicate that a subscription within the tenant has lapsed, or that the administrator for this tenant has disabled the application, preventing tokens from being issued for it.”

Troubleshoot
1.	To resolve this, the tenant admin needs to re-enable the app or create a new service principal connection.