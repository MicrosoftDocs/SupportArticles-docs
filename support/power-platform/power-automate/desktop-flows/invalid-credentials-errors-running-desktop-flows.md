---
title: Invalid credentials error running desktop flows
description: Provides a resolution for the invalid credentials error that might occur when you run a desktop flow in Power Automate.
ms.reviewer: guco, johndund
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 04/03/2025
---
# Invalid credentials error when running desktop flows in Power Automate for desktop

This article provides a solution to the invalid credentials error that occurs when you [run a desktop flow from a cloud flow](/power-automate/desktop-flows/trigger-desktop-flows#trigger-a-desktop-flow-from-a-cloud-flow) in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5021155

## Symptoms

- When you create a desktop flow connection, you receive the following error message:

  > Details: Connection failed: [Machine \<Machine ID>]. There's an issue with your credentials. Check your credentials or use different credentials to connect to the machine. Correlation id: \<Correlation ID>.

  :::image type="content" source="media/invalid-credentials-errors-running-desktop-flows/connection-failed-error.png" alt-text="Screenshot of the invalid credentials error that you might receive when creating a desktop flows connection.":::
- When you run a desktop flow, you receive the `WindowsIdentityIncorrect` error code. The message associated with this error code might be "The credentials provided with the request are invalid" or something more specific.

  ```jsonc
  {
      "error":{
          "code": "WindowsIdentityIncorrect",
          "message": "The credentials provided with the request are invalid."
      }    
  }
  ```

> [!NOTE]
> If there's a connection error, the best test is to connect to the same machine with  Remote Desktop and use the same credentials that you used when creating the desktop flow.

## Cause

The error messages occur because the credentials in the connection can't authenticate on the target machine.

When you create a connection, Power Automate checks to ensure the credentials are valid. If the credentials don't authenticate on the target machine, the connection can't be made, and you receive an error describing the problem.

If you successfully created your connection earlier but now encounter an error when running your flow, it indicates that something has changed in your user account or machine. For example, your password might have expired.

## Resolution

To see an error message with specific details on what went wrong, ensure you have Power Automate version 2.24 or higher installed. Often, this method gives you enough information to solve the problem. The following table shows some specific error codes and the resolutions.

|Error code|Error message|Cause|Resolution|
|---|---|---|---|
|-1073741477|A user has requested a type of logon (for example, interactive or network) that has not been granted. An administrator has control over who can logon interactively and through the network.|The user account doesn't have logon rights on the machine, or the administrator changed the policies of the machine (check the [User Rights Assignment](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/user-rights-assignment) settings).|To solve this issue, see ["Logon type has not been granted" error when running a desktop flow or creating a connection](logon-type-has-not-been-granted.md).|
|-1073445812|The user's UPN isn't in the expected format|The user signed in using `DOMAIN\user` but should use the `user@domain.com` format instead (or vice versa).|Try to sign in using both the `user@domain.com` and `DOMAIN\user` formats.|
|-1073741062|Smart card logon is required and was not used| |Connections to machines that require smart card logons aren't supported. Use a machine without this requirement.|
|-1073741715|Bad username or authentication information| The given credentials aren't correct. This issue might occur due to an incorrect user/password combination or username format.|1. Double-check that your username and password work on the machine. You can do this by signing out and signing back in with the same credentials. </br>2. If that works, verify you're using the correct username format by running the [dsregcmd /status](/entra/identity/devices/troubleshoot-device-dsregcmd) command in the context of the desktop flow connection account. Check the `Executing Account Name` value (in the `Diagnostic Data` section) in the output and make sure it matches the username that was used. </br>3. If your machine is [Microsoft Entra joined](/entra/identity/devices/concept-directory-join) or hybrid, use the `user@domain.com` format. If your machine is domain-only joined, use the `DOMAIN\user` format. </br></br>To determine the correct username format, check your machine's join state:</br> a. Run the [dsregcmd /status](/entra/identity/devices/troubleshoot-device-dsregcmd) command. </br>b. Look for the `Device State` section in the output: </br>- If you see `AzureAdJoined : YES`, your machine is Microsoft Entra joined. </br>- If it says `NO` after `AzureAdJoined` but `YES` after `DomainJoined`, your machine is domain-only joined. |
|-1073741730|The domain isn't available| | Make sure you're using the correct username format for your machine join state. If your machine is [Microsoft Entra joined](/entra/identity/devices/concept-directory-join) or hybrid, use the `user@domain.com` format. If your machine is domain-only joined, use the `DOMAIN\user` format. </br></br>To determine the correct username format, check your machine's join state: </br>1. Run the [dsregcmd /status](/entra/identity/devices/troubleshoot-device-dsregcmd) command. </br>2. Look for the `Device State` section in the output: </br>- If you see `AzureAdJoined : YES`, your machine is Microsoft Entra joined. </br>- If it says `NO` after `AzureAdJoined` but `YES` after `DomainJoined`, your machine is domain-only joined. |
|-1073741714|User account restriction has prevented successful authentication | The referenced username and authentication information are valid, but a user account restriction, such as time-of-day restriction, has prevented successful authentications.| Confirm that no security or account restriction policies prevent his user from successfully signing in.|
|-1073741712|The user account is restricted such that it may not be used to log on from the source workstation | | Confirm that no security or account restriction policies prevent this user from successfully signing in.|

If you don't have a more specific error associated with the problem, the easiest way to troubleshoot is to sign in to the machine with the exact credentials you entered in your connection. You can try this method by signing in to the machine locally or through a Remote Desktop connection. You should receive the same error message that Power Automate receives when trying to authenticate your credentials, which should help you troubleshoot the issue.

Other reasons that might prevent you from signing in to the target machine (besides using an incorrect username or password):

- PINs aren't supported. Make sure you use a password instead of a Windows Hello PIN.
- The machine can't connect to its domain or Microsoft Entra ID (formerly Azure Active Directory) because it isn't properly joined. To solve this issue, see [Desktop flow invalid credentials error when you use a Microsoft Entra account](~/power-platform/power-automate/authentication-or-sign-in/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account.md).
- The machine can't call the authentication endpoint due to a network issue. Make sure to check your network connection.

Here are some common reasons why the user account is configured incorrectly:

- The administrator changed the account credentials.
- The domain user account wasn't propagated to the machine.
- The user account lost privileges or was disabled.
- The user account password expired.

## More information

- [Desktop flow invalid credentials error when you use a Microsoft Entra account](troubleshoot-ui-flow-invalid-credentials-error-using-aad-account.md)
- ["Logon type has not been granted" error when running a desktop flow or creating a connection](logon-type-has-not-been-granted.md)
