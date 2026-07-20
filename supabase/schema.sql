-- Run this ONCE in the Supabase SQL editor (Database > SQL Editor > New query)
-- before the workshop. Every participant's app will share this one table,
-- scoped by participant_id so nobody sees anyone else's data.

create table if not exists workshop_data (
  id bigint generated always as identity primary key,
  participant_id text not null,
  item_type text not null default 'item',
  data jsonb not null default '{}',
  created_at timestamptz not null default now()
);

create index if not exists workshop_data_participant_idx
  on workshop_data (participant_id);

-- New tables default to Row Level Security ON with no policies, which
-- blocks all access. This workshop doesn't need real security (data is
-- throwaway), so we add one permissive policy to unblock reads/writes.
alter table workshop_data enable row level security;

create policy "workshop allow all"
  on workshop_data
  for all
  using (true)
  with check (true);
