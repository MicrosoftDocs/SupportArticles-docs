# docs/public - LMC-compatible tool documentation

This folder contains **Microsoft Learn Content (LMC)-compatible** documentation for every enabled public tool in the D365 MCP server. The folder is designed for zero-transformation sync to a learn.microsoft.com docs repository.

## Folder structure

```text
docs/public/
  README.md              # This file (internal only - not published)
  toc.yml                # LMC table of contents
  end-user/              # Combined tool reference (audience: service representatives + admins)
    toc.yml
    <tool-name>.md       # One file per tool: user guide first, admin reference at the bottom
```

Each `<tool-name>.md` file is a **combined** page — user-facing guide sections appear first, followed by the admin technical reference sections. There is no separate `admin/` folder.

## Page structure (combined)

Each tool page follows this section order:

1. **H1** — user-facing capability name (plain English, not internal tool name)
2. **MCP server availability note** — which MCP servers include this tool by default
3. **Disclaimer** — capability-change notice for agent and integration builders
4. Intro paragraph
5. **What it does** — plain-language description
6. **Try prompts like** — 4-8 natural-language examples
7. **What you'll see in chat** — response type description
8. **What you can do from the app-in-chat component** — only when `resourceUri` is set
9. **Helpful tips** — 3-6 bullets
10. **What happens next** — follow-up prompt examples
11. **Does this change data?** — read/write classification

Admin reference (appended at the bottom):

12. **Prerequisites** — what the tool requires
13. **Tool summary** — property table with internal tool name
14. **Tool behavior** — technical description
15. **Annotations** — MCP annotation hints table
16. **Input concepts** — parameter groups with tables
17. **Response and UI behavior** — response type; MCP App link if applicable
18. **Routing notes** — when to use and when not to use
19. **Related tools** — table with relative links to related tool pages
20. **Data mutation classification** — read/write status

## LMC format constraints (strict adherence required)

Every `.md` file in `end-user/` MUST follow these rules. The `check:tool-docs` build gate enforces structural compliance. `[HC-TOOL-DOCS]` in the constitution enforces content sync with enabled `tool.ts` definitions and blocks public docs for disabled tools.

### YAML frontmatter

Every article MUST begin with a YAML frontmatter block containing these fields:

```yaml
---
title: Article Title
description: Brief description for search results (max 160 characters)
ms.date: MM/DD/YYYY
ms.topic: reference
ms.service: dynamics-365-customer-service
author: TODO-github-alias      # GitHub username (non-empty placeholder allowed in stubs)
ms.author: TODO-ms-alias       # Microsoft alias (non-empty placeholder allowed in stubs)
ms.reviewer: TODO-ms-alias     # Microsoft alias of the content reviewer (non-empty)
---
```

- `title` - matches the H1 heading exactly. Use sentence case (capitalize only the first word and proper nouns/acronyms).
- `description` - max 160 characters, no markdown.
- `ms.date` - MM/DD/YYYY format (US date), updated on every edit
- `ms.topic` - always `reference` (combined pages contain reference content)
- `ms.service` - always `dynamics-365-customer-service`
- `author` and `ms.author` - required and non-empty; use placeholders like `TODO-github-alias` and `TODO-ms-alias` in stubs, then replace before publishing
- `ms.reviewer` - required and non-empty; Microsoft alias of the content reviewer (Learn style requirement)

### Learn (LMC) style conventions

Apply these conventions across all docs (they mirror the Learn editorial style):

- **Sentence case** for all headings and titles - capitalize only the first word plus proper nouns and acronyms (`SLA`, `AI`, `MCS`, `MCP`, `Copilot`, `Dataverse`, `Dynamics`).
- **Spell out `Microsoft 365 Copilot`** - never `M365 Copilot`.
- **Capitalize `Not set`** in annotation value cells.
- **No surrounding quotes** on example prompts or intents. Keep them telegraphic - drop leading articles (`Apply case closure template`, not `"Apply the case closure template"`).
- **Tables over prose** for structured data - input concepts and tool summaries use markdown tables with the minimal `|---|---|` separator.
- **`## Prerequisites`** section (bulleted requirements + `Learn more in` links) instead of an `[!IMPORTANT]` callout at the top.

