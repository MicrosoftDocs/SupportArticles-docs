---
title: Troubleshoot user issues for Microsoft Intune app protection policies
description: This article gives troubleshooting guidance for error messages and other common issues when using Intune app protection policies for mobile application management (MAM).
ms.date: 08/02/2021
search.appverid: MET150
ms.custom: sap:App management
ms.reviewer: kaushika, mghadial
---

# Troubleshooting app protection policy user issues

This article provides solutions to common user issues and error messages related to Intune app protection policies. It provides an explanation and solution, when available, for user issues in the following categories:

- [Common usage scenarios](#common-usage-scenarios): A user might experience these scenarios on apps that have an Intune app protection policy. They are not actual issues, but may be perceived as bugs or errors.

- [Common usage dialogs](#common-usage-dialogs): Usage dialogs a user might see in apps that have an Intune app protection policy. These messages and dialogs do *not* indicate an error or bug.

- [Error messages and dialogs on iOS](#error-messages-and-dialogs-on-ios), [Error messages and dialogs on Android](#error-messages-and-dialogs-on-android): Error messages and dialogs a user might see on apps that have an Intune app protection policy. They often indicate an error was made by the IT administrator or a bug with the app protection policy.

## Common usage scenarios

| Platform | Scenario | Explanation |
|---|---|---|
|iOS | The user can use the iOS/iPadOS share extension to open work or school data in unmanaged apps, even with the data transfer policy set to **Managed apps only** or **No apps**. Will this leak data? | Intune app protection policy can't control the iOS/iPadOS share extension without managing the device. Therefore, **Intune encrypts "corporate" data before sharing it outside the app**. You can validate it by attempting to open the "corporate" file outside of the managed app. The file should be encrypted and unable to be opened outside the managed app.|
|iOS | The user is **prompted to install the Microsoft Authenticator app**. | It is needed when App Based Conditional Access is applied, see [Require approved client app](/azure/active-directory/conditional-access/app-based-conditional-access).|
|Android | The user is **required to install the Company Portal app**, even if we use app protection without device enrollment.  | On Android, much of app protection functionality is built into the Company Portal app. **Device enrollment is not required even though the Company Portal app is always required**. For app protection without enrollment, the end user just needs to have the Company Portal app installed on the device.|
|iOS/Android | App protection policy not applied on draft email in the Outlook app | Since Outlook supports both corporate and personal context, it does not enforce MAM on draft email.|
|iOS/Android | App protection policy not applied on new documents in WXP (Word, Excel, PowerPoint) | Since WXP supports both corporate and personal context, it does not enforce MAM on new documents until they are saved in an identified corporate location like OneDrive.|
|iOS/Android | Apps not allowing Save As to Local Storage when policy is enabled | The App behavior for this setting is controlled by the App Developer.|
|Android | Android has more restrictions than iOS/iPadOS on what "native" apps can access MAM protected content | Android is an open platform and the **native** app association can be changed by the end user to potentially unsafe apps. Apply [Data transfer policy exceptions](/mem/intune/apps/app-protection-policies-exception) to exempt specific apps.|
|Android | Azure Information Protection (AIP) can Save as PDF when Save As is prevented | AIP honors the MAM policy for 'Disable printing' when Save as PDF is used.|
|iOS | Opening PDF attachments in Outlook app fails with **Action Not Allowed** | This issue can occur if the user has not authenticated to Acrobat Reader for Intune, or has used thumbprint to authenticate to their organization. Open Acrobat Reader beforehand and authenticate using UPN credentials.|

## Common usage dialogs

|Platform | Message or dialog | Explanation |
|---|---|---|
|iOS, Android | **Sign-in**: To protect its data, your organization needs to manage this app. To complete this action, sign in with your work or school account. | The end user must sign in with their work or school account in order to use this app, which requires an app protection policy. In order for the policy to apply, the user must authenticate against Microsoft Entra ID.|
|iOS, Android |**Restart Required**: Your organization is now protecting its data in this app. You need to restart the app to continue. | The app has just received an Intune app protection policy and must restart in order for the policy to apply.|
|iOS, Android |**Action Not Allowed**: Your organization only allows you to open work or school data in this app. | The IT administrator has set the **Allow app to receive data from other apps** to **Managed apps only**. Therefore, the end user can only transfer data into this app from other apps that have an app protection policy.|
|iOS, Android |**Action Not Allowed**: Your organization only allows you to transfer its data to other managed apps. | The IT administrator has set the **Allow app to transfer data to other apps** to **Managed apps only**. Therefore, the end user can only transfer data out of this app to other apps that have an app protection policy.|
|iOS, Android |**Wipe Alert**: Your organization has removed its data associated with this app. To continue, restart the app. | The IT administrator has initiated an app wipe using Intune app protection.|
|Android | **Company Portal required**: To use your work or school account with this app, you must install the Intune Company Portal app. Click "Go to store" to continue. | On Android, much of app protection functionality is built into the Company Portal app. **Device enrollment is not required even though the Company Portal app is always required**. For app protection without enrollment, the end user just needs to have the Company Portal app installed on the device.|

## Error messages and dialogs on iOS

|Error message or dialog | Cause | Remediation |
|---|---|---|
|**App Not Set Up**: This app has not been set up for you to use. Contact your IT administrator for help. | Failure to detect a required app protection policy for the app. |Make sure an iOS app protection policy is deployed to the user's security group and targets this app.|
|**Welcome to the Intune Managed Browser**: This app works best when managed by Microsoft Intune. You can always use this app to browse the web, and when it is managed by Microsoft Intune you gain access to additional data protection features. | Failure to detect a required app protection policy for the Intune Managed Browser app. <br><br>The user can still use the app to browse the web, but the app is not managed by Intune. | Make sure an iOS app protection policy is deployed to the user's security group and targets the Intune Managed Browser app.|
|**Sign-in Failed**: We can't sign you in right now. Please try again later. | Failure to enroll the user with the MAM service after the user attempts to sign in with their work or school account. | Make sure an iOS app protection policy is deployed to the user's security group and targets this app.|
|**Account Not Set Up**: Your organization has not set up your account to access work or school data. Contact your IT administrator for help. | The user account does not have an Intune A Direct license. | Make sure the user's account has an Intune license assigned in the [Microsoft 365 admin center](https://admin.microsoft.com).|
|**Device Non-Compliant**: This app cannot be used because you are using a jailbroken device. Contact your IT administrator for help. | Intune detected the user is on a jailbroken device. | Reset the device to default factory settings. Follow [these instructions](https://support.apple.com/HT201274) from the Apple support site.|
|**Internet Connection Required**: You must be connected to the Internet to verify that you can use this app. | The device is not connected to the Internet. | Connect the device to a WiFi or Data network.|
|**Unknown Failure**: Try restarting this app. If the problem persists, contact your IT administrator for help. | An unknown failure occurred. | Wait a while and try again. If the error persists, create a [support ticket](/mem/get-support) with Intune.|
|**Accessing Your Organization's Data**: The work or school account you specified does not have access to this app. You may have to sign in with a different account. Contact your IT administrator for help. | Intune detects the user attempted to sign in with second work or school account that is different from the MAM enrolled account for the device. Only one work or school account can be managed by MAM at a time per device. | Have the user sign in with the account whose username is pre-populated by the sign-in screen. You may need to [configure the user UPN setting for Intune](/mem/intune/apps/data-transfer-between-apps-manage-ios#configure-user-upn-setting-for-microsoft-intune-or-third-party-emm). <br> <br> Or, have the user sign in with the new work or school account and remove the existing MAM enrolled account.|
|**Connection Issue**: An unexpected connection issue occurred. Check your connection and try again.  |  Unexpected failure. | Wait a while and try again. If the error persists, create a [support ticket](/mem/get-support) with Intune.|
|**Alert**: This app can no longer be used. Contact your IT administrator for more information. | Failure to validate the app's certificate. | Make sure the app version is up to date. <br><br> Reinstall the app.|
|**Error**: This app has encountered a problem and must close. If this error persists, please contact your IT administrator. | Failure to read the MAM app PIN from the Apple iOS Keychain. | Restart the device. Make sure the app version is up to date. <br><br> Reinstall the app.|

## Error messages and dialogs on Android

|Dialog/Error message | Cause | Remediation |
|---|---|---|
|**App not set up**: This app has not been set up for you to use. Contact your IT administrator for help. | Failure to detect a required app protection policy for the app. |Make sure an Android app protection policy is deployed to the user's security group and targets this app.|
|**Failed app launch**: There was an issue launching your app. Try updating the app or the Intune Company Portal app. If you need help, contact your IT administrator. | Intune detected valid app protection policy for the app, but the app is crashing during MAM initialization. | Make sure the app version is up to date. <br><br> Make sure the Intune Company Portal app is installed and up-to-date on the device. <br><br> If the error persists, use the Company Portal app to send logs to Intune or create a [support ticket](/mem/get-support).|
|**No apps found**: There are no apps on this device that your organization allows to open this content. Contact your IT administrator for help. | The user tried to open work or school data with another app, but Intune cannot find any other managed apps that are allowed to open the data. | Make sure an Android app protection policy is deployed to the user's security group and targets at least one other MAM-enabled app that can open the data in question.|
|**Sign-in failed**: Try to sign in again. If this problem persists, contact your IT administrator for help. | Failure to authenticate the account with which the user attempted to sign in. | Make sure the user signs in with the work or school account that is already enrolled with the Intune MAM service (the first work or school account that was successfully signed into in this app). <br><br> Clear the app's data. <br><br> Make sure the app version is up to date. <br><br> Make sure the Company Portal version is up to date.|
|**Internet connection required**: You must be connected to the Internet to verify that you can use this app. | The device is not connected to the Internet. | Connect the device to a WiFi or Data network.|
|**Device noncompliant**: This app can't be used because you are using a rooted device. Contact your IT administrator for help. | Intune detected the user is on a rooted device. | Reset the device to default factory settings.|
|**Account not set up**: This app must be managed by Microsoft Intune, but your account has not been set up. Contact your IT administrator for help. | The user account does not have an Intune A Direct license. | Make sure the user's account has an Intune license assigned in the [Microsoft 365 admin center](https://admin.microsoft.com).|
|**Unable to register the app**: This app must be managed by Microsoft Intune, but we were unable to register this app at this time. Contact your IT administrator for help. | Failure to automatically enroll the app with the MAM service when app protection policy is required. | Clear the app's data. <br><br> Send logs to Intune through the Company Portal app or file a support ticket. For more information, see [How to get support in Microsoft Intune](/mem/get-support).|
