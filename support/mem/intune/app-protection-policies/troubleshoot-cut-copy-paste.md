---
title: Troubleshoot restricting cut, copy, and paste between applications
description: General steps to help troubleshoot restricting the cut, copy, and paste feature between applications.
ms.date: 01/31/2023
ms.reviewer: v-cshields, roblane-msft
search.appverid: MET150
---
# Troubleshoot restricting cut, copy, and paste between applications

The cut, copy, and paste feature is commonly used to transfer data between apps. Restricting this feature may not work as expected. To troubleshoot these issues, first ensure that the issues and configurations discussed in [Troubleshooting data transfer between apps](/troubleshoot-data-transfer.md) document are addressed.

- [Confirm that you’re using supported platforms, operating system versions, and applications.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#confirm-youre-using-supported-platforms-os-versions-and-apps)
- [Verify that the account is a corporate account and that the file is corporate data.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#verify-that-the-account-is-a-corporate-account-and-that-the-file-is-corporate-data)
- [For Android, check that the apps are in the work profile.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#for-android-check-that-the-apps-are-in-the-work-profile)
- [Confirm the expected APP settings are applied.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#confirm-the-expected-app-settings-are-applied-to-the-apps)
- [Review APP settings on the device side with Microsoft Edge.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#review-app-settings-on-the-device-side-with-microsoft-edge)
- [Compare the behavior with other devices, users, apps, and patterns.](/mem/intune/app-protection-policies/troubleshoot-data-transfer#compare-the-behavior-with-other-devices-users-apps-and-patterns)

When reviewing APP settings in the Endpoint Manager admin center, refer to the following table to make sure the desired settings are applied.

|Setting name   |Setting value   |Use case   |
|------------|------|-----------------|
|Restrict cut, copy, and paste between other apps|Block|Block copy and paste function to and from all managed apps.|
||Policy managed apps|Allow copy and paste between managed apps only. </br> Block copy and paste from managed to unmanaged apps. </br> Block copy and paste from unmanaged to managed apps.|
||Policy managed apps with **paste in**|Allow copy and paste between all managed apps. </br> Allow copy and paste from unmanaged to managed apps. </br> Block copy and paste from managed to unmanaged apps.|
||Any app|Do not restrict copy and paste between any apps, managed or unmanaged.|
|Cut and copy character limit for any app|Integer (0 - 65535)|Specify the maximum characters allowed for cut, copy, and paste with managed apps. This works as an exception when the operations are blocked by the **Restrict cut, copy, and paste between other apps** setting.|

## Common cut, copy, and paste restriction issues and scenarios

In this section, we identify common scenarios where cut, copy, and paste restrictions don’t work as expected and provide troubleshooting suggestions.

### Users can’t prevent copy/paste texts from managed to unmanaged apps

**Scenario:** Users copy texts from managed apps, such as Outlook, and try to paste them into unmanaged apps, such as Google Chrome. The pasting function is expected to be blocked however, the users are able to paste the texts into unmanaged apps.

**Action:** Check the **Restrict cut, copy, and paste between other apps** setting in both the Endpoint Manager admin center and on the device side using Microsoft Edge. It's possible that the setting is set to *Any app.* With this setting, pasting to other apps is always allowed.
- If it is set to *Policy managed apps,* copy/paste texts between managed apps is allowed while copy/paste between managed and unmanaged apps is restricted. 
- If it is set to *Policy managed apps with paste in,* copy/paste between managed apps and copy/paste from unmanaged apps to managed apps is allowed, but copy/paste from managed apps to unmanaged apps is restricted.

### Users cannot paste texts between managed apps

**Scenario:** Users copy texts from managed apps, such as Outlook, and try to paste them into managed apps, such as Word, Excel, or PowerPoint. The pasting function is expected to be allowed however, users find they can’t paste texts into managed apps.

**Action:** Check the **Restrict cut, copy, and paste between other apps** setting in both the Endpoint Manager admin center and on the device side using Microsoft Edge. It’s possible that the setting is set to *Blocked.*

Also, make sure the document you are pasting into is not opened from a managed location, such as OneDrive for Business or SharePoint Online. New documents in Word, Excel, PowerPoint are not protected by app protection policies.

For common scenarios where APP is not applied, refer to [Common usage scenarios in Troubleshooting app protection policy user issues](/mem/intune/app-protection-policies/troubleshoot-mam#common-usage-scenarios).
