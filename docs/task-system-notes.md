# Task system notes (for later)

Feedback after the first days of using the task system (GitHub Project #4 + `~/tasks`). Nothing here is done yet. Setup history and board IDs live in `~/tasks/docs/setup-progress.md` and `~/tasks/CLAUDE.md`.

Written 2026-11-13.

## Daily brief (removed 2026-11-15)

The 6:00 brief (`scripts/daily-brief`, `launchd` job `com.jewaniuk.dailybrief` on the Mac Mini, pinned issue #13 in `jewaniuk/tasks`) was hard to reach and read on a phone and its content wasn't useful. It was removed. The Next page of `attask` replaces it. See `~/tasks/docs/decisions.md`.

## Board views: keep "next", replace "board"

What works:

- The **next** view. It shows exactly what my next steps are, all in one place. Keep it.

What doesn't:

- The **board** view is useless. Nothing shows which subtasks belong to which project, so it's hard to tell what's going on.
- The **projects** view is a good start, but it's a table. I need a Kanban layout per project.

What I want instead:

1. **One top-level Kanban board** that holds only:
   - standalone tasks (no parent project), and
   - top-level project issues (e.g. `straightforward-scattering`), not their sub-issues.

   This is the overview: every ongoing project side by side with loose tasks, so I can prioritize projects against each other.
2. **One Kanban board per project**, showing only that project's sub-issues. Once I pick a project to work on, I can see at a glance what's in progress and what's coming up for that project alone.

Open questions to sort out when I pick this up:

- How to filter the top-level board to "no parent" items. Check whether GitHub Project view filters support `no:parent-issue` / `has:sub-issues`, or whether a label or a custom field is needed.
- Per-project views mean a new view for every project, made by hand in the web UI (`gh` can't create views). Check whether a single board grouped or sliced by parent issue is good enough, or whether the effort is worth it.
- Make sure whatever replaces "board" still reads well in the GitHub iOS app.
