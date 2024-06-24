from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date, datetime


class RfxCreate(BaseModel):
    tenant_id: Optional[int]
    opportunity_id: Optional[int]
    rfx_number: Optional[str]
    rfx_id: Optional[str]	
    rfx_title: Optional[str]
    rfx_record_type: Optional[str]
    prev_rfx_reference: Optional[str]
    rfx_type: Optional[str]
    bid_type: Optional[str]
    bid_validity: Optional[str]
    bid_submission_mode: Optional[str]
    submission_contents: Optional[str]
    work_agreement_ref_num: Optional[str]
    rfx_tech_contact_id: Optional[int]
    rfx_comm_contact_id: Optional[int]
    submission_instructions: Optional[str]
    visit_worksite: Optional[bool]=False
    visit_worksite_instructions: Optional[str]
    issue_date: Optional[date]
    due_date: Optional[date]
    tech_clarif_deadline: Optional[date]
    comm_clarif_deadline: Optional[date]
    expected_award_date: Optional[date]
    bid_number: Optional[str]
    rfx_status: Optional[str]
    bid_status: Optional[str]
    data: Optional[str]
    rfx_owner_id: Optional[int]
    bid_owner_id: Optional[int]
    created_by: Optional[int] 
    is_active: Optional[bool]=True
    created_at: Optional[datetime]
    updated_at: Optional[datetime]
        
class Rfx(RfxCreate):
    id: int 
    
class RfxGet(BaseModel):
    id: int 
    tenant_id: Optional[int]
    opportunity_id: Optional[int]
    rfx_number: Optional[str]
    rfx_id: Optional[str]	
    rfx_title: Optional[str]
    rfx_record_type: Optional[str]
    prev_rfx_reference: Optional[str]
    rfx_type: Optional[str]
    bid_type: Optional[str]
    bid_validity: Optional[str]
    bid_submission_mode: Optional[str]
    submission_contents: Optional[str]
    work_agreement_ref_num: Optional[str]
    rfx_tech_contact_id: Optional[int]
    rfx_comm_contact_id: Optional[int]
    submission_instructions: Optional[str]
    visit_worksite: Optional[bool]=False
    visit_worksite_instructions: Optional[str]
    issue_date: Optional[date]
    due_date: Optional[date]
    tech_clarif_deadline: Optional[date]
    comm_clarif_deadline: Optional[date]
    expected_award_date: Optional[date]
    bid_number: Optional[str]
    rfx_status: Optional[str]
    bid_status: Optional[str]
    data: Optional[str]
    rfx_owner_id: Optional[int]
    bid_owner_id: Optional[int]
    created_by: Optional[int] 
    is_active: Optional[bool]=True
    created_at: Optional[datetime]
    updated_at: Optional[datetime]
    creator_name: Optional[str]
    creator_email: Optional[str]
    creator_image: Optional[str]
    creator_jobtitle: Optional[str]
    rfxowner_name: Optional[str]
    rfxowner_email: Optional[str]
    rfxowner_image: Optional[str]
    rfxowner_jobtitle: Optional[str]
    rfxtech_contact_name: Optional[str]
    rfxcomm_contact_name: Optional[str]
    opp_title: Optional[str]
    opp_number: Optional[str]
    enduser_name: Optional[str]
    customer_name: Optional[str]
    
     
class RfxUpdateRfxNumber(BaseModel):
    rfx_number: str   
    
class RfxUpdateBidNumber(BaseModel):
    bid_number: str 
    
    
class RfxUpdateRfxOwner(BaseModel):
    rfx_owner_id: int 

class RfxUpdateBidOwner(BaseModel):
    bid_owner_id: int 
    
    
class RfxUpdateRfxStatus(BaseModel):
    rfx_status: Optional[str] 

class RfxUpdateBidStatus(BaseModel):
    bid_status: Optional[str] 
    
class RFxGetMax(BaseModel):
    id: int
    rfx_id: Optional[str]