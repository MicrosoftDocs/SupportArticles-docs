---
title: Troubleshoot dynamic groups
description: This article helps you diagnose and resolve issues with dynamic groups.
ms.date: 04/17/2025
ms.service: entra-id
ms.custom: sap:Groups, has-azure-ad-ps-ref
ms.reviewer: mimart, v-weizhu, v-loeide, mbhargav, yuhko, barclayn
---
# Troubleshoot dynamic groups

This troubleshooting guide helps you diagnose and solve issues with dynamic groups in Microsoft Entra ID.

> [!IMPORTANT]
> Dynamic membership groups changes are usually processed within a few hours. However, processing can take more than 24 hours depending on factors such as the number of groups, the number of changes, and the complexity of the rules. For more information, see [Understanding and Managing Dynamic Group Processing in Microsoft Entra ID](/entra/identity/users/manage-dynamic-group).

## Dynamic groups identification and management

To verify whether your group is a dynamic group, see [Evaluate whether a group is a dynamic group](#1).

- **Yes**: Proceed to the next section.

- **No**: [Create a basic group and add members using Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal) or other applicable groups.

### Dynamic group creation issues

### References

Recommended articles for group creation:

- [Create a new group and add members in Azure portal](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal)
- [Create groups in PowerShell MSOnline](/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#create-groups)
- [Disable groups creation in PowerShell](/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#disable-group-creation-by-your-users)
- [Microsoft Entra administrative roles](/azure/active-directory/users-groups-roles/directory-assign-admin-roles)

Common issues in creating a dynamic group or rule:

- You're unable to create a dynamic group in the Azure portal, or you receive an error when creating a dynamic group in PowerShell. See [Cannot create a dynamic group](#4).

- You can't find the attribute to create a rule. See [Create a dynamic membership rule](#7).

- You receive a **"max groups allowed"** error when trying to create a Dynamic Group in PowerShell: You have reached 15,000 groups, the maximum limit for Dynamic groups in your tenant. To create new Dynamic groups, first delete existing Dynamic groups. There's no way to increase the maximum limit.

### Dynamic membership update issues

You've created a dynamic group and configured a rule, but encountered these common issues:

No members appear in the group, some users or devices don't appear in the group, or the wrong users or devices appear in the group.

- Visit [Troubleshoot dynamic membership update issues](#9).

Existing members of the rule are removed.

- This behavior is expected. Existing members of the group are removed when a rule is enabled or changed, or attributes are changed. The users returned from the evaluation of the rule are added as members to the group.

You don't see membership changes instantly after adding or changing a rule.

- Membership evaluation is performed periodically as a background process. The duration of the process is determined by the number of users in your directory, and the size of the group is created because of the rule. Typically, directories with small numbers of users will see group membership changes within a few minutes. Directories with a large number of users can take 30 minutes or longer to populate.

- Check the [membership processing status](/azure/active-directory/users-groups-roles/groups-create-rule#check-processing-status-for-a-rule) to confirm whether the process is complete. Check the last updated date on the group **Overview** page in Azure portal to confirm that the page is updated.

- To force the group to be processed, see [Force the group to be processed now](#18).

You receive a rule processing error.

- See [Fix a rule processing error](#19).

### Dynamic group deletion or restoration issues

You receive an error when deleting a group.

- Before you attempt to delete a group in Microsoft Entra ID, ensure that you have [deleted all assigned licenses](/azure/active-directory/users-groups-roles/licensing-group-advanced#deleting-a-group-with-an-assigned-license). For more information about group deletion in general, see [Delete a group](#21).

You restored a deleted group but didn't see any update.

- When a dynamic group is deleted and restored, it's seen as a new group and re-populated according to the rule. This process might take up to 24 hours.

## Evaluate whether a group is a dynamic group<a id="1"></a>

To determine whether a group is dynamic group:

1. Sign into the [Azure portal](https://ms.portal.azure.com/).

2. Select the group in the [Overview of Group](/azure/active-directory/enterprise-users/groups-create-rule#check-processing-status-for-a-rule) tab, then check whether the **membership type** is set to **Dynamic**.

## Validate dynamic group membership rules<a id="2"></a>

Microsoft Entra ID provides the means to validate dynamic group rules. On the **Validate rules** tab, you can validate your dynamic rule against sample group members to confirm that the rule is working as expected.

When creating or updating dynamic group rules, you can use this information to help determine whether a user or device meets the rule criteria for becoming a member of a group. This can also aid you in troubleshooting when membership isn't expected.

For more information, see [Validate a dynamic group membership rule (preview) in Microsoft Entra ID](/azure/active-directory/users-groups-roles/groups-dynamic-rule-validation)

## Troubleshoot dynamic group creation issues<a id="3"></a>

You've encountered issues when creating a dynamic group or rule.

### Cannot create a dynamic group<a id="4"></a>

You don't see option to create a dynamic group in the Azure portal, or there was an error in creating a dynamic group in PowerShell.

1. Ensure that your tenant has the appropriate license.

   - Dynamic groups require the tenant to have a Microsoft Entra ID **P1 or P2 Premium license**. For more information, check [Microsoft Entra ID license plans](https://www.microsoft.com/cloud-platform/azure-active-directory-pricing)

2. Ensure that the user creating the group has the appropriate administrator permissions:

   - Ensure that you are authorized to create a new group. Global administrators can disable group creation in the Azure portal or Access Panel. You may need an administrator create the new group for you, or give you appropriate permissions.

3. Check that group creation permissions are enabled for the type of group being created.

   - Global administrators can manage group creation permissions for security or Office 365 groups created in the Azure portal or Access Panel, by setting the  **Users can create security groups in Azure portals** or **Users can create Office 365 groups in Azure portals** settings in the Azure portal under **All groups** > **General (Settings)**. This setting applies to dynamic groups as well.

4. Check that the specific user is in the list of users that can create a group.

   - Global administrators can restrict group creation to select a group of users if you have a Microsoft Entra ID P1 Premium license. You should verify that you have the appropriate permissions.

### You get a max groups allowed error when creating a Dynamic group in PowerShell<a id="8"></a>

This error means you have reached the max limit for Dynamic groups in your tenant. Check the number of groups in the tenant. The max number of Dynamic groups per tenant is 15,000.

To create any new Dynamic groups, you'll first need to delete some existing Dynamic groups. There's no way to increase the limit.

## Troubleshoot dynamic group rule creation issues

### Cannot find the attribute to create a rule<a id="6"></a>

   1. Ensure that the user attributes are in the [list of supported properties](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#supported-properties). If they're not in the list, they're not currently supported.
   2. Ensure that the device attributes are in the [list of device attributes](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#using-attributes-to-create-rules-for-device-objects). If they're not in the list, they're not currently supported. For more information, visit [Dynamic membership rules for groups in Microsoft Entra ID](/azure/active-directory/enterprise-users/groups-dynamic-membership).

### Cannot create a dynamic membership rule<a id="7"></a>

1. Ensure that your tenant has the appropriate license. Dynamic groups require the tenant to have a Microsoft Entra ID P1 Premium license.

   - The list of Microsoft Entra ID **license plans** can be accessed at [Microsoft Entra pricing](https://www.microsoft.com/cloud-platform/azure-active-directory-pricing).

   - Enterprise Mobility + Security licensing plans can be accessed at [Enterprise Mobility+Security pricing options](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/compare-plans-and-pricing).

2. If you cannot find the built-in **User Attributes**, ensure that the attribute is in the [list of supported properties](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#supported-properties). If it's not in the list, it's not currently supported.

3. If you're looking for built-in **Device Attributes**, ensure that the attribute is in the [list of device attributes](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#using-attributes-to-create-rules-for-device-objects). If it's not in the list, it's not currently supported.

4. If the attribute isn't found in the **Simple Rule** drop-down in the Azure portal, use the **Advanced Rule** to construct a rule.

   1. Ensure that the syntax is accurate and that both the property type and value match.

   2. Also ensure that you have added the appropriate object prefix to select the property.

      - For example: **user.country**, **device.deviceOSType**.

   3. Learn about the [guidelines on how to create an Advanced Rule](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#constructing-the-body-of-an-advanced-rule) including the list of supported operators and examples for common rules.

5. Also use [Extension Attributes](/azure/active-directory/active-directory-groups-dynamic-membership-azure-portal#extension-attributes-and-custom-attributes) for dynamic user rules. These rules will be visible in the drop-down list while creating a simple rule.

   - The custom attribute name can be found in the directory by querying a user's attribute using **PowerShell**, and searching for the attribute name. These attributes could also be used when constructing an Advanced Rule.

6. Ensure that the **Role** of the user creating the Dynamic group, is either a **Company Administrator** or a **User Administrator**.

7. Allow time for the group to populate.

8. The Simple Rule builder supports up to five (5) expressions. To add more than five expressions to the rule, the text box must be used.

## Troubleshoot dynamic membership update issues<a id="9"></a>

You've created a dynamic group and configured a rule, but encountered one of these issues:

- There are no members listed in the group.
- Some users or devices don't appear in the group.
- Incorrect users or devices don't appear in the group.

### Members are not added or removed as expected<a id="10"></a>

1. Check the [membership processing status](/azure/active-directory/users-groups-roles/groups-create-rule#check-processing-status-for-a-rule) to confirm if it's complete, and check the last updated date on the group Overview page in Azure portal to confirm it's up-to-date.

2. If membership processing status is **processing error** and **update paused**, ask the administrator or PG team to resume the group from processing error.

3. Verify that the users or devices satisfy the membership rule or not, following the steps in [Evaluate dynamic membership of a user or device](#11).

4. Verify that processing status is not impacted by the issue of guest user addition disallowed by policy.

   - If the group is an Office365 group and the user is a guest user, the guest user can't be added to a group if the directory setting does not allow a guest user addition in the tenant.

   - A guest user addition error in one group will block the updates of the same and other groups in the same tenant. You can choose to:

      - Allow a guest user addition by following the **Manage guest user** setting for groups in a tenant.
      - Change the group rule to exclude a guest user by adding: `(user.userType -eq "member")`.

5. If everything looks correct, allow some time for the group to populate. Depending on the size of your tenant, the group may take up to 24 hours to populate the first time, or after a rule change.

6. If problem still exists after 24 hours and the processing status shows as complete, you can [reset the processing for the group](#18) to resolve any transient system issue.

   If the processing status shows as **in processing**, continue to wait.

### Evaluate dynamic membership of a user or device<a id="11"></a>

To evaluate whether a user or device satisfies the rule to be part of a group, use **Manual validation**.

#### Manual validation

Validate the values for user or device attributes (In [Azure portal](/azure/active-directory/fundamentals/active-directory-users-profile-azure-portal#to-add-or-change-profile-information), or using [PowerShell](/powershell/module/azuread/get-azureaduser) in the rule.

- Ensure that there are users that satisfy the rule.
- For devices, check the device properties to ensure that synchronized attributes contain the expected values.

## Manage guest user setting in office365 group<a id="13"></a>

First, [install the Azure AD PowerShell module](/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#install-the-azure-ad-powershell-module)

1. Connect to the directory. Visit [How to connect to the directory using PowerShell](/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#connect-to-the-directory) for more information.

2. Check the directory setting:

   1. Read the directory setting of the tenant: [Read settings at the directory level](/azure/active-directory/users-groups-roles/groups-settings-cmdlets#read-settings-at-the-directory-level).
   2. Check the guest user setting: As shown in the following image, if **AllowToAddGuests** is **true**, check the setting in that particular group. If **AllowToAddGuests** is **false**, no matter what group level setting is, guest users can't be added.

   :::image type="content" source="media/troubleshoot-dynamic-groups/allow-to-add-guests.png" alt-text="Screenshot to check the AllowToAddGuests setting.":::

3. Update the setting at the tenant level. To change the guest user setting at the tenant level, visit: [How to update setting at tenant level using PowerShell](/azure/active-directory/users-groups-roles/groups-settings-cmdlets#update-settings-at-the-directory-level).

4. Check the setting for the group. To change the guest user setting to your target value if applicable, visit: [How to check and update setting for a specific group using PowerShell](/azure/active-directory/users-groups-roles/groups-settings-cmdlets#update-settings-for-a-specific-group)

### Existing members of the rule are removed<a id="16"></a>

This is expected behavior. Existing members of the group are removed when a rule is enabled or changed, or attributes are changed. The users returned from evaluation of the rule are added as members to the group.

### You don't see membership changes instantly after updating a rule<a id="17"></a>

Membership evaluation is done periodically in a background process. How long the process takes is determined by multiple factors.

### Force the group to be processed now<a id="18"></a>

Reset processing for a dynamic group. In the Azure portal, manually trigger the re-processing by updating the membership rule to add a whitespace in the middle of the rule.

### Fix a rule processing error<a id="19"></a>

|Rule parser error|Error usage|Corrected usage|
|---|---|---|
|Error: Attribute not supported|(user.invalidProperty -eq "Value")|(user.department -eq "value")<br>Make sure the attribute is on the [supported properties list](/azure/active-directory/users-groups-roles/groups-dynamic-membership#supported-properties).|
|Error: Operator isn't supported on attribute|(user.accountEnabled -contains true)|(user.accountEnabled -eq true)<br>The operator used isn't supported for the property type (in this example, -contains cannot be used on type boolean). Use the correct operators for the property type.|
|Error: Query compilation error|1. (user.department -eq "Sales")(user.department -eq "Marketing")<br>2. (user.userPrincipalName -match "`*@domain.ext`")|1. Missing operator. Use -and or -or two join predicates: (user.department -eq "Sales") -or (user.department -eq "Marketing")<br>2. Error in regular expression used with -match<br>(user.userPrincipalName -match "`.*@domain.ext`")<br>or alternatively: (user.userPrincipalName -match "@domain.ext$")|

## Troubleshoot dynamic groups deletion or restoration<a id="20"></a>

Before attempting to delete a group in Microsoft Entra ID, ensure you have [deleted all assigned licenses](/azure/active-directory/users-groups-roles/licensing-group-advanced#deleting-a-group-with-an-assigned-license) to avoid errors.

(For more information about group deletion in general, see [Delete a group](#21).

### Delete a group<a id="21"></a>

1. Groups can be deleted from the directory [using the Remove-AzureADGroup cmdlet in the Azure AD PowerShell module](/azure/active-directory/users-groups-roles/groups-settings-v2-cmdlets#delete-groups).

   [!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Before attempting to delete a group in Microsoft Entra ID, ensure you have [deleted all assigned licenses  to avoid errors](/azure/active-directory/users-groups-roles/licensing-group-advanced#deleting-a-group-with-an-assigned-license).

### Restore a deleted group<a id="22"></a>

- If an Office 365 group is deleted, it can only be restored up to 30 days before permanent deletion occurs. Once permanently deleted, the group can no longer be restored. To learn more about restoring groups, see [Restore a deleted Microsoft 365 group in Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-groups-restore-azure-portal).
- This functionality isn't supported for security groups and distribution groups.
- Verify that you're authorized to restore an Office 365 group. Only Global administrators, User account administrators, Intune service administrators, , or the owner of the group can restore a group.

### You restored a deleted dynamic group, but didn't see any update

When a dynamic group is deleted and restored, it's seen as a new group and re-populated according to the rule. This process might take up to 24 hours.

## Related articles

- [Creating Dynamic Membership Rules](/azure/active-directory/users-groups-roles/groups-dynamic-membership#other-properties-and-common-rules).
- [Troubleshooting groups](/azure/active-directory/users-groups-roles/groups-troubleshooting).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
