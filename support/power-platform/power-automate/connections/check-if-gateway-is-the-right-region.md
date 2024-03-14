---
title: Can't view gateways in Power Automate
description: Provides a solution to an issue where you can't see your gateway in Power Automate.
ms.reviewer: quseleba, cgarty
ms.date: 03/14/2024
ms.subservice: power-automate-connections
---
# Can't view gateways in Power Automate

This article provides a solution to an issue where you can't see your gateway in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555609

## Symptoms

You can't see one or more of your gateways on the **Gateways** page in the [Power Automate](https://make.powerautomate.com/) portal.

## Cause

If the region where you installed the on-premises data gateway doesn't match the region where your Power Automate or Power Apps environment is located, you won't be able to view or use that gateway in that environment.

## Verify the issue

To verify the issue, first check the region of the environment you're using and ensure you've selected the desired environment in Power Automate. Then, check the region of your on-premises data gateway.

#### Step 1: Verify the region of your Power Apps environment

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments) as an administrator.

1. Verify the region of the environment you're using.

    :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-region-environment.png" alt-text="Screenshot that shows how to check the region of the Power Platform environment." lightbox="media/check-if-gateway-is-the-right-region/verify-region-environment.png":::

1. Sign in to [Power Automate](https://flow.microsoft.com/) and ensure you've selected the desired environment.

    :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-environment-is-expected.png" alt-text="Screenshot that shows how to check the environment used in the flow. "lightbox="media/check-if-gateway-is-the-right-region/verify-environment-is-expected.png":::

1. Select **Gateways** in the left navigation pane.

    If **Gateways** isn't visible in the left navigation pane, select **More** > **Discover all**, find **Gateways** under **Data**, and then pin it to the navigation pane.

1. If you don't see your gateway, go to step 2 to verify the gateway's region.

#### Step 2: Verify the region of your gateway

1. On the computer hosting the gateway, go to the **Start** menu, search for **On-premises data gateway**, and launch the app:

    :::image type="content" source="media/check-if-gateway-is-the-right-region/search-launch-app.png" alt-text="Screenshot that shows how to search for the On-premises data gateway app from the Start menu.":::

1. On the app's **Status** page, select **Sign in** and sign in with the credentials you used when creating the gateway. If you can't remember the credentials, go to the [Resolution](#resolution) section.

    :::image type="content" source="media/check-if-gateway-is-the-right-region/sign-in-the-gateway.png" alt-text="Screenshot that shows the Sign in option on the app's Status page.":::

1. After signing in, you can see the region of your gateway on the **Status** page.

    :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-the-region.png" alt-text="Screenshot that shows the gateway's region on the Status page.":::

    > [!NOTE]
    > The region where your gateway is installed must map to your Power Automate region. To check the mapping of the gateway region to the Power Platform region, see [Regions overview for Power Automate](/power-automate/regions-overview).

1. If the region doesn't match your environment, follow the steps in the **Resolution** section to resolve the issue. If the region matches your environment, or if the following steps don't resolve the issue, contact [Microsoft Power Automate support](https://powerautomate.microsoft.com/support/) for further assistance.

## Resolution

It's not possible to change the region of a gateway that's already installed. However, you can follow the steps below to reinstall the gateway in a region that matches your Power Automate environment region.

1. Go to **Add or Remove Programs** and select **On-premises Data Gateway**.

1. Select **Uninstall** and follow the wizard to uninstall the gateway.

1. [Download and run the latest version of the On-Premises Data Gateway installer](https://powerapps.microsoft.com/downloads/). Before installing, see [Install an on-premises data gateway](/data-integration/gateway/service-gateway-install) for minimum requirements and considerations.

1. Follow the installation wizard until you reach the step to name the gateway. For detailed installation steps, see [Install an on-premises data gateway](/data-integration/gateway/service-gateway-install#download-and-install-a-standard-gateway).

1. Select the **Change Region** link.

    :::image type="content" source="media/check-if-gateway-is-the-right-region/select-change-region-link.png" alt-text="Screenshot that shows how to change the gateway region on the Gateway naming page.":::

1. Select the region matching your Power Apps environment and select **Done**.

   > [!NOTE]
   > The region where your gateway is installed must map to your Power Automate region. To check the mapping of the gateway region to the Power Platform region, see [Regions overview for Power Automate](/power-automate/regions-overview).

1. Follow the gateway installation wizard until it's complete.
1. Sign in to [Power Automate](https://make.powerautomate.com/), and select **Gateways** in the left navigation pane.

   If **Gateways** isn't visible in the navigation pane, select **More** > **Discover all**, find **Gateways** under **Data**, and then pin it to the navigation pane.

1. Check if the gateway appears in the list of gateways. If the gateway is still missing, contact [Microsoft Power Automate support](https://powerautomate.microsoft.com/support/) for assistance.

## More information

- [On-premises data gateway](/power-automate/gateway-reference)
- [Install an on-premises data gateway](/data-integration/gateway/service-gateway-install)
- [Learn to manage on-premises data gateways](/power-automate/gateway-manage)
- [Troubleshoot the on-premises data gateway](/data-integration/gateway/service-gateway-tshoot)
- [Regions overview for Power Automate](/power-automate/regions-overview)
