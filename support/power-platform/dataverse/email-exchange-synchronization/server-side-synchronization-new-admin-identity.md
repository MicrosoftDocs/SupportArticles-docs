---
title: Upcoming Changes to Server-Side Sync Identity in Dynamics
description: Learn about the upcoming changes to the identity used by server-side sync in Dynamics 365, including impacts on audit logs and delegate fields.
ms.date: 11/13/2025
ms.reviewer: FERNAN.OVIEDO, v-shaywood
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronizatio
---

# Upcoming changes to the identity used by server-side sync for Dataverse communications

This article provides an overview of the upcoming change to the identity used by server-side sync for Dataverse communications. It includes a detailed list of the changes you can expect to see once the new identity is in use, as well as example scenarios comparing record fields before and after the switch.

## Expected changes

Server-side sync is changing the identity used for communications with Dataverse. Previously, server-side sync used the `SYSTEM` identity that all environments have. Server-side sync operations will transition to using the `# SSSAdminProd` identity moving forward. This transition is currently planned to happen between November 2025 and March 2026.

> [!IMPORTANT]
> To preserve backward compatibility, the `SYSTEM` identity will still be used for some key server-side sync operations. This approach ensures that the identity transition doesn't impact customers that have built dependencies around the `SYSTEM` identity.

The key differences you can expect to see after the identity transition are:

- A new system user named `# SSSAdminProd` is present in Dynamics 365.
- The audit log entries for server-side sync operations that don't impersonate a system user show as being performed by `# SSSAdminProd` instead of `SYSTEM`.
- For records created or updated by server-side sync, the delegate auditing fields _Created By (delegate)_ and _Modified By (delegate)_ show `# SSSAdminProd` instead of being empty. The content of the _Created By_ and _Modified By_ fields remains unchanged.
- For records created by synchronous customizations, such as workflows or plug-ins, that run upon server-side sync operations and use the calling identity, the _Created By (delegate)_ field shows `# SSSAdminProd` instead of being empty.

## Example scenarios

The following example scenarios demonstrate which record fields will be changing. This is not a comprehensive list:

### Server-side sync picks up an email in 'Pending Send' state, sends it out, and then moves it to 'Sent' state through a 'SetState' operation. A synchronous workflow runs on email updates to create a contact using the calling identity.

| Scenario | Email Modified By | Email Modified By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ----------------- | ---------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM            | **Empty**                    | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM            | **# SSSAdminProd**           | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

### An email is automatically tracked into Dynamics. A synchronous workflow runs on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email Modified By | Email Modified By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ----------------- | ---------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | SYSTEM            | **SYSTEM**                   | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | SYSTEM            | **# SSSAdminProd**           | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

### An email is automatically tracked into Dynamics. A plug-in runs synchronously on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

### An email is manually tracked into Dynamics. A synchronous workflow runs on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

### Server-side sync tracks a task into Dynamics while impersonating the actual user. A synchronous workflow runs on task creation to create a contact by using the calling identity.

| Scenario | Task Created By | Task Created By (delegate) | Task Modified By | Task Modified By (delegate) | Task audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | --------------- | -------------------------- | ---------------- | --------------------------- | ----------------------- | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | User            | **Empty**                  | User             | **Empty**                   | User                    | User          | User               | **Empty**                     | User                       |
| After    | User            | **# SSSAdminProd**         | User             | **# SSSAdminProd**          | User                    | User          | User               | **# SSSAdminProd**            | User                       |

### Server-side sync tracks an appointment into Dynamics. The tracking mailbox belongs to a user that's different from the appointment organizer, so server-side sync doesn't use impersonation. A synchronous workflow runs on appointment create to create a contact by using the calling identity.

| Scenario | Appointment Created By | Appointment Created By (delegate) | Appointment Modified By | Appointment Modified By (delegate) | Appointment audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------------- | --------------------------------- | ----------------------- | ---------------------------------- | ------------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM                 | **Empty**                         | SYSTEM                  | **Empty**                          | **SYSTEM**                     | SYSTEM        | SYSTEM             | Empty                         | SYSTEM                     |
| After    | SYSTEM                 | **# SSSAdminProd**                | SYSTEM                  | **# SSSAdminProd**                 | **# SSSAdminProd**             | SYSTEM        | SYSTEM             | Empty                         | SYSTEM                     |

## FAQs

### Can I opt out of it?

You can't opt out of this change, but you should contact support if you experience any issues after the transition.

### In the future, can we build dependencies (in the form of customizations, processes, etc.) around the fact that server-side sync performs its operations by using the "# SSSAdminProd" user?

No, the new identity is also subject to potential change in the future. Any dependencies built on the `# SSSAdminProd` identity could break.

### We built dependencies or processes around the identities that show up in the audit log or the delegate auditing fields when server-side sync performs certain operations. These identities are now changing. What should we do?

As these identities can change in the future, only build dependencies on the publicly documented system behavior rather than observed system behaviors.

### We're not using server-side sync. Why is this user present? Can we disable it?

The new identity is present for almost every Dynamics environment, regardless of whether you're currently using server-side sync or not. Don't change system identities in any way.
