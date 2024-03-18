---
title: Fix Teams Rooms resource account sign-in issues
description: Troubleshoot common sign-in issues that occur when Microsoft Teams Rooms signs in to Exchange, and Microsoft Teams or Skype for Business.
ms.reviewer: matart
ms.topic: troubleshooting
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI167672
---
# Fix Teams Rooms resource account sign-in issues

Microsoft Teams Rooms signs in to Microsoft Exchange Server or Microsoft Exchange Online and Microsoft Teams or Skype for Business to fetch calendar information and join meetings. These interactions are monitored by using different signals in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com), such as **Sign in (Exchange)** and **Sign in (Teams)**. This article helps you troubleshoot common sign-in issues and issues that are related to specific signals.

## Symptoms

In the [Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com), one or more signals that are related to the sign-in process are shown as **Unhealthy**. Users also experience one or more of the following issues on the Teams Rooms device:

- The room console shows a banner at the top that indicates that the sign-in fails.
- Scheduled meetings aren't listed on the room console. This usually indicates an Exchange sign-in failure.
- The room's display name is missing.
- Although scheduled meetings are listed on the room console, the **Join** button is unavailable and you can't start an unscheduled meeting. This usually indicates a Teams or Skype for Business sign-in failure.

Additionally, Event ID 2001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. For example, the following event is logged:

