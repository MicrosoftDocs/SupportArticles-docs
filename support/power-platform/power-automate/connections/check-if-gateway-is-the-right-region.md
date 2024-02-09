---
title: Check if gateway is in the right region
description: Provides a solution to an issue where you can't see your gateway in Power Automate.
ms.reviewer: quseleba
ms.date: 03/31/2021
ms.subservice: power-automate-connections
---
# Check if the gateway is in the right region

This article provides a solution to an issue where you can't see your gateway in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555609

## Symptoms

I can't see my gateway in Power Automate, either on the Gateway page and/or when trying to create a desktop flows connection.

## Verifying issue

1. Check the region of your Power Apps environment
    1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments).
    1. Verify the region of the environment you're using:

        :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-region-environment.png" alt-text="Screenshot to check the region of the Power Platform environment." lightbox="media/check-if-gateway-is-the-right-region/verify-region-environment.png":::

    1. Go to [Power Automate](https://flow.microsoft.com/) and verify you're using the expected environment.

        :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-environment-is-expected.png" alt-text="Screenshot to check the environment used in flow. "lightbox="media/check-if-gateway-is-the-right-region/verify-environment-is-expected.png":::

    1. If you're using the expected environment and can't see your gateway, we need to verify the gateway's region.

2. Verify the region of your gateway
    1. On the computer hosting the gateway, search for **On-premises data gateway** in the **start** menu, and launch the app:

        :::image type="content" source="media/check-if-gateway-is-the-right-region/search-launch-app.png" alt-text="Screenshot to search for the On-premises data gateway app in the start menu.":::

    1. On the app's **Status** page, press the **Sign-In** button and sign in with the credentials you used when creating the gateway. If you can't remember the credentials you used when creating the Gateway, go straight to section 3 below (Solving steps).

        :::image type="content" source="media/check-if-gateway-is-the-right-region/sign-in-the-gateway.png" alt-text="Screenshot to select the Sign-in option on the app's Status page.":::

    1. Once signed in, you can see the region of your Gateway on the **Status** page. If the region matches the one of your environments, contact support. Otherwise, continue reading on:

        :::image type="content" source="media/check-if-gateway-is-the-right-region/verify-the-region.png" alt-text="Screenshot to check the gateway's region on the Status page.":::

## Solving steps

Reinstalling the Gateway in the proper environment.

It's unfortunately not possible to change the region of a gateway that's already installed, so you'll need to do the setup from scratch.

1. Uninstall the Gateway from the **Add or Remove Programs app**. Search for **On-premises Data Gateway**, select **Uninstall** and follow the wizard.
1. Download and run the latest version of the On-Premises Data Gateway installer available [here](https://powerapps.microsoft.com/downloads/).
1. Follow the wizard until reaching the Gateway naming page. Select the **Change region** link:

    :::image type="content" source="media/check-if-gateway-is-the-right-region/select-change-region-link.png" alt-text="Screenshot to change the gateway region on the Gateway naming page.":::

1. Select the region matching your Power Apps environment, and hit **Done**.
1. Keep following the Gateway installation wizard until complete.
1. Go to the Gateway page of the flow portal in the target environment.
1. Verify that the Gateway properly appears in the list of Gateways. If the Gateway is still missing, contact Microsoft support.
