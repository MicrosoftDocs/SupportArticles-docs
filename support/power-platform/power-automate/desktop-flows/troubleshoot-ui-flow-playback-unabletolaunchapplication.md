---
title: Troubleshoot UI flow playback UnableToLaunchApplication
description: This article helps to solve the UI flow playback error UnableToLaunchApplication when trying to run a UI flow during Test run or Flow run.
ms.reviewer: ambham
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-desktop-flows
---
# Troubleshoot UI flow Playback - Unable To Launch Application

This article provides steps to solve the issue that you receive the **UnableToLaunchApplication** error when trying to run a UI flow during Test run or Flow run.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555721

## Symptoms

When trying to run a UI flow during Test run or Flow run, the user gets the error:

> UnableToLaunchApplication.

:::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/error-message.png" alt-text="Screenshot of the error message when trying to run a UI flow during the Test run or Flow run.":::

The error is visible in the UI flow Test Page or See detail page of the UI flow run instance.

## Verifying issue

- Open the UI flow in Edit mode and select the Application Card.

  :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/application-card.png" alt-text="Screenshot to open the U I flow in Edit mode and select the Application Card.":::

- Check the Application path on the machine where UI flow is run to make sure application exe exists.

  :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/check-application-path.png" alt-text="Screenshot to check the Application path on the machine.":::

- Some applications can take a long time to launch.

## Solving steps

- If the Application path is incorrect, update to the correct path.

  :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/check-application-path.png" alt-text="Screenshot of updating to the correct path in the U I flow.":::

- In case Application launches and fails with above error **UnableToLaunchApplication** follow the steps below.

This issue sometime occurs for Power BI:

- Start Recording - Record single Action on Power BI and select the **Done** button on recorder. In the UI flow designer you will see 2 actions/steps:
  - Launch Application.
  - Select Action - Delete this action.

    :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/delete-action.png" alt-text="Screenshot shows the steps after the Application launches and fails.":::

- Start new Recording by selecting.

   :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/add-an-action.png" alt-text="Screenshot to select the Add an action option to start the new recording.":::

- Start recording Power BI Desktop application again and record couple of actions (Click or Keyboard).

  1. Open the Launch Application action.
  2. Update the Launch Application property to **No**.

     :::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/update-launch-application-property.png" alt-text="Screenshot to update the Launch Application property to No.":::

The above two-step process can solve issue for some applications.

- In case application takes long time to launch:

  - Check the launch step in your script (In the example below, select the **Launch Excel** step):
  - Select **Show advanced options** and Update the **Wait after action** value. In Example PT15S means UI flow playback will wait for 15 secs to launch application.

:::image type="content" source="media/troubleshoot-ui-flow-playback-unabletolaunchapplication/wait-after-action.png" alt-text="Screenshot to update the Wait after action value in the Launch Excel window.":::