> {"Description":"Network status : Healthy. **Exchange status : 80131500 : AADSTS50076. Signin status: NotApplicable. Teams Signin status: Unhealthy.**","ResourceState":"Unhealthy","OperationName":"Heartbeat","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"","DisplayName":"","AppVersion":"4.13.132.0","IPv4Address":"192.168.0.53","IPv6Address":""}

> [!NOTE]
> Every five minutes, Teams Rooms checks whether it's signed in to Microsoft Teams or Skype for Business, and whether it has network and Exchange connectivity. If one or more factors aren't true, a "2001" event is logged.
>
> - **Exchange status** indicates the sign-in status of the resource account in Exchange Online, or Exchange Server if mailboxes are hosted on-premises.
> - **Signin status** indicates the sign-in status of the resource account in Skype for Business Server. It's displayed as **NotApplicable** in Teams only mode.
> - **Teams Signin status** indicates the sign-in status of the resource account in Microsoft Teams. It's displayed as **NotApplicable** in Skype for Business only mode.

## Resolution

Sign-in issues can occur for different reasons. The following options can help you fix common issues that cause a sign-in failure.

### Check whether multi-factor authentication (MFA) is enabled

[Teams Rooms resource accounts shouldn't be configured to use MFA](/microsoftteams/rooms/rooms-authentication#modern-authentication). To check whether MFA is enabled, use one of the following options:

- Review the device log file.

  1. On the Teams Rooms device, open Event Viewer, and then go to **Applications and Services Log** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational**. Or, [download the device's diagnostic log files](/microsoftteams/rooms/rooms-manage#download-device-logs), extract the downloaded .zip file to a folder, then open the _Windows\EventLog\Microsoft-Windows-AAD_Operational.evtx_ file.
  1. Look for Event ID 1098. If you see error code **AADSTS50076** or **AADSTS50079**, it means that MFA is enabled on the resource account.

- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), if you see a **Failure** status with error code **50079** or **50076**, and the error description says "Due to a configuration change made by your administrator, or because you moved to a new location, you must enroll in multi-factor authentication to access.", it means that MFA is enabled on the resource account.

To fix this issue, contact your identity management team or see [Set up multi-factor authentication for Microsoft 365](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication) for more information.

### Check Conditional Access policies

To check whether sign-in is blocked by Conditional Access policies, use one of the following options:

- Review the device log file.

  1. On the Teams Rooms device, in Event Viewer, go to **Applications and Services Log** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational**. Or, [download the device's diagnostic log files](/microsoftteams/rooms/rooms-manage#download-device-logs), extract the downloaded .zip file to a folder, then open the _Windows\EventLog\Microsoft-Windows-AAD_Operational.evtx_ file.
  1. Look for Event ID 1098. If you see error **AADSTS53003**, it means that sign-in is blocked by Conditional Access policies.

- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), if you see an **Interrupted** status with error code **53003**, and the error description says, "Access has been blocked by Conditional Access policies. The access policy does not allow token issuance.", this means that the sign-in is blocked by Conditional Access policies.

For more information about supported Conditional Access assignments for Teams Rooms resource accounts, see [Conditional Access and Intune compliance for Microsoft Teams Rooms](/microsoftteams/rooms/conditional-access-and-compliance-for-devices). To fix the issue, contact your identity management team or see [Configure Microsoft Entra Conditional Access](/appcenter/general/configuring-aad-conditional-access) for more information.

### Check whether the resource account's password has expired

If a Teams Rooms resource account's password is set to expire after some time, it may cause sign-in failures.

To check whether the password of the resource account is expired, use one of the following options:

- Review the device log file.

  1. On the Teams Rooms device, open Event Viewer, and then go to **Applications and Services Log** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational**. Or, [download the device's diagnostic log files](/microsoftteams/rooms/rooms-manage#download-device-logs), extract the downloaded .zip file to a folder, and then open the _Windows\EventLog\Microsoft-Windows-AAD_Operational.evtx_ file.
  1. Look for Event ID 1098. If you see error code **AADSTS50055**, this means that the password is expired.

- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), if you see an **Interrupted** status, and the additional details contain the following message, it means the password has expired.

  > The user's password is expired, and therefore their login or session was ended. They will be offered the opportunity to reset it, or may ask an admin to reset it via `https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-users-reset-password-azure-portal`.

To fix this issue, reset the password by using one of the following methods, then update the password in **Settings** on the device.

- Sign in to the account in a web browser, and then reset the password.
- Ask an administrator to [reset the password](/microsoft-365/admin/add-users/reset-passwords).

To avoid having to reset the resource account password and then sign in to each Teams Rooms device again, you can [turn off password expiration](/microsoftteams/rooms/with-office-365#turn-off-password-expiration) for the account.

### Verify that you use the correct credentials

An incorrect username or password can also cause sign-in failures.

To check whether an incorrect username or password is used, use one the following options:

- Review the device log file.

  1. On the Teams Rooms device, open Event Viewer, and then go to **Applications and Services Log** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational**. Or, [download the device's diagnostic log files](/microsoftteams/rooms/rooms-manage#download-device-logs), extract the downloaded .zip file to a folder, and then open the _Windows\EventLog\Microsoft-Windows-AAD_Operational.evtx_ file.
  1. Look for Event ID 1098. If you see error code **AADSTS50126**, this means that the username or password is incorrect.
- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), if you see a **Failure** status that shows code **50126**, and the error description says "Error validating credentials due to invalid username or password," this means that the username or password is incorrect.

> [!NOTE]
> You may also receive these errors after the resource account password is expired for some time.

To fix this issue, make sure that you use the correct credentials. You can also [reset the password](/microsoft-365/admin/add-users/reset-passwords), and then update the password in **Settings** on the device.

### Check network connectivity

Teams Rooms must have access to all [standard Microsoft 365 endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true) and meet the [network requirements](/microsoftteams/rooms/rooms-prep#check-network-availability). Teams Rooms doesn't support proxy authentication.

If you don't see any sign-in attempts in [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), the connection to the Azure sign-in endpoints might be blocked. In this case, verify that you're using the correct username, and check for network connectivity issues.

If you see successful sign-in in [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), but the resource account sign-in still fails, try the following options:

1. Check if the resource account has valid licenses assigned.
1. Check if connections to Microsoft 365, Teams, or Exchange endpoints are blocked.

To troubleshoot network connectivity issues, you can use [Network Monitor](/windows/client-management/troubleshoot-tcpip-netmon) or a similar tool to collect network captures (you must [switch to Admin mode](/MicrosoftTeams/rooms/rooms-operations#switching-to-admin-mode-and-back-when-the-microsoft-teams-rooms-app-is-running) to start the tool, then switch to the *Skype* user). Then, work with your network team to identify and fix the issues.

### Check whether the room mailbox exists

Teams Rooms resource accounts must have a mailbox that's hosted on Exchange Online or Exchange Server. Otherwise, the Exchange service reports that no mailbox exists for the user during discovery.

To check whether a room mailbox exists, use one the following options:

- On the Teams Rooms device:

  1. In Event Viewer, go to **Applications and Services Logs** > **Skype Room System**.
  1. If you see Event ID 2001, check whether the description contains **Exchange status : GeneralError**.
- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), you see a **Success** status, but Exchange doesn't return any user when using the acquired token to complete discovery.

To fix this issue, follow these steps:

- Verify that the account being used is the [resource account](/microsoftteams/rooms/with-office-365?tabs=m365-admin-center%2Cazure-active-directory2-password%2Cactive-directory2-license) and is password enabled.
- If an Exchange hybrid deployment is used, make sure that the on-premises mailbox is synchronized so that redirection works correctly. For more information, see [Exchange Server hybrid deployments](/exchange/exchange-hybrid).

### Verify that the resource account has a Teams license assigned

Teams Rooms devices must have a [Teams Rooms Pro or Teams Rooms Basic license](/microsoftteams/rooms/rooms-licensing) assigned. To check whether a Teams license is assigned, use one of the following options:

- Review the device logs.

  1. [Download the device's diagnostic log files](/microsoftteams/rooms/rooms-manage#download-device-logs).
  1. Extract the downloaded .zip file to a folder, then go to the _App\Microsoft\Teams_ subfolder.
  1. Open the _Logs.txt_ file.
  1. If you see the following error message, this means that a license isn't assigned.

     > errorCode: FailedAuthentication, errorStep: get_skype_license, errorState: licenseError

- In [sign-in logs on the Azure portal](/azure/active-directory/reports-monitoring/concept-sign-ins#where-can-you-find-it-in-the-azure-portal), you see a **Success** status, but the sign-in fails when the process uses the acquired token to register the Teams service.
- Open a web browser, and sign in to Teams by using the resource account. If you receive the following error message, this means that a license isn't assigned.

  > You're missing out! Ask your admin to enable Microsoft Teams for \<Account Name\>

To fix this issue, make sure that a [Teams Rooms Pro or Teams Rooms Basic license](/microsoftteams/rooms/rooms-licensing) is assigned to the account, and that Microsoft Teams app is also applied, based on the license. For more information about license assignment, see [Assign Microsoft 365 licenses to user accounts](/microsoft-365/enterprise/assign-licenses-to-user-accounts).

## References

- [Authentication in Microsoft Teams Rooms on Windows](/microsoftteams/rooms/rooms-authentication)
- [Create resource accounts for rooms and shared Teams devices](/microsoftteams/rooms/with-office-365?tabs=m365-admin-center%2Cazure-active-directory2-password)
- [Conditional Access and compliance best practices for Microsoft Teams Rooms](/microsoftteams/rooms/conditional-access-and-compliance-for-devices#teams-rooms-conditional-access-best-practices)
- [Microsoft Entra authentication & authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes#aadsts-error-codes)
