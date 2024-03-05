---
title: How to configure Android enterprise devices in Microsoft Intune 
description: This guide describes how to configure Android enterprise devices in Microsoft Intune.
keywords:
author: helenclu
ms.author: luche
ms.date: 12/05/2023
ms.reviewer: kaushika, mandia
search.appverid: MET150
ms.custom: 
- intune-azure
- CI 114553
---

# End-to-end guide for configuring Android enterprise devices in Microsoft Intune 

This guide helps administrators understand how to configure and troubleshoot Android enterprise devices in a Microsoft Intune environment. It covers the following common scenarios:

- Onboarding to Google
- Application deployment
- Enabling work profile enrollment
- Configuring conditional access
- The work profile enrollment end-user experience
- Issuing a work profile passcode reset 

It helps you decide which management capability is the best for your organization and provides a FAQ about Android enterprise.

## Evaluate your needs

Before you enable Android enterprise devices in Intune, you must determine whether you want to enroll those devices as personal devices (Bring Your Own Device, or BYOD) or as corporate devices. 

### BYOD devices

BYOD devices are set up to have an Android Enterprise work profile. This feature is built into Android 5.1 and later versions. This feature allows work apps and data to be stored in a separate, self-contained, company-managed space on the device. Because personal apps and data remain on the device inside the user's personal profile, employees can continue to use their device as they usually would.

### Corporate devices

There are two options for corporate-owned devices, and each of them serves a unique use case:

- **Dedicated devices** (formerly known as COSU, or Corporate Owned Single Use). 

   > [!NOTE]
   > The example used in this guide focuses on BYOD scenarios. For more information about dedicated devices (COSU) scenarios, see [COSU Configuration and Enrollment using the QR code enrollment method](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/COSU-Configuration-and-Enrollment-using-the-QR-code-enrollment/bc-p/286905).

   Dedicated devices are typically locked to a single app or set of apps (also known as kiosk mode). It allows the administrator to control things such as the status bar, keyboard layouts, the lock screen, and other settings on the device. It prevents users from enabling other apps or changing certain settings on dedicated devices. 

   > [!NOTE]
   > Devices that you manage in this manner are enrolled in Intune without a user account and aren't associated with any end-user. They aren't intended for personal use applications or apps that have a strong requirement for user-specific account data such as Outlook or Gmail.

- **Fully managed devices** (formerly known as COBO, or Corporate Owned Business Only). 

   > [!NOTE]
   > For more information about fully managed devices, see [Set up Intune enrollment of Android Enterprise fully managed devices](/mem/intune/enrollment/android-fully-managed-enroll).

   Fully managed devices fit into a more user-centric scenario. A single user is associated with the device while the admin still retains full control over the device (as opposed to a work-profile scenario, in which multiple users have control).

When you decide how to enroll your devices, be aware that not all features are available for both methods. The following table shows some key differences.


| Feature set | Work profile (BYOD) | Dedicated (kiosk) | Fully managed |
| ----- | :-----: | :-----: | :-----: |
| Managed Email Profile |    ✓|    × | ✓ |
| Managed Wi-Fi Profile |   ✓ |    ✓ | ✓ |
|Managed VPN Profile |    ✓ |    × | ✓ |
|SCEP Certificate Profile |    ✓ |  ✓ | ✓ |
|PKCS Certificate Profile |    ✓ |    × | ✓ |
|Trusted Certificate Profile |    ✓ |    ✓ | ✓ |
|Custom Profile |    ✓ |    × | x |
|Prevent Factory Reset |    × |    ✓ | ✓ |
|Block Camera & Screen capture |    ✓ |    ✓ | ✓ |
|Block Volume Buttons |    × |    ✓ | ✓ |
|Block Copy and Paste / Data Sharing |    ✓ |    ✓ | ✓ |
|Managed Password |    ✓ |    ✓ | ✓ |
|Managed Applications (Required) |    ✓ |    ✓ | ✓ |
|Managed Applications (Available) |    ✓ |    × | ✓ |
|Containerized Profile |    ✓ |    × | x |
|Kiosk Level Device Management |    × |    ✓ | x |
|Personal Device Management |    ✓ |    × | x |
|NFC-Based Enrollment  |   × |    ✓ | ✓ |
|Token-Based Enrollment |    × |    ✓ | ✓ |
|QR Code-Based Enrollment |    × |    ✓ | ✓ |
|Zero Touch |    × |    ✓ | ✓ |
|Compliance/Conditional Access |    ✓ |    × | ✓ |

