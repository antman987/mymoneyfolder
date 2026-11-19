-- MyMoneyFolder: tabella dei dati con accesso riservato a ciascun utente.
-- Incolla tutto questo nel SQL Editor di Supabase e premi "Run".

create table if not exists public.finanza (
  user_id    uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.finanza enable row level security;

drop policy if exists "Leggi solo i tuoi dati" on public.finanza;
drop policy if exists "Crea solo i tuoi dati" on public.finanza;
drop policy if exists "Modifica solo i tuoi dati" on public.finanza;

create policy "Leggi solo i tuoi dati" on public.finanza
  for select to authenticated using ((select auth.uid()) = user_id);

create policy "Crea solo i tuoi dati" on public.finanza
  for insert to authenticated with check ((select auth.uid()) = user_id);

create policy "Modifica solo i tuoi dati" on public.finanza
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

revoke all on public.finanza from anon;
grant select, insert, update on public.finanza to authenticated;
