# automation

Daily Automated System Report Script with Cron Job and Slack Notifications.

## Overview
This project provides a Bash script that automates the generation of system performance reports, including Disk Usage, CPU Load, and Memory Usage. The script is scheduled to run daily via a cron job and sends the report as a notification to a specified Slack channel using Slack's Incoming Webhooks. 

## Features
- **Automated System Report:** Collects important system metrics like Disk Usage, CPU Load, and Memory Usage.
- **Daily Scheduling:** Uses a cron job to automatically generate and send reports every day at 8 AM.
- **Slack Notifications:** Sends the generated report directly to a Slack channel via a configured webhook.


### 1. Clone the Repository
Clone the project repository to your local environment:
```bash
git clone https://github.com/yourusername/your-repo-name.git
```

### 2. Configure Slack Webhook
In the Bash script (`system_report.sh`), you will need to set your Slack Incoming Webhook URL:
```bash
WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"
```
Replace the placeholder with your actual Slack webhook URL.

### 3. Make the Script Executable
To ensure the script can be executed, give it the appropriate permissions:
```bash
chmod +x system_report.sh
```

### 4. Set Up the Cron Job
To schedule the script to run every day at 8 AM, edit the cron jobs using the following command:
```bash
crontab -e
```
Add the following cron entry:
```bash
0 8 * * * /full/path/to/system_report.sh
```
This will ensure that the script runs daily at 8 AM. Make sure to replace `/full/path/to/system_report.sh` with the actual path of the script on your system.

### 5. Test the Script
Run the script manually to ensure that it correctly generates a report and sends a Slack notification:
```bash
./system_report.sh
```

## Script Breakdown

- **Disk Usage Report:**
  Uses `df -h` to display disk usage in human-readable format.
  
- **CPU Load Report:**
  Extracts the load average using `top -bn1 | grep "load average:"`.
  
- **Memory Usage Report:**
  Displays free and used memory with `free -h`.

The collected information is saved into `/system_report.txt` and sent to Slack using a POST request to the configured webhook.

### Cron Job
The cron job ensures the script runs automatically at 8 AM every day. You can customize the schedule by modifying the cron expression in `crontab`.

## Repository Contents

```plaintext
.
├── system_report.sh     # Bash script for generating system reports and sending to Slack
├── README.md            # Documentation for the project
```

## Conclusion
This project automates the generation of daily system performance reports and sends them to a designated Slack channel, allowing for efficient and convenient system monitoring. The use of cron ensures that the script runs regularly without requiring manual intervention, and the Slack integration provides real-time visibility of system metrics.
