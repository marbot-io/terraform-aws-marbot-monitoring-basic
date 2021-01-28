'use strict';
const AWS = require('aws-sdk')
const cloudwatch = new AWS.CloudWatch({apiVersion: '2010-08-01'});
const sns = new AWS.SNS({apiVersion: '2010-03-31'});
const STATE2ACTION = {
  'ALARM': 'AlarmActions',
  'OK': 'OKActions',
  'INSUFFICIENT_DATA':  'InsufficientDataActions'
};
exports.handler = async (event) => {
  console.log(JSON.stringify(event));
  const data = await cloudwatch.describeAlarms({
    AlarmNames: [event.detail.alarmName],
    MaxRecords: 1
  }).promise();
  const alarms = [...data.CompositeAlarms, ...data.MetricAlarms];
  console.log(JSON.stringify(alarms));
  if (alarms.length === 0) {
    return;
  } else {
    const alarm = alarms[0];
    const action = STATE2ACTION[event.detail.state.value];
    const actions = alarm[action];
    console.log(JSON.stringify(actions));
    if (alarm.ActionsEnabled) {
      if (actions.filter(action => action.includes(':autoscaling:')).length > 0) {
        console.log("drop");
      } else {
        console.log("publish");
        await sns.publish({
          TopicArn: process.env.TOPIC_ARN,
          Message: JSON.stringify(event)
        }).promise();
      }
    }
  }
};
