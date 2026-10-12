-- ════════════════════════════════════════════════════════════════════════════════
-- 🚗 PESHANG DATABASE CREATION & EMPTY SCHEMA SCRIPT (SQL Server / T-SQL)
-- 🏢 پڕۆژەی پێشانگا (Peshang) — دروستکردنی داتابەیس و تەیبڵەکان بە خاوێنی بەبێ داتا
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
-- 2. دروستکردنی تەیبڵی [CAR_] بۆ تۆمارکردنی زانیاری و وێنەی ئۆتۆمبێل
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
ELSE
BEGIN
    PRINT N'>> Table dbo.CAR_ already exists.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 3. دروستکردنی تەیبڵی [image_user] بۆ بەکارهێنەران و دەسەڵاتەکان
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

    -- تەنها بەکارهێنەری سەرەکی ئەدمین داخڵ دەکرێت
    INSERT INTO dbo.image_user ([User_], [password], [permetion], [on_off])
    VALUES ('admin', 'Na2652014Va', 'Admin', 'on');

    PRINT N'>> Table dbo.image_user created with default Admin account.';
END
ELSE
BEGIN
    PRINT N'>> Table dbo.image_user already exists.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 4. دروستکردنی تەیبڵی [BB] بۆ تۆمارکردنی کەموکوڕییەکانی ئۆتۆمبێل بە بەتاڵی
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
ELSE
BEGIN
    PRINT N'>> Table dbo.BB already exists.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 5. دروستکردنی تەیبڵی [XXX] بۆ لیست و هەڵبژاردنی جۆرەکانی کەموکوڕی
-- ════════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID(N'dbo.XXX', N'U') IS NULL
BEGIN
    PRINT N'>> Creating table dbo.XXX...';
    CREATE TABLE dbo.XXX (
        [id] [int] IDENTITY(1,1) NOT NULL,
        [Xx_] [nvarchar](250) NULL,
        CONSTRAINT [PK_XXX] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    -- داخڵکردنی بژاردە پێشوەختەکانی کەموکوڕی
    INSERT INTO dbo.XXX ([Xx_]) VALUES
    (N'ئیستۆپى تەگەرەکانى پێشەوە لاوازە'),
    (N'ئیستۆپى تەگەرەکانى دواوە لاوازە'),
    (N'لایتی پێشەوە کارناکات'),
    (N'لایتی دواوە / ستۆپ شکاوە'),
    (N'تایەکان سوابوون یان خراپن'),
    (N'سیستەمی ئیستۆپ / فەرمۆن کێشەی هەیە'),
    (N'جام شکاوە یان درزی تێدایە'),
    (N'دەرچوونی دووکەڵی ڕەش / شین لە گزۆز'),
    (N'دەنگی نائاسایی لە محەرەک'),
    (N'کێشە لە سیستەمی ئاڕاستەکردن (هۆڕن / سووکان)'),
    (N'جامشۆر یان فڵچەی جام کارناکات'),
    (N'شاسی / پەیکەری ئۆتۆمبێل کێشەی هەیە'),
    (N'فڕێنی دەستی (هاند) لاوازە'),
    (N'لایت و ئاماژەکانی لادان کارناکەن'),
    (N'لیزەر یان لایتی زیادە بەستراوە');

    PRINT N'>> Table dbo.XXX created with standard defect options.';
END
ELSE
BEGIN
    PRINT N'>> Table dbo.XXX already exists.';
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 6. زیادکردنی ئیندێکسەکان (Indexes) بۆ خێراتربوونی گەڕان و ڕاپۆرت
-- ════════════════════════════════════════════════════════════════════════════════
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_carNo' AND object_id = OBJECT_ID('dbo.CAR_'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_CAR_carNo] ON dbo.CAR_ ([carNo] ASC);
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_date_into' AND object_id = OBJECT_ID('dbo.CAR_'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_CAR_date_into] ON dbo.CAR_ ([date_into] DESC);
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_Psulla' AND object_id = OBJECT_ID('dbo.BB'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_BB_Psulla] ON dbo.BB ([Psulla] ASC);
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_date_' AND object_id = OBJECT_ID('dbo.BB'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_BB_date_] ON dbo.BB ([date_] DESC);
END
GO

-- ════════════════════════════════════════════════════════════════════════════════
-- 7. (بژاردەیی) کۆپیکردنی هەر تەیبڵێکی تری داتابەیسی کۆن (image_coart) بە بەتاڵی:
-- ئەگەر داتابەیسی image_coart لەسەر هەمان سێرڤەر بوو، دەتوانیت ئەم بەشەی خوارەوە جێبەجێ بکەیت:
-- ════════════════════════════════════════════════════════════════════════════════
/*
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'image_coart')
BEGIN
    PRINT N'>> Copying any extra tables from image_coart to Peshang (structure only)...';
    -- نموونە بۆ هەر تەیبڵێکی تر:
    -- IF OBJECT_ID(N'Peshang.dbo.YourOtherTable', N'U') IS NULL
    -- BEGIN
    --     SELECT TOP 0 * INTO Peshang.dbo.YourOtherTable FROM image_coart.dbo.YourOtherTable;
    -- END
END
*/

PRINT N'';
PRINT N'════════════════════════════════════════════════════════════════════';
PRINT N'✅ پیرۆزە! داتابەیسی [Peshang] بە هەموو تەیبڵەکانی بە بەتاڵی دروستکرا.';
PRINT N'════════════════════════════════════════════════════════════════════';
GO
