---
title: Troubleshooting RDP or Citrix issues with the Troubleshooter
description: Guide on how use the Power Automate troubleshooter to diagnose RDP/Citrix automation issues.
ms.reviewer: amitrou
ms.author: iopanag
author: JohnPanagiotopoulos
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 20/03/2025
---

# Troubleshooting RDP or Citrix issues with the Troubleshooter

This article will help you use the Power Automate troubleshooter to diagnose and potentialy solve issues related to RDP or Citrix automation. When faced with such issues, the troubleshooter should be the first course of actions for diagnosing the problem.

## How to diagnose issues with the troubleshooter

1. Make sure the problematic remote RDP/Citrix session/app is up. The troubleshooter will attempt to connect with it to check for issues.
2. Launch the troubleshooter from the Power Automate menu, `Help -> Troubleshooter`

   :::image type="content" source="media/troubleshooting-with-the-troubleshooter/troubleshooting-with-the-troubleshooter.png" alt-text="Screenshot of the Power Automate designer help menu with the Troubleshooter option highlighted.":::

3. Click on the `Run` button of the `Troubleshoot UI/Web automation issues` section.

   :::image type="content" source="media/troubleshooting-with-the-troubleshooter/troubleshooter-uiautomation-option.png" alt-text="Screenshot of the Power Automate troubleshooter with the 'Run' button of 'UI/Web automation' section highlighted":::

4. After the troubleshooter completes its checks, expand the 'RDP/Citrix UI Automation' section by clicking the right arrow next to it.

   :::image type="content" source="media/troubleshooting-with-the-troubleshooter/troubleshooter-rdp-issues.png" alt-text="Screenshot of the Power Automate troubleshooter with the 'RDP/Citrix UI Automation' section expanded and a list off issues are shown in a list along with detected RDP/Citrix clients with its separate issues":::

5. The section shows the errors detected and possible solutions where apply. Furthermore for each RDP/Citrix session/app that was detected, more detailed errors are displayed for each.

## More information

[Automate on virtual desktops](/power-automate/desktop-flows/virtual-desktops)