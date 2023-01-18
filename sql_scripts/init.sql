create sequence tab1_seq
/
create table tab1 (
   id          number,
   description varchar2(50),
   constraint tab1_pk primary key ( id )
)
/
create or replace function get_tab1_count return number as
   l_count number;
begin
   select count(*)
     into l_count
     from tab1;

   return l_count;
end;
/