### Heading hierarchy

- Exactly ONE `# H1` per file, matching the `title` frontmatter field
- `## H2` for major sections (appears in right-hand TOC on learn.microsoft.com)
- `### H3` and below for subsections (do NOT appear in page TOC)
- Space required between `#` and heading text
- No HTML headings (`<h1>`, `<h2>`, etc.)

### Callout syntax

Use the LMC alert extension syntax, not raw blockquotes:

```markdown
> [!NOTE]
> Informational content.

> [!TIP]
> Helpful optional guidance.

> [!IMPORTANT]
> Required information for success.

> [!WARNING]
> Dangerous consequences of an action.
```

Limit to 1-2 callouts per article. Do not stack multiple callouts.

### Image references

Use the LMC triple-colon image syntax when adding screenshots:

```markdown
:::image type="content" source="media/<tool-name>/<image-name>.png" alt-text="Descriptive alt text":::
```

- Store images in `media/<tool-name>/` relative to the article
- Alt text is required (accessibility)
- Supported formats: `.png`, `.jpg`, `.gif`
- Stubs ship without images by design; add screenshots during content authoring

### Cross-references

- Internal links: `[Link text](/dynamics365/customer-service/path/to/article)`
- Anchor links: `[Section name](#section-heading-in-lowercase-with-hyphens)`
- No `.md` extension in internal links
- Do NOT use relative paths (`./other-article.md`) - use absolute LMC paths

### File naming

- All lowercase
- Named by internal tool name. Preserve underscores for snake_case MCP tool names (for example, `list_cases.md`, `update_entity_record.md`).
- Preserve existing hyphenated names only for legacy hyphenated tools until those tool names migrate.
- One file per tool

### Disabled tools

Public docs are only for enabled tools. A tool listed in `apps/mcp-server/config/tool-exclusions.json` for any deployment environment is treated as disabled for public documentation:

- Do not create `end-user/<tool-name>.md` or `admin/<tool-name>.md` for a disabled tool.
- Do not add disabled tools to `end-user/toc.yml` or `admin/toc.yml`.
- When a disabled tool becomes publicly available, remove it from `tool-exclusions.json` and add both docs plus TOC entries in the same PR.

`pnpm check:tool-docs` fails when public docs exist for a disabled tool, and it doesn't require docs for disabled tools.

### Tables

Use standard markdown pipe tables. Align columns with hyphens:

```markdown
| Column A | Column B |
|----------|----------|
| Value 1  | Value 2  |
```

### Code references

- Inline backticks for all tool names, field names, values: `list_cases`, `readOnlyHint`
- Fenced code blocks with language tags allowed in the admin reference sections at the bottom

### Cross-references

- **Related tools table** — use relative `.md` links: `[list_cases](list_cases.md)`
- **Inline text** — no inline links needed for tool name mentions in prose; backtick the name only
- Do NOT use absolute LMC paths in the Related tools table — relative links keep the table correct regardless of the published path

## Sync workflow

1. Author or generate docs in this folder
2. `pnpm build:ci` runs `check:tool-docs` to verify enabled-tool coverage, disabled-tool doc absence, and structural compliance (file existence, frontmatter, sections)
3. Content depth (prompt examples, descriptions, routing notes) is human-reviewed at PR time
4. To publish: clone/sync this folder's `end-user/` contents to the target LMC repo
5. Fill `author` and `ms.author` fields before publishing
6. Replace all `<!-- TODO: -->` placeholders and `"..."` bullets before publishing
7. No markdown transformation needed - files are LMC-native

> [!IMPORTANT]
> Stub files contain `<!-- TODO: -->` comments and `"..."` placeholder bullets. These pass the build gate (which checks structure, not content depth) but are NOT publishable. Replace all placeholders before syncing to an LMC repo.

## Enforcement

