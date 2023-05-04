# Welcome to My Zsh
***

## Task
The task is to create a class called MySqliteRequest that behaves like a request on a real SQLite database. The class should have methods for select, where, join, order, insert, values, update, set, and delete. Additionally, a run method should be implemented to execute the query. A Command Line Interface (CLI) should also be created for the MySqlite class that accepts SQL-like queries.

## Description
To solve this challenge, I created the MySqliteRequest class in the my_sqlite_request.rb file. The class has methods for select, where, join, order, insert, values, update, set, and delete. The run method executes the query and returns the result. The CLI for the MySqlite class is created in the my_sqlite_cli.rb file. It accepts SQL-like queries and uses the MySqliteRequest class to execute the queries.

To install the project, simply clone the repository and ensure that Ruby is installed on your machine. No additional dependencies are required.

To use the project, run the my_sqlite_cli.rb file with Ruby. You will be presented with a prompt to enter queries in SQL-like format. The queries can include SELECT, INSERT, UPDATE, DELETE, and JOIN statements. The FROM and WHERE clauses are also supported. Only one WHERE condition and one JOIN condition are allowed per query.

## Installation
Clone the repository:

```bash

git clone https://REPO
```
## Usage

To use the CLI for the MySqlite class, run the my_sqlite_cli.rb file with Ruby:

```bash
    ruby my_sqlite_cli.rb
```
You will be presented with a prompt to enter queries in SQL-like format. For example:

```sql
    my_sqlite_cli> SELECT * FROM nba_player_data.csv WHERE birth_state='Indiana';
```
The queries can include SELECT, INSERT, UPDATE, DELETE, and JOIN statements. The FROM and WHERE clauses are also supported. Only one WHERE condition and one JOIN condition are allowed per query.

The Ctrl-C or quit commands can be used to exit the CLI.