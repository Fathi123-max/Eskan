# AI Agent & Package Setup for Eskan

> Research completed November 2026. This document captures the audited setup
> for AI coding-agent skills and in-app AI packages for the Eskan real estate
> Flutter app.

---

## Part 1 — AI Coding-Agent Skills (for developers working on this project)

These skills teach an AI coding assistant (Claude Code, Codex, Cursor, Antigravity,
GitHub Copilot, etc.) how to write correct Flutter/Dart code in **this** project.

### What was installed

Ran from the project root:

```bash
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

This created `.agents/skills/` with **40 skills** (25 Flutter + 15 Dart, with
5 overlaps merged). They are persisted in this project and available to any
compliant agent that reads `.agents/skills/`.

### Flutter skills (flutter/agent-plugins)

| Skill | What it teaches the agent |
|---|---|
| `flutter-add-integration-test` | Add integration tests with `integration_test`, convert MCP actions into permanent tests |
| `flutter-add-widget-preview` | Add interactive widget previews using `previews.dart` |
| `flutter-add-widget-test` | Write component widget tests with `WidgetTester` |
| `flutter-apply-architecture-best-practices` | Layered architecture (UI / Logic / Data), MVVM, Repository pattern |
| `flutter-build-responsive-layout` | `LayoutBuilder`, `MediaQuery.sizeOf`, `Expanded/Flexible`, adaptive breakpoints |
| `flutter-fix-layout-issues` | Diagnose and fix RenderFlex overflow, unbounded constraints, viewport errors |
| `flutter-implement-json-serialization` | Manual `fromJson`/`toJson` with `dart:convert`, pattern matching |
| `flutter-setup-declarative-routing` | `go_router`, deep linking, `StatefulShellRoute` |
| `flutter-setup-localization` | `flutter_localizations`, `intl`, `.arb` files, `l10n.yaml` |
| `flutter-use-http-package` | `http` GET/POST/PUT/DELETE, response handling |

### Dart skills (dart-lang/skills)

| Skill | What it teaches the agent |
|---|---|
| `dart-add-unit-test` | Unit tests with `package:test`, `group`/`test`/`expect`, `setUp`/`tearDown` |
| `dart-build-cli-app` | CLI architecture, `CommandRunner`, exit codes, stream routing |
| `dart-collect-coverage` | Coverage collection with `coverage` package, LCOV reports |
| `dart-fix-runtime-errors` | Diagnose and fix runtime errors |
| `dart-generate-test-mocks` | Generate mock objects for tests |
| `dart-migrate-to-checks-package` | Migrate `package:matcher` to `package:checks` |
| `dart-resolve-package-conflicts` | Resolve Dart package dependency conflicts |
| `dart-run-static-analysis` | `dart analyze`, `dart fix --apply`, strict-casts/inference/raw-types |
| `dart-setup-ffi-assets` | Compile C/C++ into Dart native assets |
| `dart-use-doc-examples` | Inject `{@example}` code into Dartdoc |
| `dart-use-ffigen` | Generate Dart FFI bindings from C headers |
| `dart-use-path-package` | Cross-platform paths with `package:path` |
| `dart-use-pattern-matching` | Switch expressions, pattern matching |
| `dart-use-primary-constructors` | Dart 3 primary constructor syntax |
| `dart-write-documentation` | Effective Dart doc comment style (`///`, no `@param`/`@return`) |

### Already-active skills in this environment

This chat has these Cloud skills available on the account (queryable via
`cloud_read_skill`):

- `shaddcn-ui` — shadcn/ui integration guidance
- `shadcn-ui` — shadcn/ui component guidance
- `nextjs-app-router-patterns` — Next.js App Router patterns
- `api-design-principles` — REST/GraphQL API design
- `planning-with-files` — file-based multi-step planning
- `executing-plans` — implement a plan inline
- `writing-plans` — write a plan from a spec
- `verification-before-completion` — verification checklist before claiming done
- `brainstorming` — creative/feature work prep
- `improve-codebase-architecture` — architecture deepening scan
- `web-design-guidelines` — UI review against Web Interface Guidelines
- `agent-browser` — browser automation CLI
- `find-skills` — discover and install agent skills
- `skill-creator` — create/modify skills

### How to use the skills

**For an AI coding assistant:** ask it to use a skill by name, e.g.

> "Use the flutter-fix-layout-issues skill to fix the overflow on the property
> detail screen."

**To verify discovery:** ask

> "Summarize the capabilities of the skills available for this project."

**To install more later:** from the project root

```bash
npx skills add <repo> --skill <name> --agent universal --yes
```

### Version control

`.agents/` is git-ignored in this project's `.gitignore` (added during setup).
Skills are downloaded on demand by each developer's agent; commit them only if
your team wants a pinned, reproducible skill set checked into the repo. To track
them, remove the `.agents/` line from `.gitignore` and commit.

---

## Part 2 — In-App AI Packages (for features inside the Eskan app)

### Recommendation summary

