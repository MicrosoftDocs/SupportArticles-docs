---
title: Troubleshooting when macOS devices don't register with Intune through Jamf Pro
description: Describes potential causes and troublehsooting steps to help resolve when Macs don't register with Intune through Jamf Pro.
ms.date: 12/06/2021
ms.reviewer: taveil
---
# Devices fail to register with Intune through Jamf Pro

This article explains common causes for when macOD devices fail to register with Intune through Jamf Pro, and offers troubleshooting steps to help resolve each scenario. Before you continue with these steps, see the troubleshooting prerequisites in [Troubleshooting integration of Jamf Pro with Microsoft Intune](troubleshoot-jamf.md#prerequisites).

## Cause 1 - Jamf Pro doesn't have correct permissions

The Jamf Pro enterprise application in Azure has the wrong permission or has more than one permission.
When you create the app in Azure, you must remove all default API permissions and then assign Intune a single permission of *update_device_attributes*.

**Solution**  
Review and if necessary correct the permissions for the Jamf app. If you use the Jamf Pro Cloud Connector, this app was created for you. If you manually configured the integration, you created the app in Azure AD. For the app permissions, see [Create an application (for Jamf) in Azure AD](/mem/intune/protect/conditional-access-integrate-jamf#create-an-application-in-azure-active-directory).

## Cause 2  - Wrong tenant or account

The Jamf Native macOS Connector app wasn't created in your Azure AD tenant or consent for the connector was signed by an account that doesn't have global admin rights.

**Solution**  
See the *Configuring macOS Intune Integration* section in [Integrating with Microsoft Intune](https://docs.jamf.com/10.13.0/jamf-pro/administrator-guide/Integrating_with_Microsoft_Intune.html) on docs.jamf.com.

### Cause 3 - User doesn't have valid license(s)

Lack of a valid Intune or Jamf license can result in the following error, which indicates that the Jamf license is expired:  

> Unable to connect to Microsoft Intune.  
> Check your Microsoft Intune Integration configuration.

**Solution**

- Jamf license: Contact Jamf for assistance to obtain a new license for Jamf.  
- Intune license: Assign the user a valid license or contact Microsoft or your Partner for information about how to obtain a current license.

### Cause 4  - User didn't use Jamf Self Service

For a device to successfully enroll and register with Intune through Jamf, the user must use Jamf Self Service to open the Intune Company Portal. If the user opens the Company Portal manually, the device enrolls and registers without its connection to Jamf.  

To determine which service the device used to enroll and register, look in the Company Portal app on the device. When registered through Jamf, you should receive a notification to open the Self-Service app to make changes.

In the Company Portal app, the user might see **`Not registered`**, and an entry similar to the following example might appear in the Company Portal logs:  

> Line 7783: &lt;DATE&gt; &lt;IP ADDRESS&gt; INFO com.microsoft.ssp.application TID=1  
> WelcomeViewController.swift: 253 (startLogin()) Portal launched without WPJ only arg while account is under partner management

**Solution**  

To change the registration source from Intune to Jamf:

1. [Remove the macOS device from Intune](/mem/intune/user-help/unenroll-your-device-from-intune-macos). To avoid further complications for devices that aren't fully removed from Intune, see [*Cause 6*](#cause-6) in this list of causes.

2. On the device, use Jamf Self Service to open the Company Portal app, and then register the device with Azure AD. This task requires you to have already completed the following tasks:
   - [Deploy the Company Portal app for macOS in Jamf Pro](/mem/intune/protect/conditional-access-assign-jamf#deploy-the-company-portal-app-for-macos-in-jamf-pro)
   - [Create a policy in Jamf Pro to have users register their devices with Azure AD](/mem/intune/protect/conditional-access-assign-jamf#create-a-policy-in-jamf-pro-to-have-users-register-their-devices-with-azure-active-directory)

3. When the portal opens, the first screen you see prompts you to sign in. Use your work or school account  

4. The Company Portal confirms your account information and shows your Device Enrollment and Device Compliance statuses. Yellow triangles highlight the actions you need to take to secure your macOS device for school or work. Click Begin to start enrollment.  

5. If prompted, type in your computer's sign-in information.  

It might take a few minutes to register your device. You'll receive a message after the registration is completed to let you know you're done.

### Cause 5 - Intune integration is turned off

If Intune integration is turned off, users receive a pop-up window in the Company Portal with the following message when they try to register a device:  

> Invalid command line input
> Registration-only command line flag (-r) can only be used when partner management is enabled in Intune. Please contact your IT admin.

The Jamf Pro server sends a pulse to the Intune servers when integration is turned off that tells Intune that integration is disabled.

**Solution**  
Re-enable Intune integration within Jamf Pro. See the following depending on how you configure integration:

- [Use the Jamf Cloud Connector to integrate Jamf Pro with Intune](/mem/intune/protect/conditional-access-jamf-cloud-connector)
- [Manually configure Microsoft Intune Integration in Jamf Pro](/mem/intune/protect/conditional-access-integrate-jamf#enable-intune-to-integrate-with-jamf-pro).

### Cause 6 - The device was previously enrolled in Intune

If a device is unenrolled from Jamf but not correctly removed from Intune (if it had been enrolled previously), or if the user has made several registration attempts, you might see multiple instances of the same device in the portal. This causes Jamf enrollment to fail.

**Solution**

1. On the Mac, start **Terminal**.
2. Run **sudo JAMF removemdmprofile**.
3. Run **sudo JAMF removeFramework**.
4. On the JAMF Pro server, delete the computer's inventory record.
5. Delete the device from AzureAD.
6. Delete the following files on the device if they exist:
   - /Library/Application Support/com.microsoft.CompanyPortal.usercontext.info
   - /Library/Application Support/com.microsoft.CompanyPortal
   - /Library/Application Support/com.jamfsoftware.selfservice.mac
   - /Library/Saved Application State/com.jamfsoftware.selfservice.mac.savedState
   - /Library/Saved Application State/com.microsoft.CompanyPortal.savedState
   - /Library/Preferences/com.microsoft.CompanyPortal.plist
   - /Library/Preferences/com.jamfsoftware.selfservice.mac.plist
   - /Library/Preferences/com.jamfsoftware.management.jamfAAD.plist
   - /Users/\<*username*>/Library/Cookies/com.microsoft.CompanyPortal.binarycookies
   - /Users/\<*username*>/Library/Cookies/com.jamf.management.jamfAAD.binarycookies
   - com.microsoft.CompanyPortal
   - com.microsoft.CompanyPortal.HockeySDK
   - enterpriseregistration.windows.net
   - `https://device.login.microsoftonline.com`
   - `https://device.login.microsoftonline.com/`
   - Microsoft Session Transport Key (public AND private keys)
   - Microsoft Workplace Join Key (public AND private keys)
7. Remove anything from the keychain on the device that references *Microsoft*, *Intune*,  or *Company Portal*, including DeviceLogin.microsoft.com certificates. Remove *JAMF* references except for JAMF public and private key. 
   > [!IMPORTANT]  
   > Removing the public and private key will break device enrollment.

8. Delete any of the following entries that you find:  
   - Kind: Application password ; Account: com.microsoft.workplacejoin.thumbprint
   - Kind: Application password ; Account: com.microsoft.workplacejoin.registeredUserPrincipalName
   - Kind: Certificate ; Issued by: MS-Organization-Access
   - Kind: Identity preference ; Name (ADFS STS URL if present): `https://<DNS NAME>.com/adfs/ls`
   - Kind: Identity preference ; Name: `https://enterpriseregistration.windows.net`
   - Kind: Identity preference ; Name: `https://enterpriseregistration.windows.net/`
9. Restart the Mac device.
10. Uninstall Company Portal from the device.
11. Go to portal.manage.microsoft.com and delete out all the instances of the Mac device. Wait at least 30 minutes before you go to the next step.
12. Re-enroll the device in JAMF Pro.
13. Reopen Self Service and start Registration policy.

### Cause 7 - User didn't provide JamfAAD access to their key

JamfAAD requests access to a "Microsoft Workplace Join Key" from the users' keychain. During registration, the user of a macOS device receives the following prompt to allow JamfAAD access to a key from their keychain:

>JamfAAD wants to access key "Microsoft Workplace Join Key" in your keychain. 
>To allow this, enter the "login" keychain password

**Solution**  
To successfully register the device with Azure AD, Jamf requires the user to provide their account password, and select **Allow**.

This request is similar to the request for [Mac devices prompt for keychain sign-in when you open an app](#mac-devices-prompt-for-keychain-sign-in-when-you-open-an-app), earlier in this article.  
