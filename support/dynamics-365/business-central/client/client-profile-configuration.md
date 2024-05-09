---
title: Profile configuration can't be started
description: Provides troubleshooting steps to solve the personalization could not be started error during profile configuration in Dynamics 365 Business Central.
ms.custom: 
ms.date: 05/06/2024
ms.reviewer: solsen
author: SusanneWindfeldPedersen
ms.author: solsen
---
# Profile configuration can't be started in Business Central

This article provides a resolution for the "personalization could not be started" error that occurs during profile configuration in Dynamics 365 Business Central.

## Symptoms

When there are issues preventing the profile configuration in Business Central, the user gets the following error message, and can't start the profile configuration. When the configuration is started, all customization records are loaded and compiled together. If one of these records causes a compilation error, then the profile configuration can't be started.

> Sorry, something went wrong and personalization could not be started. Please try again later, or contact your system administrator.

## Resolution

> [!NOTE]
> You need tenant administrator permissions in Business Central.

As a tenant administrator, you can perform the following steps to remove the profile configurations with errors or alternatively, export the profile and fix the code issues.

> [!IMPORTANT]  
> The step described in the [Remove profile configuration records](#remove-profile-configuration-records) section will delete records with compilation errors and the specific profile configuration will be deleted. It's recommended to take a screenshot of any configuration done, before deleting them.

### Identify profile configuration

1. In Business Central, in the **Tell Me** box, enter **Profiles**, and then choose the related link.
2. Select the profile card of the profile that can't be customized, and then choose **Manage customized pages**.
3. Select the **Troubleshoot** button.

You now get the list of all records that contain errors. To proceed, [remove profile configuration records](#remove-profile-configuration-records) or [export (force) of profile configuration (from version 16.2)](#export-force-of-profile-configuration-from-version-162).

### Remove profile configuration records

To remove the identified records, select the **Manage** action to delete the profile configurations with errors.

### Export (force) of profile configuration (from version 16.2)

From Business Central version 16.2, it's possible to try to mitigate the issue by doing an export of the profile, fixing the issue, and then reimporting the profile.

1. In Business Central, in the **Tell Me** box, enter **Profiles**, and then select the related link.

2. Select the **Export Profiles** button.

    A message will display to let you know that there are errors. Select **Yes** when you're prompted to export the profiles with errors. This will download the AL code related to all profiles on the tenant.

3. Unzip the profile package that you downloaded, and open the AL file for the page customization that contains the issue.

   The page customization name follows this pattern: `PageCustomization.<target-page-name>.Configuration<id>.al`. Based on the diagnostics from the troubleshooting page, or by moving the page customization AL code into an AL app to benefit from the compiler diagnostics, locate the code block that causes the issue and remove it.

4. Create a new _.zip_ file with the fixed page customization.

5. Return to the **Profile List** page and select the **Import Profiles** button.

6. Follow the wizard's instruction and, when prompted, select the profile that was fixed in the list of profiles to import.

7. Return to the list of customized pages for this profile and verify that no errors are reported.
