-- Kjør dette én gang i Supabase SQL Editor for prosjektet vokbbthefljvyzvzvkgu.
-- Krever Supabase Auth. Ikke slå av RLS.
create table if not exists public.renovation_projects (
  user_id uuid primary key references auth.users(id) on delete cascade,
  project_data jsonb not null default '{"rooms":[],"items":[],"budget":0,"buffer":10}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.renovation_projects enable row level security;
drop policy if exists "Read own renovation project" on public.renovation_projects;
create policy "Read own renovation project" on public.renovation_projects
for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Insert own renovation project" on public.renovation_projects;
create policy "Insert own renovation project" on public.renovation_projects
for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Update own renovation project" on public.renovation_projects;
create policy "Update own renovation project" on public.renovation_projects
for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
