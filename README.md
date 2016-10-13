[![Build Status](https://api.travis-ci.org/theforeman/hammer_cli_foreman_remote_execution.svg)](https://travis-ci.org/theforeman/hammer_cli_foreman_remote_execution)
[![Gem Version](https://img.shields.io/gem/v/hammer_cli_foreman_remote_execution.svg)](https://rubygems.org/gems/hammer_cli_foreman_remote_execution)
[![Code Climate](https://codeclimate.com/github/theforeman/hammer_cli_foreman_remote_execution/badges/gpa.svg)](https://codeclimate.com/github/theforeman/hammer_cli_foreman_remote_execution)


CLI Plugin for Foreman Remote Execution
=======================================

This [Hammer CLI](https://github.com/theforeman/hammer-cli) plugin contains commands for [foreman_remote_execution](https://github.com/theforeman/foreman_remote_execution).

# Examples

## Templates

### List templates

```
hammer job-template list
```

### Create a template

```
hammer job-template create --file /tmp/template.txt --name "Ping a Host"\
  --provider-type SSH --job-category "Commands"
```

### Create a template input

```
hammer template-input create --template-id 17 --name hostname\
  --input-type user --options www.google.com,www.facebook.com,localhost
```

## Jobs

### Show jobs

```
hammer job-invocation list
```

Show details:

```
hammer job-invocation info --id 83
```

### Run a job with command line inputs

```
hammer job-invocation create --job-template "Run Command - SSH Default" \
  --inputs command="ping -c 50 www.google.com" --search-query "name ~ rex01"
```

```
hammer job-invocation create --job-template "Package Action - SSH Default" \
  --inputs package=vim-enhanced,action=install --search-query "name ~ rex01"
```

### Run a job with file inputs

```
hammer job-invocation create --job-template "Run Command - SSH Default"\
  --input-files command=/tmp/script.sh --search-query "name ~ rex01"
```

### Show output

If the job is currently running, this will refresh until the job completes.

```
hammer job-invocation output --id 155 --host rex01.example.com
```

Alternatively, pass the `--async` option to see the output so far:

```
hammer job-invocation output --id 155 --host rex01.example.com --async
```

## Developer Information

### Updating API docs

In `test/data/[foreman_version]/foreman_api.json`, we include the Apipie
documentation, with generated examples from the tests.

When adding new features to the hammer, you'll need to update this.

1. From foreman directory, run remote execution tests with examples enabled:

        APIPIE_RECORD=examples rake test:foreman_remote_execution

2. From foreman directory, generate the apipie cache for English:

        FOREMAN_APIPIE_LANGS=en rake apipie:cache

3. Copy the docs to hammer_cli_foreman_remote_execution

        cp public/apipie-cache/apidoc/v2.en.json ~/hammer_cli_foreman_remote_execution/test/data/1.10/foreman_api.json

## License

This project is licensed under the GPLv3+.
