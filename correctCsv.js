const fs = require('fs');
const csv = require('csv');

const inputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all.csv';
const outputFilePath = '/Users/dionedge/Documents/GitHub/scripts/tickets-all-corrected.csv';

let processedRecords = 0;
const updateFrequency = 10000; // Update progress every 10000 records

const input = fs.createReadStream(inputFilePath);
const output = fs.createWriteStream(outputFilePath);
const parser = csv.parse({ columns: true });

const transformer = csv.transform((record, callback) => {
    processedRecords++;
    if (processedRecords % updateFrequency === 0) {
        console.log(`${processedRecords} records processed`);
    }
    // Assuming Ticket_Comment_Body needs correction
    if (record.Ticket_Comment_Body && record.Ticket_Comment_Body.includes('"')) {
        // Escape double quotes
        record.Ticket_Comment_Body = record.Ticket_Comment_Body.replace(/"/g, '""');
    }
    callback(null, record);
}, { parallel: 5 }); // Adjust parallelism as needed

const stringifier = csv.stringify({ header: true });

// Pipe the processes
input.pipe(parser).pipe(transformer).pipe(stringifier).pipe(output);

output.on('finish', () => {
    console.log(`Processing complete. Total records processed: ${processedRecords}`);
});
