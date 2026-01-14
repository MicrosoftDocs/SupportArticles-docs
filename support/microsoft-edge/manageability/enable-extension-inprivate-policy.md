---
title: Learn About Group Policy Limits for InPrivate Extensions
description: Works around an issue in which Group Policy doesn't allow enabling extensions for InPrivate browsing in Microsoft Edge.
ms.custom: 'sap:Manageability and Deployment\Group Policy: ADM template and MDM'
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/08/2026
---

# Can't enable extensions for InPrivate browsing by using Group Policy

After you deploy an extension through [Group Policy](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview), you notice that there is no policy option to enable the extension for [InPrivate browsing](/legal/microsoft-edge/privacy#inprivate-browsing). This article explains why that policy option is missing, and how to manually enable the extension for InPrivate browsing.

## Symptoms

You experience the following issue
1. By using Group Policy, you successfully deploy an extension to your clients.
1. You want to enable the extension for InPrivate browsing by using a policy. However, no policy option for this configuration is available.

## Cause

By design, you can't enable extensions for InPrivate browsing through Group Policy. This restriction is intentional to protect user privacy during InPrivate browsing sessions.

## Workaround

To manually enable extensions for InPrivate browsing, follow these steps:

1. Open Microsoft Edge, and go to `edge://extensions`.
1. Find the extension that you want to enable for InPrivate browsing.
1. Select **Details** for the corresponding extension.
1. Select the **Allow in InPrivate** checkbox.

   :::image type="content" source="./media/enable-extension-inprivate-policy/allow-inprivate.png" alt-text="The Allow in InPrivate option in Edge extension details.":::

## Related content

- [Configure extension management settings](/deployedge/microsoft-edge-browser-policies/extensionsettings)
- [Microsoft Edge - Policies](/deployedge/microsoft-edge-policies#extensionsettings)