For more information, see [Implement your Microsoft Intune plan](/mem/intune/fundamentals/planning-guide-onboarding).

## Connect an Intune account to an Android enterprise account

The first step to configure Android enterprise in your environment is to connect your Intune tenant account to your Android enterprise account:

1. Create a Google service account (@gmail.com).
   > [!NOTE]
   > This account will be associated with all Android enterprise management tasks for your tenant. It is the Google account that your company's IT admins will share to manage and publish apps in the Google Play console. You can use an existing Google account or create a new one. The account that you use must not be associated with a G-Suite domain.

2. Sign in to the [Microsoft Intune admin center](https://endpoint.microsoft.com/) by using your Intune-licensed Global Administrator account.

3. Go to **Devices** > **Android** > **Android Enrollment** > **Managed Google Play**, select **I agree**, and then select **Launch Google to connect now** to open the Managed Google Play website.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/launch-google-connect.png" alt-text="Screenshot of the Managed Google Play page, where you can launch Google to connect." lightbox="media/configure-android-enterprise-devices-intune/work-profile-settings.png":::

4. Sign in to your Google account, and then select **Get started**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/get-started.png" alt-text="Select Get started page.":::

5. Enter your business name, and then select **Next**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/business-name.png" alt-text="Enter your business name page.":::

6. Accept the terms, and then select **Confirm**.

7. Select **Complete Registration**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/complete-registration.png" alt-text="Select Complete Registration page.":::

For more information, see [Connect your Intune account to your Managed Google Play account](/mem/intune/enrollment/connect-intune-android-enterprise).

## Deploy applications

After your Intune account is connected to your Android enterprise account, you can deploy some applications by following these steps: 

1. Sign in to the [Microsoft Intune admin center](https://endpoint.microsoft.com/) by using your Intune-licensed Global Administrator account.

2. Go to **Apps** > **All apps** > **Add**. 

 
3. In the **Select app type** pane, locate the available **Store app** types, and then select **Managed Google Play app**.

4. Select **Select**. The **Managed Google Play** app store is displayed.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/managed-google-play.png" alt-text="The Managed Google Play app store.":::

5.    Search for an app to view the app details. Example: Intune Company Portal app.

6. On the page that displays the app, select **Approve**. A window for the app opens and prompts you to give permissions for the app to perform various operations.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/approve-app.png" alt-text="Select Approve in the example Intune Company Portal.":::

7.    Select **Approve** again to accept the app permissions.

        :::image type="content" source="media/configure-android-enterprise-devices-intune/accept-app-permissions.png" alt-text="Select Approve again to accept the app permissions.":::

8.    On the **Approval Settings** tab, select **Keep approved when app requests new permissions**, and then select **Save**.

        :::image type="content" source="media/configure-android-enterprise-devices-intune/approval-setting.png" alt-text="Select Keep approved when app requests new permissions under the Approval Settings tab.":::

9.    Click **Select** to select the app.

10. Select **Sync** at the top to sync the app with the Managed Google Play service.

11. Select **Refresh** to update the app list and display the newly added app.

    > [!NOTE]
    > The app sync between Intune and the Managed Google Play store is manual. Therefore, you must select the **Sync** button each time that you approve a new app.

12. After the app is added to Microsoft Intune, you can assign the app to users and devices. From the [Microsoft Intune admin center](https://endpoint.microsoft.com/), go to **Apps** > **All Apps**. Look under **Manage** to see the app displayed in the list.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/all-apps.png" alt-text="All Apps page in the Microsoft Intune admin center." lightbox="media/configure-android-enterprise-devices-intune/all-apps.png":::

13. To assign the app to a group, select the app that you want to assign. In the **Manage** section of the menu, select **Properties**, and then select **Edit** next to **Assignments** to open the **Add group** pane.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/assign-app.png" alt-text="Select Properties and then Assignments." lightbox="media/configure-android-enterprise-devices-intune/assign-app.png":::

14. In the **Assignments** tab, under **Required**, select **Add group**, select the groups to include, and then select **Select**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/add-group.png" alt-text="Select Add group under required." lightbox="media/configure-android-enterprise-devices-intune/add-group.png":::

15. On the **Assign** pane, select **Review + save** to complete the included groups selection.

16. On the **Assignments** pane, select **Save** to save your changes.

17. Return to the **App Properties** view, and verify the app under **Assignments**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/app-properties.png" alt-text="Confirm the app assignment." lightbox="media/configure-android-enterprise-devices-intune/app-properties.png":::

For more information about app deployment, see [Add Android Enterprise system apps to Microsoft Intune](/mem/intune/apps/apps-ae-system). 

## Enable Android enterprise work profile enrollment

1. From the Intune portal, go to **Device Enrollment** > **Enrollment Restrictions**, and then select **Default** under **Device Type Restrictions**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/device-enrollment.png" alt-text="The Device Type Restrictions screen." lightbox="media/configure-android-enterprise-devices-intune/device-enrollment.png":::

2. Select **Properties** > **Select platforms**, select **Block** for **Android**, select **Allow** for **Android work profile**, select **OK**, and then select **Save** to save your changes.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/select-platforms.png" alt-text="The enrollment properties screen." lightbox="media/configure-android-enterprise-devices-intune/select-platforms.png":::

    > [!NOTE] 
    > Default restrictions have the lowest priority and apply to all users, this can't be edited. When you create additional custom restrictions, be aware of the groups to which they are assigned so that you don't create a conflict with this configuration. 

For more information, see [Set up enrollment of Android Enterprise work profile devices](/mem/intune/enrollment/android-work-profile-enroll). 

## Configure conditional access

1. Deploy the Gmail app or the Nine Work app as **Required**.

2. Create an email profile to the app by following these steps:

   1. In the Intune Azure portal, select **Device configuration** > **Profiles** > **Create profile**, and then enter **Name** and **Description** for the email profile.
   2. Select **Android enterprise** from the **Platform** drop-down list.
   3. In **Profile Type** > **Work Profile Only**, select **Email**.
   4. Configure the email profile settings.

      :::image type="content" source="media/configure-android-enterprise-devices-intune/configure-email-profile.png" alt-text="Configure the email profile settings." lightbox="media/configure-android-enterprise-devices-intune/configure-email-profile.png":::

      For more information about these settings, see [Android device settings to configure email, authentication, and synchronization in Intune](/mem/intune/configuration/email-settings-android#android-enterprise).

3. After you create the email profile, assign it to groups.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/assign-email-profile-to-groups.png" alt-text="Assignments screen." lightbox="media/configure-android-enterprise-devices-intune/assign-email-profile-to-groups.png":::

4. Configure [device-based conditional access](/intune/protect/conditional-access-intune-common-ways-use#device-based-conditional-access).

For more information, see [Set up Conditional Access for Android work profile devices](/mem/intune/protect/conditional-access-exchange-create#to-set-up-conditional-access-for-android-work-profile-devices).

## Enroll your Android enterprise device

1. Sign in with your work account, and then tap **Enroll now**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/enroll-now.png" alt-text="Enroll now screen.":::

2. On the **Access Setup** screen, tap **Continue**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/access-setup.png" alt-text="Access Setup screen.":::

3. On the privacy statement screen, tap **Continue**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/privacy-statement.png" alt-text="Privacy statement screen.":::

4. On the **What's next** screen, tap **Next**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/what-is-next.png" alt-text="What's next screen.":::

5. On the **Set up a work profile** screen, tap **Accept**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/set-up-work-profile.png" alt-text="Set up a work profile screen.":::

6. On the **Activate work profile** screen, tap **Continue**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/activate-work-profile.png" alt-text="Activate work profile screen.":::

    > [!NOTE] 
    > You can see a badge icon at the top, which means that you're now inside the work profile.

7. On the **You're all set** screen, tap **Done**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/all-set.png" alt-text="You're all set screen.":::

8. You can now sign in to Gmail. When you are prompted to update security settings, tap **UPDATE NOW**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/security-update.png" alt-text="Security update screen.":::

9. Tap **Activate** to activate Gmail as Device Administrator.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/device-administrator.png" alt-text="Device administrator screen.":::

For more information, see [Enroll Android devices](/mem/intune/enrollment/android-enroll). 

## Reset Android work profile passcodes

1. Create a device profile that requires a work profile passcode by following these steps: 

    1. In the Intune Azure portal, select **Device configuration** > **Profiles** > **Create profile**, enter **Name** and **Description** for the profile.
    2. Select **Android enterprise** from the **Platform** drop-down list.
    3. In **Profile Type** > **Work Profile Only**, select **Device Restrictions**.
    4. In **Work profile settings**, select **Require** in **Require Work Profile Password**.

       :::image type="content" source="media/configure-android-enterprise-devices-intune/work-profile-settings.png" alt-text="Work Profile properties page." lightbox="media/configure-android-enterprise-devices-intune/work-profile-settings.png":::

2. On the Android enterprise device, you will be prompted to set a work profile passcode if you haven't set one.

3. Wait until you receive a second prompt that says **Secure your Work Profile - Authorize your company support to remotely reset your work profile password**. Enter your passcode to authorize reset. It activates the reset password token that Intune needs to perform this action successfully.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/secure-work-profile.png" alt-text="Secure your work profile screen.":::

    > [!NOTE] 
    > If you skip any of these steps, you will receive the following error message:  
    > **Initiating Reset passcode failed**

4. Select **Reset passcode**.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/reset-passcode.png" alt-text="Reset passcode screen.":::

5. After reset is completed, the temporary passcode is displayed.

    :::image type="content" source="media/configure-android-enterprise-devices-intune/complete-passcode-reset.png" alt-text="Reset passcode completed screen.":::

6. Enter this temporary passcode on your device.

7. When you're required to set your new PIN, you must reenter this temporary passcode, and then enter your new PIN.

For more information about passcode reset, see [Reset Android work profile passcodes](/mem/intune/remote-actions/device-passcode-reset#reset-android-work-profile-passcodes).

## Frequently asked questions

- **Question**: Why are apps that I unapproved from the Google Play for Work store not being removed from the Mobile Apps page in the Intune Admin Portal?

  **Answer**: This behavior is expected.

- **Question**: Why are managed Google Play apps not reporting under **Discovered Apps** in the Intune portal?

  **Answer**: This behavior is expected.

- **Question**: Why are managed Google Play apps that aren't deployed through Intune displayed in the work profile?

  **Answer**: System apps can be enabled in the work profile by the device OEM at the time that the work profile is created. It isn't controlled by the MDM provider.

  To troubleshoot, follow these steps: 

  1. Collect Company Portal logs.
  2. Note any apps that appear unexpectedly in the work profile.
  3. Unenroll the device from Intune and uninstall the Company Portal.
  4. Install the [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) app that allows creation of a work profile without an EMM for testing.
  5. Follow the instructions in [Test DPC](https://play.google.com/store/apps/details?id=com.afwsamples.testdpc) to create a work profile on the device.
  6. Review apps that appear in the work profile.   
  7. If the same applications show in the Test DPC app, the apps are expected by the OEM for that device.

- **Question**: Why is the Wipe (Factory Reset) option not available for my work profile enrolled device?

  **Answer**: This behavior is expected. In the work profile scenario, the MDM provider doesn't have full control over the device. The only option available is Retire (Remove Company Data) which removes the whole work profile and all its contents.

- **Question**: Why can't I find file path Internal storage/Android/Data.com.microsoft.windowsintune.companyportal/files on my work profile enrolled device to manually collect Company Portal Logs?

  **Answer**: This behavior is expected. This path is only created for the Device Admin (Legacy Android Enrollment) scenario.

  To collect logs, follow these steps: 
   
  1. In the Company Portal app with the badge, tap **Menu** > **Help** > **Email Support**, and then tap **Send Email & Upload logs**. 
  2. When you are prompted with **Send help request with**, select one of the Email apps.   
  3. An email is generated to your IT admin with an incident ID that can be provided to Microsoft product support.

- **Question**: I checked the Managed Google Play Last Sync time and it hasn't been updated in days. Why?

  **Answer**: This behavior is expected. The sync is only triggered when you manually do so.

- **Question**: Are Web Applications supported for work profile-enrolled devices?

  **Answer**: Yes. Web apps (or web links) are supported for all Android Enterprise scenarios.

- **Question**: Is the device passcode reset supported?

  **Answer**: For work profile-enrolled devices, you can reset the work profile passcode only on devices that are running Android 8.0+ if the work profile passcode is managed and the user has allowed you to reset it. For dedicated and fully managed devices, device passcode reset is supported.

- **Question**: My device is required to be encrypted upon enrollment. Is there an option to turn off encryption?

  **Answer**: No. Encryption is required by Google for the work profile. 

- **Question**:  Why are Samsung devices blocking the use of third-party keyboards like SwiftKey?

  **Answer**: Samsung began enforcing this on Android 8.0+ devices. Microsoft is currently working with Samsung on this issue and will post new information when it's available.
