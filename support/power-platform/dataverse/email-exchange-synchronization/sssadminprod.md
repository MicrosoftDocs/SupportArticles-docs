---
title: SSSAdminProd user and server-side sync operations
description: Provides guidance around the impact of the new identity used by server-side sync in Dynamics
---

# SSSAdminProd user and server-side sync operations

This article provides an overview of the changes customers can expect and observe when server-side sync transitions to a new identity when communicating with Dataverse.

## Symptoms

> - A new system user named '# SSSAdminProd' is present in Dynamics 365
> - Some operations performed by server-side sync show up as being performed by '# SSSAdminProd' instead of SYSTEM in the audit logs
> - Some records created or updated by server-side sync have the '# SSSAdminProd' system user in the delegate auditing fields, such as "Created By (delegate)" and "Modified By (delegate)"

## Cause

Server-side sync is changing the the identity used for its operations against Dataverse. Historically, server-side sync would simply leverage the user named SYSTEM that all environments have. Moving forward, server-side sync operations will transition to use the '# SSSAdminProd' user. However, to preserve backward compatibility, the SYSTEM identity will still be leveraged for some key server-side sync operations. This is to ensure that customer dependencies built on this identity are not impacted by this change.

These are the key differences you can expect:
1. For records created or updated by server-side sync, the delegate auditing fields "Created By (delegate)" and "Mofieid By (delegate)" will start showing the '# SSSAdminProd' user instead of being empty. The content of the "Created By" and "Modified By" fields remains unchanged.
2. For records created by synchronous customizations (such as workflows or plug-inss) running upon server-side sync operations and using the calling identity, the "Created By (delegate)" field will start showing the '# SSSAdminProd' user instead of being empty.
3. The audit log entries for server-side sync operations that do not impersonate a system user will change from SYSTEM to '# SSSAdminProd'

Below are a few sample scenarios to demonstrate what is changing and what is not:

### Scenario 1: an email in 'Pending Send' state is picked up by server-side sync, sent out, and moved to 'Sent' state. A synchronous workflow runs on email update to create a contact using the calling identity

|Scenario|Email Modified By|Email Modified By (delegate)|Email audit log|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**Empty**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