| Goal | Recommendation | Why |
|---|---|---|
| AI-powered property chat/search inside the app | **Wait and plan** — do not add packages yet | App is on Firebase v2/v4; the recommended `firebase_ai` 5.x needs a major Firebase upgrade. Adding it now would force a large, risky dependency migration with no feature to show for it. Plan the feature, upgrade Firebase in a controlled step, then add AI. |
| Coding-agent assistance for Flutter work | **Already installed** (Part 1) | Skills give the agent correct patterns without guessing. |
| General chat UI (buyer–agent messaging) | **Not now** | No product requirement yet; `flutter_chat_ui` + `flutter_chat_core` are general-purpose, not AI-specific. |
| Drop-in hosted AI chat widget | **Not for the core search experience** | `widget_chat` is proprietary, hosted, and has unresolved client-side secret key guidance. Fine for a contained FAQ demo, not for property search. |

### Detailed package verdicts

#### `firebase_ai` (Firebase AI Logic) — **Deferred**

- **What it is:** Flutter plugin for Firebase AI Logic, giving the client direct
  access to Gemini models (and Imagen) through Firebase.
- **Latest:** `firebase_ai: ^5.2.0` (verified publisher `firebase.google.com`).
- **Problem for this app:** `firebase_ai` 5.x depends on `firebase_core ^5.1.0`
  and `firebase_auth ^7.0.1`. This project currently pins `firebase_core: ^2.15.0`
  and `firebase_auth: ^4.6.2`. That is a major-version upgrade across the Firebase
  SDK, not a small addition. It risks breaking existing auth, Firestore, storage,
  and third-party Firebase plugins (`firebase_ui_firestore`, etc.) that may not
  yet be compatible with the newer Firebase core.
- **Why not skip to `firebase_ai` 3.x:** The older line is the deprecated
  `google_generative_ai` path, which Google has signalled is no longer the
  recommended route. Starting a new feature on a deprecated SDK is the wrong shape
  of shortcut.
- **Prerequisite if added later:** Firebase App Check. Firebase documents App Check
  as critical for AI Logic because the app calls the model directly. Production
  attestation should be configured before model requests; the debug provider is
  only for development.
- **What it would give the app:** natural-language intent extraction from Arabic/English
  queries ("شقة للإيجار في المعادي، غرفتين") and conversational clarification.
  It does **not** replace the property database — results should still come from
  deterministic Firestore queries.

#### `flutter_ai_toolkit` — **Not with current Firebase**

- **What it is:** Official Flutter team AI chat widget (`LlmChatView`) with streaming,
  voice input, attachments, function calling. Firebase AI Logic provider built in.
- **Latest:** `flutter_ai_toolkit: ^1.0.0`.
- **Problem:** its declared dependency is `firebase_ai: ^3.0.0`, which is
  incompatible with `firebase_ai` 5.x. You would have to pin older Firebase AI to
  use it. It also does not advertise first-class Arabic RTL behavior.
- **Verdict:** not worth downgrading the AI SDK for this UI when there is a better
  fit below.

#### `flutter_gen_ai_chat_ui` — **Best UI option when ready**

- **What it is:** AI-native chat UI kit. Streaming markdown, code highlighting,
  LaTeX, rich inline widgets, AI action/tool-use UI, human-in-the-loop confirmation,
  **RTL and Arabic-aware** word-level streaming.
- **Latest:** `flutter_gen_ai_chat_ui: ^2.22.0` (verified publisher `dilacode.com`).
- **Why it fits:** the app is Arabic-first (default locale `ar_EG`). This package
  explicitly addresses bidirectional text, mixed Arabic/Latin content, and
  word-aware streaming — all things that generic chat UIs mishandle for Arabic.
  It also lets you render property cards as rich inline widgets rather than dumping
  listing details into a text bubble.
- **What it does not do:** it is UI only. You supply the model call / stream.
  It does not provide AI, history storage, or property search.
- **Verdict:** the best UI choice **once the AI backend layer is decided**. Pair it
  with either `firebase_ai` (if Firebase is upgraded) or your own backend stream.

#### Genkit Dart (`genkit`) — **Backend only, not in the Flutter app**

- **What it is:** Google's open-source AI framework for Dart (stable 1.0, announced
  October 2026). Unified API across Gemini, Anthropic Claude, OpenAI, and
  OpenAI-compatible models. Flows, tools, structured output, agents.
- **Where it belongs:** on a Dart server, not in the mobile `pubspec.yaml`. Adding it
  to the Flutter app does not create a trusted server boundary. The Genkit team's own
  guidance is not to embed private API keys in a published client app.
- **When it would matter:** if you later build a Dart backend that orchestrates
  structured extraction of search criteria, calls property-search tools, and returns
  typed results to the app via `defineRemoteAction`.
- **Verdict:** do not add to this app now. If a Dart backend appears, evaluate Genkit
  there.

#### `langchain` / LangChain.dart — **Defer to a backend, if ever**

- **What it is:** Dart agent/RAG framework — models, retrieval, vector stores, tools,
  agents. Current `langchain: 0.9.0` (pre-1.0, with recent breaking changes).
- **Problem for this app:** property search is a structured filtering problem
  (price, location, bedrooms, sale/rent), not a fuzzy retrieval problem. RAG over
  embedded listing text would be a poor substitute for querying the actual fields.
