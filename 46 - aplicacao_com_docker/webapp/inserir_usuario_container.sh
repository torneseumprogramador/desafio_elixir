docker exec -it postgres_container psql -U postgres -d webapp_db -c "
INSERT INTO administradores (id, nome, email, inserted_at, updated_at, senha_hash)
VALUES (11, 'Danilo', 'danilo@teste.com', '2024-10-31 08:48:34', '2024-10-31 08:48:34'
, '\$2b\$12\$3NJ7SJOUBjoL77C7j9527OFI94vZ.feiFSca41l6a5jkswu4Qye4a');