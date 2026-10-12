/**
 * 🚗 AUTOMATED DATABASE INITIALIZER FOR PESHANG
 * ══════════════════════════════════════════════════════════════════
 * ئەم سکریپتە بە شێوەیەکی ئۆتۆماتیکی داتابەیسی Peshang و تەیبڵەکان بە بەتاڵی دروست دەکات
 * کاتێک بەیانی سێرڤەرەکە هەڵکرا، تەنها ئەمە لێدە:
 * node setup_peshang_db.js
 * ══════════════════════════════════════════════════════════════════
 */

require('dotenv').config();
const fs = require('fs');
const path = require('path');
const sql = require('mssql');

const CONFIG_PATH = path.join(__dirname, 'config.json');
let dbConfig = {
  server: process.env.DB_SERVER || '62.201.232.190',
  database: 'Peshang',
  user: process.env.DB_USER || 'sa',
  password: process.env.DB_PASSWORD || 'Nazhad@5759',
  port: parseInt(process.env.DB_PORT || '1433'),
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

if (fs.existsSync(CONFIG_PATH)) {
  try {
    const saved = JSON.parse(fs.readFileSync(CONFIG_PATH, 'utf8'));
    if (saved.server) dbConfig.server = saved.server;
    if (saved.user) dbConfig.user = saved.user;
    if (saved.password) dbConfig.password = saved.password;
    if (saved.port) dbConfig.port = parseInt(saved.port);
  } catch (e) {}
}

async function runSetup() {
  console.log('====================================================');
  console.log('🚀 دەستپێکردنی ئامادەکردنی داتابەیسی نوێی Peshang...');
  console.log(`📡 بەستنەوە بە سێرڤەر: ${dbConfig.server}:${dbConfig.port}`);
  console.log('====================================================');

  // Step 1: Connect to master to check/create database
  const masterConnConfig = {
    server: dbConfig.server,
    port: dbConfig.port,
    database: 'master',
    user: dbConfig.user,
    password: dbConfig.password,
    connectionTimeout: 15000,
    requestTimeout: 30000,
    options: {
      encrypt: false,
      trustServerCertificate: true
    }
  };

  let pool;
  try {
    pool = await sql.connect(masterConnConfig);
    console.log('✅ پەیوەندی بە سەرکەوتوویی دروستکرا لەگەڵ سێرڤەر (Connected to SQL Server).');

    console.log('🔍 پشکنین بۆ داتابەیسی Peshang...');
    await pool.request().query(`
      IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Peshang')
      BEGIN
          CREATE DATABASE [Peshang];
          PRINT 'Database Peshang created.';
      END
    `);
    console.log('✅ داتابەیسی [Peshang] ئامادەیە.');
    await pool.close();
  } catch (err) {
    console.error('❌ هەڵە لە پەیوەندی کردن بە سێرڤەر:');
    console.error(err.message);
    console.log('💡 تکایە دڵنیابەرەوە کە سێرڤەرەکە هەڵکراوە و پۆڕتی 1433 کراوەیە.');
    process.exit(1);
  }

  // Step 2: Connect to Peshang database to create tables
  const peshangConnConfig = {
    ...masterConnConfig,
    database: 'Peshang'
  };

  try {
    pool = await sql.connect(peshangConnConfig);
    console.log('🔧 دروستکردنی تەیبڵەکان بە بەتاڵی لەناو داتابەیسی Peshang...');

    // Read SQL script
    const sqlScriptPath = path.join(__dirname, 'create_peshang_database.sql');
    if (fs.existsSync(sqlScriptPath)) {
      const scriptContent = fs.readFileSync(sqlScriptPath, 'utf8');
      const batches = scriptContent
        .split(/\bGO\b/i)
        .map(b => b.trim())
        .filter(b => b.length > 0 && !b.startsWith('USE [master]'));

      for (const batch of batches) {
        if (batch) {
          await pool.request().query(batch);
        }
      }
    }

    console.log('====================================================');
    console.log('🎉 پیرۆزە! هەموو تەیبڵەکانی (CAR_, image_user, BB, XXX) بە سەرکەوتوویی دروستکران!');
    console.log('📊 داتابەیسەکە بەتاڵە و ئامادەیە بۆ بەکارهێنان لە شوێنە نوێیەکە.');
    console.log('====================================================');
    await pool.close();
  } catch (err) {
    console.error('❌ هەڵە لە دروستکردنی تەیبڵەکان:');
    console.error(err.message);
  }
}

runSetup();
