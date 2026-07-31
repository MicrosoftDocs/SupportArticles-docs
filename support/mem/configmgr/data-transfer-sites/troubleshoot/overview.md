---
title: Troubleshoot Database Replication Service
description: Introduces a set of diagrams that help you understand and troubleshoot Database Replication between Configuration Manager sites
ms.manager: dcscontentpm
audience: itpro
ms.date: 07/30/2026
ms.subservice: core-infrastructure
ms.topic: overview
ai-usage: ai-assisted
ms.reviewer: umaikhan
ms.collection: tier3
ms.custom: sap:Configuration Manager Database\Database Replication Links
ms.service: microsoft-endpoint-configuration-manager
---

<!-- markdownlint-disable-next-line MD025 -->
# Troubleshoot Configuration Manager Database Replication Service overview

In a multi-site hierarchy, Configuration Manager uses Database Replication Service (DRS) to transfer data between sites. For more information, see [Database replication](/intune/configmgr/core/plan-design/hierarchy/database-replication).

To better understand and help troubleshoot DRS issues, including issues that are related to the underlying SQL Server components, use the diagrams and information in the following articles.

- [DRS synchronization internals](drs-synchronization-internals.md)
- [DRS activation internals](drs-activation-internals.md)
- [DRS reinitialization internals](drs-reinitialization-internals.md)
- [DRS Service Broker certificate and endpoint errors](drs-ssb-certificate-errors.md)
- [Database replication](sql-replication.md)
- [DRS configuration](sql-configuration.md)
- [DRS performance](sql-performance.md)
- [DRS reinitialization (reinit)](sql-replication-reinit.md)
- [Global data reinit](global-data-reinit.md)
- [Site data reinit](site-data-reinit.md)
- [Reinit missing message](reinit-missing-message.md)

The diagrams in these articles are interconnected. Use the following diagram to understand their relationships:

:::image type="content" source="media/overview/overview.png" alt-text="Diagram of an overview process to troubleshoot DRS issues in Configuration Manager.":::

<!-- PNG used instead of SVG because of weird blankspace in the SVG. The SVG file exists in the same location. -->

For symptom-based investigation across the hierarchy, see [Troubleshoot database replication service issues](troubleshoot-database-replication-service-issues.md).
