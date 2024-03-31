from pydantic import BaseModel
from typing import Optional
from datetime import date, datetime 

class PrimaryContactsCreate(BaseModel):    
    tenant_id: Optional[int]
    company_id: Optional[int]
    designation_id: Optional[int]
    team_id: Optional[int]
    first_name: Optional[str]
    last_name: Optional[str]
    manager: Optional[str]
    function_group: Optional[str]
    contact_number: Optional[str]
    time_zone: Optional[str]
    email: Optional[str]
    working_hours: Optional[str]
    work_location: Optional[str]
    profile_image: Optional[str]
    created_at: Optional[datetime]
    company_name: Optional[str]
    designation_title: Optional[str]
    team_title: Optional[str]

class PrimaryContactsSingleRecord(BaseModel): 
    primary_contacts_id : int   
    tenant_id: Optional[int]
    company_id: Optional[int]
    designation_id: Optional[int]
    team_id: Optional[int]
    first_name: Optional[str]
    last_name: Optional[str]
    manager: Optional[str]
    function_group: Optional[str]
    contact_number: Optional[str]
    time_zone: Optional[str]
    email: Optional[str]
    working_hours: Optional[str]
    work_location: Optional[str]
    profile_image: Optional[str]
    created_at: Optional[datetime]

class PrimaryContacts(PrimaryContactsCreate):
    primary_contacts_id : int
