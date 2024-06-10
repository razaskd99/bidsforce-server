from pydantic import BaseModel
from typing import Optional
from datetime import date, datetime 

class BidValidityCreate(BaseModel):
    tenant_id: int
    title: Optional[str]
    is_active: Optional[bool] = True
    created_at : datetime

class BidValidity(BidValidityCreate):
    bid_validity_id : int
