---
title: Troubleshoot Non-Microsoft Contact Center Panel Issues
description: Troubleshoot common problems when you embed a non-Microsoft contact center agent panel in Copilot Service workspace with Channel Integration Framework 2.0.
ms.reviewer: laalexan, borisvolfson
ai-usage: ai-assisted
ms.date: 11/16/2026
ms.custom: sap:Channel Integration Framework (CIF)
---

# Troubleshoot non-Microsoft contact center panel issues in Copilot Service workspace

## Summary

This article helps you resolve problems that can occur when you build and run a custom [Channel Integration Framework (CIF) 2.0](/dynamics365/channel-integration-framework/v2/administer/overview-channel-integration-framework) agent panel for a contact center as a service (CCaaS) platform in Copilot Service workspace. Entries marked **NICE CXone** are specific to the NICE CXone Agent SDK. The other entries apply to any CCaaS platform. Where a cause isn't confirmed, the entry says so.

To learn more about how to build the panel, go to [Embed a non-Microsoft contact center in Copilot Service workspace](/dynamics365/customer-service/develop/embed-third-party-contact-center).

> [!IMPORTANT]
> This article applies to a preview feature. A preview feature is a feature that is not complete, but is made available before it's officially in a release so customers can get early access and provide feedback. Preview features aren't meant for production use and may have limited or restricted functionality.

## Make problems visible

Build the following diagnostics into the panel early, so you can find out what failed:

- **An activity log** with timestamps: buttons selected, SDK events (session, agent state, contacts, voice leg), CIF results, and request timings. Don't log tokens or transcript text.
- **Actionable error details.** Map each failed SDK call to a message that names the operation, the HTTP status, and the error type, for example "Saving wrap-up failed (HTTP 400, API error)." Never show or log response bodies, because they can contain tokens.
- **A simulated-call mode** that runs the same code with typed lines, so you can separate panel issues from telephony issues.
- **A byte-level deployment check**, so you know which version you're testing. Learn more in [Deployment and publishing](#deployment-and-publishing).

## Quick reference of common symptoms

