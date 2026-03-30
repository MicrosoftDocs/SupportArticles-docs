---
title: Conditional Access and MFA in Power Automate Flows
description: Conditional access and MFA settings can disrupt Power Automate flows across SharePoint, Teams, and Excel. Learn how to align policies and fix authentication errors.
ms.reviewer: sranjan, hamenon, cgarty, v-shaywood
ms.date: 03/30/2026
ms.custom: has-azure-ad-ps-ref, sap:Administration\Power Automate management for admins
---
# Recommendations for conditional access and multifactor authentication in Microsoft Power Automate (Flow)

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4467879

## Summary

[Conditional Access](/azure/active-directory/conditional-access/overview) and [multifactor authentication (MFA)](/azure/active-directory/authentication/concept-mfa-howitworks) policies in Microsoft Entra ID can cause authentication errors, broken connections, and failed flow runs in Microsoft Power Automate. These problems commonly occur if Conditional Access requirements don't match across Power Automate and the services it connects to, such as SharePoint, Teams, and Excel. This article provides recommendations for how to configure Conditional Access policies, explains common problems such as `AADSTS50076` errors and [Terms of Use](/entra/identity/conditional-access/terms-of-use) conflicts, and describes how to fix broken connections in embedded experiences.

## Recommendations

- To avoid authentication failures when users access Power Automate from SharePoint, Teams, or Excel, target the **Office 365** app or **All cloud apps** in your Conditional Access policy. This approach ensures consistent requirements across Power Automate and the apps that embed it. If you target individual applications instead, you must make sure that all Conditional Access requirements (MFA, Terms of Use, device compliance) match across all apps. For more information, see [Using Power Automate features embedded in other Microsoft services](#using-power-automate-features-embedded-in-other-microsoft-services).
- If your Conditional Access policies include [Terms of Use](/entra/identity/conditional-access/terms-of-use) grant controls, exclude service accounts and dedicated flow connection owners from those policies. Power Automate connections refresh tokens silently in the background. They can't present the Terms of Use acceptance UI. For more information, see [Terms of Use policies break existing flow connections](#terms-of-use-policies-break-existing-flow-connections).
- Don't use the [**remember multifactor authentication**](/entra/identity/authentication/howto-mfa-mfasettings#remember-multi-factor-authentication) feature for trusted devices. We recommend that you avoid the feature because token lifetimes shorten and force connections to refresh at the interval you configured instead of at the standard extended length.
- To avoid policy conflict errors, make sure that users who sign in to Power Automate use criteria that match the policies for the connections that a flow uses.

## Details

Manage Conditional Access policies through the Azure portal. These policies might include several requirements, such as (but not limited to) the following conditions:

- Users must sign in by using [multifactor authentication (MFA)](/azure/active-directory/authentication/concept-mfa-howitworks) (typically password plus biometric or other device) to access some or all cloud services.
- Users can access some or all cloud services from only their corporate network and not from their home networks.
- Users can use only approved devices or client applications to access some or all cloud services.

The following screenshot shows an MFA policy example that requires MFA for specific users when they access the Azure management portal.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/require-mfa-for-azure-portal.png" alt-text="Screenshot of an example that requires M F A for the specific users when they access the Azure portal.":::

You can also open the MFA configuration from the Azure portal. To do this, select **Microsoft Entra ID** > **Users and groups** > **All users** > **Multi-Factor Authentication**, and then configure policies by using the **service settings** tab.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/mfa-azure-portal.png" alt-text="Screenshot of the steps to open the M F A configuration pane from the Azure portal.":::

You can also configure MFA from **Microsoft 365 admin center**. A subset of Microsoft Entra MFA capabilities is available to Office 365 subscribers. For more information about how to enable MFA, see [Set up multifactor authentication for Office 365 users](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication).

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/mfa-admin-center.png" alt-text="Screenshot that shows that M F A can be configured from Microsoft 365 admin center.":::

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/remember-multi-factor-authentication-option.png" alt-text="Screenshot of the remember multifactor authentication option details.":::

The **remember multifactor authentication** feature can help reduce the number of user sign-ins by using a persistent cookie. This policy controls the Microsoft Entra settings that are documented in [Remember multifactor authentication for trusted devices](/entra/identity/authentication/howto-mfa-mfasettings#remember-multi-factor-authentication).

Unfortunately, this setting changes the token policy settings that make the connections expire every 14 days. This change is one of the common reasons why connections fail more frequently after MFA is enabled. We recommend that you don't use this setting.

## Effects on the Power Automate portal and embedded experiences

This section details some of the adverse effects that conditional access can have on users in your organization who use Power Automate to connect to Microsoft services relevant to a policy.

### Failure on future runs

If you enable a Conditional Access policy after you create flows and connections, the flows fail on future runs. Owners of the connections see the following error message in the Power Automate portal when they investigate the failed runs:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access \<service>.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/error-details.png" alt-text="Screenshot of the error details, including Time, Status, Error, Error Details, and how to fix the error.":::

When users view connections on the Power Automate portal, they see an error message that resembles the following message:

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/status-error.png" alt-text="Screenshot of the error Failed to refresh access token for service users see in the Power Automate portal." border="false":::

To resolve this issue, users must sign in to the Power Automate portal under conditions that match the access policy of the service that they're trying to access (such as multifactor, corporate network, and so on), and then repair or re-create the connection.

### Automatic connection creation failure

If users don't sign in to Power Automate by using criteria that match the policies, the automatic connection creation process fails to first-party Microsoft services that Conditional Access policies control. Users must manually create and authenticate the connections by using criteria that match the conditional access policy of the service that they try to access. This behavior also applies to 1-click templates that are created from the Power Automate portal.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/automatic-connection-creation-error.png" alt-text="Screenshot of the automatic connection creation error with AADSTS50076.":::

To resolve this issue, users must sign in to the Power Automate portal under conditions that match the access policy of the service they try to access (such as multifactor, corporate network, and so on) before they create a template.

### Users can't create a connection directly

If users don't sign in to Power Automate by using criteria that match the policies, they can't create a connection directly, either through Power Apps or Flow. Users see the following error message when they try to create a connection:

> AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication to access \<service>.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/aadsts50076-error.png" alt-text="Screenshot of the AADSTS50076 error when you try to create a connection.":::

To resolve this issue, users must sign in under conditions that match the access policy of the service that they're trying to access, and then re-create the connection.

### People and email pickers on the Power Automate portal fail

If Exchange Online or SharePoint access is controlled by a Conditional Access policy, and if users don't sign in to Power Automate under the same policy, people and email pickers on the Power Automate portal fail. Users can't get complete results for groups in their organization when they perform the following queries (Office 365 groups won't be returned for these queries):

- Trying to share ownership or run-only permissions to a flow
- Selecting email addresses when building a flow in the designer
- Selecting people in the **Flow Runs** panel when selecting inputs to a flow

### Using Power Automate features embedded in other Microsoft services

When you embed a flow in Microsoft services such as SharePoint, Power Apps, Excel, and Teams, Power Automate performs a token exchange with the embedding app to authenticate API calls. In order for this exchange to succeed, the Conditional Access and MFA requirements must be consistent between the embedding app and Power Automate.

If the requirements differ (for example, if MFA is required for Power Automate but not for SharePoint, or vice versa), the token exchange fails. In this situation, users see an authentication error (typically `AADSTS50076`) when they try to view or run flows from the embedded surface.

#### Cause

If you configure Conditional Access to target individual applications instead of the **Office 365** app or **All cloud apps**, you must ensure MFA requirements match across all of them. Common scenarios that cause a mismatch include:

- An admin creates a Conditional Access policy requiring MFA for Power Automate only, without matching policies for SharePoint or Teams.
- An admin creates a Conditional Access policy requiring MFA for SharePoint but not for Power Automate.
- An admin targets specific apps inconsistently when migrating between Conditional Access policies.

#### Solution

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **Protection** > **Conditional Access** > **Policies**.
1. Switch your policy to target the **Office 365** app or **All cloud apps** for consistent enforcement.
1. If you must target individual apps, verify that **Microsoft Flow Service** (Application ID: `7df0a125-d3be-4c96-aa54-591f83ff541c`) is included together with the host applications (SharePoint, Teams, Excel).

After they update policies, affected users must sign out and sign back in for the changes to take effect.

### Sharing flows by using SharePoint lists and libraries

When you try to share ownership or run-only permissions by using SharePoint lists and libraries, Power Automate can't provide the display name of the lists. Instead, it displays the unique identifier of a list. The owner and run-only tiles on the flow details page for already-shared flows can display the identifier, but not the display name.

More importantly, users might also be unable to discover or run their flows from SharePoint. This limitation exists because, currently, Power Automate doesn't pass Conditional Access policy information to SharePoint to enable SharePoint to make an access decision.

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/add-a-sharepoint-list-or-library-as-owner.png" alt-text="Screenshot that shows how to share flows by using SharePoint lists and libraries.":::

:::image type="content" source="media/conditional-access-and-multi-factor-authentication-in-flow/owner-see-site-url-and-list-id.png" alt-text="Screenshot that shows the site U R L and the list that ID owners can see.":::

### Creation of SharePoint out-of-box flows

Conditional Access policies are related to [Sharing flows by using SharePoint lists and libraries](#sharing-flows-by-using-sharepoint-lists-and-libraries). These policies can block the creation and execution of SharePoint out-of-box flows, such as the _Request Signoff_ and _Page Approval_ flows. [Control access to SharePoint and OneDrive data based on network location](/sharepoint/control-access-based-on-network-location) indicates that these policies can cause access problems that affect both first-party and third-party apps.

This scenario applies both to the network location and to Conditional Access policies (such as Disallow Unmanaged Devices). Support for the creation of SharePoint out-of-box flows is currently in development. The article will be updated when this support becomes available.

In the meantime, create similar flows yourself, and manually share these flows with the desired users. Or, if this functionality is required, disable conditional access policies.

### Terms of Use policies break existing flow connections

When an administrator adds a [Terms of Use](/entra/identity/conditional-access/terms-of-use) requirement to a Conditional Access policy after flows are already running, existing connections break. Power Automate connections refresh tokens silently in the background, and the silent token refresh process can't present the Terms of Use acceptance page to the user. The connection enters an error state, and all flows that use it stop working.

#### Symptoms

- Flows that were previously working stop working and generate connection errors.
- The connection shows a status of "Failed to refresh access token for service" in the Power Automate portal.
- The flow was created and working before the Terms of Use policy was added.
- Microsoft Entra sign-in logs show `AADSTS50158` (external security challenge not satisfied) or `AADSTS53003` (access blocked by Conditional Access policies) for the **Microsoft Flow Service** resource.

> [!NOTE]
> Unlike MFA errors, Terms of Use failures don't produce a specific AADSTS error code. The `AADSTS50158` and `AADSTS53003` codes are generic Conditional Access errors. To verify that Terms of Use is the cause, check the **Conditional Access** tab of the Microsoft Entra sign-in logs, and look for a Terms of Use grant control that has a status of **Not Satisfied.**

#### Cause

This problem can be caused by one of the following scenarios:

- **Retroactive policy**: Admin adds a Terms of Use requirement to a service (such as SharePoint or Exchange) that existing flow connections already use. Connections break on the next token refresh.
- **Consent expiry**: Admin configures Terms of Use by setting **Expire consents** on a schedule (monthly, quarterly) or a rolling re-acceptance window (for example, every 30 days). Connections break every time that consent expires, and the user must interactively re-accept.
- **Per-device Terms of Use**: Admin enables "Require users to consent on every device." Flow execution occurs on Microsoft cloud infrastructure, not on a user's registered device. Therefore, the device-level consent can never be satisfied.

#### Solution

1. Require the flow owner to sign in interactively to the [Power Automate portal](https://make.powerautomate.com). Signing in triggers the Terms of Use acceptance prompt.
1. Repair or re-create the affected connection.
1. If Terms of Use has a recurring expiry schedule, repeat this process every time consent expires.

#### Prevention

- Exclude service accounts and dedicated flow connection owners from Conditional Access policies that include Terms of Use grant controls. For more information, see [Terms of Use](/entra/identity/conditional-access/terms-of-use).
- If Terms of Use must apply to flow users, target **All cloud apps** so that acceptance during any interactive sign-in (such as Outlook or Teams) also covers Power Automate.
- Avoid configuring **Expire consents** by settng short durations if Power Automate flows are in scope. Every expiry breaks all connections for affected users.
- Never use **per-device Terms of Use** for applications that Power Automate connects to. Flow execution runs on Microsoft infrastructure, not on user-registered devices.
- Communicate planned Terms of Use policy changes to flow owners in advance so that they can proactively repair connections.
