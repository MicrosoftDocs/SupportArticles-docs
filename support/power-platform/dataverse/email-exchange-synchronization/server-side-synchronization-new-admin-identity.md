---
title: SSSAdminProd user and server-side sync operations
description: Provides guidance around the impact of the new identity used by server-side sync in Dynamics
ms.date: 11/13/2025
---

# SSSAdminProd user and server-side sync operations

This article provides an overview of the changes customers can expect when server-side sync transitions to a new identity to communicate with Dataverse.

## Symptoms

> - A new system user named '# SSSAdminProd' is present in Dynamics 365
> - Some operations performed by server-side sync show up as being performed by '# SSSAdminProd' instead of SYSTEM in the audit logs
> - Some records created or updated by server-side sync have the '# SSSAdminProd' system user in the delegate auditing fields, such as "Created By (delegate)" and "Modified By (delegate)"

## Cause

Server-side sync is changing the identity used for its operations against Dataverse. Historically, server-side sync would use the user named SYSTEM that all environments have. Server-side sync operations will transition to use the '# SSSAdminProd' user moving forward. However, to preserve backward compatibility, the SYSTEM identity will still be used for some key server-side sync operations, which ensures that this change doesn't impact customer dependencies built around this identity.

The key differences customers can expect are:
1. For records created or updated by server-side sync, the delegate auditing fields "Created By (delegate)" and "Mofieid By (delegate)" will start showing the '# SSSAdminProd' user instead of being empty. The content of the "Created By" and "Modified By" fields remains unchanged.
2. For records created by synchronous customizations (such as workflows or plug-ins) running upon server-side sync operations and using the calling identity, the "Created By (delegate)" field will start showing the '# SSSAdminProd' user instead of being empty.
3. The audit log entries for server-side sync operations that don't impersonate a system user will change from SYSTEM to '# SSSAdminProd'

The following are a few sample scenarios to demonstrate what is changing and what isn't (not a comprehensive list):

### Scenario 1: server-side sync picks up an email in 'Pending Send' state, sends it out, and moves it to 'Sent' state through a 'SetState' operation. A synchronous workflow runs on email update to create a contact using the calling identity

|Scenario|Email Modified By|Email Modified By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**Empty**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 2: an email is automatically tracked into Dynamics. A synchronous workflow runs on email create to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email Mofieid By|Email Modified By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 3: an  email is automatically tracked into Dynamics. A plug-in runs synchronously on email creation to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 4: an email is manually tracked into Dynamics. A synchronous workflow runs on email create to create a contact using the calling identity

|Scenario|Email Created By|Email Created By (delegate)|Email audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**SYSTEM**|**SYSTEM**|SYSTEM|SYSTEM|**Empty**|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|**'# SSSAdminProd'**|SYSTEM|

### Scenario 5: server-side sync tracks a task into Dynamics while impersonating the actual user. A synchronous workflow runs on task create to create a contact using the calling identity

|Scenario|Task Created By|Task Created By (delegate)|Task Modified By|Task Modified By (delegate)|Task audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|User|**Empty**|User|**Empty**|User|User|User|**Empty**|User|
|After|User|**'# SSSAdminProd'**|User|**'# SSSAdminProd'**|User|User|User|**'# SSSAdminProd'**|User|

### Scenario 6: an appointment is tracked into Dynamics through server-side sync. The tracking mailbox belongs to a user that's different from the appointment organizer, so which server-side sync doesn't use impersonation. A synchronous workflow runs on appointment create to create a contact using the calling identity

|Scenario|Appointment Created By|Appointment Created By (delegate)|Appointment Modified By|Appointment Modified By (delegate)|Appointment audit log identity|Contact owner|Contact Created By|Contact Created By (delegate)|Contact audit log identity|
|-|-|-|-|-|-|-|-|-|-|
|Before|SYSTEM|**Empty**|SYSTEM|**Empty**|**SYSTEM**|SYSTEM|SYSTEM|Empty|SYSTEM|
|After|SYSTEM|**'# SSSAdminProd'**|SYSTEM|**'# SSSAdminProd'**|**'# SSSAdminProd'**|SYSTEM|SYSTEM|Empty|SYSTEM|

## Resolution

No action should be required. Server-side sync would continue functioning as normal after the transition.

## FAQ

### 1. When will this transition take place?

This transition is currently planned to happen somewhere between November 2025 and March 2026.

### 2. Can I opt out of it?

There's no way to opt out of this change, but you should contact support if anything breaks after transition.

### 3. In the future, can we build dependencies (in the form of customizations, processes, etc.) around the fact that server-side sync performs its operations using the '# SSSAdminProd' user?

No. Much like the identity is changing now, it's also subject to changing again in the future, so any such dependencies could break.

### 4. We built dependencies or processes around the identities that show up in the audit log or the delegate auditing fields when server-side sync performs certain operations. These identities are now changing. What should we do?

As these identities can change, we advise against building dependencies around observations and assumptions about how the system behaves at a particular point in time. Instead, refer to publicly documented system behaviors.

### 5. We're not using server-side sync. Why is this user present? Can we disable it?

The user is present basically for all Dynamics environments, regardless of whether they're currently using server-side sync or not. We advise against fiddling with this system user in any way. Its presence shouldn't cause any trouble.