| Symptom | Go to |
|---|---|
| The panel doesn't appear, or disappears on some screens | [Panel visibility and docking](#panel-visibility-and-docking) |
| A new version is deployed, but the old one still runs | [Deployment and publishing](#deployment-and-publishing) |
| The sign-in pop-up window doesn't finish | [Sign-in and agent session](#sign-in-and-agent-session) |
| Start session fails with a conflict | [Start session fails with HTTP 409 Conflict](#start-session-fails-with-http-409-conflict) |
| Calls ring but never connect, and the agent is set to Refused | [Calls ring but never connect](#calls-ring-but-never-connect-and-the-agent-is-set-to-refused) |
| Wrap-up keeps failing for an old call | [An old call can't be wrapped up](#an-old-call-cant-be-wrapped-up-and-end-session-is-refused) |
| No workspace notification for an incoming call | [Calls and notifications](#calls-and-notifications) |
| No live transcript | [Live transcript](#live-transcript) |
| Wrong customer, or duplicate cases | [Customers and cases](#customers-and-cases) |
| Next best action errors or unexpected suggestions | [Next best action prototype](#next-best-action-prototype) |
| A new intent is never matched | [A new intent or line of business isn't matched](#a-new-intent-or-line-of-business-isnt-matched) |
| Connector tools don't run | [Connector tools don't run in the workspace](#connector-tools-dont-run-in-the-workspace) |

## Panel visibility and docking

Use these entries when the panel is missing, hidden, collapsed, or the wrong size in Copilot Service workspace.

### The panel doesn't appear on some screens

**Symptom:** The panel appears on the home screen but disappears when a case or contact opens, or its frame is present but 0 × 0 pixels.

**Cause:** When you assign more than one channel provider to the representative's experience profile, the Copilot Service workspace shows a provider's panel only in sessions that provider owns. Records opened in another session hide the panel. Learn more in [Support single and multiple channel providers](/dynamics365/channel-integration-framework/v2/administer/support-multiple-providers).

**Resolution:**

1. At startup, have the panel open its own session with `createSession` and your session template, and then dock the panel.
1. Open the records the panel finds or creates, such as contacts and cases, with `openForm` inside the panel's own session.
1. If the representative closes the panel's home session, reopen it.

Showing the panel next to a record in a session that the panel doesn't own isn't supported. Layout and template variations don't change this behavior.

### The panel doesn't stay docked

**Symptom:** The panel collapses or disappears after a reload.

**Cause:** CIF has four modes: `0` Minimized, `1` Docked, `2` Hidden, and `3` Collapsed. A panel that never sets its mode, or that overrides the representative's choice, behaves unpredictably.

**Resolution:** Call `setMode(1)` and `setWidth` after the session opens. Redock only when the mode is Hidden, and leave Minimized alone. Test with a plain reload and with browser developer tools closed, because an open developer tools pane changes the layout. For more information on `setMode` and `setWidth`, see [Communication panel management APIs](/dynamics365/channel-integration-framework/v2/develop/reference/microsoft-ciframework-v2#communication-panel-management-apis).

### The panel stops appearing after a configuration change

**Symptom:** After you change the channel provider or experience profile, the workspace opens without the panel.

**Cause:** Configuration changes take a few minutes to apply. The channel provider URL, app selection, and profile membership must all match.

**Resolution:** Check the channel provider settings (URL, API version, trusted domain, and app) and the profile assignment. Wait 1–3 minutes, and then reload an idle workspace. Record the previous values before any change so you can restore them.

### Environment details are missing on the home screen

**Symptom:** A check that reads the app ID from the CIF environment details fails on the home screen.

**Cause:** On the home screen, the environment details don't include `appid`.

**Resolution:** Use the app ID from the workspace page URL instead. Learn more in [`getEnvironment`](/dynamics365/channel-integration-framework/v2/develop/reference/microsoft-ciframework/getenvironment).

## Deployment and publishing

Use these entries when a solution import, publish, or rollback doesn't produce the panel version you expect.

### The new version is deployed, but the old one still runs

**Symptom:** The import succeeds, but the panel still behaves like the previous version.

**Cause:** Bundlers give built files new hashed names. The import adds the new files, but the panel keeps loading the old ones until you publish the entry page (`index.html`) that references them.

**Resolution:** Publish the changed web resources, including the entry page, with `PublishXml`. Then export the solution and compare every packaged web resource with the build, byte for byte. If the browser still shows the old version, fetch the served entry page and compare it too, then reload the workspace.

### Publish all customizations publishes unrelated work

**Cause:** **Publish all customizations** publishes every pending change in the environment, not only the panel.

**Resolution:** Publish only the web resources you changed.

### Import fails with error 80071151

**Cause:** Another solution import holds the environment's import lock.

**Resolution:** Wait for the other import to finish, then try again.

### Writes time out with "a solution is currently being imported"

**Symptom:** Creating records or importing your solution fails with a timeout (`0x80040265` or `0x80048543`), or an import fails without details, even though no other import is running.

**Cause:** The platform is installing Microsoft solution updates in the environment.

**Resolution:** In Power Apps, go to **Solutions** > **See history**, and wait until no operation is running. Then try again. Updates can arrive in waves over about an hour.

### "No sandbox hosts available" or other transient errors

**Resolution:** These errors are transient. Wait briefly, and then retry once before you investigate.

### A rollback doesn't undo everything

**Cause:** Restoring the previous web resources doesn't sign anyone out, end an agent session, or delete records the panel created.

**Resolution:** Plan a separate rollback for code, configuration, records, and sessions.

## Sign-in and agent session

Use these entries when representatives can't sign in to the CCaaS platform, can't start or rejoin an agent session, or have calls that don't connect.

### The sign-in pop-up window doesn't finish

**Symptom:** The vendor's sign-in page opens, but the panel never signs in.

**Cause:** The registered redirect URI doesn't match the callback page, the browser blocks the pop-up window, or the panel rejects the callback message.

**Resolution:**

- Register the exact callback URL, for example `https://<org>.crm.dynamics.com/WebResources/<prefix>/auth-callback.html`.
- Open the pop-up window directly in the button's click event handler so the browser doesn't block it.
- In the panel, accept the callback message only from your own origin and from the pop-up window you opened, and check the `state` value.
- Ask the vendor to allow your environment's origin for the SDK's browser calls (CORS).

### The representative is signed in, but calls don't arrive

**Cause:** Sign-in, agent session, voice connection, and agent state are four separate steps. Signing in doesn't start a session or make the agent available.

**Resolution:** Show each step's state in the panel (signed in, session started, voice ready, and available), and check them in order.

### The voice connection never becomes ready (NICE CXone)

**Symptom:** The session starts, but voice stays not ready, and the browser WebRTC library isn't found.

**Cause:** The voice SDK needs the vendor's WebRTC library (`AudioCodesUA`) loaded as a classic script before the panel's module script.

**Resolution:** Package the library as a web resource, load it first, and check that `typeof AudioCodesUA === "function"` in the panel's own frame.

### Start session fails with HTTP 409 Conflict

**Symptom:** Starting the agent session fails after a tab or browser was closed.

**Cause:** The platform still holds the agent's earlier session.

**Resolution:** On HTTP 409, rejoin the existing session instead of failing. For NICE CXone, call `acd.session.joinSession`. Treat other errors as failures. A rejoined session can carry problems with it, as described in the next entry.

### Calls ring but never connect, and the agent is set to Refused

**Symptom:** After the panel rejoins an existing session, incoming calls stay in the incoming state for 30–45 seconds, never auto-accept, and then ring out. The platform sets the agent to Unavailable / Refused. **Accept** might disappear before the representative can select it.

**Cause (suspected):** The rejoined session's voice leg still points at the browser tab that held the session before, so the platform can't connect calls to the new tab.

**How to confirm:** Log voice-leg events. When a call rings and no voice-leg "dialing" event arrives, the platform can't reach this tab. At sign-in, the log shows that the session was rejoined (409) rather than started.

**Resolution:**

1. Add a **Reset session** action to the panel. The action force-ends the vendor session, including its contacts, disconnects voice, clears the panel's call state, and starts a fresh session. Don't allow the action while a call is live. For NICE CXone, call `acd.session.endSession` with `forceLogoff`, `endContacts`, and `ignorePersonalQueue` set to `true`.
1. Select **Reset session**, set the agent to available, and place a test call.
1. If the panel rejoins the old session again, close every other tab or app that's signed in as the agent, or ask the platform administrator to sign the agent out. Then reset again.

To prevent this problem, finish wrap-up and end the agent session before you close or reload the workspace, and use one tab per agent.

### An old call can't be wrapped up, and End session is refused

**Symptom:** A call that ended in an earlier session appears in the panel as disconnected. Its dispositions don't load, saving wrap-up fails, and the panel doesn't end the session because the call isn't wrapped up.

**Cause:** When a session is rejoined, the platform resends contacts left from the earlier session. The platform often can't save their wrap-up anymore.

**Resolution:**

- Flag a contact as a leftover when it already ended the first time the panel receives it. Show a warning, and let the representative remove it from the panel without saving wrap-up.
- Don't let leftovers block ending the session.
- Use **Reset session** to clear leftovers on the platform side as well.

### A wrapped-up call reappears

**Cause:** The SDK can resend a contact after its wrap-up is saved.

**Resolution:** Store the IDs of wrapped-up contacts, and ignore later updates for them.

### The panel signs out after the token refreshes

**Cause:** The panel clears its signed-in state when the SDK refreshes the token.

**Resolution:** Keep the signed-in state on a successful refresh event. Only an explicit failure or sign-out should clear it. Verify the fix with a real token refresh, not a mock.

## Calls and notifications

### No workspace notification appears for an incoming call

**Symptom:** The panel shows the incoming call, but no notification appears in the workspace.

**Cause:** The notification template that the panel names in `notifyEvent` doesn't exist or doesn't match.

**Resolution:** Create the notification template, for example **Incoming call** with **Accept** and **Decline**, a timeout, and a caller field, and use its exact name. Keep **Accept** and **Decline** in the panel as well, so representatives can handle calls without the notification.

### The notification stays open after the call is answered

**Cause:** The route auto-accepts the call, but the panel doesn't close the notification.

**Resolution:** Close the notification when the call is answered, and ignore **Accept** or **Decline** selections that arrive after the call leaves the incoming state.

### The notification closes, but the call is still ringing

**Cause:** The workspace closes notifications on timeout or when its queue limit is reached.

**Resolution:** Don't treat a closed notification as a decline. Only an explicit **Decline** rejects the call. Keep the panel's **Accept** and **Decline** available while the call rings.

### The panel doesn't recognize the test route (NICE CXone)

**Cause:** The contact object includes the dialed number and skill, but not the Studio script name.

**Resolution:** Recognize the route by both the dialed number and the skill, and check that the agent is assigned to that skill.

### An outbound call doesn't ring

**Cause:** Not confirmed.

**Resolution:** Check that voice is ready, the agent has an outbound skill assigned, and the number is in full international format. Use the voice-leg log to confirm that a call was placed.

## Live transcript

Use these entries when live call transcript lines are missing, duplicated, or in the wrong order in the panel.

### No transcript appears (NICE CXone)

**Symptom:** Calls connect, but no transcript lines arrive.

**Resolution:** Check the following items in order:

1. The Studio script for the route runs **Continuous Transcription**.
1. Agent voice transcription is turned on for the agent.
1. `agent.isVoiceTranscriptEnabledAndToggledOn` returns `true` after the session starts. It depends on the agent feature `release-agent-voice-transcription-AW-20973`.
1. The SDK can load the agent's feature list. If the feature-list request from the Dynamics 365 origin fails its CORS check (HTTP 403), the flag stays off, and NICE support must allow the origin.

For a demo only, the panel can force the flag on in memory behind a configuration switch. Don't rely on this workaround in production.

### Transcript messages arrive, but no lines appear (NICE CXone)

**Cause:** The panel expects text, but NICE sends `contactId` as a number and marks final lines with `messageMetaData.completeUtterance` instead of `messageIsCompletedUtterance`.

**Resolution:** Accept both ID types and both final flags. When you debug, log field types, not values.

### Customer lines disappear when the representative speaks

**Cause:** Sequence numbers restart for each speaker, so lines keyed only by contact and sequence number overwrite each other.

**Resolution:** Key lines by contact, speaker, and sequence number, and order them by timestamp.

### Lines repeat, flicker, or go back to partial text

**Resolution:** Replace partial text as updates arrive, ignore partial updates after a line is final, and drop exact duplicates. Use only final lines for notes and AI requests.

### The transcript appears in the vendor's app but not in Dynamics 365

**Cause:** The panel's transcript is for live display only. Storing transcripts in Dynamics 365 for its own AI features needs a separate server-side integration from the vendor.

**Resolution:** Save the final transcript to the case yourself, for example as a note at wrap-up. Treat platform-level transcript delivery as a separate project with the vendor.

## Customers and cases

Use these entries when the panel opens the wrong customer, creates duplicate records, or opens a case form in an unexpected place.

### The wrong customer opens, or no customer opens

**Cause:** Phone numbers arrive in different formats, and a number can match several contacts.

**Resolution:** Normalize the number and search both `telephone1` and `mobilephone` with [`searchAndOpenRecords`](/dynamics365/channel-integration-framework/v2/develop/reference/microsoft-ciframework/searchandopenrecords). If one contact matches, open it. If no contact matches, open a search prefilled with the number. If several contacts match, let the representative choose. Never select one automatically.

### Record search returns an object, not an array

**Resolution:** Parse the JSON string that `searchAndOpenRecords` returns. The result is an object keyed by index (`"0"`, `"1"`, …). Convert it with `Object.values`.

### Duplicate cases or contacts are created after an error

**Cause:** A create request failed on the client, but the record was created on the server.

**Resolution:** Treat a failed create as "outcome unknown." Search for the record before you try again, and keep the ID of every record you create.

### The case form opens in the wrong place

**Cause:** `openForm` opens in the focused session. If the panel's session isn't focused, the form opens elsewhere, and the panel might be hidden.

**Resolution:** Focus or create the panel's call session first, and then call `openForm`.

## Next best action prototype

The entries in this section apply only to the optional prototype that calls the `msdyn_GetIntentNextAction` action. To find out why a suggestion appeared, read the case's `msdyn_intentcontexthistory` row. The row holds every request, tool call, and tool result for that case.

### Every request fails with inner error 50008

**Symptom:** The request returns HTTP 200 with an inner error such as `GetEntityActionPlan API error: 50008 - Intent Core service encountered an error`.

**Cause:** The request is missing `availableActions`. The property is required.

**Resolution:** Send `availableActions`. Send only `ReplyToCustomer` to get words to say rather than tasks.

### One case fails every time with 50000, but other cases work

**Cause:** Not confirmed. The case's history holds a failed state (`lastFailedResponseStatus`), often after a tool fails.

**Resolution:** Test on a new case. Find the failing step in the history before you change instructions.

### The first request on a new case fails once

**Resolution:** Retry once. If the second request succeeds and the history shows no escalation, treat the failure as transient.

### A tool runs before the customer provides the details

**Symptom:** A connector runs with empty inputs, the request fails, and later requests for the case keep failing.

**Cause:** The agent can call an intent's tool as soon as the intent matches. A missing required connector input causes a hard escalation.

**Resolution:** Make connector inputs optional, and return an empty result when they're missing. In the instructions, ask for the details before the tool step.

### An irreversible action happens before the customer confirms

**Cause:** One of the following:

- Requests were sent after representative-only lines, so the agent acted on the representative's words.
- A destructive tool was registered globally and offered on every request.
- The instructions didn't require explicit confirmation.

**Resolution:** Request suggestions only after a new final customer line. Scope destructive tools to their intent. In the instructions, require a read-back of the details and an explicit "yes" before the action. Test with a customer who hesitates.

### The suggestion says a step is done when it isn't

**Cause:** The agent reads a tool result as completed work.

**Resolution:** Scope or remove the tool, and make its result describe what it found, not what it did.

### Suggestions cite unrelated knowledge articles

**Cause:** Knowledge search returns the top results from the whole environment.

**Resolution:** Remove, unpublish, or filter articles that compete with your scenario. Back them up first.

### The intent isn't matched

**Cause:** The customer's first words don't match the intent's name and description, the request sends a different line of business ID, or the intent isn't available to the service yet.

**Resolution:** Compare the customer's opening line with the intent definition, adjust the description or instructions, and test on a new case. If the history shows "No new intents found" for every wording, go to the next entry.

### A new intent or line of business isn't matched

**Symptom:** For an intent you just created, the history shows `_identify_new_intent` returning "No new intents found" on every request, even when the customer uses the intent's exact name. The line of business instructions still load.

**Cause:** One of the following:

- The request sends another line of business ID. The intent lookup searches only the line of business in `intentFamilyId`, and the ID is different in each environment.
- The intent isn't available to the service yet. Availability can take from a few minutes to several hours after the intent is created, whether in Copilot Service admin center or through the Web API. Saving the intent or line of business again doesn't make it available sooner.

**Resolution:** Check `intentFamilyId` in the request. Test an older intent with its own line of business ID. If the older intent works and the new one doesn't, wait and test again. Create intents well before a rehearsal.

### Connector tools don't run in the workspace

**Symptom:** The intent is matched, but the agent never calls its tools, and the tool definitions in the history don't list them.

**Cause:** The connector's connection isn't shared with the agent's service identity.

**Resolution:** In Power Apps, share each custom connector and each of its connections with the **Dynamics 365 Analytics** service principal with **Can use** permission. Sharing only the connector isn't enough. Learn more in [Manage connectors for AI agents](/dynamics365/contact-center/administer/manage-customer-intent-agent#manage-connectors-for-ai-agents-optional) and [Share a custom connector in your organization](/connectors/custom-connectors/share).

### The intent stays the same when the topic changes

**Cause:** The agent keeps the case's first intent and updates only the next step.

**Resolution:** Use a new case for a new scenario.

### "No grounded information available" appears

**Cause:** Knowledge search found nothing to ground the answer.

**Resolution:** Add or publish a relevant article, and test with a clear customer question. Show a friendly message in the panel, such as "No answer in knowledge for this yet."

### No new suggestion appears after the representative speaks

**Cause:** The panel requests suggestions only after a new final customer line, at most every 10 seconds, one at a time.

**Resolution:** Wait for the customer's next line, or select **Refresh**. If suggestions lag a fast conversation, shorten the interval. If they change too often or send too many requests, lengthen it. Below about 8 seconds, requests queue behind slow answers.

### The case history row is very large

**Cause:** Tool definitions and intent mappings repeat in every request. Many or long intents increase the size.

**Resolution:** Remove unused intents, shorten instructions, and send only the case fields that changed. The history table is an elastic table, so a delete operation needs the partition key `<case-id>_incident`. Back up rows first.

## Environments and testing

Use these entries when the panel behaves differently between environments, or when you can't find the cause of a problem in browser traces.

### The backup environment behaves differently

**Cause:** The configuration differs between environments, such as the panel version, channel provider, profile, templates, intents, instructions, tools, connector sharing, or knowledge. The case form can also differ.

**Resolution:** Compare both environments before every rehearsal. Build one panel package per environment when the configuration differs, and confirm that each package's configuration, including its line of business ID, belongs to its environment.

### A browser trace doesn't show anything useful

**Cause:** Filtered or partial developer tools captures can miss startup requests. An open developer tools pane changes the workspace layout.

**Resolution:** Use the panel's activity log first. When you capture a trace, note the filter and reload boundary. Never export HAR files, because they contain tokens.

### A feature switch is on, but the feature doesn't run

**Cause:** A build dropped a runtime configuration value.

**Resolution:** Show the effective configuration in the panel's debug view, and test that each switch reaches the code that uses it.

## Related content

- [Embed a non-Microsoft contact center in Copilot Service workspace](/dynamics365/customer-service/develop/embed-third-party-contact-center)  
- [Overview of Channel Integration Framework 2.0](/dynamics365/channel-integration-framework/v2/administer/overview-channel-integration-framework)  
- [Support single and multiple channel providers](/dynamics365/channel-integration-framework/v2/administer/support-multiple-providers)  
- [Microsoft.CIFramework methods (JavaScript API reference)](/dynamics365/channel-integration-framework/v2/develop/reference/microsoft-ciframework-v2)
