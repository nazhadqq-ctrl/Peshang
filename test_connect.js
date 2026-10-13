const sql = require('mssql');

const combinations = [
  { user: 'sa', password: 'Nazhad@5759' },
  { user: 'sa', password: 'Nazhad9999' },
  { user: 'ASA', password: 'Nazhad9999' },
  { user: 'ASA', password: 'Nazhad@5759' }
];

async function testAll() {
  for (const c of combinations) {
    console.log(`Testing user: ${c.user} on 185.181.111.17...`);
    const cfg = {
      server: '185.181.111.17',
      port: 1433,
      database: 'master',
      user: c.user,
      password: c.password,
      connectionTimeout: 5000,
      options: {
        encrypt: false,
        trustServerCertificate: true
      }
    };
    try {
      const pool = await sql.connect(cfg);
      console.log(`>>> SUCCESS! Connected with user: ${c.user}`);
      const res = await pool.request().query('SELECT @@VERSION as ver, name FROM sys.databases');
      console.log('Databases on server:', res.recordset.map(r => r.name).filter(Boolean));
      await pool.close();
      return { user: c.user, password: c.password };
    } catch (err) {
      console.log(`Failed for ${c.user}: ${err.message}`);
    }
  }
}

testAll();
