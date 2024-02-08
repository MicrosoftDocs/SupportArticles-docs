---
title: CRM outbound phone calls default to Lync not Skype
description: Microsoft Dynamics CRM Online outbound phone calls default to Lync instead of Skype. Provides a resolution.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-other-functionality
---
# Microsoft Dynamics CRM Online outbound phone calls default to Lync instead of Skype

This article provides a resolution for the issue that Microsoft Dynamics CRM Online outbound phone calls default to Lync instead of Skype.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2800946

## Symptoms

When selecting a phone number attribute that is valid for Skype integration, such as the out-of-the-box **Mobile Phone** field on the Contact entity, Lync attempts to dial the call instead of Skype.

## Cause

This issue can occur if Lync is installed after Skype, as this sets the default `CALLTO` protocol program to the last installed telephony provider. The issue can also occur if the default `CALLTO` protocol handler has been manually changed in the Control Panel.

## Resolution

Change the default program for the `CALLTO:` protocol from Lync to Skype.

1. Access the **Start** Menu and select **Control Panel**.
2. In the **View by:** field, under **Category**, select **Large Icons**.
3. Select the **Default Programs applet**.
4. Select **Set your default programs**.
5. Select Skype from the list and then select **Choose defaults for this program**.
6. Select the `CALLTO` protocol in the list and select **Save**.
7. Select **Ok**.
