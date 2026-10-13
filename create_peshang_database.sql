-- ════════════════════════════════════════════════════════════════════════════════
-- 🚗 PESHANG DATABASE CREATION & EMPTY SCHEMA SCRIPT (SQL Server / T-SQL)
-- 🏢 پڕۆژەی پێشانگا (Peshang) — سێرڤەر: 185.181.111.17
-- 👑 گەشەپێدەر: نەژاد قادر محمد
-- ════════════════════════════════════════════════════════════════════════════════

USE [master];
GO

-- 1. دروستکردنی داتابەیسی نوێ [Peshang] ئەگەر بوونی نەبێت
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Peshang')
BEGIN
    PRINT N'>> Creating database [Peshang]...';
    CREATE DATABASE [Peshang];
    PRINT N'>> Database [Peshang] created successfully.';
END
ELSE
BEGIN
    PRINT N'>> Database [Peshang] already exists.';
END
GO

USE [Peshang];
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 2. دروستکردنی تەیبڵی [CAR_] بۆ تۆمارکردنی زانیاری و وێنەی ئۆتۆمبێل (بە بەتاڵی)
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.CAR_', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.CAR_...';
    CREATE TABLE dbo.CAR_ (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [carNo] [nvarchar](8) NULL,
        [bash] [nvarchar](30) NULL,
        [plet] [nvarchar](30) NULL,
        [pic] [image] NULL,
        [date_into] [date] NULL,
        [Nnote] [nchar](100) NULL,
        [uuser] [nvarchar](50) NULL,
        [DD] [datetime] NULL,
        [bar_] [nvarchar](255) NULL,
        [N_pshknin] [nvarchar](50) NULL,
        [driver_name] [nvarchar](100) NULL,
        [mobile] [nvarchar](20) NULL,
        [address] [nvarchar](200) NULL,
        [chassis] [nvarchar](50) NULL,
        [color] [nvarchar](50) NULL,
        [gear] [nvarchar](50) NULL,
        [fuel] [nvarchar](50) NULL,
        [pistons] [nvarchar](50) NULL,
        [inspector_name] [nvarchar](100) NULL,
        [price] [nvarchar](50) NULL,
        [result] [nvarchar](50) NULL,
        [expire_date] [date] NULL,
        [lab_name] [nvarchar](100) NULL,
        CONSTRAINT [PK_CAR_] PRIMARY KEY CLUSTERED ([id] ASC)
    );
    PRINT N'>> Table dbo.CAR_ created.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 3. دروستکردنی تەیبڵی [image_user] بۆ بەکارهێنەران و ئەدمین
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.image_user', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.image_user...';
    CREATE TABLE dbo.image_user (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [User_] [nvarchar](50) NULL,
        [permetion] [nvarchar](50) NULL,
        [on_off] [nvarchar](50) NULL,
        [password] [nvarchar](255) NULL,
        CONSTRAINT [PK_image_user] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    -- گواستنەوەی بەکارهێنەران لە image_coart ئەگەر هەبێت
    IF EXISTS (SELECT * FROM image_coart.sys.tables WHERE name = 'image_user')
    BEGIN
        SET IDENTITY_INSERT dbo.image_user ON;
        INSERT INTO dbo.image_user (id, User_, permetion, on_off, password)
        SELECT id, User_, permetion, on_off, password FROM image_coart.dbo.image_user;
        SET IDENTITY_INSERT dbo.image_user OFF;
    END

    -- دڵنیابوونەوە لە بوونی هەژماری سەرەکی ئەدمین
    IF NOT EXISTS (SELECT 1 FROM dbo.image_user WHERE User_ = 'admin')
    BEGIN
        INSERT INTO dbo.image_user ([User_], [password], [permetion], [on_off])
        VALUES ('admin', 'Na2652014Va', 'Admin', 'on');
    END

    PRINT N'>> Table dbo.image_user created with accounts.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 4. دروستکردنی تەیبڵی [BB] بۆ کەموکوڕییەکانی ئۆتۆمبێل (بە بەتاڵی)
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.BB', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.BB...';
    CREATE TABLE dbo.BB (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [Psulla] [int] NULL,
        [Xx_] [nvarchar](250) NULL,
        [date_] [date] NULL,
        [user_] [nvarchar](50) NULL,
        [AA] [nvarchar](50) NULL,
        [BBB] [nvarchar](50) NULL,
        [CCC] [nvarchar](50) NULL,
        [DDD] [nvarchar](50) NULL,
        [EEE] [nvarchar](50) NULL,
        CONSTRAINT [PK_BB] PRIMARY KEY CLUSTERED ([id] ASC)
    );
    PRINT N'>> Table dbo.BB created.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 5. دروستکردنی تەیبڵی [XXX] بۆ لیست و هەڵبژاردنی کەموکوڕییەکان
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.XXX', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.XXX...';
    CREATE TABLE dbo.XXX (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [Xx_] [nvarchar](250) NULL,
        CONSTRAINT [PK_XXX] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    IF EXISTS (SELECT * FROM image_coart.sys.tables WHERE name = 'XXX')
    BEGIN
        SET IDENTITY_INSERT dbo.XXX ON;
        INSERT INTO dbo.XXX (id, Xx_)
        SELECT id, Xx_ FROM image_coart.dbo.XXX;
        SET IDENTITY_INSERT dbo.XXX OFF;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.XXX ([Xx_]) VALUES
        (N'لایتی پێشەوە کارناکات'),
        (N'لایتی دواوە / ستۆپ شکاوە'),
        (N'تایەکان سوابوون یان خراپن'),
        (N'سیستەمی ئیستۆپ / فەرمۆن کێشەی هەیە'),
        (N'جام شکاوە یان درزی تێدایە'),
        (N'دەرچوونی دووکەڵی ڕەش / شین لە گزۆز'),
        (N'دەنگی نائاسایی لە محەرەک'),
        (N'کێشە لە سیستەمی ئاڕاستەکردن (هۆڕن / سووکان)'),
        (N'جامشۆر یان فڵچەی جام کارناکات'),
        (N'شاسی / پەیکەری ئۆتۆمبێل کێشەی هەیە');
    END
    PRINT N'>> Table dbo.XXX created.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 6. دروستکردنی تەیبڵی [PIC] بۆ وێنەی کەیسەکان (بە بەتاڵی)
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.PIC', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.PIC...';
    CREATE TABLE dbo.PIC (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [Case_No] [nvarchar](50) NULL,
        [pic] [image] NULL,
        [Full_Name] [nvarchar](100) NULL,
        [date_in] [date] NULL,
        [User_] [nvarchar](50) NULL,
        [NNote] [nvarchar](50) NULL,
        CONSTRAINT [PK_PIC] PRIMARY KEY CLUSTERED ([id] ASC)
    );
    PRINT N'>> Table dbo.PIC created.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 7. دروستکردنی تەیبڵی [Tbl_User]
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.Tbl_User', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.Tbl_User...';
    CREATE TABLE dbo.Tbl_User (
        [id] [tinyint] IDENTITY(1,1) NOT NULL,
        [User_id] [nvarchar](50) NOT NULL,
        [Password] [nvarchar](50) NOT NULL,
        [Permission] [nvarchar](50) NOT NULL,
        CONSTRAINT [PK_Tbl_User] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    IF EXISTS (SELECT * FROM image_coart.sys.tables WHERE name = 'Tbl_User')
    BEGIN
        SET IDENTITY_INSERT dbo.Tbl_User ON;
        INSERT INTO dbo.Tbl_User (id, User_id, Password, Permission)
        SELECT id, User_id, Password, Permission FROM image_coart.dbo.Tbl_User;
        SET IDENTITY_INSERT dbo.Tbl_User OFF;
    END
    PRINT N'>> Table dbo.Tbl_User created.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 8. دروستکردنی ئیندێکسەکان (Performance Indexes)
-- ════════════════════════════════════════════════════════════════════════════════
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_carNo' AND object_id = OBJECT_ID('dbo.CAR_'))
    CREATE NONCLUSTERED INDEX [IX_CAR_carNo] ON dbo.CAR_ ([carNo] ASC);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_date_into' AND object_id = OBJECT_ID('dbo.CAR_'))
    CREATE NONCLUSTERED INDEX [IX_CAR_date_into] ON dbo.CAR_ ([date_into] DESC);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_Psulla' AND object_id = OBJECT_ID('dbo.BB'))
    CREATE NONCLUSTERED INDEX [IX_BB_Psulla] ON dbo.BB ([Psulla] ASC);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_date_' AND object_id = OBJECT_ID('dbo.BB'))
    CREATE NONCLUSTERED INDEX [IX_BB_date_] ON dbo.BB ([date_] DESC);
GO

PRINT N'';
PRINT N'════════════════════════════════════════════════════════════════════';
PRINT N'✅ پیرۆزە! داتابەیسی [Peshang] بە سەرکەوتوویی دروستکرا.';
PRINT N'════════════════════════════════════════════════════════════════════';
GO
