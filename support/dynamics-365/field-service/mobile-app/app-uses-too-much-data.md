---
title: Field Service mobile app uses too much data
description: Provides troubleshooting tips if the Microsoft Dynamics 365 Field Service mobile app uses too much data.
author: JonBaker007
ms.author: jobaker
ms.reviewer: mhart
ms.date: 10/30/2024
ms.custom: sap:Mobile application
---

# Field Service mobile app uses too much data

This article provides troubleshooting tips if the Field Service mobile app uses too much data.

## Troubleshooting checklist

To reduce the amount of data the mobile app uses, consider the following actions:

- Limit customization. To understand how customizations are consuming data, use debugging tools like F12 in the browser or Fiddler with the Windows app.
- [Create an offline profile](/dynamics365/field-service/mobile/set-up-offline-profile) and enable offline-first mode. Make sure business can be performed offline and large synchronizations can be handled over wifi.
- Limit views and forms to the minimum required.
- Use default views that filter data to only the data that's important to the field worker. For example, my recent bookings instead of all bookings.
- Allow image resolution to default to smaller file sizes for photo capture.
- Review other [performance considerations for customizing the mobile app](/dynamics365/field-service/mobile/improve-mobile-performance).