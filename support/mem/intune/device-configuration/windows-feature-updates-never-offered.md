---
title: Windows 10 feature updates not offered on Intune-managed devices
description: Helps fix error 80070426 where feature updates are never offered on Microsoft Intune-managed Windows 10 devices that run Windows 10 version 1709 or later.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Windows 10 update rings
ms.reviewer: kaushika
---
# Feature updates are not offered on Intune-managed Windows 10 devices

This article fixes an issue in which feature updates are never offered on Microsoft Intune-managed Windows 10 devices that are running Windows 10 version 1709 or a later version.

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows 10, version 1709 or a later version.
- The computer is managed by  Microsoft Intune.
- The computer is configured to receive updates from Windows Update (typically Windows Update for Business).

In this scenario, servicing and definition updates are installed successfully. However, feature updates are never offered. Additionally, the following error entries are logged in the WindowsUpdate.log file:

> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * START * Finding updates CallerId = Update;taskhostw Id = 25  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Online = Yes; Interactive = No; AllowCachedResults = No; Ignore download priority = No  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ServiceID = {855E8A7C-ECB4-4CA3-B045-1DFA50104289} Third party service  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Search Scope = {Current User}  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Caller SID for Applicability: S-1-12-1-2933642503-1247987907-1399130510-4207851353  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Got 855E8A7C-ECB4-4CA3-B045-1DFA50104289 redir Client/Server URL: <`https://fe3.delivery.mp.microsoft.com/ClientWebService/client.asmx`>""  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Token Requested with 0 category IDs.  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; GetUserTickets: No user tickets found. Returning WU_E_NO_USERTOKEN.  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] Method failed [AuthTicketHelper::GetDeviceTickets:570]  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] Method failed [AuthTicketHelper::GetDeviceTickets:570]  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] GetDeviceTickets  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] Method failed [AuthTicketHelper::AddTickets:1092]  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] Method failed [CUpdateEndpointProvider::GenerateSecurityTokenWithAuthTickets:1587]  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] GetAgentTokenFromServer  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] GetAgentToken  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] EP:Call to GetEndpointToken  
> Misc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \*FAILED* [80070426] Failed to obtain service 855E8A7C-ECB4-4CA3-B045-1DFA50104289 plugin Client/Server auth token of type 0x00000001  
> ProtocolTalker &nbsp;\*FAILED* [80070426] Method failed [CAgentProtocolTalkerContext::DetermineServiceEndpoint:377]  
> ProtocolTalker &nbsp;\*FAILED* [80070426] Initialization failed for Protocol Talker Context  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Exit code = 0x80070426  
> Agent&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * END * Finding updates CallerId = Update;taskhostw  Id = 25

Error code 80070426 translates to the following:

> ERROR_SERVICE_NOT_ACTIVE - # The service has not been started.

## Cause

This issue occurs if the Microsoft Account sign-in assistant (MSA or wlidsvc) service is disabled. The DCAT Flighting service (ServiceId: 855E8A7C-ECB4-4CA3-B045-1DFA50104289) relies on the MSA to get the global device ID for the device. If the MSA service isn't running, the global device ID is not generated and sent by the client. Therefore, the search for feature updates never completes successfully.

## Solution

To fix this issue, follow these steps:

1. Sign in to [Microsoft Intune admin center](https://endpoint.microsoft.com/), and select **Device configuration** > **Profiles**.

1. Select the profile that's assigned to the affected Windows 10 devices, and then select **Properties** > **Device restrictions** > **Cloud and Storage**.

1. Set **Microsoft Account sign-in assistant** to **Not configured**.

   :::image type="content" source="media/windows-feature-updates-never-offered/sign-in-assistant.png" alt-text="Screenshot of the Microsoft Account sign-in assistant setting under Cloud and Storage.":::

## More information

The [Accounts/AllowMicrosoftAccountSignInAssistant](/windows/client-management/mdm/policy-csp-accounts#accounts-allowmicrosoftaccountsigninassistant) account policy was added in Windows 10, version 1703. This policy lets IT administrators disable the MSA service.

If the MSA service is disabled, Windows Update no longer offers feature updates to devices that are running Windows 10, version 1709 or a later version. For more information, see [Feature updates are not being offered while other updates are](/windows/deployment/update/windows-update-troubleshooting#feature-updates-are-not-being-offered-while-other-updates-are).
