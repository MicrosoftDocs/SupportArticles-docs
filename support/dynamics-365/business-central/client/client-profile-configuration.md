---
title: Profile configuration can't be started
description: Learn how to troubleshoot issues with profile configuration.
ms.custom: na
ms.date: 04/18/2024
ms.reviewer: solsen
ms.topic: troubleshooting
author: SusanneWindfeldPedersen
ms.author: solsen
---

# Profile configuration can't be started

When there are issues preventing the profile configuration in Business Central, the user gets an error message, and isn't able to start the profile configuration. When the configuration is started, all customization records are loaded and compiled together. If one of these records causes a compilation error, then the profile configuration can't be started.

## Prerequisites

You need tenant administrator permissions in Business Central.

## Symptoms

The user sees the following error message "Sorry, something went wrong and personalization could not be started. Please try again later, or contact your system administrator."

## Resolution

As a tenant administrator, you can do the following to mitigate the issue. The steps below describe how to remove the profile configurations with errors or alternatively, exporting the profile and fix the code issues.

> [!NOTE]  
> The steps in the [Removing profile configuration records](client-profile-configuration.md#removing-profile-configuration-records) section will delete records with compilation errors and the specific profile configuration will be deleted. It's recommended to take a screenshot of any configuration done, before deleting them.

### Identifying profile configuration

1. In Business Central, in the **Tell Me** box, enter **Profiles**, and then choose the related link.
2. Select the profile card of the profile that can't be customized, and then choose **Manage customized pages**.
3. Select the **Troubleshoot** button.  
  You now get the list of all records that contain errors. To proceed, select either [Removing profile configuration records](client-profile-configuration.md#removing-profile-configuration-records) or [Force export of profile configuration (from version 16.2)](client-profile-configuration.md#export-force-of-profile-configuration-from-version-162).

### Removing profile configuration records

To remove the identified records, select the **Manage** action to delete the profile configurations with errors.

### Export (force) of profile configuration (from version 16.2)

From Business Central version 16.2 it's possible to try to mitigate the issue by doing an export of the profile, fixing the issue, and then reimporting the profile.

1. In Business Central, in the **Tell Me** box, enter **Profiles**, and then choose the related link.
2. Select the **Export Profiles** button.  
  A message will display to let you know that there are errors. Select **Yes** when prompted to export the profiles with errors. This will download the AL code related to **all** profiles on the tenant.
3. Unzip the profile package that you downloaded and open the AL file for the page customization that contains the issue.  
  **Note:** The page customization name follows this pattern: `PageCustomization.<target-page-name>.Configuration<id>.al`. Based on the diagnostics from the troubleshooting page, or by moving the page customization AL code into an AL app in order to benefit from the compiler diagnostics, locate the code block that is causing the issue and remove it.
4. Create a new .zip file with the fixed page customization.
5. Return to the **Profile List** page and select the **Import Profiles** button.
6. Follow the wizard's instruction and, when prompted, select the profile that was fixed in the list of profiles to import.
7. Return to the list of customized pages for this profile and verify that no errors are reported anymore.