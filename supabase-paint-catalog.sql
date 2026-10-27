-- Kjør i Supabase SQL Editor for å administrere malingsprodukter sentralt.
-- Lesbart for alle, endringer utføres via Supabase dashboard / SQL-editor.
create table if not exists public.paint_catalog (
 id bigint generated always as identity primary key,
 name text not null unique,
 brand text not null,
 surface text not null check (surface in ('walls','ceiling','wood','other')),
 pack_liters numeric(8,2),
 coverage_m2_per_liter numeric(8,2),
 is_active boolean not null default true,
 created_at timestamptz not null default now()
);
alter table public.paint_catalog enable row level security;
drop policy if exists "Public read active paint" on public.paint_catalog;
create policy "Public read active paint" on public.paint_catalog for select to anon, authenticated using (is_active = true);
insert into public.paint_catalog (name,brand,surface) values
 ('Jotun LADY Wonderwall','Jotun','walls'),
 ('Jotun LADY Pure Color','Jotun','walls'),
 ('Jotun LADY Balance','Jotun','walls'),
 ('Jotun LADY New Era','Jotun','walls'),
 ('Jotun LADY Supreme Finish','Jotun','wood'),
 ('Butinox Interiør Stue og Sov','Butinox','walls'),
 ('Butinox Interiør Tak','Butinox','ceiling'),
 ('Nordsjö Ambiance Deep Matt','Nordsjö','walls'),
 ('Flügger Dekso 1 Ultramat','Flügger','walls')
on conflict (name) do nothing;
-- Angi pack_liters / coverage_m2_per_liter bare når de er verifisert for riktig variant.
-- Pris, lager og butikktilbud er ikke inkludert uten en verifisert butikk-API.
