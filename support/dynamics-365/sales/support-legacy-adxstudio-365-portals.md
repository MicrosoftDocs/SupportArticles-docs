---
title: Support Legacy Adxstudio and 365 Portals
description: Legacy Adxstudio Portals and Microsoft Dynamics 365 Portals Supportability.
ms.reviewer: jbirnbau
ms.topic: article
ms.date: 
---
# Microsoft Dynamics 365 Portals, Legacy Adxstudio Portals, and Open Source Portals Supportability

This article describes supportability for Microsoft Dynamics 365 Portals, Legacy Adxstudio Portals, and Open Source Portals.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3165165

## Summary

On September 28, 2015, Microsoft [announced](https://blogs.microsoft.com/blog/2015/09/28/microsoft-acquires-adxstudio-inc-web-portal-and-application-lifecycle-management-solutions-provider/) the acquisition of Adxstudio Inc., the developers of [Adxstudio Portals](https://community.adxstudio.com/products/adxstudio-portals/). Following the acquisition, Microsoft has continued to develop the portal application, releasing version 8.x as an optional portal add-on for Dynamics 365.

## Support for all versions of the portal application

With the availability of version 8.x, the supportability for previous releases of the portal application has changed. Support for all versions of the portal application is defined below:

- **All SaaS (Microsoft-hosted) portal add-on deployments running version 8.x or higher (starting with CRM 2016 Update 1 and above) are supported by Microsoft through an organization's existing Dynamics 365 support contract.**

  Customers can open support cases for version 8.x portal add-on deployments through the same methods as they would open a normal Dynamics 365 support case.

- **All legacy Adxstudio Portals deployments will continue to be supported on Dynamics CRM 2015, Dynamics CRM 2016, and Dynamics 365 until August 1, 2018, depending on the version they're associated to:**

  - For Dynamics 365 versions up to 8.1.0, Adxstudio Portals version 7.0.0018 or higher will be required.
  - For Dynamics 365 from version 8.1.1 up to and excluding 9.0.0, Adxstudio Portals version 7.0.0024 or higher will be required.
  - For Dynamics 365 version 9.0.0 or higher, Adxstudio Portals version 7.0.0026 or higher will be required.

  Refer to the Adxstudio [Release Notes](https://community.adxstudio.com/products/adxstudio-portals/releases/adxstudio-portals-7/release-notes/) for the improvements made on each version. Support cases for legacy Adxstudio Portals deployments that meet this requirement can be opened via Microsoft Premier channels, MPN partner channels, or the pay-per-incident process through `https://support.microsoft.com` until August 1, 2018. The support won't be offered for the legacy product after that date, as defined in [Upcoming changes to legacy Adxstudio Portals v7](https://cloudblogs.microsoft.com/dynamics365/it/2017/09/14/changes-coming-for-legacy-adxstudio-portals-v7).

- **All legacy Adxstudio Portals deployments on version 7.0.0017 and below are unsupported on any version of Dynamics CRM or Dynamics 365.**
  
  To reach a supported state, organizations with an Adxstudio Portals deployment on version 7.0.0017 or below must upgrade to version 7.0.0018 or higher, and ensure the associated organization is running Dynamics CRM 2015 or higher (including Dynamics 365). Instructions for upgrading to version 7.x can be found [on the legacy Adxstudio Community website](https://community.adxstudio.com/products/adxstudio-portals/releases/adxstudio-portals-7/upgrade-instructions/).

- **Deploying a SaaS (Microsoft-hosted) portal to a Dynamics 365 organization that already contains a version 7.x or lower portal is unsupported and highly discouraged as it can lead to a loss of functionality and may require a full removal of all portal solutions (and therefore all portal data) at a later date.**
  
  Likewise, deploying a version 7.x or lower portal to a Dynamics 365 organization that already contains a SaaS (Microsoft-hosted) portal is also unsupported, as is deploying a self-hosted, open source portal to an organization that already contains a SaaS (Microsoft-hosted) portal.

- **All legacy Adxstudio products and solutions not available through the Adxstudio Installer interface are unsupported.**

  It includes the standalone Adxstudio Productivity Pack, the ALM Toolkit, and the Website Copy Tool. Additionally, only those solutions available through the Adxstudio Installer following the release of Adxstudio Portals version 7.0.0018 (July 8, 2015) and used with a portal website are supported.

To determine the version of a currently deployed portal, see [How to Determine the Version of a Microsoft Dynamics 365 Portal](https://support.microsoft.com/help/3166126).
