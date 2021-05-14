https://github.com/ankane/dexter
https://ankane.org/introducing-dexter
https://www.busbud.com/blog/automatically-index-heroku-postgres-database-dexter/
https://github.com/ankane/dexter/blob/master/guides/Hosted-Postgres.md

# "docker compose up -d" pour installer postgres avec l'extension HypoPG import le sql de la db de prod
# "gem install pgdexter" pour parser les logs
# Enfin pipe les logs de la prod vers dexter

app_name="app_name"
file_path="db_$(date +%Y_%m_%d-%H_%M_%S).dump"
curl `heroku pg:backups public-url --app yespark` > $file_path
pg_restore -v --host=localhost --username=dexter --password --dbname=dexter --clean --no-acl --jobs=3 --no-owner db_2021_04_23-20_38_06.dump

heroku logs -a yespark -p postgres -t \
    | sed 's/^.*: \[[A-Z0-9_]*] \[[0-9-]*]//' \
    | dexter --log-level debug --min-calls 100 --min-time 1 --interval 60  --create --analyze postgres://dexter:dexter@localhost:5432/dexter \
    | tee dexter.log


        o.separator "Options:"
        o.boolean "--analyze", "analyze tables that haven't been analyzed in the past hour", default: false
        o.boolean "--create", "create indexes", default: false
        o.array "--exclude", "prevent specific tables from being indexed"
        o.string "--include", "only include specific tables"
        o.string "--input-format", "input format", default: "stderr"
        o.integer "--interval", "time to wait between processing queries, in seconds", default: 60
        o.boolean "--log-explain", "log explain", default: false, help: false
        o.string "--log-level", "log level", default: "info"
        o.boolean "--log-sql", "log sql", default: false
        o.float "--min-calls", "only process queries that have been called a certain number of times", default: 0
        o.float "--min-time", "only process queries that have consumed a certain amount of DB time, in minutes", default: 0
        o.integer "--min-cost-savings-pct", default: 50, help: false
        o.boolean "--pg-stat-activity", "use pg_stat_activity", default: false, help: false
        o.boolean "--pg-stat-statements", "use pg_stat_statements", default: false, help: false
        o.string "-s", "--statement", "process a single statement"
        o.string "--tablespace", "tablespace to create indexes"
        o.on "-v", "--version", "print the version" do

        
docker exec -it tmp_postgres_1 psql -U foo baz

# Enable logging for slow queries in your Postgres config file on Heroku

log_min_duration_statement = 10 # ms

# Docker commands utils
docker compose down --remove-orphans --volumes
docker system prune --all --volumes --force
docker compose up --build






