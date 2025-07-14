---
title: Office Online Server and Office Web Apps Server limitations and features with Information Rights Management (IRM)
description: Describes the limitations and features with Information Rights Management in Office Online Server and Office Web Apps Server.
author: helenclu
ms.author: luche
ms.reviewer: jhaak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
  - Office Web Apps
ms.date: 06/06/2024
---

# Office Online limitations and features with Information Rights Management (IRM)

This article was written by [Dan Fox](https://social.technet.microsoft.com/profile/Dan+F.+-+MSFT), Support Escalation Engineer.

Office Online Server and Office Web Apps Server offer the read-only capability for SharePoint document libraries with Information Rights Management (IRM) enabled.  Protected documents where the IRM or Azure Information Policy protection is applied from Office applications are not supported by Office Online Server and Office Web Apps Server.

Office Online Server and Office Web Apps Server rely on the document host system (like SharePoint) to communicate with Rights Management servers because it has no means to directly communicate with Rights Management servers. IRM protection prevents Office Online Server and Office Web Apps Server from allowing editing of IRM protected documents.

Documents that have any IRM permissions modification or protection added from Office applications and are stored on a document management system can't be opened by Office Online Server and Office Web Apps Server. This is true with IRM protected documents that are stored on other third-party host systems.

**Limitations**

Office Online Server and Office Web Apps Server don't support the following features that are offered for non-IRM protected documents.  These features are currently suppressed from the user interface:

- Edit in browser
- Print
- Save
- Copy selection
- Add comments

**Error with preview in a browser**

When users try to preview an IRM protected document by using Office Online Server and Office Web Apps Server, users may receive an error as follows:

**Sorry, Microsoft Word Online can't display this embedded document because it's protected by Information Rights Management (IRM).**

:::image type="content" source="media/office-online-limitations-and-features-with-information-rights-management/test-wac.png" alt-text="Screenshot of the error message after previewing an I R M protected document.":::

To fix this issue, remove the IRM setting and then preview the document again. If the preview is displayed, apply the IRM setting in the document library again.
