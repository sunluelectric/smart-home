import sys
import warnings

from datetime import datetime

from credit_card_bill_injector.crew import CreditCardBillInjector

warnings.filterwarnings("ignore", category=SyntaxWarning, module="pysbd")

from dotenv import load_dotenv
import os

import fitz

def run():
    """
    This function sets up the environment and runs the CrewAI process.
    """
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..')))
    dotenv_path = os.path.expanduser('~/Projects/smart-home/.env')
    load_dotenv(dotenv_path=dotenv_path, override=True)

    doc = fitz.open('/data/Projects/smart-home/input-document/credit_card_bill.pdf')
    bill_content = ""
    for page in doc:
        bill_content += page.get_text()
    doc.close()

    injector_crew = CreditCardBillInjector()

    result = injector_crew.crew().kickoff(
        inputs={
            'bill_content': bill_content
        }
    )

    print("\n\n########################")
    print("## Here is your Crew's result:")
    print("########################\n")
    print(result)

if __name__ == '__main__':
    run()
