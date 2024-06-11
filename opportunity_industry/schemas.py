from pydantic import BaseModel
from typing import Optional
from datetime import date, datetime 

class OpportunityIndustryCreate(BaseModel):
    tenant_id: int
    title: Optional[str]
    active: Optional[bool] = True
    created_at : datetime

class OpportunityIndustry(OpportunityIndustryCreate):
    opportunity_industry_id : int
