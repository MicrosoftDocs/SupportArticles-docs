---
title: Understand Error Codes
description: Understand error codes so that you can troubleshoot issues in your agent design by using Microsoft Copilot Studio.
ms.date: 06/04/2026
ms.reviewer:
  - jameslew
  - erickinser
  - v-shaywood
ms.custom: sap:Authoring
---

# Understand error codes

When an agent encounters a problem during a conversation, it responds by sending a message that includes an error code for the specific problem. Users of the agent should give this error code to their administrator.

As an agent maker, if a problem occurs when you use the test pane to [test your agent](/microsoft-copilot-studio/authoring-test-bot), you receive a message that contains the error code and more context about the problem. Alternatively, you can use the **Topic checker** panel to [validate your agent's configuration](/microsoft-copilot-studio/authoring-topic-management#view-topic-errors).

## Error list

# [Web app](#tab/webApp)

> [!NOTE]
> The term _dialog_ is used in some error messages to refer to a _topic_.

| Error code                                                                            | Description                                                                                                                                                                        |
| ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [AIModelActionBadRequest](#aimodelactionbadrequest)                                   | There's a mismatch between the prompt action types.                                                                                                                                |
| [AIModelActionRequestTimeout](#aimodelactionrequesttimeout)                           | There's a timeout error related to a call to an AI Builder model.                                                                                                                  |
| [AIPluginOperationNotFound](#aipluginoperationnotfound)                               | There's an error when attempting to access a connected agent.                                                                                                                      |
| [AsyncResponsePayloadTooLarge](#asyncresponsepayloadtoolarge)                         | There's an error related to the output of a connector.                                                                                                                             |
| [AuthenticationNotConfigured](#authenticationnotconfigured)                           | Authentication is required but wasn't configured.                                                                                                                                  |
| [BindingKeyNotFoundError](#bindingkeynotfounderror)                                   | One or more inputs changed on the agent flow (added, removed, or renamed). The agent flow needs to be removed and readded to ensure Copilot Studio has the correct list of inputs. |
| [BingSearchFailed](#bingsearchfailed)                                                 | A system issue occurred while searching Bing knowledge.                                                                                                                            |
| [ConnectedAgentAuthMismatch](#connectedagentauthmismatch)                             | There's an authentication mismatch between the orchestrator and subagent.                                                                                                          |
| [ConnectedAgentBotNotFound](#connectedagentbotnotfound)                               | A subagent in a multi-agent orchestration configuration wasn't found.                                                                                                              |
| [ConnectedAgentBotNotPublished](#connectedagentbotnotpublished)                       | A subagent in a multi-agent orchestration configuration wasn't published.                                                                                                          |
| [ConnectedAgentChainingNotSupported](#connectedagentchainingnotsupported)             | Multi-level agent chaining isn't supported.                                                                                                                                        |
| [ConnectedAgentGptComponentNotFound](#connectedagentgptcomponentnotfound)             | A connected agent is missing descriptions or instructions.                                                                                                                         |
| [ConnectorPowerFxError](#connectorpowerfxerror)                                       | There's an error in the Power Fx expression evaluation in connector actions.                                                                                                       |
| [ConsentNotProvidedByUser](#consentnotprovidedbyuser)                                 | A user interacting with an agent rejected the agent's single sign-on (SSO) request.                                                                                                |
| [ContentError](#contenterror)                                                         | There's an error in the topic content.                                                                                                                                             |
| [ConversationStateTooLarge](#conversationstatetoolarge)                               | The conversation state exceeds the size limits.                                                                                                                                    |
| [DataLossPreventionViolation](#datalosspreventionviolation)                           | There's a data policy violation.                                                                                                                                                   |
| [DataverseFileAttachment429](#dataversefileattachment429)                             | SharePoint throttled Dataverse file attachment search.                                                                                                                             |
| [DataverseSearchFailed](#dataversesearchfailed)                                       | A system issue occurred while searching Dataverse knowledge.                                                                                                                       |
| [DataverseStructured401](#dataversestructured401)                                     | Dataverse structured search returned an authentication error.                                                                                                                      |
| [DataverseStructured429](#dataversestructured429)                                     | Dataverse structured search was throttled.                                                                                                                                         |
| [DataverseStructured500](#dataversestructured500)                                     | Dataverse structured search returned an internal server error.                                                                                                                     |
| [DataverseStructured503](#dataversestructured503)                                     | Dataverse structured search was unavailable.                                                                                                                                       |
| [EnforcementMessageC2](#enforcementmessagec2)                                         | Not enough prepaid capacity is available.                                                                                                                                          |
| [ExecutionTimeout](#executiontimeout)                                                 | A tool or flow action exceeded its configured execution timeout.                                                                                                                   |
| [FlowActionBadRequest](#flowactionbadrequest)                                         | A request that was made to an [agent flow][1] is malformed.                                                                                                                        |
| [FlowActionException](#flowactionexception)                                           | An error occurred while executing an [agent flow][1].                                                                                                                              |
| [FlowActionTimedOut](#flowactiontimedout)                                             | An [agent flow][1] took more than 100 seconds to run and timed out.                                                                                                                |
| [FlowMakerConnectionBlocked](#flowmakerconnectionblocked)                             | An [agent flow][1] was invoked with unauthorized maker credentials in the connection.                                                                                              |
| [FoundryIQSearchFailed](#foundryiqsearchfailed)                                       | A system issue occurred while searching Foundry IQ knowledge.                                                                                                                      |
| [GenAISearchandSummarizeRateLimitReached](#genaisearchandsummarizeratelimitreached)   | The usage limit for generative AI was reached.                                                                                                                                     |
| [GenAIToolPlannerRateLimitReached](#genaitoolplannerratelimitreached)                 | The usage limit for generative orchestration was reached.                                                                                                                          |
| [HTTP400BadRequest](#http400badrequest)                                               | A tool call failed because the request syntax or parameters were invalid.                                                                                                          |
| [HTTP401Unauthorized](#http401unauthorized)                                           | A tool call failed because authentication credentials were missing or expired.                                                                                                     |
| [HTTP403Forbidden](#http403forbidden)                                                 | A tool call failed because the caller is authenticated but lacks permission to access the resource.                                                                                |
| [HTTP404NotFound](#http404notfound)                                                   | A tool call failed because the requested resource doesn't exist.                                                                                                                   |
| [HTTP408RequestTimeout](#http408requesttimeout)                                       | A tool call failed because the request exceeded allowed time limits.                                                                                                               |
| [HTTP422UnprocessableEntity](#http422unprocessableentity)                             | A tool call failed because the request was well formed but contained semantic validation errors.                                                                                   |
| [HTTP429TooManyRequests](#http429toomanyrequests)                                     | A tool call failed because the request rate exceeded service limits.                                                                                                               |
| [HTTP500InternalServerError](#http500internalservererror)                             | A tool call failed because the service encountered an unexpected internal error.                                                                                                   |
| [HTTP502BadGateway](#http502badgateway)                                               | A tool call failed because an upstream service returned an invalid response.                                                                                                       |
| [HTTP503ServiceUnavailable](#http503serviceunavailable)                               | A tool call failed because the service is temporarily unavailable.                                                                                                                 |
| [HTTP504GatewayTimeout](#http504gatewaytimeout)                                       | A tool call failed because the upstream service didn't respond in time.                                                                                                            |
| [InfiniteLoopInBotContent](#infiniteloopinbotcontent)                                 | A node was executed too many times.                                                                                                                                                |
| [InvalidAuthenticationToken](#invalidauthenticationtoken)                             | A tool call failed because the access token format was invalid or corrupted.                                                                                                       |
| [InvalidContent](#invalidcontent)                                                     | Invalid content was added to the code editor.                                                                                                                                      |
| [LatestPublishedVersionNotFound](#latestpublishedversionnotfound)                     | Unable to retrieve the published version of the agent.                                                                                                                             |
| [MsalUiException](#msaluiexception)                                                   | A tool call failed because interactive sign-in is required to acquire a token.                                                                                                     |
| [OpenAIHate](#openaihate)                                                             | Hate content was detected.                                                                                                                                                         |
| [OpenAIJailBreak](#openaijailbreak)                                                   | Jailbreak content was detected.                                                                                                                                                    |
| [OpenAIndirectAttack](#openaindirectattack)                                           | Indirect attack content was detected.                                                                                                                                              |
| [OpenAIRateLimitReached](#openairatelimitreached)                                     | The capacity limit of the agent was reached.                                                                                                                                       |
| [OpenAISelfHarm](#openaiselfharm)                                                     | Self-harm content was detected.                                                                                                                                                    |
| [OpenAISexual](#openaisexual)                                                         | Sexual content was detected.                                                                                                                                                       |
| [OpenAIViolence](#openaiviolence)                                                     | Violence content was detected.                                                                                                                                                     |
| [OperationTimeout](#operationtimeout)                                                 | A specific tool operation timed out before completion.                                                                                                                             |
| [OutgoingMessageSizeTooBig](#outgoingmessagesizetoobig)                               | A message sent by an agent was too large to process.                                                                                                                               |
| [QuotaExceeded](#quotaexceeded)                                                       | A tool call failed because monthly, daily, or concurrency quota limits were exceeded.                                                                                              |
| [RedirectToDisabledDialog](#redirecttodisableddialog)                                 | A topic was [redirecting][2] to a disabled topic.                                                                                                                                  |
| [RedirectToNonExistentDialog](#redirecttononexistentdialog)                           | A topic was [redirecting][2] to another topic that no longer exists.                                                                                                               |
| [SharePoint429](#sharepoint429)                                                       | SharePoint knowledge search was throttled.                                                                                                                                         |
| [SharePoint500](#sharepoint500)                                                       | SharePoint knowledge search returned an internal server error.                                                                                                                     |
| [SharePoint503](#sharepoint503)                                                       | SharePoint knowledge search was unavailable.                                                                                                                                       |
| [SharePointSearchFailed](#sharepointsearchfailed)                                     | A system issue occurred while searching SharePoint knowledge.                                                                                                                      |
| [SystemError](#systemerror)                                                           | A system error occurred in Copilot Studio.                                                                                                                                         |
| [TooMuchDataToHandle](#toomuchdatatohandle)                                           | The request that was made by the user is too large to process.                                                                                                                     |

[1]: /microsoft-copilot-studio/advanced-flow
[2]: /microsoft-copilot-studio/authoring-topic-management#redirect-to-another-topic

#### AIModelActionBadRequest

**Error messages:**

- The output of the prompt evaluated to `{ActualType}` but expected `{ExpectedType}`.

- The input parameter `{ParameterName}` for prompt `{PromptName}` is missing.

- The input parameter `{ParameterName}` for prompt `{PromptName}` is blank but is required.

- Expected: `{ExpectedType}`. Actual: `{ActualType}`.

**Resolution:** This error occurs if a prompt action receives incorrect input or returns unexpected output types. To resolve the problem, take one of the following actions, based on the error:

- _Type mismatch:_ Check your prompt configuration to make sure that the output schema matches the expected variable type.
- _Missing required input:_ Verify that all required inputs are connected to variables that have values.
- _Blank required value:_ Make sure that the variable has a value before you call the prompt.

For more information, see [Create a prompt action](/ai-builder/use-a-custom-prompt-in-mcs#create-a-prompt-action).

#### AIModelActionRequestTimeout

**Error message**: The prompt `prompt-name` execution timed out.

**Resolution**: Make sure that the call to the AI Builder model doesn't exceed 100 seconds.

#### AIPluginOperationNotFound

**Error message**: Sorry, the bot can't talk for a while. It's something the bot's owner needs to address.

**Resolution**: Republish the agent. This error can occur when an agent is published through an import or a solution deployment.

#### AsyncResponsePayloadTooLarge

**Error message**: The output returned from the connector was too large to be handled by the agent. Try reducing its size by utilizing available connector filters or by limiting the number of configured action outputs.

**Resolution**: One of the agent's real-time connectors is returning a payload that's larger than the agent can handle. For more information about the payload limit, see [Copilot Studio web app limits](/microsoft-copilot-studio/requirements-quotas#copilot-studio-web-app-limits).

#### AuthenticationNotConfigured

**Error messages:**

- Authentication is not configured for this bot.

- The bot requires sign in, but is not configured for authentication. Please update the authentication method for the bot.

- Integrated authentication is not supported in channel `{channel}`.

**Resolution:** This error occurs if your agent uses actions or features that require user authentication, but authentication isn't configured. To resolve the problem:

1. In your agent, go to **Settings > Security > Authentication**.
1. Select an appropriate authentication method: **Authenticate with Microsoft** for Microsoft 365 users, or **Authenticate manually** for custom OAuth providers.
1. If the error mentions a specific channel, verify that the channel supports the authentication method that you're using. Some channels don't support integrated authentication.

For more information, see [Configure user authentication](/microsoft-copilot-studio/configuration-end-user-authentication).

#### BindingKeyNotFoundError

**Error messages**:

- Binding '{0}' is not found, refresh this flow to get the latest bindings
- Input binding '{0}' is not found, refresh this flow to get the latest bindings
- Output binding '{0}' is not found, refresh this flow to get the latest bindings

**Resolution**: Check that the agent flow inputs and outputs are set up correctly. Try refreshing the inputs or outputs to resolve this issue. If that doesn't work, try setting up the agent flow again.

To get the latest inputs and outputs, remove and readd the agent flow.

#### BingSearchFailed

**Error message**: This is a system issue on our side. Nothing you need to fix. Error details: Platform runtime - BingSearchFailed.

**Resolution**: A platform-side Bing search failure can cause this issue. Retry later. If the issue continues, contact support.

#### ConnectedAgentAuthMismatch

**Error message:** Your connected agent with schema name `{AgentSchemaName}` has an authentication mismatch with the main agent.

**Resolution:** The orchestrator agent and connected subagent have different authentication configurations. For multi-agent orchestration to work, both agents must use compatible authentication settings. To resolve the problem:

1. Open both agents, and go to **Settings > Security > Authentication**.
1. Make sure that both agents use the same authentication method (for example, both use **Authenticate with Microsoft**).
1. If you're using manual authentication, make sure that both agents are configured to use the same OAuth provider and settings.

The following authentication compatibility rules apply:

- If the connected agent has **No authentication** configured, any orchestrator authentication is acceptable.
- If the connected agent requires authentication, the orchestrator must use the _same_ authentication method.
- **Manual authentication (Generic OAuth2)** on the orchestrator isn't compatible with connected agents that require authentication. Both agents must use the same manual authentication configuration, or the connected agent must have no authentication requirement.

For more information, see [Configure user authentication](/microsoft-copilot-studio/configuration-end-user-authentication) and [Use agents as actions in other agents (preview)](/microsoft-copilot-studio/advanced-use-dispatcher).

#### ConnectedAgentBotNotFound

**Error message:** Connected agent with schema name {AgentSchemaName} not found.

**Resolution:** This error occurs in multi-agent orchestration if the orchestrator agent can't find a connected subagent. To resolve the problem:

1. Verify that the connected agent exists in the same environment as the orchestrator agent.
1. Make sure that the connected agent's schema name is spelled correctly in the orchestrator configuration.
1. Check that you have access permissions to the connected agent.
1. If the connected agent was recently created, wait a few minutes, and then try again.

For more information, see [Use agents as actions in other agents (preview)](/microsoft-copilot-studio/advanced-use-dispatcher).

#### ConnectedAgentBotNotPublished

**Error message:** Connected agent with schema name `{AgentSchemaName}` needs to be published to be invoked.

**Resolution:** The connected subagent must be published before the orchestrator agent can invoke it. To resolve the problem:

1. Open the connected agent in Copilot Studio.
1. Publish the agent.
1. Return to the orchestrator agent, and test again.

For more information, see [Use agents as actions in other agents (preview)](/microsoft-copilot-studio/advanced-use-dispatcher).

#### ConnectedAgentChainingNotSupported

**Error message:** Agent chaining detected. Your agent cannot be connected to agent with schema name `{AgentSchemaName}` as it already has a connected agent.

**Resolution:** Multi-level agent chaining isn't supported. An orchestrator agent can connect to subagents, but those subagents can't have their own connected agents. To resolve the problem:

1. Review your agent architecture, and flatten the hierarchy.
1. Move the functionality from deeply nested agents into either the orchestrator or first-level connected agents.
1. Consider using topics or actions instead of more connected agents.

For more information, see [Use agents as actions in other agents (preview)](/microsoft-copilot-studio/advanced-use-dispatcher).

#### ConnectedAgentGptComponentNotFound

**Error message:** No GPT component found for connected agent with schema name `{AgentSchemaName}`.

**Resolution:** The connected agent is missing a required description or instructions. The orchestrator needs that information to know when to call the connected agent. To resolve the problem:

1. Open the connected agent in Copilot Studio.
1. Go to the agent's **Overview** page.
1. Make sure that the agent has a clear **Description** and **Instructions** configured.
1. After you make changes, publish the connected agent.
1. Return to the orchestrator agent, and test again.

For more information, see [Use agents as actions in other agents (preview)](/microsoft-copilot-studio/advanced-use-dispatcher).

#### ConnectorPowerFxError

**Error message:** Power Fx expression evaluation failed: {ErrorDetails}

**Resolution:** A Power Fx expression that's used in a connector action wasn't evaluated correctly. To resolve the problem:

1. Open the topic that contains the connector action.
1. Review the Power Fx expressions in the action's input parameters.
1. Test the expressions by using sample data to determine the issue.
1. Use the formula bar's error indicators to locate specific problems.

Common causes include:

- Syntax errors.
- Type mismatches, such as comparing text to numbers without conversion.
- Null or blank values. For handling, use functions such as `IsBlank()`, `Coalesce()`, or `IfError()`.
- Invalid function usage.

For more information, see [Use Power Fx in Copilot Studio](/microsoft-copilot-studio/advanced-power-fx).

#### ConsentNotProvidedByUser

**Error message**: No consent provided for SSO connection.

**Resolution**: The user who's interacting with the agent must verify the connection by using the agent's single sign-on (SSO) connection prompt.

#### ContentError

**Error message**: This error produces dynamic messages based on the context of the error.

**Resolution**: This message is a catch-all error for problems that are related to your agent's content. The error message provides more details.

Common problems include:

- A node is missing required properties.
- Invalid YAML was added by using the [code editor](/microsoft-copilot-studio/authoring-create-edit-topics#edit-topics-with-the-code-editor).
- A [Power Fx formula](/microsoft-copilot-studio/advanced-power-fx) contains an error.

#### ConversationStateTooLarge

**Error message:** Conversation state size exceeds the maximum allowed limit.

**Resolution:** The conversation accumulates too much data in its state, exceeding the allowed size limits. To resolve the problem:

1. Reduce variable data by reviewing your topics and reducing the amount of data stored in variables during the conversation.
1. Clear unused variables by setting them to blank if they're no longer needed.
1. Simplify conversation flows by breaking complex conversations into smaller, more focused interactions.
1. Avoid storing large JSON objects, arrays, or text blocks in conversation variables.

To prevent this error:

- Use variables only for data that has to persist across topics.
- Consider using Power Automate flows to store and retrieve large data from external sources instead of keeping it in conversation state.

For more information, see [Copilot Studio quotas and limits](/microsoft-copilot-studio/requirements-quotas).

#### DataLossPreventionViolation

**Error message**: This environment requires users to sign in before they can use the agent. Go to Manage > Security > Authentication and select the option that requires users to sign in.

**Resolution**

- Your environment's data policies require that users sign in. See [Add user authentication with the Sign in system topic](/microsoft-copilot-studio/advanced-end-user-authentication#add-user-authentication-with-the-sign-in-system-topic).
- One or more connectors that you use in the agent aren't in the same data group. See [Copilot Studio connectors](/microsoft-copilot-studio/admin-data-loss-prevention#copilot-studio-connectors-and-data-groups).
- The tenant administrator blocked one or more connectors that you use in the agent.

#### DataverseFileAttachment429

**Error message**: SharePoint is limiting requests right now. Try again later. Error details: DataverseFiles429.

**Resolution**: Service throttling can cause this error. Wait and retry.

#### DataverseSearchFailed

**Error message**: This is a system issue on our side. Nothing you need to fix. Error details: Platform runtime - DataverseSearchFailed.

**Resolution**: Dataverse knowledge search failures, such as user connection errors, can cause this issue. To resolve the problem:

1. Open the agent knowledge source settings, and reauthenticate the Dataverse connection.
1. Verify that the user has valid licensing and permissions for the Dataverse knowledge source.
1. If the issue persists after reauthentication, contact support.

#### DataverseStructured401

**Error message**: Search ran into an authentication issue. This usually resolves on its own. Nothing to fix on your side. Error details: Dataverse401.

**Resolution**: This error can indicate missing permissions for the agent's identity or user account. To resolve the problem:

1. Grant the required Dataverse knowledge search permissions to the agent's service principal.
1. Verify that the knowledge source environment matches the agent's environment.
1. Retry after permission updates.

For more information, see [Troubleshoot enterprise knowledge sources](../knowledge/enterprise-data.md).

#### DataverseStructured429

**Error message**: Dataverse is limiting requests right now. Try again later. Error details: Dataverse429.

**Resolution**: The service was throttled or timed out. To reduce recurrence:

1. Retry with exponential backoff.
1. Reduce knowledge source size where possible.
1. Spread large query loads over time.

For more information, see [Microsoft Graph throttling guidance](/graph/throttling).

#### DataverseStructured500

**Error message**: This isn't a configuration problem. The owning service needs to investigate. Error details: Dataverse500.

**Resolution**: A service-side issue can cause this error. Retry later. If the issue continues, contact support.

#### DataverseStructured503

**Error message**: This isn't a configuration problem. The owning service needs to investigate. Error details: Dataverse503.

**Resolution**: Temporary service unavailability can cause this error. Retry later.

#### EnforcementMessageC2

**Error message**: This agent is currently unavailable. It has reached its usage limit. Please try again later.

**Resolution**: This message appears if an agent reaches its message capacity or the pay-as-you-go meter reaches its limit. To resolve the problem, add more prepaid capacity or create a pay-as-you-go billing plan. The agent chat should then resume working within five minutes. For more information, see [Overage Enforcement](/microsoft-copilot-studio/requirements-messages-management#overage-enforcement).

#### ExecutionTimeout

**Error message**: This tool call timed out. The operation took too long to complete. Error details: Timeout · execution.

**Resolution**: Long-running execution paths can cause this error. To resolve the problem:

1. Break large workflows into smaller steps.
1. Optimize query and transformation logic.
1. Remove unnecessary actions from the critical path.
1. Validate loops and branching conditions for inefficiencies.

#### FlowActionBadRequest

**Error messages**:

- The parameter with name {KeyName} on flow {FlowName} ({FlowId}) is declared to be of type {ItemTypeKind}. This type isn't supported when invoking Power Automate. Currently, only Text, Boolean and Numbers are supported.
- The parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing in the 'Call Flow' action.
- The parameter with name {KeyName} on flow {FlowName} ({FlowId}) evaluated to type {ResolveType}, expected type {ExpectedType}.
- The flow {FlowName} ({FlowId}) failed to run with response code {ResponseCode}, error code: {FlowErrorCode}.

**Resolution**: Verify that the [base type](/microsoft-copilot-studio/authoring-variables-about#variable-types) of any variables that you pass to the flow matches the parameter type. For more information, see [FlowActionBadRequest agent error in channels](../channels/agent-flow-action-bad-request.md)

#### FlowActionException

**Error messages**:

- No output was received from flow {FlowName} ({FlowId}), even though output was expected as per the agent definition.
- The output parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing from the response data. Refresh the flow, or ensure the flow returns this value.
- The output parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing from the output schema. Please refresh the flow.

**Resolution**: [Check the flow for errors](/power-automate/error-checker).

#### FlowActionTimedOut

**Error message**: The flow with id {FlowId} has timed out. Error Code: {FlowErrorCode}

**Resolution**: [Check the flow for errors](/power-automate/error-checker) to understand why the cloud flow took more than 100 seconds to run before it returned to your agent. Try to optimize the query and the data that you return from the back-end system. If some of the cloud flow logic can continue to run after a result is sent to the agent, put these actions after the "Return value(s) to Copilot Studio" step in your cloud flow.

#### FlowMakerConnectionBlocked

**Error message**: The flow with name `{FlowName}` is using a maker connection, which isn't allowed. Error Code: `{FlowMakerConnectionBlocked}`

**Resolution**: The administrator prevents using maker credentials in a connection invoked from the agent flow. [Open the flow in Power Automate](/power-automate/overview-manage-cloud-flows#open-the-details-screen-for-a-flow) and [share the cloud flow by using run-only permissions](/power-automate/create-team-flows#share-a-cloud-flow-with-run-only-permissions).

#### FoundryIQSearchFailed

**Error message**: This is a system issue on our side. Nothing you need to fix. Error details: Platform runtime - FoundryIQSearchFailed.

**Resolution**: A platform-side Foundry IQ search failure can cause this issue. Retry later. If the issue continues, contact support.

#### GenAISearchandSummarizeRateLimitReached

**Error message**: The usage limit for search and summarize has been reached. Please try again later.

**Resolution**: The agent returns this message if it reaches its [generative AI limit](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent) to search and summarize sources. For more information, see [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### GenAIToolPlannerRateLimitReached

**Error message**: The usage limit for generative orchestration has been reached. Please try again later.

**Resolution**: The agent returns this message if it reaches its [generative orchestration limit](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent). For more information, see [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### HTTP400BadRequest

**Error message**: Bad Request.

**Resolution**: Malformed payloads or invalid parameters can cause this error. To resolve the problem:

1. Verify that all required parameters are present.
1. Confirm that data types match the action schema.
1. Test with known-good sample data.
1. Validate the JSON formatting for complex payloads.

#### HTTP401Unauthorized

**Error message**: Unauthorized.

**Resolution**: This error can be caused by missing or expired authentication credentials. To resolve the problem:

1. Verify that the connector is configured correctly in Copilot Studio.
1. Check whether the OAuth token expired, and reauthenticate the connection.
1. Validate the API key or connection settings.
1. Test the connection before deploying.
1. If you use service principal authentication, verify that the credentials weren't rotated.

#### HTTP403Forbidden

**Error message**: Forbidden.

**Resolution**: This error can be caused by missing permissions in the target system. To resolve the problem:

1. Verify that the user or app has the required roles and permissions.
1. Check app registration permissions and admin consent requirements.
1. Verify resource-level sharing and delegation settings.
1. Confirm that tenant and environment scoping are correct.

#### HTTP404NotFound

**Error message**: Not Found.

**Resolution**: Missing or incorrect resource identifiers can cause this error. To resolve the problem:

1. Verify that the resource ID or URL is correct.
1. Confirm that the resource still exists.
1. Verify that the environment and tenant selection are correct.
1. Prefer dynamic resource selection over manually typed IDs.

#### HTTP408RequestTimeout

**Error message**: This tool call timed out. The operation took too long to complete. Error details: Timeout · execution.

**Resolution**: Exceeding client or network time limits can cause this error. To resolve the problem:

1. Check network stability and latency.
1. Reduce payload size where possible.
1. Add retries with incremental backoff.
1. Use asynchronous patterns for long-running operations.

#### HTTP422UnprocessableEntity

**Error message**: Unprocessable Entity.

**Resolution**: Semantic validation failures can cause this error. To resolve the problem:

1. Validate field-level formats and allowed values.
1. Add data validation before the tool call.
1. Check business rule constraints.
1. Retry with known-good sample data.

#### HTTP429TooManyRequests

**Error message**: Too Many Requests.

**Resolution**: Throttling limits can cause this error. To resolve the problem:

1. Add delays between calls.
1. Implement exponential backoff retries.
1. Limit concurrency for batch operations.
1. Respect `Retry-After` headers when present.
1. Monitor usage and throttling in analytics.

#### HTTP500InternalServerError

**Error message**: This tool is temporarily unavailable. The service didn't respond or is currently unavailable. Error details: Service availability · 5xx.

**Resolution**: A service-side issue can cause this error. To resolve the problem:

1. Retry the request because transient failures are common.
1. Check connector and service health dashboards for active incidents.
1. Add a retry policy with exponential backoff.
1. If the issue persists, collect request timestamp and correlation details, and contact support.

#### HTTP502BadGateway

**Error message**: This tool is temporarily unavailable. The service didn't respond or is currently unavailable. Error details: Service availability · 5xx.

**Resolution**: Invalid responses from upstream dependencies can cause this error. To resolve the problem:

1. Wait, and retry after a short delay.
1. Validate the endpoint URL and connector configuration.
1. Add retries with exponential backoff.
1. If the issue persists, check vendor status pages and connector documentation.

#### HTTP503ServiceUnavailable

**Error message**: This tool is temporarily unavailable. The service didn't respond or is currently unavailable. Error details: Service availability · 5xx.

**Resolution**: This error can be caused by temporary service outages or overload. To resolve the problem:

1. Retry later with longer backoff.
1. Check service health for planned maintenance or incidents.
1. Defer noncritical operations until the service stabilizes.
1. Implement circuit-breaker style controls for repeated failures.

#### HTTP504GatewayTimeout

**Error message**: This tool is temporarily unavailable. The service didn't respond or is currently unavailable. Error details: Service availability · 5xx.

**Resolution**: Slow upstream processing or network latency can cause this error. To resolve the problem:

1. Retry the operation, and verify whether the back-end service completed the work despite the timeout.
1. Reduce payload size, and optimize expensive queries.
1. Break large operations into smaller batches.
1. Increase the configured timeout where supported.

#### InfiniteLoopInBotContent

**Error message**: Action {DialogId}.{TriggerId}.{ActionId} was executed more than {MaxTurnCount} times in a row. This indicates a cycle in execution of the dialog and hence dialog execution will be terminated.

**Resolution**: Make sure that the topic ends correctly and links to other topics that end correctly, such as the **Escalate** system topic.

#### InvalidAuthenticationToken

**Error message**: InvalidAuthenticationToken.

**Resolution**: Malformed or stale token data can cause this error. To resolve the problem:

1. Remove and recreate the connection.
1. Reauthenticate the connector.
1. Clear the browser or app cache if applicable.
1. Retry the flow.

#### InvalidContent

**Error message**: A total of {TotalComponents} component(s) exist in the agent, but none are valid.

**Resolution**: [Open the code editor](/microsoft-copilot-studio/authoring-create-edit-topics#edit-topics-with-the-code-editor) to review problems that affect the content.

#### LatestPublishedVersionNotFound

**Error message**: Unable to retrieve the latest published version of the agent.

**Resolution**: [Publish the agent](/microsoft-copilot-studio/publication-fundamentals-publish-channels).

#### MsalUiException

**Error message**: MsalUiException.

**Resolution**: This error can be caused when silent token acquisition fails and interactive sign-in is required. To resolve the problem:

1. Sign out, and sign in again to refresh your token.
1. Complete any interactive authentication prompts.
1. Retry the tool call after authentication completes.

#### OpenAIHate

**Error message**: The content was filtered due to Responsible AI restrictions.

A Responsible AI check blocks the content that's considered to be hateful. Hateful content refers to any content that attacks or uses discriminatory language against a person or identity group based on certain differentiating attributes of these groups.

This restriction includes, but isn't limited to, content about:

- Race, ethnicity, nationality
- Gender identity groups and expression
- Sexual orientation
- Religion
- Personal appearance and body size
- Disability status
- Harassment and bullying

**Resolution**: To avoid this situation, reinforce responsible AI guidelines together with your agent users. You can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAIJailBreak

**Error message**: The content was filtered due to Responsible AI restrictions.

A security check blocks the content of a jailbreak attempt. A jailbreak attempt is a user prompt attack that ignores system prompts and tries to alter the intended agent behavior. These attacks include attempts to change system rules, embedding a conversation mockup to confuse the model, role-play, and encoding attacks. For more information, see [Prompt Shields in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/jailbreak-detection).

**Resolution**: To avoid this situation, reinforce responsible AI guidelines together with your agent users. You can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAIndirectAttack

**Error message**: The content was filtered due to Responsible AI restrictions.

An attack was detected from information that's not directly supplied by the agent author or the user, such as external documents. Attackers try to embed instructions in grounded data that's provided by the user to maliciously gain control of the system by:

- Manipulating content
- Intrusion
- Unauthorized data exfiltration or data removal from a system
- Blocking system capabilities
- Fraud
- Code execution and infecting other systems

For more information, see [Prompt Shields for documents](/azure/ai-services/content-safety/concepts/jailbreak-detection#prompt-shields-for-documents).

**Resolution**: If you're testing, and you didn't intend the test to be an attack, make sure that your instructions align with what you want the agent to be able to do. Otherwise, reinforce responsible AI guidelines together with your agent users to avoid this situation.

#### OpenAIRateLimitReached

**Error message**: An error has occurred.

**Resolution**: Your agent reached the maximum number of generative answer responses. Review your [message capacity](/microsoft-copilot-studio/requirements-messages-management), and review the information in [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### OpenAISelfHarm

**Error message**: The content was filtered due to Responsible AI restrictions.

A Responsible AI check blocked content that's related to self-harm. Self-harm describes language that's related to physical actions that are intended to purposely hurt, injure, damage one's body, or kill oneself.

This restriction includes, but isn't limited to, content about:

- Eating disorders
- Bullying and intimidation

**Resolution**: To avoid this situation, reinforce responsible AI guidelines together with your agent users. You can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAISexual

**Error message**: The content was filtered due to Responsible AI restrictions.

A Responsible AI check blocked content that's considered to be sexual. Sexual content describes language that's related to anatomical organs and genitals, romantic relationships, sexual acts, and acts that are portrayed in erotic or affectionate terms, including those portrayed as an assault or an act of sexual violence.

This restriction includes, but isn't limited to, content about:

- Vulgar content
- Prostitution
- Nudity and pornography
- Abuse
- Child exploitation, child abuse, child grooming

**Resolution**: To avoid this situation, reinforce responsible AI guidelines together with your agent users. You can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAIViolence

**Error message**: The content was filtered due to Responsible AI restrictions.

A Responsible AI check blocked content that's considered to be violent. Violent content describes language that's related to physical actions that are intended to hurt, injure, damage, or kill someone or something. It also describes weapons, guns, and related entities.

This restriction includes, but isn't limited to, content about:

- Weapons
- Bullying and intimidation
- Terrorist and violent extremism
- Stalking

**Resolution**: To avoid this situation, reinforce responsible AI guidelines together with your agent users. You can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OperationTimeout

**Error message**: This tool call timed out. The operation took too long to complete. Error details: Timeout · execution.

**Resolution**: Operation-level timeouts in dependent services can cause this error. To resolve the problem:

1. Narrow query scope, and add filtering.
1. Add retry with backoff for transient timeouts.
1. Use pagination for large result sets.
1. Review target service performance and request limits.

#### OutgoingMessageSizeTooBig

**Error message**: Outgoing message size too large.

**Resolution**: Depending on the channel that you use to transfer files, such as Direct Line or Facebook, you might receive the following error message: "The request content length exceeded limit of 262,144 bytes." The [channel](/azure/bot-service/bot-service-resources-faq-general?azure-bot-service-4.0#what-is-the-size-limit-of-a-file-transferred-using-channels&preserve-view=true) imposes these limits, not Copilot Studio.

In this scenario, consider a few options. One option is to provide a link to the resource as an internet attachment. Another option is to review your nodes to make sure that none of them use a variable that contains a large volume of text, such as a `JSON.stringify()` static method. If you use this method or a variable that contains a large volume of text, modify the node to pass only the portion of text that's necessary. For example, if you use an Adaptive Card to pass data to another topic, update the variable to pass only the necessary property.

For more information, see [Maximum channel data message size limits when using Copilot Studio in Omnichannel](/microsoft-copilot-studio/requirements-quotas#maximum-channel-data-message-size-limits-when-using-copilot-studio-in-omnichannel).

#### QuotaExceeded

**Error message**: QuotaExceeded.

**Resolution**: Exhausted monthly, daily, or concurrency entitlements can cause this error. To resolve the problem:

1. Check usage in admin analytics.
1. Reduce unnecessary tool calls.
1. Consolidate operations where possible.
1. Review and upgrade licensing or quota plans if needed.

#### RedirectToDisabledDialog

**Error message**: The Dialog with Id {DialogId} is disabled in the definition. Please enable the Dialog before using it.

**Resolution**: [Re-enable the topic](/microsoft-copilot-studio/authoring-topic-management) or [remove the redirect node](/microsoft-copilot-studio/authoring-create-edit-topics#delete-a-node).  

#### RedirectToNonExistentDialog

**Error message**: The Dialog with Id {DialogId} wasn't found in the definition. Please check that the Dialog is present and that the Id is correct.

**Resolution**: [Create a new topic](/microsoft-copilot-studio/authoring-create-edit-topics#create-a-topic) to redirect to, or [remove the redirect node](/microsoft-copilot-studio/authoring-create-edit-topics#delete-a-node).

#### SharePoint429

**Error message**: SharePoint is limiting requests right now. Try again later. Error details: SharePoint429.

**Resolution**: Service throttling can cause this error. Wait and retry.

#### SharePoint500

**Error message**: This isn't a configuration problem. The owning service needs to investigate. Error details: SharePoint500.

**Resolution**: A service-side issue can cause this error. Retry later. If the issue continues, contact support.

#### SharePoint503

**Error message**: This isn't a configuration problem. The owning service needs to investigate. Error details: SharePoint503.

**Resolution**: Temporary service unavailability can cause this error. Retry later.

#### SharePointSearchFailed

**Error message**: This is a system issue on our side. Nothing you need to fix. Error details: Platform runtime - SharePointSearchFailed.

**Resolution**: A platform-side SharePoint search failure can cause this issue. Retry later. If the issue continues, contact support.

#### SystemError

**Error message**: This error doesn't produce an error message.

**Resolution**: [Contact customer support](/microsoft-copilot-studio/fundamentals-support).

#### TooMuchDataToHandle

**Error message**: The request is resulting in too much data to handle, please evaluate the amount of data being returned by your actions.

**Resolution**: This error indicates that the request that was sent to OpenAI exceeds the maximum request size that's allowed. The request includes the user input, output from previous actions, tools that were called, and conversation history. Review the tools that you use. If it's possible, scope down their output to only the necessary fields. For more information, see [Create a Power Automate flow](/microsoft-copilot-studio/advanced-flow-create) and [Call a Power Automate flow as an action](/microsoft-copilot-studio/advanced-use-flow).

# [Classic/Teams](#tab/classic+teams)

| Error                   | Bot response                                                                                                                                                             | Resolution                                                                                                                                                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **2000**                | "The user is trapped in an infinite loop. Check to make sure `{Topic Name}` reaches a logical conclusion."                                                               | Make sure that the topic ends correctly, or links to other topics that end correctly, such as the [Escalate][3] system topic.                                                                                             |
| **2001**                | "The bot content is invalid."                                                                                                                                            | [Check the topic for errors][4].                                                                                                                                                                                          |
| **2002**                | "We ran into an issue with CDS."                                                                                                                                         | A problem occurred when you tried to access the [Dataverse][5]. Check your configuration for errors. Otherwise, try again later because a service issue might exist.                                                      |
| **2003**                | "There's a problem with `{Flow Name}` in `{Topic Name}`. Please check your content."                                                                                     | [Check the flow for errors][6] and [look for failed runs in the flow run history][7].                                                                                                                                     |
| **2004**                | "There's a problem with `{Skill Name}` in `{Topic Name}`. Please check your content."                                                                                    | A problem affects your skill. Check both [the skill][15] and [topic][9] for errors messages.                                                                                                                              |
| **2005**                | "We ran into a problem. Please check your content."                                                                                                                      | A problem affects your Power Automate Flow template. [Check the flow for errors][6].                                                                                                                                      |
| **2006**                | "We couldn't find your bot."                                                                                                                                             | Your bot couldn't be found because the bot, or its environment, was deleted. To configure a new bot, see [Create and delete agents][10]. To configure a new environment, see [Work with Power Platform environments][11]. |
| **2007**                | "The bot contains too much content to be able to work."                                                                                                                  | Reduce message lengths or number of topics, then try again. Read more about [content limits][12].                                                                                                                         |
| **2008**                | "We couldn't find the user's token."                                                                                                                                     | Check your bot's [authorization configuration][13] for errors.                                                                                                                                                            |
| **2009**                | "To use this bot, publish it in Copilot Studio."                                                                                                                         | To use this bot, [publish it in Copilot Studio][14].                                                                                                                                                                      |
| **2010**                | "We can't retrieve your bot content."                                                                                                                                    | Content couldn't be found because it was deleted. To configure a new agent, see [Create and delete agents][10]. To configure a new environment, see [Work with Power Platform environments][11].                          |
| **2011**                | "We couldn't find `{Skill Name}` in `{Topic Name}`. Please check your content."                                                                                          | Your skill couldn't be found because it was deleted. To create a skill, see [Configure a Bot Framework skill][15].                                                                                                        |
| **2012**                | "We couldn't find `{Flow Name}` in `{Topic Name}`. Please check your content."                                                                                           | Your Power Automate Flow couldn't be found because it was deleted. To create a flow, see [Create a flow][16].                                                                                                             |
| **2014**                | "The translation service didn't respond."                                                                                                                                | Try again later. If the issue persists, [contact customer support][17].                                                                                                                                                   |
| **2015**                | "You're not authorized to call `{Skill Name}`. Please check the skill and its usage for any issues."                                                                     | Check your [skill's configuration][15], and also check whether your bot is [added to the skill's allow list][18].                                                                                                          |
| **2016**                | "Sorry, we couldn't find your bot."                                                                                                                                      | A problem affects an [Azure Bot Service channel][19]. The channel might be deleted or configured incorrectly.                                                                                                             |
| **2017**                | "Sorry, we couldn't access your bot."                                                                                                                                    | The [Azure Bot Service channel][19] couldn't be accessed. Check the channel configuration for authentication issues.                                                                                                      |
| **2018**                | "The user is typing too fast."                                                                                                                                           | You sent messages too quickly. Read more about [quotas and limits within Copilot Studio][11].                                                                                                                             |
| **2019**                | "We couldn't find your environment. It may have been deleted."                                                                                                           | Your environment was deleted. To configure a new environment, see [Work with Power Platform environments][11].                                                                                                            |
| **2020**                | "Something happened, and `{Flow Name}` isn't working in `{Topic Name}`. Try again later. If the issue persists, check your flow's setup and run history."                | Your Power Automate flow isn't working. Try again later. If the issue persists, [check the flow for errors][6].                                                                                                           |
| **2021**                | "Number of dialogs executed in the current turn exceeded the maximum of `{Dialog Limit}`."                                                                               | By default, the maximum number of topics is 50. Reduce the number of topics, then try again.                                                                                                                              |
| **2022**                | "The bot sent more than `{Message Limit}` messages in this turn."                                                                                                        | Limit messages per turn to less than 30.                                                                                                                                                                                  |
| **2024**                | "This environment requires users to sign in before they can use the bot. Go to Manage > Security > Authentication and select the option that requires users to sign in." | Your environment data policies require that users sign in. To learn how to require users to sign in, see [Configure user authentication][20].                                                                             |
| **2025**                | "There are one or more empty nodes in topic `{Topic Name}`, Please check your content."                                                                                  | Add content to empty nodes or remove them from the topic.                                                                                                                                                                 |
| **2025**                | "`{Topic Name}` is redirecting to a topic, which has been turned off. Return to `{Topic Name}` and check your content."                                                  | Your topic is [redirecting][2] to another topic that has been turned off. [Turn on the other topic][21] or [remove the redirect node][22].                                                                                |
| **2025**                | "The topic you're trying to redirect to no longer exists. Return to `{Topic Name}` and check your content."                                                              | The topic you're trying to [redirect][2] to no longer exists. [Create a topic][23] to redirect to or [remove the redirect node][22].                                                                                      |
| **2026**                | "There was a problem with the Power Automate Flow. Please check your content."                                                                                           | [Check the flow for errors][6].                                                                                                                                                                                           |
| **2030**                | "Check Power Automate flow run history and ensure that flow ran successfully."                                                                                           |                                                                                                                                                                                                                           |
| **2100** _(Teams only)_ | "The user is typing too fast."                                                                                                                                           | Interactions with the bot are rate-limited to mitigate spam. Try again while typing slower.                                                                                                                               |
| **2101**                | "The user's conversation with the bot was too long or the user's message was too long."                                                                                  | Try to restart the conversation with the bot or use a shorter message.                                                                                                                                                    |
| **2102**                | "The user sent a message which is too large to process."                                                                                                                 | You sent a message that's too large to process. Shorten your message, then try again.                                                                                                                                     |
| **3000**                | "Unexpected error"                                                                                                                                                       | A system error occurred. [Contact customer support][17] for more details.                                                                                                                                                 |
| **3001**                | "Power Automate isn't available for your flow `{Flow Name}` now. Try again later."                                                                                       | Power Automate isn't responding. Restart the conversation with your bot, and try again. If the issue persists, [contact customer support][17].                                                                            |
| **3002**                | "Something happened in Power Automate, and your request to your flow `{Flow Name}` wasn't accepted. Try again later."                                                    | An error occurred in Power Automate, and the request to your flow isn't accepted. Your flow might take more than two minutes to respond.                                                                                  |
| **3003**                | "There's a network problem connecting to your flow `{Flow Name}`. Please try again later."                                                                               | Try again later. If the issue persists, [contact customer support][17].                                                                                                                                                   |

[3]: /microsoft-copilot-studio/advanced-hand-off
[4]: /microsoft-copilot-studio/authoring-topic-management#view-topic-errors
[5]: /powerapps/maker/data-platform/data-platform-intro
[6]: /power-automate/error-checker
[7]: /power-automate/fix-flow-failures#identify-the-error
[9]: /microsoft-copilot-studio/authoring-topic-management#view-topic-errors
[10]: /microsoft-copilot-studio/authoring-first-bot
[11]: /microsoft-copilot-studio/environments-first-run-experience
[12]: /microsoft-copilot-studio/requirements-quotas
[13]: /microsoft-copilot-studio/advanced-end-user-authentication
[14]: /microsoft-copilot-studio/publication-fundamentals-publish-channels
[15]: /microsoft-copilot-studio/configuration-add-skills
[16]: /microsoft-copilot-studio/advanced-flow-create
[17]: /microsoft-copilot-studio/fundamentals-support
[18]: /azure/bot-service/skill-implement-skill
[19]: /microsoft-copilot-studio/publication-connect-bot-to-azure-bot-service-channels
[20]: /microsoft-copilot-studio/configuration-end-user-authentication#required-user-sign-in-and-agent-sharing
[21]: /microsoft-copilot-studio/authoring-topic-management#turn-a-topic-on-or-off
[22]: /microsoft-copilot-studio/authoring-create-edit-topics
[23]: /microsoft-copilot-studio/authoring-create-edit-topics#create-a-topic

---
