from pydantic import BaseModel, Field
from typing import List, Optional

class Transaction(BaseModel):
    """Represents a single transaction line item from a credit card bill."""
    date: str = Field(..., description="Date of the transaction in YYYY-MM-DD format.")
    merchant_name: str = Field(..., description="Name of the merchant as it appears on the bill.")
    amount: float = Field(..., description="Amount of the transaction.")
    currency: str = Field(..., description="Currency of the transaction, e.g., 'AUD', 'USD'.")
    raw_entity: Optional[str] = Field(None, description="The raw, unparsed text line for the transaction.")

class StatementSummary(BaseModel):
    """Summarizes the key financial figures from a credit card statement."""
    previous_balance: float = Field(..., description="Balance from the previous statement.")
    payments_and_credits: float = Field(..., description="Total amount of payments and credits applied.")
    new_charges: float = Field(..., description="Total amount of new charges this period.")
    new_balance: float = Field(..., description="The new total balance due for this statement.")
    minimum_payment: float = Field(..., description="Minimum payment due.")
    minimum_payment_due_date: str = Field(..., description="Due date for the minimum payment in YYYY-MM-DD format.")

class CardInfo(BaseModel):
    """Contains basic information about the credit card and cardholder."""
    customer_name: str = Field(..., description="The name of the cardholder.")
    issuer: str = Field(..., description="The name of the bank or card issuer.")
    card_network: Optional[str] = Field(None, description="The network of the card, e.g., 'Visa', 'Mastercard'.")
    last4: str = Field(..., description="The last four digits of the credit card number.")
    statement_date: str = Field(..., description="The date the statement was issued in YYYY-MM-DD format.")
    card_status: str = Field(..., description="The status of the card, e.g., 'Active'.")

class BillAnalysis(BaseModel):
    """The complete structured output for a parsed credit card bill."""
    card_info: CardInfo = Field(..., description="Basic card and statement information.")
    statement_summary: StatementSummary = Field(..., description="Summary of statement balances and payments.")
    transactions: List[Transaction] = Field(..., description="A list of all transactions for this statement.")
