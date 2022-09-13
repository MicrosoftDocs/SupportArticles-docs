---
title: Error code occurs when running an attended or unattended desktop flow
description: Provides mitigation steps for the error codes that occur when running attended or unattended desktop flows.
ms.reviewer: cefriant
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: power-automate-flows
---
# Error code occurs when running an attended or unattended desktop flow

This article provides the mitigation steps for the error codes that occur when running attended or unattended desktop flows.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555406

> [!NOTE]
> If the error code that you receive is not listed in the table, contact [Power Automate support](https://powerautomate.microsoft.com/support/).

|Error code|HTTP status code|Run mode|Mitigation steps|
|---|---|---|---|
|UnsupportedRpaScriptSchemaVersion|400|Attended</br>Unattended|The selected flow was issued by a later version of Power Automate for desktop. You'll need to install the latest version of Power Automate for desktop on your machine.|
|InvalidUIFlowsCertificates|401|Attended</br>Unattended|You'll need to install the latest version of desktop flows on your machine as the security certificate of the desktop flows app has expired.|
|WindowsIdentityIncorrect|401|Attended</br>Unattended|Check that you can sign in to the machine using the connection credentials. Below are supported format:</br>- domain\username -> domain account (domain and Microsoft Azure Active Directory (Azure AD))</br>- username@domain... -> Azure AD account</br>- username -> local account</br>- machine name\username -> local account</br>- local\username -> local account</br>- .\username -> local account|
|NoUnlockedActiveSessionForAttended|400|Attended|Check that you're logged in with the correct user and that the session is unlocked on the machine.|
|SessionCreationError|400|Unattended|Check requirements for unattended scenario:</br>- The user specified in your connection is a member of the Remote Desktop Users group.</br>- Remote Desktop is enabled on the computer.|
|SessionCreationWinLogonFailure|400|Unattended|We can't create a Windows session to run your unattended desktop flow. You need to restart your machine.|
|SessionExistsForTheUserWhenUnattended|400|Unattended|Check that you aren't logged in with the same user (regardless of the state of the session) on the machine.|
|TooManyActiveSessions|400|Unattended|Windows Server only.</br>You need to sign out at least one active session on the machine.|
|ExistingRecordingSession|400|Local|Windows Server only.</br>Check that there's no other user connected to the machine launching a recording or a test playback.|
|LocalPlaybackOrRecordingOngoing|429|All|Check that there's no recording nor test playback ongoing on the machine for the same user session.|
|UnattendedUnsupportedWithOldConnection|403|Unattended|You need to create a new connection on the portal.|
|RDPIsNotEnabled|400|Unattended|You need to enable Remote Desktop on the machine.|
|UIFlowAlreadyRunning|429|Attended</br>Unattended|A desktop flow is already running on the machine. You need to wait for its completion.|
|AadLogonFailure|400|Unattended|You need to disable Network Level Authentication (NLA) on the machine if you want to use Azure Active Directory (Azure AD) credentials.|
|Win10AlreadyHasActiveSession|400|Unattended|Windows 10 only. You need to sign out from the active session on the machine.|
|UIFlowAgentNotAvailable|400|Attended</br>Unattended|You need to confirm that the service uiflowservice is up and running on your machine. If you have the following error when trying to start uiflowservice, see [Desktop flows failure](https://support.microsoft.com/help/4564550/):</br>**Windows could not start the UIFlowService service on Local Computer. Error 1069: The service did not start due to a logon failure**|
|UnableToCallCrlEndpoint|400|Attended</br>Unattended|You need to ensure the revocation list for the certificates can be checked. Ensure that the CRL services aren't blocked on the target machine. The services that must be contacted are listed in this article: [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#ui-flows-required-services)|
|NoListenerConnected|404|Attended</br>Unattended|The endpoint wasn't found. There are no listeners connected to the endpoint.</br>Check that your machine is online.|
|ConnectionNotEstablished|404|Attended</br>Unattended|The endpoint wasn't found. None of the connected listeners accepted the connection within the allowed timeout.</br>This error code can be caused by routing or firewall configuration issues. Check that your machine is online and can communicate with the required Power Automate endpoints.|
|DnsError|404|Attended</br>Unattended|The endpoint wasn't found.</br>Register your machine again and schedule new runs.|
|ConnectionTimeout|404|Attended</br>Unattended|This request operation didn't receive a reply within the configured timeout.</br>Check that your machine is online and can communicate with the required Power Automate endpoints.|
|EndpointDoNotExist|404|Attended</br>Unattended|The endpoint wasn't found.</br>Register your machine again and schedule new runs.|
|GroupIsEmpty|400|Attended</br>Unattended|The machine group is empty.</br>Add machines to the group, then reschedule new runs.|
|NoCandidateMachine|400|Attended</br>Unattended|The run has exceeded the queue waiting time limit.</br>Consider allocating more machines or spreading desktop flow runs to optimize wait time in the queue.|
|DesktopFlowsActionThrottled|429|Attended</br>Unattended|The desktop flow action failed because of throttling. This error code appears when too many desktop flows use the same connection.</br>Check your connection usage and assign your desktop flows to multiple connections.|
|DesktopFlowsActionTimeout|400|Attended</br>Unattended|The execution of the desktop flow action exceeded maximum duration.</br>Increase the time-out value that's set on the action or split the desktop flow into several shorter desktop flows.|
