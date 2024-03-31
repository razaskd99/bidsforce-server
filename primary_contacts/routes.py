from fastapi import APIRouter, HTTPException, Depends
from typing import List
from primary_contacts.schemas import PrimaryContactsCreate, PrimaryContacts, PrimaryContactsSingleRecord
from primary_contacts.services import (
    create_primary_contacts,
    get_all_primary_contacts,
    update_primary_contacts,
    delete_primary_contacts,
    get_primary_contacts_by_id,
    get_primary_contacts_by_manager,
    get_primary_contacts_by_team,
    get_primary_contacts_by_company,
    delete_all_primary_contacts
)
from auth.services import get_current_user

router = APIRouter()

@router.post("/primary_contacts/", response_model=PrimaryContactsSingleRecord, tags=["Primary Contacts"], summary="Create a Primary Contacts", description="This method will create a new Primary Contacts")
async def add_primary_contacts(bid_stage_data: PrimaryContactsSingleRecord, current_user: str = Depends(get_current_user)):
    return create_primary_contacts(bid_stage_data)

@router.put("/primary_contacts/id/{primary_contacts_id}", response_model=PrimaryContactsSingleRecord, tags=["Primary Contacts"], summary="Update an Primary Contacts", description="This method will update an existing Primary Contacts")
async def edit_primary_contacts(primary_contacts_id: int,  bid_stage_data: PrimaryContactsSingleRecord, current_user: str = Depends(get_current_user)):
    return update_primary_contacts(primary_contacts_id, bid_stage_data)

@router.delete("/primary_contacts/id/{primary_contacts_id}", tags=["Primary Contacts"], summary="Delete an Primary Contacts", description="This method will delete Primary Contacts")
async def remove_primary_contacts(primary_contacts_id: int, current_user: str = Depends(get_current_user)):
    deleted = delete_primary_contacts(primary_contacts_id,)
    if not deleted:
        raise HTTPException(status_code=404, detail="Bid Stage not found")
    return {"message": "Primary Contacts deleted successfully"}

@router.delete("/primary_contacts/all-rfx/tenant_id/{tenant_id}", tags=["Primary Contacts"], summary="Delete an Primary Contacts", description="This method will delete Primary Contacts")
async def remove_all_primary_contacts(tenant_id: int, current_user: str = Depends(get_current_user)):
    deleted = delete_all_primary_contacts(tenant_id,)
    if not deleted:
        raise HTTPException(status_code=404, detail="Bid Stage not found")
    return {"message": "Primary Contacts deleted successfully"}

@router.get("/primary_contacts/tenant/{tenant_id}",  tags=["Primary Contacts"], summary="Get All Primary Contacts", description="This method will return all Primary Contacts")
async def list_primary_contacts(tenant_id: int,current_user: str = Depends(get_current_user)):
    contact_list= get_all_primary_contacts(tenant_id)
    if not contact_list:
        raise HTTPException(status_code=404, detail="Contacts not found")
    return contact_list


@router.get("/primary_contacts/id/{primary_contacts_id}", response_model=PrimaryContacts, tags=["Primary Contacts"], summary="Get Primary Contacts by ID", description="This method will return Primary Contacts by ID")
async def get_primary_contacts_by_id_api(primary_contacts_id: int, current_user: str = Depends(get_current_user)):
    return_item = get_primary_contacts_by_id(primary_contacts_id)
    if not return_item:
        raise HTTPException(status_code=404, detail="Primary Contacts not found")
    return return_item

@router.get("/primary_contacts/tenant/{tenant_id}/manager/{manager_name}", response_model=List[PrimaryContacts], tags=["Primary Contacts"], summary="Get Primary Contacts by Tenant ID and Manager", description="This method will return all Primary Contacts by Tenant ID and Manager name.")
async def get_primary_contacts_by_manager_api(tenant_id: int, manager_name: str, current_user: str = Depends(get_current_user)):
    return_item = get_primary_contacts_by_manager(tenant_id, manager_name)
    if not return_item:
        raise HTTPException(status_code=404, detail="Primary Contacts not found")
    return return_item


@router.get("/primary_contacts/tenant/{tenant_id}/team/{team_id}", response_model=List[PrimaryContacts], tags=["Primary Contacts"], summary="Get Primary Contacts by Tenant ID and Team", description="This method will return all Primary Contacts by Tenant ID and Team ID")
async def get_primary_contacts_by_team_api(tenant_id: int, team_id: int, current_user: str = Depends(get_current_user)):
    return_item = get_primary_contacts_by_team(tenant_id, team_id)
    if not return_item:
        raise HTTPException(status_code=404, detail="Primary Contacts not found")
    return return_item

@router.get("/primary_contacts/tenant/{tenant_id}/company/{company_id}", response_model=List[PrimaryContacts], tags=["Primary Contacts"], summary="Get Primary Contacts by Tenant ID and Company", description="This method will return all Primary Contacts by Tenant ID and Company ID")
async def get_primary_contacts_by_company_api(tenant_id: int, company_id: int, current_user: str = Depends(get_current_user)):
    return_item = get_primary_contacts_by_company(tenant_id, company_id)
    if not return_item:
        raise HTTPException(status_code=404, detail="Primary Contacts not found")
    return return_item