from pydantic import BaseModel
from typing import Optional
from datetime import date, datetime 

class RfxTypeCreate(BaseModel):
    tenant_id: int
    title: Optional[str]
    is_active: Optional[bool] = True
    created_at : datetime

class RfxType(RfxTypeCreate):
    rfx_type_id : int
