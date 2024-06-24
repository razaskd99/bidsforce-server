from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from opportunity_industry.schemas import OpportunityIndustry, OpportunityIndustryCreate
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors
import re

def create_opportunity_industry(item_form_data: OpportunityIndustryCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO opportunity_industry (
        tenant_id,
        title,
        active,
        created_at
    ) VALUES (%s, %s, %s, %s) RETURNING *;
    """

    try:
        title = re.sub(r'\w+', lambda m:m.group(0).capitalize(), item_form_data.title)
        values = (
            item_form_data.tenant_id,
            title,
            item_form_data.active,
            item_form_data.created_at
        )

        cursor.execute(query, values)
        new_item = cursor.fetchone()

    
        conn.commit()
        conn.close()

        if new_item:
            data ={
                "opportunity_industry_id" : new_item[0],
                "tenant_id" : new_item[1],
                "title" : new_item[2],
            }
            error_response = {"msg": "Opportunity Industry created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "Opportunity Industry already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "Opportunity Industry already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)
    

def get_all_opportunity_industry(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM opportunity_industry             
            WHERE tenant_id = %s AND lower(title) LIKE %s
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        query = """
            SELECT * FROM opportunity_industry             
            WHERE tenant_id = %s 
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()

    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM opportunity_industry WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()
    conn.close()
    
    if query_all_items:
        return {
            "data": [
                OpportunityIndustry(
                    opportunity_industry_id=row[0],
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


def update_opportunity_industry(opportunity_industry_id: int,  item_form_data: OpportunityIndustryCreate) -> Optional[OpportunityIndustry]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE opportunity_industry SET 
        title = %s,
        active = %s
    WHERE opportunity_industry_id = %s RETURNING *;
    """

    values = (
        item_form_data.title,
        item_form_data.active,
        opportunity_industry_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return OpportunityIndustry(
            opportunity_industry_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            title=updated_itemm[2],
            active=updated_itemm[3],
            created_at=updated_itemm[4]
        )
    else:
        raise HTTPException(status_code=404, detail="Opportunity Sales Stages update failed")


def delete_opportunity_industry(opportunity_industry_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM opportunity_industry WHERE opportunity_industry_id = %s RETURNING opportunity_industry_id;"
    cursor.execute(query, (opportunity_industry_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_opportunity_industry(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM opportunity_industry WHERE tenant_id = %s RETURNING opportunity_industry_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_opportunity_industry_by_id(opportunity_industry_id: int) -> Optional[OpportunityIndustry]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM opportunity_industry WHERE opportunity_industry_id = %s;"

    cursor.execute(query, (opportunity_industry_id,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return OpportunityIndustry (
                opportunity_industry_id=get_all_items[0],
                tenant_id=get_all_items[1],
                title=get_all_items[2],
                active=get_all_items[3],
                created_at=get_all_items[4]
            )
    else:
        return None


