CLI Plugin for Foreman Remote Execution
=======================================

This [Hammer CLI](https://github.com/theforeman/hammer-cli) plugin contains commands for [foreman_remote_execution](https://github.com/theforeman/foreman_remote_execution).

Examples
--------

### Create a Template

```
hammer job-template create --file /tmp/template.txt --name "Ping a Host"\
  --provider-type Ssh --job-name "Ping"
```

### Create a Template Input

```
hammer template-input create --template-id 17 --name hostname\
  --input-type user --options www.google.com,www.facebook.com,localhost
```

### Run a Job Examples

#### Command line inputs

```
hammer job-invocation create --job-name "Run Command" --inputs command="ping -c 50 www.google.com"\
  --search-query "name ~ rex01"
```

```
hammer job-invocation create --job-name "Package Action"\
  --inputs package=vim-enhanced,action=install --search-query "name ~ rex01"
```

#### File inputs:

```
hammer job-invocation create --job-name "Run Command"\
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

License
-------

This project is licensed under the GPLv3+.
