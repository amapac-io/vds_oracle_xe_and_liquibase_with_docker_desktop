declare
   type t_list is
      table of varchar2(30);
   l_list t_list := t_list(
                          'development',
                          'staging',
                          'production'
                    );
   e_user_already_exists exception;
   pragma EXCEPTION_INIT ( e_user_already_exists, -1920 );
begin
   for l_iterator in 1..l_list.COUNT loop
      DBMS_OUTPUT.PUT('Creating user '
                      || l_list(l_iterator)
                      || ': ');
      begin
         execute immediate 'CREATE USER '
                           || l_list(l_iterator)
                           || ' QUOTA UNLIMITED ON users PROFILE DEFAULT IDENTIFIED BY oracle ACCOUNT UNLOCK';
         DBMS_OUTPUT.PUT_LINE('User '
                              || l_list(l_iterator)
                              || ' created');
         execute immediate 'GRANT CONNECT, RESOURCE, CREATE VIEW to ' || l_list(l_iterator); -- <.>
      exception
         when e_user_already_exists then
            execute immediate 'ALTER USER '
                              || l_list(l_iterator)
                              || ' QUOTA UNLIMITED ON users PROFILE DEFAULT IDENTIFIED BY oracle ACCOUNT UNLOCK';
            DBMS_OUTPUT.PUT_LINE('User '
                                 || l_list(l_iterator)
                                 || ' exists, altered');
            execute immediate 'GRANT CONNECT, RESOURCE, CREATE VIEW to ' || l_list(l_iterator); -- <.>
      end;
   end loop;
end;
/