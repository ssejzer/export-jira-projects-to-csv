# export-jira-projects-to-csv
Bash script to export JIRA projects, roles and permissions to CSV format

# Usage


## create a .env file with your instance details and credentials

```ini
# Your Personal Access Token
# https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html
TOKEN=hip-hip-env-files
# Your instance URL
URL='https://jira.mycompany.com:8400'
```

## Run it!

### To get all the projects
```bash
jiraproj2csv.sh
```

### To get one project
```bash
jiraproj2csv.sh "project ID"
```


