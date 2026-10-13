const sql = require('mssql');

const dbConfig = {
  server: '185.181.111.17',
  port: 1433,
  user: 'ASA',
  password: 'Nazhad9999',
  connectionTimeout: 15000,
  requestTimeout: 60000,
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

async function createPeshangDb() {
  console.log('===============================================================');
  console.log('🚀 Connecting to SQL Server: 185.181.111.17:1433 (user: ASA)...');
  console.log('===============================================================');

  // Step 1: Connect to master to create Peshang database
  let pool = await sql.connect({ ...dbConfig, database: 'master' });
  console.log('✅ Connected to master database.');

  console.log('🔍 Checking if database [Peshang] exists...');
  const dbCheck = await pool.request().query("SELECT database_id FROM sys.databases WHERE name = N'Peshang'");
  if (dbCheck.recordset.length === 0) {
    console.log('>> Creating database [Peshang] on 185.181.111.17...');
    await pool.request().query("CREATE DATABASE [Peshang]");
    console.log('✅ Database [Peshang] created successfully!');
  } else {
    console.log('ℹ️ Database [Peshang] already exists.');
  }
  await pool.close();

  // Step 2: Connect to Peshang database
  console.log('\n📡 Connecting to [Peshang] database to create empty tables...');
  pool = await sql.connect({ ...dbConfig, database: 'Peshang' });

  // 1. Table CAR_ (completely empty)
  console.log('>> Creating table dbo.CAR_...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.CAR_', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.CAR_ (
        [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
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
        [lab_name] [nvarchar](100) NULL
      );
      PRINT 'Table dbo.CAR_ created.';
    END
  `);

  // 2. Table BB (defects records - completely empty)
  console.log('>> Creating table dbo.BB...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.BB', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.BB (
        [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [Psulla] [int] NULL,
        [Xx_] [nvarchar](250) NULL,
        [date_] [date] NULL,
        [user_] [nvarchar](50) NULL,
        [AA] [nvarchar](50) NULL,
        [BBB] [nvarchar](50) NULL,
        [CCC] [nvarchar](50) NULL,
        [DDD] [nvarchar](50) NULL,
        [EEE] [nvarchar](50) NULL
      );
      PRINT 'Table dbo.BB created.';
    END
  `);

  // 3. Table PIC (case photos - completely empty)
  console.log('>> Creating table dbo.PIC...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.PIC', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.PIC (
        [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [Case_No] [nvarchar](50) NULL,
        [pic] [image] NULL,
        [Full_Name] [nvarchar](100) NULL,
        [date_in] [date] NULL,
        [User_] [nvarchar](50) NULL,
        [NNote] [nvarchar](50) NULL
      );
      PRINT 'Table dbo.PIC created.';
    END
  `);

  // 4. Table XXX (defects lookup)
  console.log('>> Creating table dbo.XXX and copying defect lookup categories...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.XXX', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.XXX (
        [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [Xx_] [nvarchar](250) NULL
      );
      
      -- Copy defect suggestions from image_coart if available, else insert defaults
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
      PRINT 'Table dbo.XXX created.';
    END
  `);

  // 5. Table image_user (users & permissions)
  console.log('>> Creating table dbo.image_user and syncing user accounts...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.image_user', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.image_user (
        [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [User_] [nvarchar](50) NULL,
        [permetion] [nvarchar](50) NULL,
        [on_off] [nvarchar](50) NULL,
        [password] [nvarchar](255) NULL
      );

      -- Copy users from image_coart if available
      IF EXISTS (SELECT * FROM image_coart.sys.tables WHERE name = 'image_user')
      BEGIN
        SET IDENTITY_INSERT dbo.image_user ON;
        INSERT INTO dbo.image_user (id, User_, permetion, on_off, password)
        SELECT id, User_, permetion, on_off, password FROM image_coart.dbo.image_user;
        SET IDENTITY_INSERT dbo.image_user OFF;
      END

      -- Ensure master admin user exists
      IF NOT EXISTS (SELECT 1 FROM dbo.image_user WHERE User_ = 'admin')
      BEGIN
        INSERT INTO dbo.image_user (User_, password, permetion, on_off)
        VALUES ('admin', 'Na2652014Va', 'Admin', 'on');
      END
      PRINT 'Table dbo.image_user created.';
    END
  `);

  // 6. Table Tbl_User
  console.log('>> Creating table dbo.Tbl_User...');
  await pool.request().query(`
    IF OBJECT_ID(N'dbo.Tbl_User', N'U') IS NULL
    BEGIN
      CREATE TABLE dbo.Tbl_User (
        [id] [tinyint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [User_id] [nvarchar](50) NOT NULL,
        [Password] [nvarchar](50) NOT NULL,
        [Permission] [nvarchar](50) NOT NULL
      );

      IF EXISTS (SELECT * FROM image_coart.sys.tables WHERE name = 'Tbl_User')
      BEGIN
        SET IDENTITY_INSERT dbo.Tbl_User ON;
        INSERT INTO dbo.Tbl_User (id, User_id, Password, Permission)
        SELECT id, User_id, Password, Permission FROM image_coart.dbo.Tbl_User;
        SET IDENTITY_INSERT dbo.Tbl_User OFF;
      END
      PRINT 'Table dbo.Tbl_User created.';
    END
  `);

  // 7. Indexes for High Performance
  console.log('>> Creating performance indexes...');
  await pool.request().query(`
    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_carNo' AND object_id = OBJECT_ID('dbo.CAR_'))
      CREATE NONCLUSTERED INDEX [IX_CAR_carNo] ON dbo.CAR_ ([carNo] ASC);

    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CAR_date_into' AND object_id = OBJECT_ID('dbo.CAR_'))
      CREATE NONCLUSTERED INDEX [IX_CAR_date_into] ON dbo.CAR_ ([date_into] DESC);

    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_Psulla' AND object_id = OBJECT_ID('dbo.BB'))
      CREATE NONCLUSTERED INDEX [IX_BB_Psulla] ON dbo.BB ([Psulla] ASC);

    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_BB_date_' AND object_id = OBJECT_ID('dbo.BB'))
      CREATE NONCLUSTERED INDEX [IX_BB_date_] ON dbo.BB ([date_] DESC);
  `);

  // Verification
  console.log('\n===============================================================');
  console.log('📊 Verification of tables created in [Peshang]:');
  const tables = await pool.request().query(`
    SELECT t.name AS TableName, p.rows AS RowCounts
    FROM sys.tables t
    INNER JOIN sys.partitions p ON t.object_id = p.object_id
    WHERE p.index_id IN (0, 1)
    ORDER BY t.name;
  `);

  console.table(tables.recordset);
  console.log('===============================================================');
  console.log('🎉 ALL DONE! Peshang database is live and fully ready on 185.181.111.17!');
  console.log('===============================================================');

  await pool.close();
}

createPeshangDb().catch(err => {
  console.error('❌ Failed:', err);
  process.exit(1);
});
