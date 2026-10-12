const fs = require('fs');
const path = require('path');

function replaceInFile(filePath) {
    if (!fs.existsSync(filePath)) return;
    let content = fs.readFileSync(filePath, 'utf8');
    const originalContent = content;

    content = content.replace(/Peshang/g, "Peshang");
    content = content.replace(/Peshang/g, "Peshang");
    content = content.replace(/PESHANG/g, "PESHANG");

    if (content !== originalContent) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated: ${filePath}`);
    }
}

function walkSync(currentDirPath, callback) {
    fs.readdirSync(currentDirPath).forEach(function (name) {
        var filePath = path.join(currentDirPath, name);
        var stat = fs.statSync(filePath);
        if (stat.isFile()) {
            callback(filePath, stat);
        } else if (stat.isDirectory()) {
            if (name !== 'node_modules' && name !== '.git') {
                walkSync(filePath, callback);
            }
        }
    });
}

walkSync(__dirname, function(filePath) {
    if (filePath.endsWith('.js') || filePath.endsWith('.json') || filePath.endsWith('.env') || filePath.endsWith('.html') || filePath.endsWith('.bat')) {
        replaceInFile(filePath);
    }
});

console.log("All references updated to Peshang successfully!");
