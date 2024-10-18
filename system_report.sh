#!/bin/bash

# Filename for the report
REPORT_DETAILS="system_report.txt"
NAME="Folashade"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

# Create or clear the report file
echo "Generating system report......" > "$REPORT_DETAILS"
echo ".............................." >> "$REPORT_DETAILS"
echo "" >> "$REPORT_DETAILS"

# CPU Information
echo "CPU info: $(lscpu | grep 'Model name' | awk -F ':' '{ print $2 }' | xargs)" >> "$REPORT_DETAILS"

# Memory Usage
echo "Memory usage:" >> "$REPORT_DETAILS"
free -h >> "$REPORT_DETAILS"

# Disk Usage
echo "Disk Usage: " >> "$REPORT_DETAILS"
df -h >> "$REPORT_DETAILS"

# Finish report
echo "" >> "$REPORT_DETAILS"
echo "Report generated on: $(date)" >> "$REPORT_DETAILS"

# Print report file location
echo "System report saved to: $REPORT_DETAILS"

# Read the report file content
REPORT_CONTENT=$(<"$REPORT_DETAILS")

# Escape newlines and backticks in the content to ensure it's properly formatted for JSON
ESCAPED_REPORT_CONTENT=$(echo "$REPORT_CONTENT" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/`/\\`/g')

# Construct the message to be sent to Slack
MESSAGE="System report generated by $NAME on $(date).\n\n\`\`\`$ESCAPED_REPORT_CONTENT\`\`\`"

# Send the report content to Slack
response=$(curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL)

# Check if the report was sent successfully
if [[ $response == *"ok"* ]]; then
    echo "Report sent to Slack successfully!"
else
    echo "Failed to send report to Slack: $response"
fi
