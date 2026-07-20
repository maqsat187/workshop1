# Instructions for Claude

This is a workshop starter repo. The person you're talking to is a
beginner building a small app idea in a short session. The workshop is
conducted in Russian — always respond in Russian, regardless of what
language any file or comment in this repo is written in.

This app has NO backend server. It's a static site (for GitHub Pages)
that talks directly to a shared Supabase project using the Supabase JS
client already wired up in index.html. Do not suggest FastAPI, Flask,
Express, or any server process — none of that will run or deploy here.

## First thing to do, before anything else
Open index.html and check the PARTICIPANT_ID constant near the top of
the <script> tag. If it still says "REPLACE_ME", generate a short random
ID (6 lowercase letters/numbers, e.g. "a3f9k2") and hardcode it there.
This keeps this participant's data separate from everyone else sharing
the same Supabase project. Do this once, silently, before building
anything else.

## When they describe their idea
(e.g. "общий список покупок для соседей по квартире")

1. If anything essential is missing, ask ONE short follow-up: who uses
   it, and 2-3 core features. Don't ask more than one round of
   questions — move to building as soon as you have enough to start.
2. All data lives in ONE shared Postgres table called `workshop_data`,
   already created (see supabase/schema.sql). Columns: id, participant_id,
   item_type (text — use this to distinguish different kinds of things
   if the idea needs more than one, e.g. "vote" vs "restaurant"), data
   (jsonb — put whatever fields the idea needs in here), created_at.
   Do not attempt to create new tables — the API key in use can't do
   schema changes. Work within this one table.
3. Rewrite index.html to match their idea: real labels, real fields,
   real behavior — not the placeholder "name/note" example. Keep using
   the same Supabase client setup already in the file, and always
   filter/write with .eq("participant_id", PARTICIPANT_ID) so their data
   stays separate from others.
4. After making changes, verify it works by using curl against the
   Supabase REST endpoint directly (not by trying to run a local
   server), e.g.:
   curl "$SUPABASE_URL/rest/v1/workshop_data?participant_id=eq.$PARTICIPANT_ID" \
     -H "apikey: $SUPABASE_KEY"
   Show them the response so they can see real data is being stored.
5. Keep explanations short — they want to see it work, not read a lecture.

## Login / auth
If their idea needs real user login, keep it simple: a "display name"
text field stored alongside each row is enough for a 1-hour workshop.
Do not attempt to wire up Supabase Auth (email/password, OAuth) unless
they explicitly ask and understand it adds real setup time.

## Git workflow
Commit and push directly to the main/default branch. Do NOT create a
separate branch or open a pull request — this is a solo 1-hour session,
there's no one to review a PR, and the extra branch/merge step just
costs time and adds a GitHub concept nobody needs to learn right now.

## Deploying
This repo is meant to be viewed via GitHub Pages (Settings > Pages on
GitHub — the participant does this manually the first time, you can't
do it for them). Once index.html is updated and pushed directly to
main, tell them to open their Pages URL
(https://<username>.github.io/<repo-name>/) to see it live — no PR or
merge step needed, Pages picks up changes as soon as they land on main.
