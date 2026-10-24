USE EcosistemaNK;
GO

-- 1. Tabla de Usuarios
CREATE TABLE dbo.Users (
  id INT IDENTITY(1,1) PRIMARY KEY,
  email NVARCHAR(255) UNIQUE NOT NULL,
  password_hash NVARCHAR(255),
  name NVARCHAR(100),
  role NVARCHAR(50) DEFAULT 'free',
  google_id NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- 2. Tabla de Perfiles
CREATE TABLE dbo.Profiles (
  user_id INT PRIMARY KEY FOREIGN KEY REFERENCES dbo.Users(id) ON DELETE CASCADE,
  diagnostico NVARCHAR(MAX),
  indice_sostenibilidad INT DEFAULT 50,
  habitos_personalizados NVARCHAR(MAX) DEFAULT '[]',
  ancla_semanal NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE()
);

-- 3. Tabla de Prioridades
CREATE TABLE dbo.Priorities (
  id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES dbo.Users(id) ON DELETE CASCADE,
  [date] DATE NOT NULL,
  title NVARCHAR(255) NOT NULL,
  is_completed BIT DEFAULT 0,
  is_event BIT DEFAULT 0,
  event_type NVARCHAR(50),
  external_id NVARCHAR(100),
  sort_order INT DEFAULT 0,
  created_at DATETIME DEFAULT GETDATE()
);

-- 4. Tabla de Check-ins (Ojo con la "I" mayúscula)
CREATE TABLE dbo.CheckIns (
  id INT IDENTITY(1,1) PRIMARY KEY,
  user_id INT FOREIGN KEY REFERENCES dbo.Users(id) ON DELETE CASCADE,
  [date] DATE NOT NULL,
  type NVARCHAR(50) NOT NULL,
  value INT NOT NULL,
  photo_url NVARCHAR(255),
  created_at DATETIME DEFAULT GETDATE()
);

-- 5. Tabla de Frases Ancla (con textos de ejemplo)
CREATE TABLE dbo.AnchorPhrases (
  id INT IDENTITY(1,1) PRIMARY KEY,
  text NVARCHAR(255) NOT NULL,
  active BIT DEFAULT 1,
  sort_order INT DEFAULT 0
);

INSERT INTO dbo.AnchorPhrases (text, sort_order) VALUES 
('No tienes que sostenerlo todo. Solo lo que hoy te corresponde.', 1),
('Cada pequeño paso cuenta en tu proceso.', 2),
('La claridad viene después de la pausa.', 3);
GO