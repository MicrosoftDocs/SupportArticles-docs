---
title: Troubleshoot restricting cut, copy, and paste between applications
description: General steps to help troubleshoot restricting the cut, copy, and paste feature between applications.
ms.date: 02/08/2023
ms.reviewer: v-cshields, roblane-msft
search.appverid: MET150
---
# Troubleshoot restricting cut, copy, and paste between applications

The cut, copy, and paste feature is commonly used to transfer data between applications (apps). Restricting this feature may not work as expected. To troubleshoot these issues, first ensure that the issues and configurations discussed in the [Troubleshooting data transfer between apps](/troubleshoot-data-transfer.md) document are addressed.

When reviewing Intune app protection policy (APP) settings in the Endpoint Manager admin center, refer to the following table to make sure the desired settings are applied.

|Setting name   |Setting value   |Use case   |
|------------|------|-----------------|
|Restrict cut, copy, and paste between other apps|Block|Block copy and paste function to and from all managed apps.|
||Policy managed apps|Allow copy and paste between managed apps only. </br> Block copy and paste from managed to unmanaged apps. </br> Block copy and paste from unmanaged to managed apps.|
||Policy managed apps with **paste in**|Allow copy and paste between all managed apps. </br> Allow copy and paste from unmanaged to managed apps. </br> Block copy and paste from managed to unmanaged apps.|
||Any app|Doesn't restrict copy and paste between any apps, managed or unmanaged.|
|Cut and copy character limit for any app|Integer (0 - 65535)|Specify the maximum characters allowed for cut, copy, and paste with managed apps. This setting works as an exception when the operations are blocked by the **Restrict cut, copy, and paste between other apps** setting.|

## Common cut, copy, and paste restriction scenarios

In this section, we identify and provide troubleshooting suggestions for common scenarios where cut, copy, and paste restrictions don’t work as expected.

### Users can copy/paste texts from managed to unmanaged apps

**Scenario:** Users can copy text from managed apps, such as Outlook, and try to paste it into unmanaged apps, such as Google Chrome. The pasting function should be blocked, however, the users are able to paste the text into unmanaged apps.

**Action:** Check the **Restrict cut, copy, and paste between other apps** setting in both the Endpoint Manager admin center and the device using Microsoft Edge. It's possible that the setting is set to *Any app.* With this setting, pasting to other apps is always allowed.

- If you use the setting *Policy managed apps,* then:
  - copying and/or pasting text between managed apps is allowed.
  - copying and/or pasting text between managed and unmanaged apps is restricted.

- If you use the setting *Policy managed apps with paste in,* then:
  - copying and/or pasting texts between managed apps is allowed.
  - copying and/or pasting from unmanaged apps to managed apps is allowed.
  - copying and/or pasting texts from managed apps to unmanaged apps is restricted.

### Users can't copy/paste texts between managed apps

**Scenario:** Users copy text from managed apps, such as Outlook, and try to paste it into managed apps, such as Word, Excel, or PowerPoint. The pasting function should be allowed, however, users find they can’t paste the text into managed apps.

**Action:** Check the **Restrict cut, copy, and paste between other apps** setting in both the Endpoint Manager admin center and the device using Microsoft Edge. It’s possible that the setting is set to *Blocked.*

Also, when copying and pasting text from one managed app to another, make sure the document you're pasting into is opened from a managed location, such as OneDrive for Business or SharePoint Online. App protection policies don't apply to new, unsaved documents.

For more information and scenarios involving APP, see to [Common usage scenarios in Troubleshooting app protection policy user issues](/mem/intune/app-protection-policies/troubleshoot-mam#common-usage-scenarios).
