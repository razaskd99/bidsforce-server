from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from functional_group.schemas import FunctionalGroupCreate, FunctionalGroup
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors


def create_functional_group(item_form_data: FunctionalGroupCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO functional_group (
        tenant_id,
        title,
        active,
        created_at
    ) VALUES (%s, %s, %s, %s) RETURNING *;
    """
    try:
        values = (
            item_form_data.tenant_id,
            item_form_data.title,
            item_form_data.active,
            item_form_data.created_at
        )
        cursor.execute(query, values)
        new_item = cursor.fetchone()
    
        conn.commit()
        conn.close()

        if new_item:
            data = {
                "id" : new_item[0],
                "tenant_id" : new_item[1],
                "title" : new_item[2],
            }
            error_response = {"msg": "Functional Group created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "Functional Group already exists", "code": 400}
            return json.dumps(error_response)
    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "Functional Group already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)


def get_all_functional_group(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()
    
    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM functional_group             
            WHERE tenant_id = %s AND lower(title) LIKE %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM functional_group             
            WHERE tenant_id = %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()

    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM functional_group WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()    
    
    conn.close()
    if query_all_items:
        return {
            "data": [
            FunctionalGroup(
                id=row[0],
                tenant_id=row[1],
                title=row[2],
                active=row[3],
                created_at=row[4]
            )
            for row in query_all_items
        ],
        "total_count": total_count
        }
    else:
        None


def update_functional_group(functional_group_id: int,  item_form_data: FunctionalGroupCreate) -> Optional[FunctionalGroup]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE functional_group SET 
        title = %s,
        active = %s
    WHERE id = %s RETURNING *;
    """

    values = (
        item_form_data.title,
        item_form_data.active,
        functional_group_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return FunctionalGroup(
            id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            title=updated_itemm[2],
            active=updated_itemm[3],
            created_at=updated_itemm[4]
        )
    else:
        raise HTTPException(status_code=404, detail="Bid Validity update failed")


def delete_functional_group(functional_group_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM functional_group WHERE id = %s RETURNING id;"
    cursor.execute(query, (functional_group_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_functional_group(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM functional_group WHERE tenant_id = %s RETURNING id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_functional_group_by_id(functional_group_id: int) -> Optional[FunctionalGroup]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM functional_group WHERE id = %s;"

    cursor.execute(query, (functional_group_id,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return FunctionalGroup (
                id=get_all_items[0],
                tenant_id=get_all_items[1],
                title=get_all_items[2],
                active=get_all_items[3],
                created_at=get_all_items[4]
            )
    else:
        return None


