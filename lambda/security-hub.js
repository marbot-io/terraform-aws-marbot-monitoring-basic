'use strict';
const AWS = require('aws-sdk')
const securityhub = new AWS.SecurityHub({apiVersion: '2018-10-26'});
exports.handler = async (event) => {
  console.log(JSON.stringify(event));
  await securityhub.batchUpdateFindings({
    FindingIdentifiers: event.detail.findings.map((finding) => ({
      Id: finding.Id,
      ProductArn: finding.ProductArn
    })),
    Workflow: {
      Status: 'NOTIFIED'
    }
  }).promise();
};
