---
title: Troubleshoot Database Replication Service
description: Use these diagrams to help understand and troubleshoot Database Replication between Configuration Manager sites
ms.manager: dcscontentpm
audience: itpro
ms.date: 03/25/2026
ms.subservice: core-infra
ms.topic: overview
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
---

# Troubleshoot Configuration Manager Database Replication Service overview

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

To better understand and help troubleshoot issues with Database Replication Service, use these diagrams.

- [Database replication](sql-replication.md)
- [DRS configuration](sql-configuration.md)
- [DRS performance](sql-performance.md)
- [DRS reinitialization (reinit)](sql-replication-reinit.md)
- [Global data reinit](global-data-reinit.md)
- [Site data reinit](site-data-reinit.md)
- [Reinit missing message](reinit-missing-message.md)

These troubleshooting diagrams are interconnected. Use the following diagram to understand their relationships:

:::image type="content" source="media/overview/overview.png" alt-text="Diagram of an overview process to troubleshoot SQL Server replication.":::

<!-- PNG used instead of SVG because of weird blankspace in the SVG. The SVG file exists in the same location. -->

For more information, see the following series of blogs from Microsoft Support:

- [ConfigMgr DRS Synchronization Internals](https://techcommunity.microsoft.com/t5/configuration-manager-archive/configmgr-drs-synchronization-internals/ba-p/1154317)
- [ConfigMgr 2012 Data Replication Service (DRS) Unleashed](https://techcommunity.microsoft.com/t5/configuration-manager-archive/configmgr-2012-data-replication-service-drs-unleashed/ba-p/339916)
- [ConfigMgr 2012 DRS – Troubleshooting FAQs](https://techcommunity.microsoft.com/t5/configuration-manager-archive/configmgr-2012-drs-troubleshooting-faqs/ba-p/339934)
- [ConfigMgr 2012 DRS Initialization Internals](https://techcommunity.microsoft.com/t5/configuration-manager-archive/configmgr-2012-drs-initialization-internals/ba-p/339948)
- [ConfigMgr 2012: DRS and SQL Server service broker certificate issues](https://techcommunity.microsoft.com/t5/configuration-manager-archive/configmgr-2012-drs-and-sql-service-broker-certificate-issues/ba-p/339910)
