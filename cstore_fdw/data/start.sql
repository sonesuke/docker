drop database if exists test;
create database test;
\c test
CREATE EXTENSION cstore_fdw;
CREATE SERVER cstore_server FOREIGN DATA WRAPPER cstore_fdw;
CREATE FOREIGN TABLE data
(
 id INTEGER,
 num INTEGER
)
SERVER cstore_server
OPTIONS(compression 'pglz');
