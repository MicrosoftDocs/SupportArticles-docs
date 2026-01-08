---
title: Can't enable extensions for InPrivate browsing using Group Policy in Microsoft Edge
description: Resolve issues when you can't enable extensions for InPrivate browsing through Group Policy in Microsoft Edge.
ms.custom: "sap:Manageability and Deployment\Group Policy: ADM template and MDM"
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/08/2026
---

# Can't enable extensions for InPrivate browsing using Group Policy

After deploying an extension through [Group Policy](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview) you might notice that there isn't a policy option to enable the extension for [InPrivate browsing](/legal/microsoft-edge/privacy#inprivate-browsing). This article explains why that policy option is missing, and how users can manually enable the extension for InPrivate browsing.

## Symptoms

You experience the following issue:

1. You successfully deployed an extension through Group Policy to your clients.
1. You want to enable the extension for InPrivate browsing using policy, but there's no policy option available.

## Cause

By design, it's not possible to enable extensions for InPrivate browsing through Group Policy. This restriction is intentional to protect user privacy during InPrivate browsing sessions.

## Solution

End users can manually enable extensions for InPrivate browsing by following these steps:

1. Open Microsoft Edge and go to `edge://extensions`.
2. Find the extension you want to enable for InPrivate browsing.
3. Select **Details** for the corresponding extension.
4. Select the **Allow in InPrivate** checkbox.

   :::image type="content" source="./media/enable-extension-inprivate-policy/allow-inprivate.png" alt-text="Screenshot showing the Allow in InPrivate option in Edge extension details.":::

## Related content

- [Configure extension management settings](/deployedge/microsoft-edge-browser-policies/extensionsettings)
- [Microsoft Edge - Policies](/deployedge/microsoft-edge-policies#extensionsettings)
