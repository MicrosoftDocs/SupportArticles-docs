---
title: SSSAdminProd user and server-side sync operations
description: Provides guidance around the impact of the new identity used by server-side sync in Dynamics
---

# SSSAdminProd user and server-side sync operations

This article provides an overview of the changes customers can expect and observe when server-side sync transitions to a new identity when communicating with Dataverse.

## Symptoms

> - A new system user named SSSAdminProd is present in Dynamics 365
> - Some operations performed by server-side sync show up as being performed by SSSAdminProd instead of SYSTEM in the audit logs
> - Some records created or updated by server-side sync have the SSSAdminProd system user in the delegate auditing fields, such as "Created By (delegate)" and "Modified By (delegate)"
