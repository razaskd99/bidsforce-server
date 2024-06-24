from fastapi import APIRouter, HTTPException, Depends
from typing import List, Optional
from . import services
from .schemas import Rfx, RfxCreate, RfxGet 
from .schemas import RfxUpdateBidOwner, RfxUpdateRfxOwner, RfxUpdateBidNumber, RfxUpdateRfxNumber
from .schemas import RfxUpdateBidStatus, RfxUpdateRfxStatus, RFxGetMax
from auth.services import get_current_user

router = APIRouter()

# Create an RFX record
@router.post(
    "/rfx/",
    response_model=Rfx,
    tags=["RFX"],
    summary="Create a new RFX record",
    description="Create a new RFX record with the provided details."
)
def create_rfx(rfx: RfxCreate, current_user: str = Depends(get_current_user)):
    return services.create_rfx(rfx)

# Get all RFX records
@router.get(
    "/rfx/tenant/{tenant_id}",
    tags=["RFX"],
    summary="Get all RFX records",
    description="Retrieve a list of all existing RFX records."
)
def get_all_rfx_api(tenant_id: int, searchTerm: str, offset: int, limit: int, current_user: str = Depends(get_current_user)):
    return services.get_all_rfx(tenant_id, searchTerm, offset, limit)

# Get an RFX by ID
@router.get(
    "/rfx/id/{rfx_id}",
    response_model=Optional[RfxGet],
    tags=["RFX"],
    summary="Get an RFX by ID",
    description="Retrieve an RFX record by its unique ID."
)
def get_rfx_by_id_api(rfx_id: int, current_user: str = Depends(get_current_user)):
    rfx = services.get_rfx_by_id(rfx_id)
    if rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return rfx

# Get RFXs by RFx owner ID
@router.get(
    "/rfx/{tenant_id}/initiator/{rfx_owner_id}",
    response_model=List[RfxGet],
    tags=["RFX"],
    summary="Get RFXs by rfx owner ID",
    description="Retrieve list of RFX records by the rfx owner ID."
)
def get_rfx_by_rfx_owner_id_api(tenant_id: int, initiator_id: int, current_user: str = Depends(get_current_user)):
    return services.get_rfx_by_rfx_owner_id(tenant_id, initiator_id)

# Get an RFX by title
@router.get(
    "/rfx/{tenant_id}/title/{rfx_title}",
    response_model=Optional[Rfx],
    tags=["RFX"],
    summary="Get an RFX by title",
    description="Retrieve an RFX record by its title."
)
def get_rfx_by_title(tenant_id: int, rfx_title: str, current_user: str = Depends(get_current_user)):
    rfx = services.get_rfx_by_rfx_title(tenant_id, rfx_title)
    if rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return rfx

# Get an RFX by number
@router.get(
    "/rfx/{tenant_id}/rfx_number/{rfx_number}",
    response_model=List[RfxGet],
    tags=["RFX"],
    summary="Get RFX by rfx number",
    description="Retrieve RFX records by Rfx number."
)
def get_rfx_by_rfx_number_api(tenant_id: int, rfx_number: str, current_user: str = Depends(get_current_user)):
    rfx = services.get_rfx_by_rfx_number(tenant_id, rfx_number)
    if rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return rfx

# Update an RFX by ID
@router.put(
    "/rfx/id/{id}",
    response_model=Rfx,
    tags=["RFX"],
    summary="Update an RFX by ID",
    description="Update an existing RFX record by its ID."
)
def update_rfx_api(id: int, rfx: RfxCreate, current_user: str = Depends(get_current_user)):
    updated_rfx = services.update_rfx(id, rfx)
    if updated_rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return updated_rfx



# Update Rfx Status to by Rfx ID
@router.put("/rfx/rfx_status/{status}/id/{id}", response_model=Optional[bool], tags=["RFX"], summary="Update Rfx Status by ID", description="Update RFx Status by Rfx ID .")
async def edit_rfx_status(id: int, status: str, rfx_data: RfxUpdateRfxStatus, current_user: str = Depends(get_current_user)):
    return services.update_rfx_status(id, status)

# Update Bid Status to by Rfx ID
@router.put("/rfx/bid_status/{status}/id/{id}", response_model=Optional[bool], tags=["RFX"], summary="Update Bid Status by ID", description="Update RFx Status by Rfx ID .")
async def edit_rfx_status(id: int, status: str, rfx_data: RfxUpdateBidStatus, current_user: str = Depends(get_current_user)):
    return services.update_bid_status(id, status)

# Delete an RFX by ID
@router.delete(
    "/rfx/id/{id}",
    response_model=bool,
    tags=["RFX"],
    summary="Delete an RFX by ID",
    description="Delete an existing RFX record by its unique identifier."
)
def delete_rfx(id: int, current_user: str = Depends(get_current_user)):
    return services.delete_rfx(id)


# Get an RFX by ID
@router.get(
    "/rfx/opportunity/{opportunity_id}",
    response_model=List[RfxGet],
    tags=["RFX"],
    summary="Get RFX by Opportunity ID",
    description="Retrieve RFX records by Opportunity ID."
)
def get_rfx_by_opportunity_id_api(opportunity_id: int, current_user: str = Depends(get_current_user)):
    rfx = services.get_rfx_by_opportunity_id(opportunity_id)
    if rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return rfx

# Get an RFX by ID
@router.get(
    "/rfx/max_id",
    response_model=Optional[RFxGetMax],
    tags=["RFX"],
    summary="Get RFX max ID",
    description="Retrieve an RFX max ID."
)
def get_rfx_by_max_id_api(current_user: str = Depends(get_current_user)):
    rfx = services.get_rfx_id_max()
    if rfx is None:
        raise HTTPException(status_code=404, detail="RFX not found")
    return rfx