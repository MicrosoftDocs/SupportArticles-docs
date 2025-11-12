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

Below are a few sample scenarios to demonstrate what is changing and what is not. This is not a comprehensive list of scenarios.

### Scenario 1: an email in 'Pending Send' state is picked up by server-side sync, sent out, and moved to 'Sent' state through a 'SetState' operation. A synchronous workflow runs on email update to create a contact using the calling identity

|Scenario|Email Modified By|Email Modified By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**Empty**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 2: an email is automatically tracked into Dynamics, for which server-side sync uses the DeliverIncoming SDK message. A synchronous workflow runs on email create to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email Mofieid By|Email Modified By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 3: an  email is automatically tracked into Dynamics, for which server-side sync uses the DeliverIncoming SDK message. A synchronous plug-in runs on email create to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 4: an email is manually tracked into Dynamics, for which server-side sync uses the DeliverPromote SDK message. A synchronous workflow runs on email create to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 5: a task is tracked into Dynamics by server-side sync, which impersonates the actual user. A synchronous workflow runs on task create to create a contact using the calling identity

|Scenario|Task Created By|Task Created By (delegate)|Task Modified By|Task Modified By (delegate)|Task audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|User|**Empty**|User|**Empty**|User|User|User|**Empty**|User|
|After|User|**'# SSSAdminProd'**|User|**'# SSSAdminProd'**|User|User|User|**'# SSSAdminProd'**|User|

### Scenario 6: an appointment is tracked into Dynamics through server-side sync by a mailbox belonging to a user that is different from the appointment organizer, for which server-side sync does not use impersonation. A synchronous workflow runs on appointment create to create a contact using the calling identity

|Scenario|Appointment Created By|Appointment Created By (delegate)|Appointment Modified By|Appointment Modified By (delegate)|Appointment audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**Empty**|SYSTEM|**Empty**|**SYSTEM**|SYSTEM|SYSTEM|Empty|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|Empty|SYSTEM|

## Resolution

No action should be required, server-side sync would continue functioning as normal after the transition.

## FAQ

### 1. When will this transition take place?

This is currently planned to happen somewhere between November 2025 and March 2026.

### 2. Can I opt out of it?

There is no way to opt out of this change, but you should contact support if anything breaks after transition.

### 3. Moving forward, can we build dependencies (in the form of customizations, processes, etc.) around the fact that server-side sync operations are performed by '# SSSAdminProd'?

No. Much like the identity is changing now, it is also subject to changing again in the future, so any such dependencies could break.

### 4. We have built dependencies or processes around the identities that show up in the audit log or the delegate auditing fields when operations are performed by server-side sync. What should we do?

As these identities can and will be changing, we we advise against building dependencies around observations and assumptions about how the system behaves at a particular point in time, and instead refer to publicly documented system behaviors.

### 5. We are not using server-side sync. Why is this user present? Can we disable it?

The user is present basically for all Dynamics environments, regardless of whether they are currently using server-side sync or not. We do not advise fiddling with this system user in any way, and its presence should not cause any trouble.
