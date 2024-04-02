const fs = require('fs');
const parse = require('csv-parse');
const stringify = require('csv-stringify');

const inputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all-corrected.csv';
const outputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all-cleaned.csv';

const output = fs.createWriteStream(outputFilePath);

fs.createReadStream(inputFilePath)
    .pipe(parse.parse({
        columns: true,
        skip_empty_lines: true
    }))
    .on('data', function(record) {
        Object.keys(record).forEach(key => {
            record[key] = record[key].replace(/[^\x00-\x7F]/g, '');
        });
        stringify.stringify([record], { header: false }, function(err, outputLine) {
            if (err) {
                console.error(err);
                return;
            }
            output.write(outputLine);
        });
    })
    .on('end', function() {
        console.log('Cleaning process completed.');
    });

output.on('finish', function() {
    output.end();
});
