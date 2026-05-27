# Agent Loop Flow

The core Hermes execution cycle visualized as a decision flow.

```
┌─────────────────────────────────────────────────┐
│                 Session Start                    │
│  Load SOUL.md, USER.md, bootstrap files         │
│  Load memory, session history                    │
└────────────────────┬────────────────────────────┘
                     │
         ┌───────────▼───────────┐
         │   User Input          │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Context Assembly    │◄── Session history
         │   + Memory            │◄── session_search
         │   + Bootstrap files   │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   LLM Inference       │
         │   (tool calls)        │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Tool Execution      │
         │   (terminal, file,    │
         │    web, etc.)         │
         └───────────┬───────────┘
                     │
              ┌──────┴──────┐
              │ Compressed? │─── Yes ──► Compress and continue
              └──────┬──────┘
                     │ No
         ┌───────────▼───────────┐
         │   Response Output     │
         │   (text, voice,       │
         │    platform msg)     │
         └───────────┬───────────┘
                     │
         ┌───────────▼───────────┐
         │   Max turns reached?  │─── Yes ──► End session
         └───────────┬───────────┘
                     │ No
                     └──► Back to User Input
```

## Loop Stages

### 1. Session Start
- Load SOUL.md (persona)
- Load USER.md (user profile)
- Load bootstrap files (IDENTITY.md, HEARTBEAT.md, MEMORY.md, TOOLS.md)
- Load memory entries via session_search
- Load session history

### 2. User Input
- Message, voice, or platform event
- Session pauses waiting for input

### 3. Context Assembly
- Bootstrap files injected
- Memory entries retrieved
- Session history loaded
- Current input appended

### 4. LLM Inference
- Model generates response
- May include tool calls
- Tool calls execute in Tool Execution stage

### 5. Tool Execution
- terminal, file, web, browser, etc.
- Results returned to LLM

### 6. Check Compression
- If context > threshold, compress
- Continue with compressed history

### 7. Response Output
- Text response
- Voice synthesis (if enabled)
- Platform message (if gateway)

### 8. Check Max Turns
- If max_turns reached, end session
- Otherwise loop back to User Input

## Key Decision Points

| Decision | Path A | Path B |
|----------|--------|--------|
| Compressed? | Continue with compressed | Response output |
| Max turns? | End session | Loop back |
| Tool call? | Execute tool | Response output |