CREATE TABLE IF NOT EXISTS settings (
    id SERIAL PRIMARY KEY,
    key TEXT NOT NULL UNIQUE,
    value TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    admin BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS public_keys (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    public_key TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (user_id, public_key),
    CONSTRAINT user_id_fk
    FOREIGN KEY(user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS repos (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    project_name TEXT NOT NULL,
    description TEXT NOT NULL,
    private BOOLEAN NOT NULL,
    mirror BOOLEAN NOT NULL,
    hidden BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS collabs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    repo_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (user_id, repo_id),
    CONSTRAINT user_id_fk
    FOREIGN KEY(user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT repo_id_fk
    FOREIGN KEY(repo_id) REFERENCES repos(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

