from pydantic import BaseModel
from typing import Optional
from datetime import date, datetime 

class RfxStageCreate(BaseModel):
    tenant_id: int
    title: Optional[str]
    is_active: Optional[bool] = True
    created_at : datetime

class RfxStage(RfxStageCreate):
    rfx_stage_id : int
