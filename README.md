# Tools

A set of tools I've curated for a quick local development iteration.

## Install

```sh
./install.sh
```

Symlinks `tools.sh` to `~/.local/bin/tools`.

## Usage

```
Usage: tools <command> <tool>

Commands:
  start   <tool>   Start a tool
  stop    <tool>   Stop a tool
  reload  <tool>   Restart a tool
  ls               List available tools

Available tools:
  mysql
  mysql-legacy
  postgres
```

## Available tools

| Tool          | Image         | Port | Credentials                        |
| ------------- | ------------- | ---- | ---------------------------------- |
| `mysql`       | mysql:8.4     | 3306 | root/password, mysql/password, db `app` |
| `mysql-legacy`| mysql:8.0     | 3307 | root/password, mysql/password, db `app` |
| `postgres`    | postgres:17   | 5432 | postgres/password, db `app`        |

## Examples

```sh
tools ls
tools start postgres
tools reload mysql
tools stop mysql-legacy
```
