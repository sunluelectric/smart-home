# tools/postgresql_tools.py

from crewai.tools import tool
import os
import psycopg
from dotenv import load_dotenv

dotenv_path = os.path.expanduser("~/Projects/smart-home/.env")
load_dotenv(dotenv_path=dotenv_path, override=True)

@tool("PostgreSQL Query Executor")
def run_postgres_query(query: str) -> str:
    """
    Executes a SQL query on a PostgreSQL database and returns the results.

    Args:
        query (str): The SQL query to execute.

    Returns:
        str: The results of the query or an error message.
    """
    try:
        # Load database connection details from environment variables
        db_host = os.getenv("PG_HOST", "localhost")
        db_port = os.getenv("PG_PORT", "5432")
        db_name = os.getenv("POSTGRES_DB", "mydatabase")
        db_user = os.getenv("POSTGRES_USER", "SUNLU")
        db_password = os.getenv("PG_PASSWORD", "")
        print(f"Connecting to database {db_name} at {db_host}:{db_port} as user {db_user}")
        # Connect to the PostgreSQL database
        with psycopg.connect(
            host=db_host,
            port=db_port,
            dbname=db_name,
            user=db_user,
            password=db_password
        ) as conn:
          # Create a cursor to execute the query
            with conn.cursor() as cur:
                cur.execute(query)
                if cur.description:  # If the query returns rows
                    results = cur.fetchall()
                    return str(results)
                else:  # If the query does not return rows (e.g., INSERT, UPDATE)
                    conn.commit()
                    return "Query executed successfully."
    except Exception as e:
        return f"An error occurred: {e}"
