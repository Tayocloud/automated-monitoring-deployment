# System Monitoring with Bash, Email Alerts & CI/CD Deployment

This project is a lightweight system monitoring tool built using **Bash** scripting. It checks **CPU**, **memory**, and **disk usage**, and sends automated email alerts when usage exceeds defined thresholds. The script is deployed using a **CI/CD pipeline** via **GitHub Actions** and can be run on any EC2 instance or virtual machine. All alert data is logged for future reference.



## Features

- **Monitors CPU, Memory, and Disk Usage**  
- **Sends Email Alerts**: Uses **Gmail SMTP** for real-time alerts when thresholds are exceeded
- **Logging**: All alerts are logged in `/var/log/system_monitor.log` for historical tracking
- **Automatic Execution**: Runs every 3 hours via **cron job**
- **CI/CD Deployment**: GitHub Actions for automated deployment to an EC2 instance



## Architecture Overview

This system consists of:
- A **Bash script** that monitors system resources and triggers alerts.
- **Email notifications** through Gmail's SMTP server.
- **CI/CD pipeline** using GitHub Actions to deploy the monitoring script to an EC2 instance.
- **Logging** system to record every alert that is triggered.



## Prerequisites

- **Bash**: The script is written in Bash and requires a Linux or Unix-based system.
- **Gmail Account**: Used for sending email alerts (requires **App Password** for Gmail).
- **EC2 Instance** (Optional): If you want to deploy the script on AWS EC2.
- **GitHub Actions**: For CI/CD pipeline deployment to EC2.


## Setup

### 1. Clone the Repository
Clone this repository to your local machine or directly to your EC2 instance:

```bash
git clone https://github.com/yourusername/repository-name.git
cd repository-name

2. Update Email Credentials

In the monitor.sh script, replace the following variables with your email and app password:

EMAIL_FROM="your_email@gmail.com"
EMAIL_TO="recipient_email@gmail.com"
EMAIL_PASS="your_app_password"

3. Set Cron Job for Automated Execution

To ensure the script runs every 3 hours, add it to your cron jobs:

crontab -e

Then, add the following line:

0 */3 * * * /path/to/monitor.sh

4. Deploy via CI/CD Pipeline (GitHub Actions)

This repository includes a .github folder with a pre-configured CI/CD pipeline. This pipeline automatically deploys the script to your EC2 instance whenever changes are pushed to the repository.

Ensure that the following steps are completed:

1. SSH Access: Your EC2 instance must be accessible via SSH.


2. AWS Credentials: Set up your AWS credentials on GitHub using GitHub Secrets for deployment.


3. Push to GitHub: Once everything is configured, any new push to the repository will trigger the GitHub Actions workflow to deploy the monitoring script to your EC2 instance.




Running the Script

After setup, the script will:

Monitor system resources (CPU, memory, and disk).

Send email alerts if any resource exceeds the threshold (e.g., 80%).

Log all alerts into /var/log/system_monitor.log.


You can manually run the script by executing:

./monitor.sh


Acknowledgments

Inspired by system monitoring tools like Datadog but built from scratch.

Thanks to the GitHub Actions documentation for helping with CI/CD setup.

Special mention to msmtp for enabling email functionality in Bash.


### How to Use

1. Replace placeholders with your personal email credentials and recipient details.
2. Configure your system to run the script automatically every 3 hours.
3. Push the project to GitHub, and configure GitHub Actions to deploy it to your EC2 instance.

This `README.md` provides clear instructions to get your project running from scratch! Let me know if you'd like any adjustments!

