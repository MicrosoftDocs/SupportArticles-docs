---
title: Conditional access and multifactor authentication in Power Automate (Flow)
description: Using conditional access has an unexpected effect on users who use Flow to connect to Microsoft services that are relevant to conditional access policies.
ms.reviewer: sranjan, hamenon, cgarty
ms.date: 02/27/2024
ms.subservice: power-automate-admin
ms.custom: has-azure-ad-ps-ref
---
# Recommendations for conditional access and multifactor authentication in Microsoft Power Automate (Flow)

[Conditional Access](/azure/active-directory/conditional-access/overview) is a feature of Microsoft Entra ID that lets you control how and when users can access applications and services. Despite its usefulness, you should be aware that using conditional access might have an adverse or unexpected effect on users in your organization who use Microsoft Power Automate (Flow) to connect to Microsoft services that are relevant to conditional access policies.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4467879

## Recommendations

- Don't use [remember multifactor authentication for trusted devices](/entra/identity/authentication/howto-mfa-mfasettings#remember-multi-factor-authentication) because token lifetimes will shorten and cause connections to require refresh at the interval configured rather than at the standard extended length.
- To avoid policy conflict errors, ensure that users who sign in to Power Automate use criteria that match the policies for the connections a flow uses.

## Details

Conditional access policies are managed through the Azure portal and might have several requirements, including (but not limited to) the following:

- Users must sign in using [multifactor authentication (MFA)](/azure/active-directory/authentication/concept-mfa-howitworks) (typically password plus biometric or other device) to access some or all cloud services.
- Users might access some or all cloud services only from their corporate network and not from their home networks.
- Users might use only approved devices or client applications to access some or all cloud services.

The following screenshot shows an MFA policy example that requires MFA for specific users when they access the Azure management portal.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/require-mfa-for-azure-portal.png" alt-text="Screenshot shows an example that requires M F A for the specific users when accessing the Azure Management portal.":::

You can also open the MFA configuration from the Azure portal. To do this, select **Microsoft Entra ID** > **Users and groups** > **All users** > **Multi-Factor Authentication**, and then configure policies by using the **service settings** tab.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/mfa-azure-portal.png" alt-text="Screenshot shows steps to open the M F A configuration from the Azure portal.":::

MFA can also be configured from **Microsoft 365 admin center**. A subset of Microsoft Entra multifactor authentication capabilities is available to Office 365 subscribers. For more information about how to enable MFA, see [Set up multifactor authentication for Office 365 users](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication).

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/mfa-admin-center.png" alt-text="Screenshot shows that M F A can be configured from Microsoft 365 admin center.":::

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/remember-multi-factor-authentication-option.png" alt-text="Screenshot of the remember multifactor authentication option details.":::

The **remember multi-factor authentication** setting can help you to reduce the number of user logons by using a persistent cookie. This policy controls the Microsoft Entra settings that are documented in [Remember multifactor authentication for trusted devices](/entra/identity/authentication/howto-mfa-mfasettings#remember-multi-factor-authentication).

Unfortunately, this setting changes the token policy settings that make the connections expire every 14 days. This is one of the common reasons why connections fail more frequently after MFA is enabled. We recommend that you don't use this setting.

## Effects on the Power Automate portal and embedded experiences

This section details some of the adverse effects that conditional access can have on users in your organization who use Power Automate to connect to Microsoft services relevant to a policy.

### Effect 1 - Failure on future runs

If you enable a conditional access policy after flows and connections are created, flows fail on future runs. Owners of the connections will see the following error message in the Power Automate portal when they investigate the failed runs:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access \<service>.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/error-details.png" alt-text="Screenshot of the error details including Time, Status, Error, Error Details, and how to fix.":::

When users view connections on the Power Automate portal, they see an error message that resembles the following:

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/status-error.png" alt-text="Screenshot of the error Failed to refresh access token for service users see in the Power Automate portal." border="false":::

To resolve this issue, users must sign in to the Power Automate portal under conditions that match the access policy of the service that they're trying to access (such as multi-factor, corporate network, and so on), and then repair or re-create the connection.

### Effect 2 - Automatic connection creation failure

If users don't sign in to Power Automate by using criteria that match the policies, the automatic connection creation to first-party Microsoft services that are controlled by the conditional access policies fail. Users must manually create and authenticate the connections by using criteria that match the conditional access policy of the service that they try to access. This behavior also applies to 1-click templates that are created from the Power Automate portal.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/automatic-connection-creation-error.png" alt-text="Screenshot of the automatic connection creation error with AADSTS50076.":::

To resolve this issue, users must sign in to the Power Automate portal under conditions that match the access policy of the service they try to access (such as multi-factor, corporate network, and so on) before they create a template.

### Effect 3 - Users can't create a connection directly

If users don't sign in to Power Automate by using criteria that match the policies, they can't create a connection directly, either through Power Apps or Flow. Users see the following error message when they try to create a connection:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access \<service>.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/aadsts50076-error.png" alt-text="Screenshot of the AADSTS50076 error when attempting to create a connection.":::

To resolve this issue, users must sign in under conditions that match the access policy of the service that they're trying to access, and then re-create the connection.

### Effect 4 - People and email pickers on the Power Automate portal fail

If Exchange Online or SharePoint access is controlled by a conditional access policy, and if users don't sign in to Power Automate under the same policy, people and email pickers on the Power Automate portal fail. Users can't get complete results for groups in their organization when they perform the following queries (Office 365 groups won't be returned for these queries):

- Trying to share ownership or run-only permissions to a flow
- Selecting email addresses when building a flow in the designer
- Selecting people in the **Flow Runs** panel when selecting inputs to a flow

### Effect 5 - Using Power Automate features embedded in other Microsoft services

When a flow is embedded in Microsoft services such as SharePoint, Power Apps, Excel, and Teams, the Power Automate users are also subject to conditional access and multi-factor policies based on how they authenticated to the host service. For example, if a user signs in to SharePoint by using single-factor authentication, but tries to create or use a flow that requires multi-factor access to Microsoft Graph, the user receives an error message.

### Effect 6 - Sharing flows by using SharePoint lists and libraries

When you try to share ownership or run-only permissions by using SharePoint lists and libraries, Power Automate can't provide the display name of the lists. Instead, it displays the unique identifier of a list. The owner and run-only tiles on the flow details page for already-shared flows will be able to display the identifier, but not the display name.

More importantly, users might also be unable to discover or run their flows from SharePoint. This is because, currently, the conditional access policy information isn't passed between Power Automate and SharePoint to enable SharePoint to make an access decision.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/add-a-sharepoint-list-or-library-as-owner.png" alt-text="Screenshot to share flows with SharePoint lists and libraries.":::

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/owner-see-site-url-and-list-id.png" alt-text="Screenshot shows the site U R L and the list ID owners can see.":::

### Effect 7 - Creation of SharePoint out-of-box flows

Related to Effect 6, the creation and execution of SharePoint out-of-box flows, such as the _Request Signoff_ and _Page Approval_ flows, can be blocked by conditional access policies. [Control access to SharePoint and OneDrive data based on network location](/sharepoint/control-access-based-on-network-location) indicates that these policies can cause access issues that affect both first-party and third-party apps.

This scenario applies both to the network location and to conditional access policies (such as Disallow Unmanaged Devices). Support for the creation of SharePoint out-of-box flows is currently in development. We'll post more information in this article when this support becomes available.

In the interim, we advise users to create similar flows themselves, and manually share these flows with the desired users, or to disable conditional access policies if this functionality is required.
