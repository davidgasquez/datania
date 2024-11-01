.DEFAULT_GOAL := run

db:
	wget https://github.com/davidgasquez/datania/releases/latest/download/datania.duckdb -O data/database.duckdb

run:
	uv run dagster-dbt project prepare-and-package --file datania/dbt/resources.py
	uv run dagster asset materialize --select \* -m datania.definitions

dev:
	uv run dagster dev

.PHONY: web
web:
	npm run dev --prefix web

setup:
	uv sync
	. .venv/bin/activate

clean:
	rm -rf data/*.parquet data/*.duckdb
	rm -rf dbt/target dbt/dbt_packages dbt/logs
