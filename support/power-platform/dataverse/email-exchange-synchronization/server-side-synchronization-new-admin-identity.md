---
title: Upcoming Changes to Server-Side Sync Identity in Dynamics
description: Learn about the upcoming changes to the identity that's used by server-side sync in Dynamics 365, including effects on audit logs and delegate fields.
ms.date: 11/13/2025
ms.reviewer: FERNAN.OVIEDO, v-shaywood
ms.custom: sap:Email and Exchange Synchronization\Set up and configuration of server-side synchronizatio
---

# Changes to server-side sync identity for Dataverse communications

This article provides an overview of the upcoming changes to the identity that's used by server-side sync for Dataverse communications in Microsoft Dynamics 365. This article includes a detailed list of the changes that you can expect to see after the new identity is active. It also provides example scenarios that compare record fields before and after the switch.

## Expected changes

Server-side sync is changing the identity that's used for Dataverse communications. Previously, server-side sync used the `SYSTEM` identity that all environments have. Server-side sync operations are transitioning to using the `# SSSAdminProd` identity moving forward. This transition is currently planned to occur between November 2025 and March 2026.

> [!IMPORTANT]
> To preserve backward compatibility, the `SYSTEM` identity will continue to be used for some key server-side sync operations. This approach makes sure that the identity transition doesn't affect users that built dependencies around the `SYSTEM` identity.

The key differences that you can expect to see after the identity transition are:

- A new Dynamics 365 system user that's named `# SSSAdminProd` is added.
- The audit log entries for server-side sync operations that don't impersonate a system user are shown as performed by `# SSSAdminProd` instead of `SYSTEM`.
- For records that are created or updated by server-side sync:
   - The delegate auditing fields _Created By (delegate)_ and _Modified By (delegate)_ now shows `# SSSAdminProd` instead of being empty.
   - The content of the _Created By_ and _Modified By_ fields remains unchanged.
- For records that are created by synchronous customizations, such as workflows or plug-ins, and that run on server-side sync operations and use the calling identity:
   - The _Created By (delegate)_ field now shows `# SSSAdminProd` instead of being empty.

## Example scenarios

The following example scenarios demonstrate which record fields are changing. (This is not a comprehensive list.)

#### Scenario 1

Server-side sync picks up an email message in 'Pending Send' state, sends it, and then moves it to the 'Sent' state through a 'SetState' operation. A synchronous workflow runs on email updates to create a contact using the calling identity.

| Scenario | Email Modified By | Email Modified By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ----------------- | ---------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM            | **Empty**                    | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM            | **# SSSAdminProd**           | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

#### Scenario 2

An email message is automatically tracked into Dynamics. A synchronous workflow runs on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email Modified By | Email Modified By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ----------------- | ---------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | SYSTEM            | **SYSTEM**                   | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | SYSTEM            | **# SSSAdminProd**           | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

#### Scenario 3

An email message is automatically tracked into Dynamics. A plug-in runs synchronously on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

#### Scenario 4

An email message is manually tracked into Dynamics. A synchronous workflow runs on email creation to create a contact by using the calling identity.

| Scenario | Email Created By | Email Created By (delegate) | Email audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------- | --------------------------- | ------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM           | **SYSTEM**                  | **SYSTEM**               | SYSTEM        | SYSTEM             | **Empty**                     | SYSTEM                     |
| After    | SYSTEM           | **# SSSAdminProd**          | **# SSSAdminProd**       | SYSTEM        | SYSTEM             | **# SSSAdminProd**            | SYSTEM                     |

#### Scenario 5

Server-side sync tracks a task into Dynamics while impersonating the actual user. A synchronous workflow runs on task creation to create a contact by using the calling identity.

| Scenario | Task Created By | Task Created By (delegate) | Task Modified By | Task Modified By (delegate) | Task audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | --------------- | -------------------------- | ---------------- | --------------------------- | ----------------------- | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | User            | **Empty**                  | User             | **Empty**                   | User                    | User          | User               | **Empty**                     | User                       |
| After    | User            | **# SSSAdminProd**         | User             | **# SSSAdminProd**          | User                    | User          | User               | **# SSSAdminProd**            | User                       |

#### Scenario 6

Server-side sync tracks an appointment into Dynamics. The tracking mailbox belongs to a user that's different from the appointment organizer. Therefore, server-side sync doesn't use impersonation. A synchronous workflow runs on appointment creation to create a contact by using the calling identity.

| Scenario | Appointment Created By | Appointment Created By (delegate) | Appointment Modified By | Appointment Modified By (delegate) | Appointment audit log identity | Contact owner | Contact Created By | Contact Created By (delegate) | Contact audit log identity |
| -------- | ---------------------- | --------------------------------- | ----------------------- | ---------------------------------- | ------------------------------ | ------------- | ------------------ | ----------------------------- | -------------------------- |
| Before   | SYSTEM                 | **Empty**                         | SYSTEM                  | **Empty**                          | **SYSTEM**                     | SYSTEM        | SYSTEM             | Empty                         | SYSTEM                     |
| After    | SYSTEM                 | **# SSSAdminProd**                | SYSTEM                  | **# SSSAdminProd**                 | **# SSSAdminProd**             | SYSTEM        | SYSTEM             | Empty                         | SYSTEM                     |

## Frequently asked questions

**Q1: Can I opt out of this change?**

**A1:** You can't opt out of this change. However, you should contact Microsoft Support if you experience any issues after the transition.

**Q2: In the future, can we build dependencies (in the form of customizations, processes, etc.) around the fact that server-side sync performs its operations by using the "# SSSAdminProd" user?**

**A2:** No, the new identity is also subject to potential change in the future. Any dependencies that are built on the `# SSSAdminProd` identity could break.

**Q3: We built dependencies or processes around the identities that appear in the audit log or the delegate auditing fields when server-side sync performs certain operations. These identities are now changing. What should we do?**

**A3:** Because these identities can change in the future, we recommend that you build dependencies on only the publicly documented system behavior instead of observed system behaviors. For more information, see [Server-side synchronization](/power-platform/admin/server-side-synchronization)

**Q4: We're not using server-side sync. Do we need this user? Can we disable it?**

**A4:** The new identity exists for almost every Dynamics environment, regardless of whether you're currently using server-side sync. Don't change system identities in any way.
