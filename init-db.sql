-- Criação da tabela de usuários do sistema (login)
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    is_admin INTEGER DEFAULT 0
);

-- Inserir conta ADM inicial caso não exista
INSERT INTO users (username, password, is_admin)
SELECT 'rodrigoadm', '$2b$10$4O4vEXUOYaL6VLdystD5K.eJ2PjZ4PRw8MZc2tZxePkpGqKZzLcia', 1
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'rodrigoadm');


-- Tabela de funcionários visíveis no painel
CREATE TABLE IF NOT EXISTS staff (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    photo TEXT,
    created_by INTEGER,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Tabela de tarefas ativas (com cronômetro)
CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    staff_id INTEGER NOT NULL,
    description TEXT NOT NULL,
    start_time TEXT NOT NULL,
    estimated_minutes INTEGER,
    end_time TEXT,
    status TEXT DEFAULT 'em_andamento',
    created_by INTEGER,
    FOREIGN KEY (staff_id) REFERENCES staff(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Log histórico para o quadro da direita + exportação Excel
CREATE TABLE IF NOT EXISTS task_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    staff_name TEXT NOT NULL,
    description TEXT NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL,
    status TEXT NOT NULL,
    created_by INTEGER,
    FOREIGN KEY (created_by) REFERENCES users(id)
);
