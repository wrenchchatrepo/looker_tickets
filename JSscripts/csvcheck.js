const fs = require('fs');
const fastcsv = require('fast-csv');

function countTicketCommentBodyErrors(filePath) {
    const readStream = fs.createReadStream(filePath);
    let errorCount = 0;
    let recordCount = 0;

    const csvParser = fastcsv.parse({
        delimiter: ',',
        headers: true,
        skipEmptyLines: true
    });

    csvParser.on('data', function(record) {
        recordCount++;
        if (record.Ticket_Comment_Body && (record.Ticket_Comment_Body.includes('\n') || record.Ticket_Comment_Body.includes('\r') || record.Ticket_Comment_Body.includes('"'))) {
            // Increment error count for each problematic line
            errorCount++;
        }
        if (recordCount % 10000 === 0) {
            console.log(`Checked ${recordCount} records so far.`);
        }
    });

    csvParser.on('end', function() {
        console.log(`Total lines with errors in Ticket_Comment_Body: ${errorCount}`);
    });

    readStream.pipe(csvParser);
}

// Known path to your CSV file
countTicketCommentBodyErrors('/Users/dionedge/Documents/GitHub/scripts/tickets-all-corrected.csv');