- **When it could help:** a later knowledge assistant over unstructured content —
  neighborhood guides, FAQs, property documents — or a multi-tool agent with a real
  retrieval pipeline.
- **Verdict:** not now. If adopted later, evaluate on the backend, not the client.

#### `openai_dart` — **Only if OpenAI is the chosen provider**

- **What it is:** typed Dart client for the OpenAI API (text, streaming, tools,
  multimodal). Current `openai_dart: 12.0.0`, requires Dart 3.12+.
- **Problem:** this app's natural AI path is Google/Firebase (it already uses Firebase).
  OpenAI is a different provider and would need its own backend boundary for key safety.
- **Verdict:** not now. If OpenAI is chosen later, call it from a trusted backend,
  never with a key in the client.

#### `flutter_chat_ui` + `flutter_chat_core` — **General chat, not AI**

- **What they are:** Flyer Chat's customizable, backend-agnostic chat UI and core
  models/controllers. Good for buyer–agent messaging, support conversations, etc.
- **Why not now:** for a single AI property assistant, they force you to build the
  streaming, AI presentation, and Arabic RTL handling yourself — exactly what
  `flutter_gen_ai_chat_ui` already prioritizes. They make sense if the product adds
  general messaging as a separate feature.
- **Verdict:** not now.

#### `widget_chat` — **Hosted drop-in, not for core search**

- **What it is:** hosted chatbot SDK with a dashboard for content/tools, rich messages,
  multilingual UI. Quick to add a support/FAQ bot without your own backend.
- **Problems:** proprietary and dependent on the vendor's hosted service; the package
  guidance mentions a project secret key passed in client-side widget config while also
  advising not to expose that key client-side — a conflict to resolve with the vendor
  before shipping. Arabic RTL behavior is not established for a polished search
  experience.
- **Verdict:** not for the core property search experience. A contained FAQ demo could
  be a separate trial, but not the main app path.

### Suggested AI feature architecture for Eskan

When the team is ready to build an AI property assistant:

1. **Upgrade Firebase first, in its own step.** Move `firebase_core`, `firebase_auth`,
   and related Firebase plugins to the versions required by `firebase_ai` 5.x in a
   controlled migration, with `flutter pub upgrade` run in a Flutter SDK environment
   and the existing widget/integration tests green before adding AI.
2. **Add `firebase_ai` (+ `firebase_app_check`) only after the Firebase upgrade.**
   Configure App Check for production before any model request.
3. **Add `flutter_gen_ai_chat_ui` for the chat screen.** Wire its `onSendMessage`
   handler to `firebase_ai` (or your backend stream). Use its rich inline widgets to
   render property cards, not plain text.
4. **Keep search deterministic.** The AI layer should parse the Arabic/English query
   into a validated structured filter, then call the existing `PropertyServices` /
   Firestore query path. Show real listings as cards. Do not let the model invent
   prices, availability, or listing IDs.
5. **Gate actions by app authorization.** Contact, favorite, and viewing requests go
   through normal app auth, not model discretion.
6. **Consider Genkit on a backend later** if orchestration, structured extraction, or
   RAG over unstructured content becomes a real requirement.

### What was NOT added to pubspec.yaml and why

The `firebase_ai` / `firebase_app_check` / `flutter_gen_ai_chat_ui` lines are present
in `pubspec.yaml` but **commented out**, with a note that the Firebase upgrade must
happen first. This keeps the intent visible without forcing a broken dependency graph
or a risky untested upgrade into the current codebase.

Packages explicitly decided **not** to add (and why):

- `genkit` — server-side only; no Dart backend exists yet.
- `langchain` — pre-1.0, overkill for structured property search; defer to a backend.
- `openai_dart` — different provider, no product need, key-safety requires a backend.
- `flutter_chat_ui` + `flutter_chat_core` — general messaging, not AI; no product need yet.
- `widget_chat` — hosted/vendor-locked, unresolved client-side secret guidance, not for core search.
- `flutter_ai_toolkit` — incompatible with the current recommended `firebase_ai` line.

---

## Part 3 — Already-removed dead dependencies

During the earlier audit/fix pass, these were removed from `pubspec.yaml` because
they were unused or replaced:

- `uuid` — was referenced in code but not in `pubspec.yaml` (compile blocker);
  replaced with Firestore auto-generated document IDs.
- `image_picker`, `http`, `file_picker`, `flutter_chat_types`, `flutter_chat_ui`,
  `flutter_firebase_chat_core`, `flutter_markdown`, `markdown`, `flutter_xlider` —
  unused in the current codebase.
- `flutter_firebase_chat_core` and `flutter_chat_types` were transitive leftovers
  from an older chat experiment; the app does not use Firebase chat.

---

## Part 4 — Native splash screen

`pubspec.yaml` already contains a `flutter_native_splash` config with
`background_image: assets/images/splash.png`. The generation command is:

```bash
dart run flutter_native_splash:create
```

This was noted during the audit but not run because the Flutter SDK is not installed
in this workspace. Run it in a Flutter SDK environment before building a release.