- **Build gate:** `scripts/check-tool-docs.ts` verifies every enabled tool has a combined doc, disabled tools have no public docs, required frontmatter fields are present, required section headings exist, no legacy `### Resource URI` heading, and the tool name appears in backticks
- **Constitutional bar:** `[HC-TOOL-DOCS]` - every enabled tool MUST have a combined doc file with LMC-compatible structure, and disabled tools MUST NOT have public docs
- **Human review:** Content depth (descriptions, prompt examples, routing notes, annotation values) is reviewed at PR time, not by the gate
- **PR review:** Copilot Code Review checks for `[HC-TOOL-DOCS]` violations when `tools/**/tool.ts` files change

## Content authoring guide

### Combined tool page (`end-user/<tool-name>.md`)

Each file serves both service representatives and admins. Follow `end-user/list_cases.md` for user-facing tone and `end-user/apply_email_template.md` for admin-section depth. Required sections in order:

**User-facing (top half):**
1. **H1** - user-facing capability name (plain English, not internal tool name)
2. **MCP server availability note** - auto-generated; do not remove
3. **Disclaimer** - capability-change notice; verbatim, do not modify
4. Intro paragraph - one sentence describing when to use the capability
5. **What it does** - plain-language paragraph
6. **Try prompts like** - 4-8 natural-language examples
7. **What you'll see in chat** - describe the response type
8. **What you can do from the app-in-chat component** - only if `resourceUri` exists
9. **Helpful tips** - 3-6 bullets
10. **What happens next** - follow-up prompt examples
11. **Does this change data?** - read/write classification

**Admin reference (bottom half):**
12. **Prerequisites** - tool-specific configuration steps only; omit if none beyond the MCP server setup
13. **Tool summary** - a `| Property | Value |` table with `User-facing name`, `Internal tool name` (backticked), and `Purpose` rows
14. **Tool behavior** - prose describing what the tool does and what it does not do
15. **Annotations** - `| Annotation | Value | Meaning |` table of MCP annotation hints
16. **Input concepts** - `### <group>` subsections, each with an `| Input | Description | Required |` table
17. **Response and UI behavior** - prose; for tools with an MCP App, include the MCP App link (not a `### Resource URI` subsection); include `### Response type`
18. **Routing notes** - `Use ... when the user wants to:` / `Don't use ... when the user wants to:`
19. **Related tools** - `| Tool | Relationship |` table with relative `.md` links
20. **Data mutation classification** - prose stating the `readOnlyHint` and when data changes

Optional trailing sections (`Entity scopes`, `Category`) may follow when relevant.

## MCP server namespaces

The NOTE callout at the top of each page is generated from the tool's `namespaces` field in its `tool.ts` definition. The mapping from internal namespace keys to display names is defined in `NAMESPACE_DISPLAY` in `scripts/generate-tool-doc-stubs.ts`.

| Internal key | Display name | Agent | Status |
|---|---|---|---|
| `service` | Dynamics 365 Customer Service | Service Agent | **GA** |
| `sales` | Dynamics 365 Sales | Sales Agent | Pre-release |
| `field-service` | Dynamics 365 Field Service | Field Service Agent | Pre-release |

**GA gate:** only namespaces in the `GA_NAMESPACES` set (in `scripts/generate-tool-doc-stubs.ts`) appear in the public NOTE callout. Pre-release namespaces are omitted until they reach GA — even if a tool's `tool.ts` includes that namespace.

**Rules:**
- A tool scoped only to pre-release namespaces gets a generic fallback note ("available by default on select Dynamics 365 MCP servers").
- A tool with no `namespaces` field is available on all servers; the NOTE lists only the GA subset of those.
- When a namespace reaches GA: add its key to `GA_NAMESPACES` in `scripts/generate-tool-doc-stubs.ts`, then run a targeted fix script (same pattern as `fix-namespace-note.ts`) to update the NOTE callouts in all affected docs.

**Two links in the generated docs are placeholders that need real LMC target URLs before publishing:**
- `[Learn more about adding this tool to other MCP servers](...)` — update the `configure-customer-service-mcp-server` link target to a page covering cross-server tool configuration, once that page exists.
- `[Learn more about MCP Apps](...)` in the `## Response and UI behavior` section — the URL `/dynamics365/customer-service/administer/use-mcp-apps-in-chat` does not yet exist in the LMC repo. Create that page or redirect before syncing.
