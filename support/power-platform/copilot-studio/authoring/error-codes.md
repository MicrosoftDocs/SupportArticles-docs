---
title: "Understand error codes"
description: "Understand error codes to troubleshoot issues in your agent design with Microsoft Copilot Studio."
ms.date: 10/02/2025
ms.reviewer:
  - jameslew
  - erickinser
  - v-shaywood
ms.custom: sap:Authoring
---

# Understand error codes

When an agent encounters a problem during a conversation, it responds with a message that includes an error code for the specific problem that was encountered. Users of the agent should give this error code to their administrator.

As an agent maker, if a problem occurs when you're using the test pane to [test your agent](/microsoft-copilot-studio/authoring-test-bot), you can see a message with more context about the problem, in addition to the error code. Alternatively, you can use the **Topic checker** panel to [validate your agent](/microsoft-copilot-studio/authoring-topic-management#view-topic-errors).

## Error list

# [Web app](#tab/webApp)

> [!NOTE]
> The term _dialog_ used in some error messages refers to a _topic_.

| Error code                                                        | Description                                                         |
| ----------------------------------------------------------------- | ------------------------------------------------------------------- |
| [AIModelActionRequestTimout](#aimodelactionrequesttimeout)        | There's a timeout error related to a call to an AI Builder model.   |
| [AsyncResponsePayloadTooLarge](#asyncresponsepayloadtoolarge)     | There's an error related to the output of a connector.              |
| [ContentError](#contenterror)                                     | There's an error in the topic content.                              |
| [ConsentNotProvidedByUser](#consentnotprovidedbyuser)             | A user interacting with an agent rejects the agent's SSO request.   |
| [DataLossPreventionViolation](#datalosspreventionviolation)       | There was a data policy violation.                                  |
| [EnforcementMessageC2](#enforcementmessagec2)                     | Not enough prepaid capacity was available.                          |
| [FlowActionBadRequest](#flowactionbadrequest)                     | A request made to an [agent flow][1] was malformed.                 |
| [FlowActionException](#flowactionexception)                       | An error occurred while executing an [agent flow][1].               |
| [FlowActionTimedOut](#flowactiontimedout)                         | An [agent flow][1] took more than 100 seconds to run and timed out. |
| [FlowMakerConnectionBlocked](#flowmakerconnectionblocked)         | An [agent flow][1] invoked with unauthorized maker credentials in connection. |
| [GenAISearchandSummarizeRateLimitReached](#genaisearchandsummarizeratelimitreached) | The usage limit for generative AI was reached.    |
| [GenAIToolPlannerRateLimitReached](#genaitoolplannerratelimitreached) | The usage limit for generative orchestration was reached.       |
| [InfiniteLoopInBotContent](#infiniteloopinbotcontent)             | A node was executed too many times.                                 |
| [InvalidContent](#invalidcontent)                                 | Invalid content was added to the code editor.                       |
| [LatestPublishedVersionNotFound](#latestpublishedversionnotfound) | Unable to retrieve the published version of the agent.              |
| [OpenAIHate](#openaihate)                                         | Hate content was detected.                                          |
| [OpenAIJailBreak](#openaijailbreak)                               | Jailbreak content was detected.                                     |
| [OpenAIndirectAttack](#openaindirectattack)                       | Indirect attack content was detected.                               |
| [OpenAISelfHarm](#openaiselfharm)                                 | Self-harm content was detected.                                     |
| [OpenAISexual](#openaisexual)                                     | Sexual content was detected.                                        |
| [OpenAIRateLimitReached](#openairatelimitreached)                 | The capacity limit of the agent was reached.                        |
| [OpenAIViolence](#openaiviolence)                                 | Violence content was detected.                                      |
| [OutgoingMessageSizeTooBig](#outgoingmessagesizetoobig)           | A message sent by an agent is too large to process.                 |
| [RedirectToDisabledDialog](#redirecttodisableddialog)             | A topic is [redirecting][2] to a disabled topic.                    |
| [RedirectToNonExistentDialog](#redirecttononexistentdialog)       | A topic is [redirecting][2] to another topic that no longer exists. |
| [SystemError](#systemerror)                                       | A system error occurred in Copilot Studio.                          |
| [TooMuchDataToHandle](#toomuchdatatohandle)                       | The request made by the user is too large to process.               |

[1]: /microsoft-copilot-studio/advanced-flow
[2]: /microsoft-copilot-studio/authoring-topic-management#redirect-to-another-topic

#### AIModelActionRequestTimeout

**Error message**: The prompt `prompt-name` execution timed out.

**Resolution**: Ensure that the call to the AI Builder model doesn't exceed 100 seconds.

#### AsyncResponsePayloadTooLarge

**Error message**: The output returned from the connector was too large to be handled by the agent. Try reducing its size by utilizing available connector filters or by limiting the number of configured action outputs.

**Resolution**: One of the agent's real-time connectors is returning a payload that's larger than the agent can handle. For more information regarding the payload limit, see [Copilot Studio web app limits](/microsoft-copilot-studio/requirements-quotas#copilot-studio-web-app-limits).

#### ContentError

**Error message**: This error produces dynamic messages based on the context of the error.

**Resolution**: This message is a catch-all error for problems related to your agent's content. The error message provides more details.

Common problems include:

- A node is missing required properties.
- Invalid YAML was added with the [code editor](/microsoft-copilot-studio/authoring-create-edit-topics#edit-topics-with-the-code-editor).
- A [Power Fx formula](/microsoft-copilot-studio/advanced-power-fx) contains an error.

#### ConsentNotProvidedByUser

**Error message**: No consent provided for SSO connection.

**Resolution**: The user interacting with the agent must confirm the connection using the agent's single sign-on connection prompt.

#### DataLossPreventionViolation

**Error message**: This environment requires users to sign in before they can use the agent. Go to Manage > Security > Authentication and select the option that requires users to sign in.

**Resolution**:

- Your environment's data policies require that users sign in. See [Add user authentication with the Sign in system topic](/microsoft-copilot-studio/advanced-end-user-authentication#add-user-authentication-with-the-sign-in-system-topic).
- One or more connectors that are used in the agent aren't in the same data group. See [Copilot Studio connectors](/microsoft-copilot-studio/admin-data-loss-prevention#copilot-studio-connectors-and-data-groups).
- One or more connectors that are used in the agent were blocked by the tenant administrator.

#### EnforcementMessageC2

**Error message**: This agent is currently unavailable. It has reached its usage limit. Please try again later.

**Resolution**: This message is returned when an agent has reached its message capacity or the pay-as-you-go meter has reached its limit. To resolve the issue, add more prepaid capacity or create a pay-as-you-go billing plan. The agent chat should then resume working within 5 minutes. For more information, go to [Overage Enforcement](/microsoft-copilot-studio/requirements-messages-management#overage-enforcement).

#### FlowActionBadRequest

**Error messages**:

- The parameter with name {KeyName} on flow {FlowName} ({FlowId}) is declared to be of type {ItemTypeKind}. This type isn't supported when invoking Power Automate. Currently, only Text, Boolean and Numbers are supported.
- The parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing in the 'Call Flow' action.
- The parameter with name {KeyName} on flow {FlowName} ({FlowId}) evaluated to type {ResolveType}, expected type {ExpectedType}.
- The flow {FlowName} ({FlowId}) failed to run with response code {ResponseCode}, error code: {FlowErrorCode}.

**Resolution**: Check that the [base type](/microsoft-copilot-studio/authoring-variables-about#variable-types) of any variables you pass to the flow match the parameter's type.

#### FlowActionException

**Error messages**:

- No output was received from flow {FlowName} ({FlowId}), even though output was expected as per the agent definition.
- The output parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing from the response data. Refresh the flow, or ensure the flow returns this value.
- The output parameter with name {ItemKey} on flow {FlowName} ({FlowId}) is missing from the output schema. Please refresh the flow.

**Resolution**: [Check the flow for errors](/power-automate/error-checker).

#### FlowActionTimedOut

**Error message**: The flow with id {FlowId} has timed out. Error Code: {FlowErrorCode}

**Resolution**: [Check the flow for errors](/power-automate/error-checker) to understand why the cloud flow took more than 100 seconds to run before it returned to your agent. Try to optimize the query and the data you return from backend system. If some of the cloud flow logic can continue to run after a result is sent to the agent, place these actions after the 'Return value(s) to Copilot Studio' step in your cloud flow.

#### FlowMakerConnectionBlocked

**Error message**: The flow with name `{FlowName}` is using a maker connection, which isn't allowed. Error Code: `{FlowMakerConnectionBlocked}`

**Resolution**: The administrator prevents using maker credentials in a connection invoked from the agent flow. [Open the flow in Power Automate](/power-automate/overview-manage-cloud-flows#open-the-details-screen-for-a-flow) and [share the cloud flow with run-only permissions](/power-automate/create-team-flows#share-a-cloud-flow-with-run-only-permissions).

#### GenAISearchandSummarizeRateLimitReached

**Error message**: The usage limit for search and summarize has been reached. Please try again later.

**Resolution**: This message is returned when the agent reaches its [generative AI limit](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent) to search and summarize sources. For more information, see [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### GenAIToolPlannerRateLimitReached

**Error message**: The usage limit for generative orchestration has been reached. Please try again later.

**Resolution**: This message is returned when the agent reaches its [generative orchestration limit](/microsoft-copilot-studio/requirements-quotas#generative-ai-messages-to-an-agent). For more information, see [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### InfiniteLoopInBotContent

**Error message**: Action {DialogId}.{TriggerId}.{ActionId} was executed more than {MaxTurnCount} times in a row. This indicates a cycle in execution of the dialog and hence dialog execution will be terminated.

**Resolution**: Make sure the topic ends properly and links to other topics that end properly, such as the **Escalate** system topic.

#### InvalidContent

**Error message**: A total of {TotalComponents} component(s) exist in the agent, but none are valid.

**Resolution**: [Open the code editor](/microsoft-copilot-studio/authoring-create-edit-topics#edit-topics-with-the-code-editor) to review issues with the content.

#### LatestPublishedVersionNotFound

**Error message**: Unable to retrieve the latest published version of the agent.

**Resolution**: [Publish the agent](/microsoft-copilot-studio/publication-fundamentals-publish-channels).

#### OpenAIHate

**Error message**: The content was blocked by a Responsible AI check for hateful content. Hate harms refer to any content that attacks or uses discriminatory language with reference to a person or identity group based on certain differentiating attributes of these groups.

This includes, but isn't limited to:

- Race, ethnicity, nationality
- Gender identity groups and expression
- Sexual orientation
- Religion
- Personal appearance and body size
- Disability status
- Harassment and bullying

**Resolution**: You can reinforce responsible AI guidelines with your agent users to avoid this situation. Optionally, you can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAIJailBreak

**Error message**: The content was blocked by a security check for a jailbreak attempt. This is a user prompt attack that's ignoring system prompts with the goal of altering the intended agent behavior. Classes of attacks include attempt to change system rules, embedding a conversation mockup to confuse the model, role-play, or encoding attacks. For more information, see [Prompt Shields in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/jailbreak-detection).

**Resolution**: You can reinforce responsible AI guidelines with your agent users to avoid this situation. Optionally, you can also update the agent content moderation policies.

#### OpenAIndirectAttack

**Error message**: There was an attack detected from information not directly supplied by the agent author or the end user, such as external documents. Attacker attempts to embed instructions in grounded data provided by the user to maliciously gain control of the system by:

- Manipulating content
- Intrusion
- Unauthorized data exfiltration or data removal from a system
- Blocking system capabilities
- Fraud
- Code execution and infecting other systems

For more information, see [Prompt Shields for documents](/azure/ai-services/content-safety/concepts/jailbreak-detection#prompt-shields-for-documents).

**Resolution**: If you're testing and didn't mean it to be an attack, make sure your instructions are in line with what you want the agent to be able to do. Otherwise, you can reinforce responsible AI guidelines with your agent users to avoid this situation.

#### OpenAISelfHarm

**Error message**: The content was blocked by a Responsible AI check for content related to self-harm. Self-harm describes language related to physical actions intended to purposely hurt, injure, damage one's body or kill oneself.

This includes, but isn't limited to:

- Eating Disorder
- Bullying and intimidation

**Resolution**: You can reinforce responsible AI guidelines with your agent users to avoid this situation. Optionally, you can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAISexual

**Error message**: The content was blocked by a Responsible AI check for sexual content. Sexual describes language related to anatomical organs and genitals, romantic relationships and sexual acts, acts portrayed in erotic or affectionate terms, including those portrayed as an assault or a forced sexual violent act against one's will.

This includes, but isn't limited to:

- Vulgar content
- Prostitution
- Nudity and Pornography
- Abuse
- Child exploitation, child abuse, child grooming

**Resolution**: You can reinforce responsible AI guidelines with your agent users to avoid this situation. Optionally, you can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OpenAIRateLimitReached

**Error message**: An error has occurred.

**Resolution**: Your agent reached the maximum number of generative answers responses. Review your [message capacity](/microsoft-copilot-studio/requirements-messages-management), and review the information in [Resolve throttling errors in agents](../licensing/throttling-errors-agents.md).

#### OpenAIViolence

**Error message**: The content was blocked by a Responsible AI check for violent content. Violence describes language related to physical actions intended to hurt, injure, damage, or kill someone or something; describes weapons, guns, and related entities.

This includes, but isn't limited to:

- Weapons
- Bullying and intimidation
- Terrorist and violent extremism
- Stalking

**Resolution**: You can reinforce responsible AI guidelines with your agent users to avoid this situation. Optionally, you can also update the agent [content moderation](/microsoft-copilot-studio/knowledge-copilot-studio#content-moderation) policies.

#### OutgoingMessageSizeTooBig

**Error message**: Outgoing message size too big.

**Resolution**: Depending on the channel, such as Direct Line or Facebook, being used to transfer files, you might receive the following error message: "The request content length exceeded limit of 262,144 bytes." These limits are imposed by the [channel](/azure/bot-service/bot-service-resources-faq-general?azure-bot-service-4.0#what-is-the-size-limit-of-a-file-transferred-using-channels&preserve-view=true), and not Copilot Studio.

In this scenario, there are a few options. One option is to provide a link to the resource as an internet attachment. Another option is to review your nodes to ensure that none of them are using a variable that contains a large volume of text, such as a `JSON.stringify()` static method. If you use this method or a variable that contains a large volume of text, modify the node to only pass the portion of text that's necessary. For example, if you use an Adaptive Card to pass data to another topic, update the variable to only pass the necessary property.

For more information, see [Maximum channel data message size limits when using Copilot Studio in Omnichannel](/microsoft-copilot-studio/requirements-quotas#maximum-channel-data-message-size-limits-when-using-copilot-studio-in-omnichannel).

#### RedirectToDisabledDialog

**Error message**: The Dialog with Id {DialogId} is disabled in the definition. Please enable the Dialog before using it.

**Resolution**: [Re-enable the topic](/microsoft-copilot-studio/authoring-topic-management) or [remove the redirect node](/microsoft-copilot-studio/authoring-create-edit-topics#delete-a-node).  

#### RedirectToNonExistentDialog

**Error message**: The Dialog with Id {DialogId} wasn't found in the definition. Please check that the Dialog is present and that the Id is correct.

**Resolution**: [Create a new topic](/microsoft-copilot-studio/authoring-create-edit-topics#create-a-topic) to redirect to, or [remove the redirect node](/microsoft-copilot-studio/authoring-create-edit-topics#delete-a-node).

#### SystemError

**Error message**: This error doesn't produce an error message.

**Resolution**: [Contact customer support](/microsoft-copilot-studio/fundamentals-support).

#### TooMuchDataToHandle

**Error message**: The request is resulting in too much data to handle, please evaluate the amount of data being returned by your actions.

**Resolution**: This indicates the request being sent to OpenAI is exceeding the maximum request size allowed. There are a number of things that make up the request including the user input, output from previous actions, tools called, and conversation history. Review the tools you're using, and, where possible, scope down their output to only the necessary fields. For more information, see [Create a Power Automate flow](/microsoft-copilot-studio/advanced-flow-create) and [Call a Power Automate flow as an action](/microsoft-copilot-studio/advanced-use-flow).

# [Classic/Teams](#tab/classic+teams)

| Error | Bot response | Resolution |
| ----- | ------------ | ---------- |
| **2000** | "The user is trapped in an infinite loop. Check to make sure `{Topic Name}` reaches a logical conclusion." | Make sure the topic ends properly, or links to other topics that end properly, such as the [Escalate][3] system topic. |
| **2001** | "The bot content is invalid." | [Check the topic for errors][4]. |
| **2002** | "We ran into an issue with CDS." | There was a problem accessing the [Dataverse][5]. Check your configuration for errors. Otherwise try again later as there might be a service issue. |
| **2003** | "There's a problem with `{Flow Name}` in `{Topic Name}`. Please check your content." | [Check the flow for errors][6] and [look for failed runs in the flow run history][7]. |
| **2004** | "There's a problem with `{Skill Name}` in `{Topic Name}`. Please check your content." | There was a problem with your skill. Check both [the skill][8] and [topic][9] for errors. |
| **2005** | "We ran into a problem. Please check your content." | There was a problem with your Power Automate Flow template. [Check the flow for errors][6]. |
| **2006** | "We couldn't find your bot." | Your bot couldn't be found because the bot, or its environment, was deleted. To configure a new bot, see [Create and delete agents][10]. To configure a new environment, see [Work with Power Platform environments][11]. |
| **2007** | "The bot contains too much content to be able to work." | Reduce message lengths or number of topics, then try again. Read more about [content limits][12]. |
| **2008** | "We couldn't find the user's token." | Check your bot's [authorization configuration][13] for errors. |
| **2009** | "To use this bot, publish it in Copilot Studio." | To use this bot, [publish it in Copilot Studio][14]. |
| **2010** | "We can't retrieve your bot content." | Content couldn't be found because it was deleted. To configure a new agent, see [Create and delete agents][10]. To configure a new environment, see [Work with Power Platform environments][11]. |
| **2011** | "We couldn't find `{Skill Name}` in `{Topic Name}`. Please check your content." | Skill couldn't be found because it was deleted. To create a new skill, see [Configure a Bot Framework skill][15]. |
| **2012** | "We couldn't find `{Flow Name}` in `{Topic Name}`. Please check your content." | Your Power Automate Flow couldn't be found because it was deleted. To create a new flow, see [Create a flow][16]. |
| **2014** | "The translation service didn't respond." | Try again later. If the issue persists, [contact customer support][17]. |
| **2015** | "You're not authorized to call `{Skill Name}`. Please check the skill and its usage for any issues." | Check your [skill's configuration][15] and ensure your bot is [added to the skill's allowlist][18]. |
| **2016** | "Sorry, we couldn't find your bot." | There was a problem with an [Azure Bot Service channel][19]. The channel might have been deleted or configured incorrectly. |
| **2017** | "Sorry, we couldn't access your bot." | The [Azure Bot Service channel][19] couldn't be accessed. Check the channel configuration for authentication issues. |
| **2018** | "The user is typing too fast." | You sent messages too quickly. Read more about [quotas and limits within Copilot Studio][11]. |
| **2019** | "We couldn't find your environment. It may have been deleted." | Your environment was deleted. To configure a new environment, see [Work with Power Platform environments][11]. |
| **2020** | "Something happened, and `{Flow Name}` isn't working in `{Topic Name}`. Try again later. If the issue persists, check your flow's setup and run history." | Your Power Automate flow isn't working. Try again later. If the issue persists, [check the flow for errors][6]. |
| **2021** | "Number of dialogs executed in the current turn exceeded the maximum of `{Dialog Limit}`." | By default, the maximum number of topics is 50. Reduce the number of topics, then try again. |
| **2022** | "The bot sent more than `{Message Limit}` messages in this turn." | Limit messages per turn to under 30. |
| **2024** | "This environment requires users to sign in before they can use the bot. Go to Manage > Security > Authentication and select the option that requires users to sign in." | Your environment's data policies requires that users sign in. To learn how to require users to sign in, see [Configure user authentication][20]. |
| **2025** | "There are one or more empty nodes in topic `{Topic Name}`, Please check your content." | Add content to empty nodes or remove them from the topic. |
| **2025** | "`{Topic Name}` is redirecting to a topic, which has been turned off. Return to `{Topic Name}` and check your content." | Your topic is [redirecting][2] to another topic that has been turned off. [Turn on the other topic][21] or [remove the redirect node][22]. |
| **2025** | "The topic you're trying to redirect to no longer exists. Return to `{Topic Name}` and check your content." | The topic you're trying to [redirect][2] to no longer exists. [Create a new topic][23] to redirect to or [remove the redirect node][22]. |
| **2026** | "There was a problem with the Power Automate Flow. Please check your content." | [Check the flow for errors][6]. |
| **2030** | "Check Power Automate flow run history and ensure that flow ran successfully." |  |
| **2100** _(Teams only)_ | "The user is typing too fast." | Interactions with the bot are rate limited to mitigate spam. Try again while typing slower. |
| **2101** | "The user's conversation with the bot was too long or the user's message was too long." | Try restarting the conversation with the bot or using a shorter message. |
| **2102** | "The user sent a message which is too large to process." | You sent a message that is too large to process. Shorten your message, then try again. |
| **3000** | "Unexpected error" | A system error occurred. [Contact customer support][17] for more details. |
| **3001** | "Power Automate isn't available for your flow `{Flow Name}` now. Try again later." | Power Automate isn't responding. Restart the conversation with your bot and try again. If the issue persists, [contact customer support][17]. |
| **3002** | "Something happened in Power Automate, and your request to your flow `{Flow Name}` wasn't accepted. Try again later." | An error occurred in Power Automate and the request to your flow wasn't accepted. Your flow might have taken more than 2 minutes to respond. |
| **3003** | "There's a network problem connecting to your flow `{Flow Name}`. Please try again later." | Try again later. If the issue persists, [contact customer support][17]. |

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
