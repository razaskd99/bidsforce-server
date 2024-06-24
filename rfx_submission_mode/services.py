from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from rfx_submission_mode.schemas import RfxSubModeCreate, RfxSubMode
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors
import re


def create_rfx_submission_mode(item_form_data: RfxSubModeCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO rfx_submission_mode (
        tenant_id,
        title,
        is_active,
        created_at
    ) VALUES (%s, %s, %s, %s) RETURNING *;
    """

    try:
        title = re.sub(r'\w+', lambda m:m.group(0).capitalize(), item_form_data.title)
        values = (
            item_form_data.tenant_id,
            title,
            item_form_data.is_active,
            item_form_data.created_at
        )

        cursor.execute(query, values)
        new_item = cursor.fetchone()

    
        conn.commit()
        conn.close()

        if new_item:
            data ={
                "rfx_submission_mode_id" : new_item[0],
                "tenant_id" : new_item[1],
                "title" : new_item[2],
            }
            error_response = {"msg": "RFx Submission Mode created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "RFx Submission Mode already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "RFx Submission Mode already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)


def get_all_rfx_submission_mode(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM rfx_submission_mode             
            WHERE tenant_id = %s AND lower(title) LIKE %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        query = """
            SELECT * FROM rfx_submission_mode             
                WHERE tenant_id = %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()

    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM rfx_submission_mode WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()    
    conn.close()
    
    if query_all_items:
        return {
            "data": [
                RfxSubMode(
                    rfx_submission_mode_id =row[0],
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


def update_rfx_submission_mode(rfx_submission_mode_id : int,  item_form_data: RfxSubModeCreate) -> Optional[RfxSubMode]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE rfx_submission_mode SET 
        title = %s,
        is_active = %s
    WHERE rfx_submission_mode_id  = %s RETURNING *;
    """

    values = (
        item_form_data.title,
        item_form_data.is_active,
        rfx_submission_mode_id 
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return RfxSubMode(
            rfx_submission_mode_id =updated_itemm[0],
            tenant_id=updated_itemm[1],
            title=updated_itemm[2],
            is_active=updated_itemm[3],
            created_at=updated_itemm[4]
        )
    else:
        raise HTTPException(status_code=404, detail="RFx Submission Mode update failed")


def delete_rfx_submission_mode(rfx_submission_mode_id : int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM rfx_submission_mode WHERE rfx_submission_mode_id  = %s RETURNING rfx_submission_mode_id ;"
    cursor.execute(query, (rfx_submission_mode_id ,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_rfx_submission_mode(tenant_id : int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM rfx_submission_mode WHERE tenant_id  = %s RETURNING rfx_submission_mode_id ;"
    cursor.execute(query, (tenant_id ,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False



def get_rfx_submission_mode_by_id(rfx_submission_mode_id : int) -> Optional[RfxSubMode]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM rfx_submission_mode WHERE rfx_submission_mode_id  = %s ;"

    cursor.execute(query, (rfx_submission_mode_id ,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return RfxSubMode (
                rfx_submission_mode_id =get_all_items[0],
                tenant_id=get_all_items[1],
                title=get_all_items[2],
                is_active=get_all_items[3],
                created_at=get_all_items[4]
            )
    else:
        return None


def get_rfx_submission_mode_by_name(title : str, tenant_id: int) -> Optional[RfxSubMode]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM rfx_submission_mode WHERE lower(title) = %s AND tenant_id = %s RETURNING *;"

    cursor.execute(query, (title.lower(), tenant_id))
    get_item = cursor.fetchone()

    conn.close()

    if get_item:
        return RfxSubMode(
                rfx_submission_mode_id =get_item[0],
                tenant_id=get_item[1],
                title=get_item[2],
                is_active=get_item[3],
                created_at=get_item[4]
            )
    else:
        return None
    

def get_all_active_rfx_submission_mode( tenant_id: int) -> List[RfxSubMode]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM rfx_submission_mode WHERE is_active = %s AND tenant_id = %s;"

    cursor.execute(query, (True, tenant_id,))
    all_records = cursor.fetchall()

    conn.close()
    if all_records:
        return [
            RfxSubMode (
                rfx_submission_mode_id =row[0],
                tenant_id=row[1],
                title=row[2],
                is_active=row[3],
                created_at=row[4]
            )
            for row in all_records
        ]
    else:
        return None
    
def get_all_rfx_submission_mode_by_created_at(tenant_id: int, created_at: str) -> Optional[RfxSubMode]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM rfx_submission_mode WHERE tenant_id = %s AND lower(created_at) = %s ;"

    cursor.execute(query, (tenant_id, created_at.lower()))
    all_records = cursor.fetchone()

    conn.close()
    if all_records:
        return RfxSubMode(
                rfx_submission_mode_id =all_records[0],
                tenant_id=all_records[1],
                title=all_records[2],
                is_active=all_records[3],
                created_at=all_records[4]
            )
    else:
        return None
