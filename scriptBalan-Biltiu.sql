USE [master]
GO
/****** Object:  Database [Biblioteca2]    Script Date: 31.05.2023 19:08:58 ******/
CREATE DATABASE [Biblioteca2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteca2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Biblioteca2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Biblioteca2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Biblioteca2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Biblioteca2] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteca2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteca2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteca2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteca2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteca2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteca2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteca2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Biblioteca2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteca2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteca2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteca2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteca2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteca2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteca2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteca2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteca2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Biblioteca2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteca2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteca2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteca2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteca2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteca2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteca2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteca2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Biblioteca2] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteca2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteca2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteca2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteca2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Biblioteca2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Biblioteca2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Biblioteca2] SET QUERY_STORE = ON
GO
ALTER DATABASE [Biblioteca2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Biblioteca2]
GO
/****** Object:  UserDefinedFunction [dbo].[DisponibilitateCarti]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DisponibilitateCarti](@id_carte INT)
RETURNS INT
AS
BEGIN
    DECLARE @copi_disponibile INT;

    SELECT @copi_disponibile = nr_bucati
    FROM Carti
    WHERE id_autor = @id_carte;

    RETURN @copi_disponibile;
END;
GO
/****** Object:  Table [dbo].[Carti]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carti](
	[id_carte] [int] IDENTITY(1,1) NOT NULL,
	[titlu] [varchar](100) NOT NULL,
	[data_publicarii] [date] NOT NULL,
	[nr_bucati] [int] NOT NULL,
	[id_autor] [int] NOT NULL,
	[id_gen] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_carte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[nrTitluriGen]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[nrTitluriGen](@genreId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT id_carte, titlu, data_publicarii, nr_bucati
    FROM Carti
    WHERE id_gen = @genreId
);
GO
/****** Object:  UserDefinedFunction [dbo].[nrCopiGen]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[nrCopiGen]
(
    @id_gen INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT SUM(nr_bucati) AS Nr_total_copi
    FROM Carti
    WHERE id_gen = @id_gen
);
GO
/****** Object:  Table [dbo].[Autori]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autori](
	[id_autor] [int] IDENTITY(1,1) NOT NULL,
	[nume_autor] [varchar](50) NOT NULL,
	[prenume_autor] [varchar](50) NOT NULL,
	[data_nasterii] [date] NOT NULL,
	[nationalitate] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_autor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genuri]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genuri](
	[id_gen] [int] IDENTITY(1,1) NOT NULL,
	[nume_gen] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_gen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Imprumuturi]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Imprumuturi](
	[id_imprumuturi] [int] IDENTITY(1,1) NOT NULL,
	[data_imprumutului] [date] NOT NULL,
	[data_returnarii] [date] NULL,
	[nr_imprumuturi] [int] NOT NULL,
	[id_user] [int] NOT NULL,
	[id_carte] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_imprumuturi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id_user] [int] IDENTITY(1,1) NOT NULL,
	[nume_user] [varchar](50) NOT NULL,
	[prenume_user] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[telefon] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Autori] ON 

INSERT [dbo].[Autori] ([id_autor], [nume_autor], [prenume_autor], [data_nasterii], [nationalitate]) VALUES (1, N'Nume Autor 1', N'Prenume Autor 1', CAST(N'1990-01-01' AS Date), N'Nationalitate 1')
INSERT [dbo].[Autori] ([id_autor], [nume_autor], [prenume_autor], [data_nasterii], [nationalitate]) VALUES (2, N'Nume Autor 2', N'Prenume Autor 2', CAST(N'1985-05-10' AS Date), N'Nationalitate 2')
SET IDENTITY_INSERT [dbo].[Autori] OFF
GO
SET IDENTITY_INSERT [dbo].[Carti] ON 

INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (1, N'Titlu Carte 1', CAST(N'2022-01-01' AS Date), 1, 1, 1)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (2, N'Titlu Carte 2', CAST(N'2021-05-10' AS Date), 4, 2, 2)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (3, N'Titlu Carte 3', CAST(N'2023-03-15' AS Date), 2, 1, 3)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (4, N'Titlu Carte 1', CAST(N'2022-01-01' AS Date), 5, 1, 1)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (5, N'Titlu Carte 2', CAST(N'2021-05-10' AS Date), 3, 2, 2)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (6, N'Titlu Carte 3', CAST(N'2023-03-15' AS Date), 2, 1, 3)
INSERT [dbo].[Carti] ([id_carte], [titlu], [data_publicarii], [nr_bucati], [id_autor], [id_gen]) VALUES (1004, N'Carte 1', CAST(N'2023-05-01' AS Date), 5, 1, 1)
SET IDENTITY_INSERT [dbo].[Carti] OFF
GO
SET IDENTITY_INSERT [dbo].[Genuri] ON 

INSERT [dbo].[Genuri] ([id_gen], [nume_gen]) VALUES (1, N'Gen Carte 1')
INSERT [dbo].[Genuri] ([id_gen], [nume_gen]) VALUES (2, N'Gen Carte 2')
INSERT [dbo].[Genuri] ([id_gen], [nume_gen]) VALUES (3, N'Gen Carte 3')
SET IDENTITY_INSERT [dbo].[Genuri] OFF
GO
SET IDENTITY_INSERT [dbo].[Imprumuturi] ON 

INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (1, CAST(N'2023-05-01' AS Date), CAST(N'2023-05-27' AS Date), 2, 1, 1)
INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (2, CAST(N'2023-05-05' AS Date), CAST(N'2023-05-29' AS Date), 1, 2, 2)
INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (3, CAST(N'2023-05-10' AS Date), NULL, 3, 1, 3)
INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (5, CAST(N'2023-05-25' AS Date), CAST(N'2023-06-08' AS Date), 2, 1, 1)
INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (6, CAST(N'2023-05-25' AS Date), NULL, 2, 1, 1)
INSERT [dbo].[Imprumuturi] ([id_imprumuturi], [data_imprumutului], [data_returnarii], [nr_imprumuturi], [id_user], [id_carte]) VALUES (7, CAST(N'2023-05-25' AS Date), CAST(N'2023-05-27' AS Date), 2, 1, 2)
SET IDENTITY_INSERT [dbo].[Imprumuturi] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id_user], [nume_user], [prenume_user], [email], [telefon]) VALUES (1, N'Nume User 1', N'Prenume User 1', N'user1@example.com', N'1234567890')
INSERT [dbo].[Users] ([id_user], [nume_user], [prenume_user], [email], [telefon]) VALUES (2, N'Nume User 2', N'Prenume User 2', N'user2@example.com', N'9876543210')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Carti]  WITH CHECK ADD FOREIGN KEY([id_autor])
REFERENCES [dbo].[Autori] ([id_autor])
GO
ALTER TABLE [dbo].[Carti]  WITH CHECK ADD FOREIGN KEY([id_gen])
REFERENCES [dbo].[Genuri] ([id_gen])
GO
ALTER TABLE [dbo].[Imprumuturi]  WITH CHECK ADD FOREIGN KEY([id_carte])
REFERENCES [dbo].[Carti] ([id_carte])
GO
ALTER TABLE [dbo].[Imprumuturi]  WITH CHECK ADD FOREIGN KEY([id_user])
REFERENCES [dbo].[Users] ([id_user])
GO
/****** Object:  StoredProcedure [dbo].[ImprumutCarte]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImprumutCarte]
    @id_user INT,
    @id_carte INT,
	@nr_imprumuturi INT,
    @data_imprumutului DATE
AS
BEGIN
    -- Verificăm disponibilitatea cărții
    IF EXISTS (
        SELECT 1
        FROM Carti
        WHERE id_carte = @id_carte AND nr_bucati = nr_bucati
    )
    BEGIN
        -- Înregistrăm împrumutul în tabela Imprumuturi
        INSERT INTO Imprumuturi (id_user, id_carte, data_imprumutului,nr_imprumuturi)
        VALUES (@id_user, @id_carte, @data_imprumutului,@nr_imprumuturi);

        -- Actualizăm numărul de bucăți disponibile pentru cartea respectivă
        UPDATE Carti
        SET nr_bucati = nr_bucati - @nr_imprumuturi
        WHERE id_carte = @id_carte;

        PRINT 'Împrumutul a fost înregistrat cu succes.';
    END
    ELSE
    BEGIN
        PRINT 'Cartea nu este disponibilă pentru împrumut.';
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[ReturneazaCarte]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReturneazaCarte]
    @id_imprumut INT,
    @data_returnarii DATE,
	@nr_imprumuturi INT
AS
BEGIN
    -- Verificăm dacă împrumutul există și nu a fost returnat anterior
    IF EXISTS (
        SELECT 1
        FROM Imprumuturi
        WHERE id_imprumuturi = @id_imprumut AND data_returnarii IS NULL 
    )
    BEGIN
        -- Actualizăm data de returnare în tabela Imprumuturi
        UPDATE Imprumuturi
        SET data_returnarii = @data_returnarii
        WHERE id_imprumuturi = @id_imprumut;

        -- Actualizăm numărul de bucăți disponibile pentru cartea respectivă
        UPDATE Carti
        SET nr_bucati = nr_bucati + @nr_imprumuturi
        WHERE id_carte = (
            SELECT id_carte
            FROM Imprumuturi
            WHERE id_imprumuturi = @id_imprumut
        );

        PRINT 'Cartea a fost returnată cu succes.';
    END
    ELSE
    BEGIN
        PRINT 'Nu există niciun împrumut cu ID-ul specificat sau cartea a fost deja returnată.';
    END
END;




GO
/****** Object:  Trigger [dbo].[InsertCarti]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InsertCarti]
ON [dbo].[Carti]
AFTER INSERT
AS
BEGIN
    PRINT 'O noua carte a fost inserata.';
END;
GO
ALTER TABLE [dbo].[Carti] ENABLE TRIGGER [InsertCarti]
GO
/****** Object:  Trigger [dbo].[VerificaExistentaCarte]    Script Date: 31.05.2023 19:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[VerificaExistentaCarte]
ON [dbo].[Imprumuturi]
AFTER INSERT
AS
BEGIN
IF EXISTS (
SELECT 1
FROM inserted i
LEFT JOIN Carti c ON i.id_carte = c.id_carte
WHERE c.id_carte IS NULL
)
BEGIN
ROLLBACK;
RAISERROR ('Cartea pe care incercati sa o imprumutati nu exista', 16, 1);
END;
END;
GO
ALTER TABLE [dbo].[Imprumuturi] ENABLE TRIGGER [VerificaExistentaCarte]
GO
USE [master]
GO
ALTER DATABASE [Biblioteca2] SET  READ_WRITE 
GO
