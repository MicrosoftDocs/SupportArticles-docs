---
title: Error code occurs when running an attended or unattended desktop flow
description: Provides mitigation steps for the error codes that occur when running attended or unattended desktop flows.
ms.reviewer: cefriant, kenseongtan, guco, johndund
ms.date: 01/19/2024
ms.subservice: power-automate-desktop-flows
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
|WindowsIdentityIncorrect|401|Attended</br>Unattended|Check that you can sign in to the machine using the connection credentials. Below are supported format:</br>- domain\username -> domain account (domain and Microsoft Entra ID)</br>- username@domain... -> Microsoft Entra account</br>- username -> local account</br>- machine name\username -> local account</br>- local\username -> local account</br>- .\username -> local account|
|NoUnlockedActiveSessionForAttended|400|Attended|Check that you're logged in with the correct user and that the session is unlocked on the machine. For more information about this error code, see [NoUnlockedActiveSessionForAttended](troubleshoot-desktop-flow-run-queue-errors.md#nounlockedactivesessionforattended).|
|SessionCreationError|400|Unattended|We couldn't create the session on the machine for an unknown reason. Check the following:<br>- Ensure that you can remote desktop to the machine from another machine on your network. If you're using a Windows server, you can try to remote desktop to "localhost" from the local machine itself when logged in as another account. If these fail, use [general remote desktop troubleshooting](/troubleshoot/windows-server/remote/rdp-error-general-troubleshooting).<br>- Ensure that no third-party software is installed that may affect login or interfere with creating a remote desktop connection.<br>- If you have a legal notice enabled for login, work with your system administrator to try disabling it.|
|SessionCreationWinLogonFailure|400|Unattended|We can't create a Windows session to run your unattended desktop flow. You need to restart your machine.|
|SessionExistsForTheUserWhenUnattended|400|Unattended|Check that you aren't logged in with the same user (regardless of the state of the session) on the machine. For more information about this error code, see [SessionExistsForTheUserWhenUnattended](troubleshoot-desktop-flow-run-queue-errors.md#sessionexistsfortheuserwhenunattended).|
|SessionNotFound|400|Unattended|The Windows session on the machine for the given run can't be found. This issue can occur in the following cases:<br>- The machine reboots during the run.<br>- You're using a virtual machine that was cloned after installing Power Automate. If it was cloned after the installation, you need to re-register the machine.|
|TooManyActiveSessions|400|Unattended|Windows Server only.</br>You need to sign out at least one active session on the machine.|
|ExistingRecordingSession|400|Local|Windows Server only.</br> Check that there's no other user connected to the machine launching a recording or a test playback.|
|LocalPlaybackOrRecordingOngoing|429|All|Check that there's no recording nor test playback ongoing on the machine for the same user session.|
|UnattendedUnsupportedWithOldConnection|403|Unattended|You need to create a new connection on the portal.|
|RDPIsNotEnabled|400|Unattended|You need to enable Remote Desktop on the machine.|
|UIFlowAlreadyRunning|429|Attended</br>Unattended|A desktop flow is already running on the machine. You need to wait for its completion. For more information about this error code, see [UIFlowAlreadyRunning](troubleshoot-desktop-flow-run-queue-errors.md#uiflowalreadyrunning).|
|AadLogonFailure|400|Unattended|You need to disable Network Level Authentication (NLA) on the machine if you want to use Microsoft Entra credentials.|
|Win10AlreadyHasActiveSession|400|Unattended|Windows 10 only. You need to sign out from the active session on the machine.|
|UIFlowAgentNotAvailable|400|Attended</br>Unattended|You need to confirm that the service uiflowservice is up and running on your machine. If you have the following error when trying to start uiflowservice, see [Desktop flows failure](https://support.microsoft.com/help/4564550/):</br>**Windows could not start the UIFlowService service on Local Computer. Error 1069: The service did not start due to a logon failure**|
|UnableToCallCrlEndpoint|400|Attended</br>Unattended|You need to ensure the revocation list for the certificates can be checked. Ensure that the CRL services aren't blocked on the target machine. The services that must be contacted are listed in this article: [Limits for automated, scheduled, and instant flows](/power-automate/limits-and-config#ui-flows-required-services)|
|NoListenerConnected|404|Attended</br>Unattended|The endpoint wasn't found. There are no listeners connected to the endpoint.</br> Check that your machine is online.|
|ConnectionNotEstablished|404|Attended</br>Unattended|The endpoint wasn't found. None of the connected listeners accepted the connection within the allowed timeout.</br> This error code can be caused by routing or firewall configuration issues. Check that your machine is online and can communicate with the required Power Automate endpoints.|
|DnsError|404|Attended</br>Unattended|The endpoint wasn't found.</br> Register your machine again and schedule new runs.|
|ConnectionTimeout|404|Attended</br>Unattended|This request operation didn't receive a reply within the configured timeout.</br> Check that your machine is online and can communicate with the required Power Automate endpoints.|
|EndpointDoNotExist|404|Attended</br>Unattended|The endpoint wasn't found.</br>Register your machine again and schedule new runs.|
|GroupIsEmpty|400|Attended</br>Unattended|The machine group is empty.</br> Add machines to the group, then reschedule new runs.|
|NoCandidateMachine|400|Attended</br>Unattended|The run has exceeded the queue waiting time limit.</br> Consider allocating more machines or spreading desktop flow runs to optimize wait time in the queue.|
|DesktopFlowsActionThrottled|429|Attended</br>Unattended|The desktop flow action failed because of throttling. This error code appears when too many desktop flows use the same connection. Check your connection usage and assign your desktop flows to multiple connections.|
|DesktopFlowsActionTimeout|400|Attended</br>Unattended|The execution of the desktop flow action exceeded maximum duration.</br> Increase the time-out value that's set on the action or split the desktop flow into several shorter desktop flows.|
|OnPremiseDataGatewayNotAvailable|502|Attended</br>Unattended|This error code only occurs when using an on-premises data gateway (deprecated) to connect to the machine. Check that the targeted machine and the data gateway on that machine are up and running.|
|AuthTokenNotYetValid|401|Attended</br>Unattended|This can happen if the group password is created from a machine that has a clock indicating a time in the future for the machine that sent that error. Please ensure that all machines have an up-to-date clock and retry in a few minutes.|
|UIFlowAgentLauncherServiceIsNotRunning|500|Attended</br>Unattended|A required service is not running on the target machine. Please ensure that the **Power Automate agent launcher service** is running on the target machine.|
|TotalChunksMismatch|400|Attended</br>Unattended|When sending the required data to run the desktop flow, a corruption was detected. </br>- Ensure that there is enough free disk space on the target machine to run the automation. </br>- Ensure that the network connection is stable during the automation. </br>- Consider reducing the size of the script to reduce the risk of a chunks mismatch error. </br>- If the issue occurs consistently for every run，and you're running Power Automate version 2.36 or later, check if the cache folder _C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache_ exists. If it does, stop the runs from executing, and then delete the cache folder with administrator permissions.|
|DesktopFlowMalformedMachineResponse|500|Attended</br>Unattended|This error code occurs when the target machine provides an unexpected response to the cloud orchestrator. </br>- Verify that the machine has sufficient compute and memory resources while running the automation.</br>- Ensure that the network connection is stable during the automation. </br>- Ensure that you have the latest version of Power Automate for desktop installed.|
|WcfServerCrash|500|Attended</br>Unattended|This error code occurs when the machine encounters an unexpected error while answering the cloud orchestrator. </br>- Verify that the machine has sufficient compute and memory resources while running the automation.</br>- Ensure that the network connection is stable during the automation. </br>- Ensure that you have the latest version of Power Automate for desktop installed.|
|RdpPermissionNotGranted|400|Unattended|This error occurs when the user specified in the connection doesn't have permissions to create remote desktop sessions on the machine. </br>- Verify that the user in question is included in either the Administrators or Remote Desktop Users group on the machine.|
|XrmMachineGroupNotFound|404|Attended</br>Unattended|This error occurs when the machine group has been deleted. Please re-create the group and update the connection.|
|SessionCreationInvalidCredentials|400|Unattended|This error occurs when the unattended session couldn't be created with the provided credentials. This issue might occur due to an incorrectly formatted username. For Microsoft Entra joined machines, ensure the username is in the `user@domain.com` format. For domain-joined machines, the username should be in the `domain\user` format.|
