from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from bid_validity.schemas import BidValidityCreate, BidValidity
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors


def create_bid_validity(item_form_data: BidValidityCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO bid_validity (
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
                "bid_validity_id" : new_item[0],
                "tenant_id" : new_item[1],
                "title" : new_item[2],
            }
            error_response = {"msg": "Bid Validity created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "Bid Validity already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "Bid Validity already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)

def get_all_bid_validity(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()
    
    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM bid_validity             
            WHERE tenant_id = %s AND lower(title) LIKE %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        query = """
            SELECT * FROM bid_validity             
                WHERE tenant_id = %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()

    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM bid_validity WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()    
    conn.close()
    
    if query_all_items:
        return {
            "data": [
                BidValidity(
                    bid_validity_id=row[0],
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


def update_bid_validity(bid_validity_id: int,  item_form_data: BidValidityCreate) -> Optional[BidValidity]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE bid_validity SET 
        title = %s,
        is_active = %s
    WHERE bid_validity_id = %s RETURNING *;
    """

    values = (
        item_form_data.title,
        item_form_data.is_active,
        bid_validity_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return BidValidity(
            bid_validity_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            title=updated_itemm[2],
            is_active=updated_itemm[3],
            created_at=updated_itemm[4]
        )
    else:
        raise HTTPException(status_code=404, detail="Bid Validity update failed")


def delete_bid_validity(bid_validity_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM bid_validity WHERE bid_validity_id = %s RETURNING bid_validity_id;"
    cursor.execute(query, (bid_validity_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_bid_validity(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM bid_validity WHERE tenant_id = %s RETURNING bid_validity_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_bid_validity_by_id(bid_validity_id: int) -> Optional[BidValidity]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM bid_validity WHERE bid_validity_id = %s ;"

    cursor.execute(query, (bid_validity_id,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return BidValidity (
                bid_validity_id=get_all_items[0],
                tenant_id=get_all_items[1],
                title=get_all_items[2],
                is_active=get_all_items[3],
                created_at=get_all_items[4]
            )
    else:
        return None


def get_bid_validity_by_name(title : str, tenant_id: int) -> Optional[BidValidity]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM bid_validity WHERE lower(title) = %s AND tenant_id = %s RETURNING *;"

    cursor.execute(query, (title.lower(), tenant_id))
    get_item = cursor.fetchone()

    conn.close()

    if get_item:
        return BidValidity(
                bid_validity_id=get_item[0],
                tenant_id=get_item[1],
                rfx_id=get_item[2],
                title=get_item[3],
                is_active=get_item[4]
            )
    else:
        return None
    

def get_all_active_bid_validity( tenant_id: int) -> List[BidValidity]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM bid_validity WHERE is_active = %s AND tenant_id = %s;"

    cursor.execute(query, (True, tenant_id,))
    all_records = cursor.fetchall()

    conn.close()
    if all_records:
        return [
            BidValidity (
                bid_validity_id=row[0],
                tenant_id=row[1],
                title=row[2],
                is_active=row[3],
                created_at =row[4]
            )
            for row in all_records
        ]
    else:
        return None
    

