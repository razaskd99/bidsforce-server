from fastapi import APIRouter, HTTPException, Depends, Response
from typing import List
from opportunity_industry.schemas import OpportunityIndustryCreate, OpportunityIndustry
from opportunity_industry.services import (
    create_opportunity_industry,
    get_all_opportunity_industry,
    update_opportunity_industry,
    delete_opportunity_industry,
    get_opportunity_industry_by_id,
    delete_all_opportunity_industry
) 
from auth.services import get_current_user

router = APIRouter()

@router.post("/opportunity_industry/", tags=["Opportunity Industry (OPP Prereq)"], summary="Create a Opportunity Industry", description="This method will create a new Opportunity Industry")
async def add_opportunity_industry(opp_sales_stages_data: OpportunityIndustryCreate, current_user: str = Depends(get_current_user)):
    return create_opportunity_industry(opp_sales_stages_data)

@router.get("/opportunity_industry/tenant/{tenant_id}", tags=["Opportunity Industry (OPP Prereq)"], summary="Get All Opportunity Industry", description="This method will return all Opportunity Industry")
async def list_opportunity_industry(tenant_id: int, searchTerm: str, offset: int, limit: int, current_user: str = Depends(get_current_user)):
    return_items = get_all_opportunity_industry(tenant_id, searchTerm, offset, limit)
    if not return_items:
        raise HTTPException(status_code=404, detail="Opportunity Industry not found")
    return return_items
   

@router.put("/opportunity_industry/id/{opportunity_industry_id}", response_model=OpportunityIndustry, tags=["Opportunity Industry (OPP Prereq)"], summary="Update an Opportunity Industry", description="This method will update an existing Opportunity Industry")
async def edit_opportunity_industry(opportunity_industry_id: int,  opp_sales_stages_data: OpportunityIndustryCreate, current_user: str = Depends(get_current_user)):
    return update_opportunity_industry(opportunity_industry_id, opp_sales_stages_data)
 
@router.delete("/opportunity_industry/id/{opportunity_industry_id}", tags=["Opportunity Industry (OPP Prereq)"], summary="Delete an Opportunity Industry", description="This method will delete Opportunity Industry")
async def remove_opportunity_industry(opportunity_industry_id: int, current_user: str = Depends(get_current_user)):
    deleted = delete_opportunity_industry(opportunity_industry_id,)
    if not deleted:
        raise HTTPException(status_code=404, detail="Record not found")
    else:
        return Response(content="Record deleted successfully.", status_code=200)

@router.delete("/opportunity_industry/all/tenant_id/{tenant_id}", tags=["Opportunity Industry (OPP Prereq)"], summary="Delete an Opportunity Industry", description="This method will delete Opportunity Industry")
async def remove_all_opportunity_industry(tenant_id: int, current_user: str = Depends(get_current_user)):
    deleted = delete_all_opportunity_industry(tenant_id,)
    if not deleted:
        raise HTTPException(status_code=404, detail="Opportunity Industry not found")
    return {"message": "Opportunity Industry deleted successfully"}

@router.get("/opportunity_industry/id/{opportunity_industry_id}", response_model=OpportunityIndustry, tags=["Opportunity Industry (OPP Prereq)"], summary="Get Opportunity Industry by ID", description="This method will return Opportunity Industry by ID")
async def get_opportunity_industry_by_id_api(opportunity_industry_id: int, current_user: str = Depends(get_current_user)):
    return_item = get_opportunity_industry_by_id(opportunity_industry_id)
    if not return_item:
        raise HTTPException(status_code=404, detail="Opportunity Industry not found")
    return return_item


