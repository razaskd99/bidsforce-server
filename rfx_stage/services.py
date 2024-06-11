from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from rfx_stage.schemas import RfxStageCreate, RfxStage
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors


def create_rfx_stage(item_form_data: RfxStageCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO rfx_stage (
        tenant_id,
        title,
        is_active,
        created_at
    ) VALUES (%s, %s, %s, %s) RETURNING *;
    """

    try:
        values = (
            item_form_data.tenant_id,
            item_form_data.title,
            item_form_data.is_active,
            item_form_data.created_at
        )

        cursor.execute(query, values)
        new_item = cursor.fetchone()

    
        conn.commit()
        conn.close()

        if new_item:
            data ={
                "rfx_stage_id" : new_item[0],
                "tenant_id" : new_item[1],
                "title" : new_item[2],
            }
            error_response = {"msg": "RFx Stage created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "RFx Stage already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "RFx Stage already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)


def get_all_rfx_stage(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM rfx_stage             
            WHERE tenant_id = %s AND lower(title) LIKE %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        query = """
            SELECT * FROM rfx_stage             
                WHERE tenant_id = %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()

    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM rfx_stage WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()    
    conn.close()
    
    if query_all_items:
        return {
            "data": [
                RfxStage(
                    rfx_stage_id=row[0],
                    tenant_id=row[1],
                    title=row[2],
                    is_active=row[3],
                    created_at=row[4]
                )
                for row in query_all_items
            ],
            "total_count": total_count
        }
    else:
        None


def update_rfx_stage(rfx_stage_id: int,  item_form_data: RfxStageCreate) -> Optional[RfxStage]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE rfx_stage SET 
        title = %s,
        is_active = %s
    WHERE rfx_stage_id = %s RETURNING *;
    """

    values = (
        item_form_data.title,
        item_form_data.is_active,
        rfx_stage_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return RfxStage(
            rfx_stage_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            title=updated_itemm[2],
            is_active=updated_itemm[3], 
            created_at=updated_itemm[4]
        )
    else:
        raise HTTPException(status_code=404, detail="RFx Stage update failed")


def delete_rfx_stage(rfx_stage_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM rfx_stage WHERE rfx_stage_id = %s RETURNING rfx_stage_id;"
    cursor.execute(query, (rfx_stage_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False

def delete_all_rfx_stage(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM rfx_stage WHERE tenant_id = %s RETURNING rfx_stage_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_rfx_stage_by_id(rfx_stage_id: int) -> Optional[RfxStage]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    SELECT * FROM rfx_stage WHERE rfx_stage_id = %s;
    """

    cursor.execute(query, (rfx_stage_id,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return RfxStage (
                    rfx_stage_id=get_all_items[0],
                    tenant_id=get_all_items[1],
                    title=get_all_items[2],
                    is_active=get_all_items[3],
                    created_at=get_all_items[4]
                )           
        
    else:
        return None


def get_rfx_stage_by_name(tenant_id: int, title : str) -> List[RfxStage]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    SELECT * FROM rfx_stage WHERE tenant_id = %s AND lower(title) = %s;
    """

    cursor.execute(query, (tenant_id, title.lower()))
    get_item = cursor.fetchall()

    conn.close()

    if get_item:
        return [
            RfxStage (
                rfx_stage_id=row[0],
                tenant_id=row[1],
                title=row[2],
                is_active=row[3],
                created_at=row[4]
            )
            for row in get_item
        ]
    else:
        return None
    

def get_all_active_rfx_stage( tenant_id: int) -> List[RfxStage]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    SELECT * FROM rfx_stage WHERE tenant_id = %s AND is_active = %s;
    """

    cursor.execute(query, (tenant_id, True))
    all_records = cursor.fetchall()

    conn.close()
    if all_records:
        return [
            RfxStage (
                rfx_stage_id=row[0],
                tenant_id=row[1],
                title=row[2],
                is_active=row[3],
                created_at=row[4]
            )
            for row in all_records
        ]
    else:
        return None
    


